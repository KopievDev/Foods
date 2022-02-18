//
//  NetworkService.swift
//  Foods
//
//  Created by Ivan Kopiev on 17.02.2022.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func getArticles<T:Codable>(type: T.Type, _ completion: @escaping (T?)-> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    let baseURL: URL? = URL(string: "https://api.jsonbin.io/b/620ca6bc1b38ee4b33bd9656")
    var session = URLSession(configuration: URLSessionConfiguration.default)

    init(configurator: URLSessionConfiguration) {
        self.session = URLSession(configuration: configurator)
    }
    
    func getArticles<T>(type: T.Type, _ completion: @escaping (T?) -> Void) where T : Decodable, T: Encodable {
        guard let baseURL = baseURL else {return}
        let request = URLRequest(url: baseURL)
        let decoder = JSONDecoder()
        session.dataTask(with: request) { data, _, error in
            
            guard let data = data, error == nil, let model = try? decoder.decode(type.self, from: data)  else {return}
            DispatchQueue.main.async {
                completion(model)
            }
        }.resume()
    }

}

