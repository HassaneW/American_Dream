
import XCTest
@testable import American_Dream_Project

class Money: XCTestCase {
    func test_getMoneysInvalidURL() {
        let urlSession = URLSessionFake(data: nil, response: nil, error: nil)
        let badUrl = "@,%"
        let moneyService = MoneyService(convertMoneySession: urlSession, apiUrl: badUrl)
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        moneyService.getMoneys { (result) in
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
    func test_getMoneysError() {
        let fakeError = FakeResponseData.error
        let urlSession = URLSessionFake(data: nil, response: nil, error: fakeError)
        let moneyService = MoneyService(convertMoneySession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        moneyService.getMoneys { (result) in
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
    func test_getMoneyInvalidResponse() {
        let urlSession = URLSessionFake(data: nil, response: nil, error: nil)
        let moneyService = MoneyService(convertMoneySession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        moneyService.getMoneys { (result) in
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
    func test_getMoneyErrorStatusCode() {
        let fakeResponse = FakeResponseData.responseKO
        let urlSession = URLSessionFake(data: nil, response: fakeResponse, error: nil)
        let moneyService = MoneyService(convertMoneySession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        moneyService.getMoneys { (result) in
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
    func test_getMoneyInvalidData() {
        let fakeResponse = FakeResponseData.responseOK
        let urlSession = URLSessionFake(data: nil, response: fakeResponse, error: nil)
        let moneyService = MoneyService(convertMoneySession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        moneyService.getMoneys { (result) in
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
    func test_getMoneyDecodingError() {
        let fakeData = FakeResponseData.incorrectData
        let fakeResponse = FakeResponseData.responseOK
        let urlSession = URLSessionFake(data: fakeData, response: fakeResponse, error: nil)
        let moneyService = MoneyService(convertMoneySession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        moneyService.getMoneys { (result) in
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
    func test_getMoneysDecodingSucess() {
        let fakeData = FakeResponseData.moneyCorrectData
        let fakeResponse = FakeResponseData.responseOK
        let urlSession = URLSessionFake(data: fakeData, response: fakeResponse, error: nil)
        let moneyService = MoneyService(convertMoneySession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        moneyService.getMoneys { (result) in
            switch result {
            case .success (let money):
                XCTAssertEqual(money.base, "EUR")
                XCTAssertEqual(money.date, "2020-08-25")
                XCTAssertEqual(money.monnaie.dollar, 1.183019)
                XCTAssertEqual(money.monnaie.cfa, 657.685376)
                XCTAssertEqual(money.baseConversion, 1.183019)
                XCTAssertEqual(money.description, "Base Money : EUR, date : 2020-08-25, Conversion : 1.183019$")
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for : [expectation], timeout: 0.1)
    }
}
