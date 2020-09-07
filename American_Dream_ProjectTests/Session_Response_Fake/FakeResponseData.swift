
import Foundation

class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://apple.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    class ServiceError: Error {}
    static let error = ServiceError()
    
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "OpenWheather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static var moneyCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "ConvertMoney", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static var translationCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let incorrectData = "erreur".data(using: .utf8)!
    static var imageData = "image".data(using: .utf8)!
}

