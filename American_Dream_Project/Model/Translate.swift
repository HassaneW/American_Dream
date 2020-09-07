
import Foundation

// MARK: - Translate
struct Translate: Codable {
    let data: DataClass
    var translatedText: String {
        return data.translations[0].translatedText
    }
}
// MARK: - DataClass
struct DataClass: Codable { //TODO: change name
    let translations: [Translation]
}
// MARK: - Translation
struct Translation: Codable {
    let translatedText: String
}
#if DEBUG
extension Translate : CustomStringConvertible {
    // Never call description in the code
    var description: String {
        return "Translate sentence is: \(translatedText)"
    }
}
#endif
