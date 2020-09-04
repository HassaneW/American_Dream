//
//  NetworkingService.swift
//  test_Projet_9
//
//  Created by Wandianga on 6/27/20.
//  Copyright © 2020 Wandianga. All rights reserved.
//

import Foundation



class WeatherService {
    static var shared = WeatherService()
    private init() {}

  private var apiUrl = ConfigNetworkingService.openWeather.baseUrl
    
    private var task: URLSessionDataTask?
   private var openWheatherSession = URLSession(configuration: .default)
    
    // 3) Cette instance de fausses donnés et stocker dans le constructeur et elle va remplacer l'implémentation de urlSession. C'est içi que l'appel réseau va être simuler
    
    // Session api Url name
    init(openWheatherSession: URLSession, apiUrl : String) {
        self.openWheatherSession = openWheatherSession
        self.apiUrl = apiUrl
    }

    init(openWheatherSession : URLSession) {
        self.openWheatherSession = openWheatherSession
    }
    
//    init(openWheatherSession: URLSession, apiUrl: String? = nil) {
//        self.openWheatherSession = openWheatherSession
//        if let apiUrl = apiUrl {
//            self.apiUrl = apiUrl
//        }
//    }
   
    
    
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
//        URLSession.shared
            // 4 Créer une instance de datataskFake
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
