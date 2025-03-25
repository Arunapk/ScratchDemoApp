//
//  NetworkManager.swift
//  ScratchApp
//
//  Created by HTS-676 on 07/02/25.
//

import Foundation
import Alamofire

public typealias Parameters = [String: Any]

class NetworkManager {
    static let shared = NetworkManager() // Singleton instance
    
    private let baseURL = "https://dummyjson.com/"
    
    private init() {} // Prevents external initialization
    
    //MARK: URL Session
    // Generic function to fetch data from API
//    func request<T: Decodable>(endpoint: String, method: String = "GET", parameters: [String: Any]? = nil) async throws -> T {
//        guard let url = URL(string: baseURL + endpoint) else {
//            throw NetworkError.invalidURL
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = method
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        // Add request body if parameters are provided
//        if let parameters = parameters {
//            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//        }
//        
//        let (data, response) = try await URLSession.shared.data(for: request)
//        
//        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//            throw NetworkError.serverError
//        }
//        
//        return try JSONDecoder().decode(T.self, from: data)
//    }
    
    //MARK: URLSession
    func APIRequestSession<T: baseSwiftyJSON>(endPoints: URLEndPoints, Method: HTTPMethod, Parameters: Parameters? = nil, completion: @escaping(Result<T, NetworkError>) -> Void){
        let urlString = baseURL + endPoints.value
        guard let URL = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        var URLrequest = URLRequest(url: URL)
        URLrequest.httpMethod = Method.rawValue
        URLrequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
    }
    
    
    //MARK: Alamofire
    func APIRequest<T: baseSwiftyJSON>(endPoints: URLEndPoints, Method: HTTPMethod, Parameters: Parameters? = nil, completion: @escaping(Result<T, NetworkError>) -> Void){
        
        let urlString = baseURL + endPoints.value
        guard let URL = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        AF.request(URL, parameters: Parameters).response(queue: DispatchQueue.main, completionHandler: { (AFResponseData) in
            switch AFResponseData.result {
            case .success(let data):
                guard let jsonResult = dataToJSON(data: data ?? Data()) else { return }
                let jsonValue = LocalJSONObject(jsonResult)
                let jsonInit = T.init(json: jsonValue)
                completion(.success(jsonInit))
                debugPrint("\(jsonValue)")
                break
            case .failure(let error):
                completion(.failure(.requestFailed(error: error)))
                debugPrint("\(error)")
                break
            }
        })
    }
}

func dataToJSON(data: Data) -> Any? {
    do {
        return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    } catch let myJSONError {
        print(myJSONError)
    }
    return nil
}

struct NetworkParameter{
    var endPoint: String
    var method: HTTPMethod
    var parameter: Parameters
    
}

// Network error types
public enum NetworkError: Error {
    case invalidURL
    case serverError
    case decodingError
    case requestFailed(error: Error)
}



