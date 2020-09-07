
import Foundation

class WeatherService {
    static var shared = WeatherService()
    private init() {}
    private var apiUrl = ConfigNetworkingService.openWeather.baseUrl
    private var task: URLSessionDataTask?
    private var openWheatherSession = URLSession(configuration: .default)
    init(openWheatherSession: URLSession, apiUrl : String) {
        self.openWheatherSession = openWheatherSession
        self.apiUrl = apiUrl
    }
    init(openWheatherSession : URLSession) {
        self.openWheatherSession = openWheatherSession
    }
    func getWeathers(completion: @escaping (Result<[Weather],ServiceError>) -> Void) {
        let arguments = [
            "id" : ConfigNetworkingService.openWeather.identityTown,
            "units" : ConfigNetworkingService.openWeather.degreesCelsius,
            "appid" : ConfigNetworkingService.openWeather.apiKey
        ]
        var urlComponents = URLComponents(string: apiUrl)
        var queryItems = [URLQueryItem]()
        for (key, value) in arguments {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else {
            completion(.failure(.invalidUrl))
            return
        }
        task = openWheatherSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.requestError(error.localizedDescription)))
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    completion(.failure(.errorStatusCode(status)))
                    return
                }
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                do {
                    let openWeather = try JSONDecoder().decode(OpenWeather.self, from: data)
                    completion(.success(openWeather.weathers))
                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(.decodingError))
                }
            }
        }
        task?.resume()
    }
}
