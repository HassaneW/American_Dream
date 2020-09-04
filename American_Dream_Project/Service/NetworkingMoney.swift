//
//  NetworkingFixerIO.swift
//  test_Projet_9
//
//  Created by Wandianga on 6/28/20.
//  Copyright © 2020 Wandianga. All rights reserved.
//

import Foundation


class MoneyService {
    static var shared = MoneyService()
     
    
     private var apiUrl = ConfigNetworkingService.money.baseUrl
    
  
     
     private var task: URLSessionDataTask?
    private var convertMoneySession = URLSession(configuration: .default)
    
     private init() {}
    
    // Session api Url name
    init(convertMoneySession: URLSession, apiUrl : String) {
        self.convertMoneySession = convertMoneySession
        self.apiUrl = apiUrl
    }
    
    init(convertMoneySession: URLSession) {
        self.convertMoneySession = convertMoneySession
    }
    
//    let baseUrl = ConfigNetworkingService.money.baseUrl
    func getMoneys(completion: @escaping (Result<Money,ServiceError>) -> Void) {
        let arguments = [
            "access_key" : ConfigNetworkingService.money.apiKey,
            "symbols" : ConfigNetworkingService.money.symbols,
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
     
//        task = convertMoneySession.dataTask(with: url)
        
        task = convertMoneySession.dataTask(with: url) { (data, response, error) in
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
                let moneyConversion = try JSONDecoder().decode(Money.self, from: data)
                completion(.success(moneyConversion))
            } catch let error {
              print(error.localizedDescription)
                completion(.failure(.decodingError))
            }
        }
        task?.resume()
    }
}

