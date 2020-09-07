
import Foundation

enum ServiceError: Error {
    case invalidResponse
    case errorStatusCode(Int)
    case decodingError
    case invalidData
    case requestError(String)
    case invalidUrl
}
extension ServiceError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .errorStatusCode(let statusCode):
            return "Invalid Status Code \(statusCode)"
        case .requestError(let description):
            return "Request error : \(description)"
        case .invalidData :
            return "Invalid data"
        case .decodingError:
            return "Decoding error"
        case .invalidUrl :
            return "Invalid Url"
        case .invalidResponse:
            return "Invalid Response"
            
        }
    }
}
