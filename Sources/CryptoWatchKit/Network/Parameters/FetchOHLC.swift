import Foundation

public enum OHLCPeriod: String, Encodable, Hashable, CodingKey {
    case minute = "60",
         threeMinutes = "180",
         fiveMinutes = "300",
         thirtyMinutes = "1800",
         hour = "3600",
         twoHours = "7200",
         fourHours = "14400",
         sixHours = "21600",
         twelveHours = "43200",
         day = "86400",
         threeDays = "259200",
         week = "604800",
         weekStartingOnMonday = "604800_Monday"
}

public struct FetchOHLC: Encodable {
    let after: TimeInterval?
    let before: TimeInterval?
    let periods: [OHLCPeriod]?
    
    public init(after: TimeInterval? = nil, before: TimeInterval? = nil, periods: [OHLCPeriod]? = nil) {
        self.after = after
        self.before = before
        self.periods = periods
    }
}
