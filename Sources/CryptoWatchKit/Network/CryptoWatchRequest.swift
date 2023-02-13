import Foundation

struct CryptoWatchRequest {
    let urlComponents: URLComponents
    let parameters: Encodable?
    
    init(endpoint: Endpoint, parameters: Encodable? = nil) throws {
        guard let urlComponents = URLComponents(string: "\(CryptoWatchKit.baseUrl)/\(endpoint.path)") else {
            throw CryptoWatchException.invalidURL
        }
        self.urlComponents = urlComponents
        self.parameters = parameters
    }
}
