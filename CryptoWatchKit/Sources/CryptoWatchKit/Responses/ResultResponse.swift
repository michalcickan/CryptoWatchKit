import Foundation

struct ResultResponse<T: Decodable>: Decodable {
    let result: T
}
