  
  import Foundation
  
  class TranslateService {
    static var shared = TranslateService()
    private init() {}
    private var apiUrl = ConfigNetworkingService.Translate.baseUrl
    private var task: URLSessionDataTask?
    private var translateSession = URLSession(configuration: .default)
    init(translateSession: URLSession, apiUrl : String) {
        self.translateSession = translateSession
        self.apiUrl = apiUrl
    }
    init(translateSession: URLSession) {
        self.translateSession = translateSession
    }
    func getTranslate(text: String, targetCode: String, completion: @escaping (Result<Translate,ServiceError>) -> Void) {
        let arguments = [
            "key" : ConfigNetworkingService.Translate.apiKey,
            "q" : text,
            "source" : ConfigNetworkingService.Translate.languageSourceCode,
            "target" : targetCode,
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
        task = translateSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.requestError(error.localizedDescription)))
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
                let translate = try JSONDecoder().decode(Translate.self, from: data)
                print(translate)
                completion(.success(translate))
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(.decodingError))
            }
        }
        task?.resume()
    }
  }
