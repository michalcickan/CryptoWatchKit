import Foundation

struct CryptoWatchRequest {
    let url: URL
    let parameters: Encodable?
    
    init(endpoint: Endpoint, parameters: Encodable? = nil) throws {
        guard let url = URL(string: "\(CryptoWatchKit.baseUrl)/\(endpoint.path)") else {
            throw CryptoWatchException.invalidURL
        }
        self.url = url
        self.parameters = parameters
    }
}
