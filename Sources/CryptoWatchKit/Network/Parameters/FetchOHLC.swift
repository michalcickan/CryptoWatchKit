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
    let after: Int?
    let before: Int?
    let periods: [OHLCPeriod]?
    
    public init(after: TimeInterval? = nil, before: TimeInterval? = nil, periods: [OHLCPeriod]? = nil) {
        self.after = after != nil ? Int(after!) : nil
        self.before = before != nil ? Int(before!) : nil
        self.periods = periods
    }
}
