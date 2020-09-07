
import Foundation

// MARK: - OpenWeather
struct OpenWeather: Codable {
    let weathers: [Weather]
    enum CodingKeys: String, CodingKey {
        case weathers = "list"
    }
}
// MARK: - List
struct Weather : Codable {
    let conditions: [Condition]
    let temperature: Temperature
    let cityName: String
    var conditionDescription : String {
        return conditions[0].description
    }
    var degrees : Double {
        return temperature.degrees
    }
    var conditionIconUrl : String? {
        guard let icon = conditions[0].icon else {  return nil }
        return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
    enum CodingKeys: String, CodingKey {
        case conditions = "weather"
        case temperature = "main"
        case cityName = "name"
    }
}
extension Weather : CustomStringConvertible {
    var description: String {
        return "Weather for \(cityName) is \(degrees)°C with \(conditionDescription), IconUrl: \(conditionIconUrl ?? "Missing Icon Url")"
    }
}
// MARK: - Main
struct Temperature: Codable {
    let degrees : Double
    enum CodingKeys: String, CodingKey {
        case degrees = "temp"
    }
}
// MARK: - Weather
struct Condition: Codable {
    let description: String
    let icon: String?
}


