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
}
