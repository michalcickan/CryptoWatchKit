import Foundation

extension URLSession {
    func `get`<T: Decodable>(request: CryptoWatchRequest) async throws -> T {
        try await performRequest(request, method: .get)
    }
    
    func `get`<T: Decodable>(request: CryptoWatchRequest, type: T.Type) async throws -> T {
        try await performRequest(request, method: .get)
    }
    
    func post<T: Decodable>(request: CryptoWatchRequest) async throws -> T {
        try await performRequest(request, method: .post)
    }
}

private extension URLSession {
    enum Method: String {
        case post="POST", get="GET"
    }
    
    func performRequest<T: Decodable>(_ request: CryptoWatchRequest, method: Method) async throws -> T {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = method.rawValue
        let result: (Data, URLResponse)
        if #available(iOS 15.0, *) {
            result = try await data(for: urlRequest)
        } else {
            result = try await fetchForOlderVersions(url: urlRequest)
        }
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: result.0)
    }
    
    // Fallback
    func fetchForOlderVersions(url: URLRequest) async throws -> (Data, URLResponse) {
        guard #available(iOS 13.0, *) else {
            throw CryptoWatchException.unsupported
        }
        return try await withCheckedThrowingContinuation { continuation in
            let task = dataTask(with: url) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }
                
                continuation.resume(returning: (data, response))
            }
            
            task.resume()
        }
    }
}
