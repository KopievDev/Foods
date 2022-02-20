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

enum APIType {
    case articles

    var baseURL: URL? {urlComponents.url}
    
    var path: String {
        switch self {
        case .articles: return "b/620ca6bc1b38ee4b33bd9656"
        }
    }
    
    var urlComponents: URLComponents {
        var urlComp = URLComponents()
        urlComp.scheme = "https"
        urlComp.host = "api.jsonbin.io"
        return urlComp
    }
    
    var request: URLRequest? {
        guard let url = URL(string: path, relativeTo: baseURL) else {return nil}
        var request = URLRequest(url: url)
        switch self {
        case .articles:
            request.httpMethod = "GET"
            return request
        }
    }
}

class NetworkService: NetworkServiceProtocol {
    
    var session = URLSession(configuration: URLSessionConfiguration.default)

    init(configurator: URLSessionConfiguration) {
        self.session = URLSession(configuration: configurator)
    }
    
    func getArticles<T>(type: T.Type, _ completion: @escaping (T?) -> Void) where T : Decodable, T: Encodable {
        guard let request = APIType.articles.request else {return}
        let decoder = JSONDecoder()
        session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil, let model = try? decoder.decode(type.self, from: data)  else {return}
            DispatchQueue.main.async {completion(model)}
        }.resume()
    }

}

