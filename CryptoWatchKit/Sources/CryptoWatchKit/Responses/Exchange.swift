import Foundation

// MARK: - Exchange
public struct Exchange: Codable {
    public let id: Int
    public let symbol, name: String
    public let route: String
    public let active: Bool
}
