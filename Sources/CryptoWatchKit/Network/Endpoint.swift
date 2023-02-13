import Foundation

public enum Endpoint {
    case exchanges,
         ohlc(exchangeSymbol: String, pair: String),
         pairs
    
    var path: String {
        switch self {
        case .exchanges: return "exchanges"
        case let .ohlc(exchangeSymbol, pair):
            return "markets/\(exchangeSymbol)/\(pair)/ohlc"
        case .pairs: return "pairs"
        }
    }
}
