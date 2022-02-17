//
//  NetworkService.swift
//  Foods
//
//  Created by Ivan Kopiev on 17.02.2022.
//

import Foundation

typealias ResponseBlock = ([String: Any]) -> Void

protocol NetworkServiceProtocol: AnyObject {
    func getArticles(_ completion: @escaping ResponseBlock)
}

class NetworkService: NetworkServiceProtocol {
    
    let baseURL: URL? = URL(string: "https://api.jsonbin.io/b/620ca6bc1b38ee4b33bd9656")
    var session = URLSession(configuration: URLSessionConfiguration.default)

    init(configurator: URLSessionConfiguration) {
        self.session = URLSession(configuration: configurator)
    }
    
    func getArticles(_ completion: @escaping ResponseBlock) {
        guard let baseURL = baseURL else {return}
        let request = URLRequest(url: baseURL)
        session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil, let json = self.jsonToDictionary(data: data) else {return}
            DispatchQueue.main.async {
                completion(json)
            }
        }.resume()
    }
    
    private func jsonToDictionary(data: Data) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            return nil
        }
    }
}

