import Foundation

public struct FetchPairs: Encodable {
    let limit: Int?
    let cursorId: String?
    
    public init(limit: Int? = nil, cursorId: String? = nil) {
        self.limit = limit
        self.cursorId = cursorId
    }
    
    enum CodingKeys: String, CodingKey {
        case limit, cursorId = "cursor"
    }
}
