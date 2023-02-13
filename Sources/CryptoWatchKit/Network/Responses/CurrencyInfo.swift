import Foundation

public struct CurrencyInfo: Codable {
    public let id: Int
    public let symbol, name: String
    public let fiat: Bool
    public let route: String
}
