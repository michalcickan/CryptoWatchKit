import Foundation

// MARK: - Pair
public struct Pair: Codable {
    public let id: Int
    public let symbol: String
    public let base, quote: CurrencyInfo
    public let route: String
}
