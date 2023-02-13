import Foundation

struct DictionaryResult<K: CodingKey, V: Decodable>: Decodable where K: Hashable {
    let values: [K: V]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: K.self)
        var values = [K: V]()
        container.allKeys.forEach {
            if let value = try? container.decodeIfPresent(V.self, forKey: $0) {
                values[$0] = value
            }
        }
        self.values = values
    }
}
