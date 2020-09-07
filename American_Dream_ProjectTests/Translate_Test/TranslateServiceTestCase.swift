
import XCTest
@testable import American_Dream_Project

class Translate: XCTestCase {
    func test_getTranslateInvalidURL() {
        let fakeError = FakeResponseData.error
        let urlSession = URLSessionFake(data: nil, response: nil, error: fakeError)
        let badUrl = "@,%"
        let translateService = TranslateService(translateSession: urlSession, apiUrl: badUrl)
        let expectation = XCTestExpectation(description: "wait for queue")
        
        translateService.getTranslate(text: "q", targetCode: "target") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, ServiceError.invalidUrl.errorDescription)
            case .success:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for : [expectation], timeout: 0.1)
    }
    func test_getTranslateError() {
        let fakeError = FakeResponseData.error
        let urlSession = URLSessionFake(data: nil, response: nil, error: fakeError)
        let translateService = TranslateService(translateSession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue")
        
        translateService.getTranslate(text: "q", targetCode: "target") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for : [expectation], timeout: 0.1)
    }
    func test_getTranslateInvalidResponse() {
        let urlSession = URLSessionFake(data: nil, response: nil, error: nil)
        let translateService = TranslateService(translateSession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue")
        
        translateService.getTranslate(text: "q", targetCode: "target") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, ServiceError.invalidResponse.errorDescription)
            case .success:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for : [expectation], timeout: 0.1)
    }
    func test_getTranslateErrorStatusCode() {
        let fakeResponse = FakeResponseData.responseKO
        let urlSession = URLSessionFake(data: nil, response: fakeResponse, error: nil)
        let translateService = TranslateService(translateSession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue")
        
        translateService.getTranslate(text: "q", targetCode: "target") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, ServiceError.errorStatusCode(500).errorDescription)
            case .success:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for : [expectation], timeout: 0.1)
    }
    func test_getTranslateInvalidData() {
        let fakeResponse = FakeResponseData.responseOK
        let urlSession = URLSessionFake(data: nil, response: fakeResponse, error: nil)
        let translateService = TranslateService(translateSession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue")
        
        translateService.getTranslate(text: "q", targetCode: "target") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, ServiceError.invalidData.errorDescription)
            case .success:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for : [expectation], timeout: 0.1)
    }
    func test_getTranslateDecodingError() {
        let fakeData = FakeResponseData.incorrectData
        let fakeResponse = FakeResponseData.responseOK
        let urlSession = URLSessionFake(data: fakeData, response: fakeResponse, error: nil)
        let translateService = TranslateService(translateSession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue")
        
        translateService.getTranslate(text: "q", targetCode: "target") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, ServiceError.decodingError.errorDescription)
            case .success:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for : [expectation], timeout: 0.1)
    }
    func test_getTranslateDecodingSucess() {
        let fakeData = FakeResponseData.translationCorrectData
        let fakeResponse = FakeResponseData.responseOK
        let urlSession = URLSessionFake(data: fakeData, response: fakeResponse, error: nil)
        let translateService = TranslateService(translateSession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue")
        
        translateService.getTranslate(text: "q", targetCode: "target") { (result) in
            switch result {
            case .success (let translate):
                XCTAssertEqual(translate.translatedText, "大家好")
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for : [expectation], timeout: 0.1)
    }
}
