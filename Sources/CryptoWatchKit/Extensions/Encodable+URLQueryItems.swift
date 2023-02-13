import Foundation

extension Encodable {
    var queryItems: [URLQueryItem] {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            assertionFailure("Cannot decode params")
            return []
        }
        return dictionary.map { (key, value) in
            guard let arr = value as? Array<Any> else {
                return URLQueryItem(name: key, value: String(describing: value))
            }
            return URLQueryItem(
                name: key,
                value: arr.map { String(describing: $0) }.joined(separator: ",")
            )
        }
    }
}
