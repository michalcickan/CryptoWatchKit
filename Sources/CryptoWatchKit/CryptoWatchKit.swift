public struct CryptoWatchKit {
    static private(set) var apiKey = ""
    static let baseUrl = "https://api.cryptowat.ch"
    
    private init() { }
    
    public static func configure(apiKey: String) {
        self.apiKey = apiKey
    }
}
