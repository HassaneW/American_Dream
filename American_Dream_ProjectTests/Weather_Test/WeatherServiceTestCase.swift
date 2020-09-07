
import XCTest
@testable import American_Dream_Project

class Wheather: XCTestCase {
    func test_getWeathersInvalidURL() {
        let urlSession = URLSessionFake(data: nil, response: nil, error: nil)
        let badUrl = "@,%"
        let weatherService = WeatherService(openWheatherSession: urlSession, apiUrl: badUrl)
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getWeathers { (result) in
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
    func test_getWeathersError() {
        let fakeError = FakeResponseData.error
        let urlSession = URLSessionFake(data: nil, response: nil, error: fakeError)
        let weatherService = WeatherService(openWheatherSession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getWeathers { (result) in
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
    func test_getWeathersinvalidResponse() {
        let urlSession = URLSessionFake(data: nil, response: nil, error: nil)
        let weatherService = WeatherService(openWheatherSession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getWeathers { (result) in
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
    func test_getWeathersErrorStatusCode() {
        let fakeResponse = FakeResponseData.responseKO
        let urlSession = URLSessionFake(data: nil, response: fakeResponse, error: nil)
        let weatherService = WeatherService(openWheatherSession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getWeathers { (result) in
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
    func test_getWeathersInvalidData() {
        let fakeResponse = FakeResponseData.responseOK
        let urlSession = URLSessionFake(data: nil, response: fakeResponse, error: nil)
        let weatherService = WeatherService(openWheatherSession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getWeathers { (result) in
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
    func test_getWeathersDecodingError() {
        let fakeData = FakeResponseData.incorrectData
        let fakeResponse = FakeResponseData.responseOK
        let urlSession = URLSessionFake(data: fakeData, response: fakeResponse, error: nil)
        let weatherService = WeatherService(openWheatherSession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getWeathers { (result) in
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
    func test_getWeathersDecodingSucess() {
        let fakeData = FakeResponseData.weatherCorrectData
        let fakeResponse = FakeResponseData.responseOK
        let urlSession = URLSessionFake(data: fakeData, response: fakeResponse, error: nil)
        let weatherService = WeatherService(openWheatherSession: urlSession)
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        weatherService.getWeathers { (result) in
            switch result {
            case .success (let weather):
                XCTAssertEqual(weather.count, 2)
                XCTAssertEqual(weather[0].cityName, "Dakar")
                XCTAssertEqual(weather[1].cityName, "New York")
                XCTAssertEqual(weather[0].conditionDescription, "broken clouds")
                XCTAssertEqual(weather[1].conditionDescription, "few clouds")
                XCTAssertEqual(weather[0].degrees, 27.52)
                XCTAssertEqual(weather[1].degrees, 13.39)
                XCTAssertEqual(weather[0].conditions[0].icon, "04d")
                XCTAssertNil(weather[1].conditions[0].icon)
                XCTAssertEqual(weather[0].conditionIconUrl, "https://openweathermap.org/img/wn/04d@2x.png")
                XCTAssertNil(weather[1].conditionIconUrl)
                XCTAssertEqual(weather[0].description, "Weather for Dakar is 27.52°C with broken clouds, IconUrl: https://openweathermap.org/img/wn/04d@2x.png")
                XCTAssertEqual(weather[1].description, "Weather for New York is 13.39°C with few clouds, IconUrl: Missing Icon Url")
                
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for : [expectation], timeout: 0.1)
    }
}
