import XCTest
@testable import CryptoWatchKit

final class CryptoWatchKitTests: XCTestCase {
    func testOHLCEndpoint() {
        let endpoint = Endpoint.ohlc(exchangeSymbol: "bitfinex", pair: "btcusd")
        
        XCTAssertEqual(endpoint.path, "markets/bitfinex/btcusd/ohlc")
    }
    
    func testExchangesFetch() async throws {
        let response = try await CryptoWatchManager.shared.fetchExchanges()
        XCTAssertEqual(response.count, 48)
    }
}
