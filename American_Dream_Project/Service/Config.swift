
import Foundation

enum ConfigNetworkingService {
    enum openWeather {
        static let baseUrl = "https://api.openweathermap.org/data/2.5/group"
        static let identityTown = "2253350,5128638"
        static let degreesCelsius = "metric"
        static  let apiKey = APIKey.weather
    }
    enum money {
        static let baseUrl = "http://data.fixer.io/api/latest"
        static  let apiKey = APIKey.exchange
        static  let symbols = "USD,XOF"
    }
    enum Translate {
        static  let baseUrl = "https://translation.googleapis.com/language/translate/v2"
        static  let apiKey = APIKey.translation
        static let languageSourceCode = "fr"
    }
}



