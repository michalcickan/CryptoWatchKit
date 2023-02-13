import Foundation

public struct OHLC: Decodable {
    public let closeTime: Double
    public let openPrice: Double
    public let highPrice: Double
    public let lowPrice: Double
    public let closePrice: Double
    public let volume: Double
    public let quoteVolume: Double
    
    public init(from decoder: Decoder) throws {
        var unkeyedContainer = try decoder.unkeyedContainer()
        
        self.closeTime = (try? unkeyedContainer.decode(Double.self)) ?? 0
        self.openPrice = (try? unkeyedContainer.decode(Double.self)) ?? 0
        self.highPrice = (try? unkeyedContainer.decode(Double.self)) ?? 0
        self.lowPrice = (try? unkeyedContainer.decode(Double.self)) ?? 0
        self.closePrice = (try? unkeyedContainer.decode(Double.self)) ?? 0
        self.volume = (try? unkeyedContainer.decode(Double.self)) ?? 0
        self.quoteVolume = (try? unkeyedContainer.decode(Double.self)) ?? 0
    }
}
