import Foundation

public struct GenericWithCursor<T: Decodable>: Decodable {
    public let result: T
    public let cursor: Cursor
}
