import XCTest
@testable import CryptoWatchKit

final class CryptoWatchKitTests: XCTestCase {
    func testOHLCEndpoint() {
        let endpoint = Endpoint.ohlc(exchangeSymbol: "bitfinex", pair: "btcusd")
        
        XCTAssertEqual(endpoint.path, "markets/bitfinex/btcusd/ohlc")
    }
    
    func testEncodingParameters() async throws {
        let expectedPairs = [URLQueryItem(name: "limit", value: "50"), URLQueryItem(name: "cursor", value: "aaa")]
        let params = FetchPairs(limit: 50, cursorId: "aaa")
        let resultPairs = params.queryItems
        let filteredResult = expectedPairs.filter { resultPairs.contains($0) }
        XCTAssertEqual(filteredResult.count, resultPairs.count)
    }
    
    func testExchangesFetch() async throws {
        let response = try await CryptoWatchManager.shared.fetchExchanges()
        XCTAssertEqual(response.count, 48)
    }
    
    func testFetchPairsFetchLimit() async throws {
        let response = try await CryptoWatchManager.shared.fetchPairs(params: FetchPairs(limit: 20))
        XCTAssertEqual(response.result.count, 20)
    }
    
    func testFetchPairsLazyLoading() async throws {
        let firstResponse = try await CryptoWatchManager.shared.fetchPairs(params: FetchPairs(limit: 2))
        let secondResponse = try await CryptoWatchManager.shared.fetchPairs(params: FetchPairs(limit: 2, cursorId: firstResponse.cursor.last))
        XCTAssertNotEqual(firstResponse.result.first?.id, secondResponse.result.first?.id)
    }
    
    func testFetchOHLCPeriods() async throws {
        // in app, pairs and exchanges should be cached since it is not changed
//        let pair = try await CryptoWatchManager.shared.fetchPairs(params: FetchPairs(limit: 1))
        let response = try await CryptoWatchManager.shared.fetchExchanges()
        let ohlc = try await CryptoWatchManager.shared.fetchOHLC(exchangeSymbol: response[0].symbol, pair: "btceur", params: FetchOHLC(periods: [.fourHours, .day]))
        XCTAssertEqual(ohlc.values.count, 2)
        XCTAssertNotNil(ohlc[.fourHours])
        XCTAssertNotNil(ohlc[.day])
        XCTAssertNil(ohlc[.fiveMinutes])
    }
    
    func testFetchOHLCPeriodsWithAfter() async throws {
        // in app, pairs and exchanges should be cached since it is not changed
//        let pair = try await CryptoWatchManager.shared.fetchPairs(params: FetchPairs(limit: 1))
        let response = try await CryptoWatchManager.shared.fetchExchanges()
        let ohlc = try await CryptoWatchManager.shared.fetchOHLC(exchangeSymbol: response[0].symbol, pair: "btceur", params: FetchOHLC(before: Date().timeIntervalSince1970, periods: [.fourHours, .day]))
        XCTAssertEqual(ohlc.values.count, 2)
        XCTAssertNotNil(ohlc[.fourHours])
        XCTAssertNotNil(ohlc[.day])
        XCTAssertNil(ohlc[.fiveMinutes])
    }
}
