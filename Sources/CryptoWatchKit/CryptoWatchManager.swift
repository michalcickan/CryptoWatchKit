import Foundation
/**
 This doesn't have to be as separate class. It would suffice just make an extension on URLSession
 and call from other app e.g. URLSession.shared.fetchExchanges, but it won't be clear that it belongs to CryptoWat.ch.
 This way it shouldn't cause confusion.
 */
final public class CryptoWatchManager {
    private let session = URLSession.shared
    public static let shared = CryptoWatchManager()
}

public extension CryptoWatchManager {
    func fetchExchanges() async throws -> [Exchange] {
        return try await session.get(
            request: CryptoWatchRequest(endpoint: .exchanges),
            type: ResultResponse<[Exchange]>.self
        ).result
    }
    
    func fetchOHLC(exchangeSymbol: String, pair: String, params: FetchOHLC? = nil) async throws -> Dictionary<OHLCPeriod, [OHLC]> {
        return try await session.get(
            request: CryptoWatchRequest(endpoint: .ohlc(exchangeSymbol: exchangeSymbol, pair: pair), parameters: params),
            type: ResultResponse<DictionaryResult<OHLCPeriod, [OHLC]>>.self
        ).result.values
    }
    
    func fetchPairs(params: FetchPairs? = nil) async throws -> GenericWithCursor<[Pair]> {
        return try await session.get(request: CryptoWatchRequest(endpoint: .pairs, parameters: params))
    }
}
