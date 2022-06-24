//
//  OpenweatherAPI.swift
//  WeatherApp
//
//  Created by Guglielmo Chimera on 13/06/22.
//

import Foundation

struct OpenweatherAPI {
    static let baseURL = "https://api.openweathermap.org/"
    static let path = "geo/1.0/direct"
    static let apiKey = "9616e49ec5c1472da3d8aee349210fb5"
    
    enum query {
    case q
    }
}

class WeatherRequest {
    
    //AppError enum which shows all possible errors
    enum AppError: Error {
        case networkError(Error)
        case dataNotFound
        case jsonParsingError(Error)
        case invalidStatusCode(Int)
    }

    //Result enum to show success or failure
    enum Result<T> {
        case success(T)
        case failure(AppError)
    }

    static let shared = WeatherRequest() // Singleton
    
    //dataRequest which sends request to given URL and convert to Decodable Object
    func dataRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
        
        //create the url with NSURL
        let dataURL = URL(string: url)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                completion(Result.failure(AppError.networkError(error!)))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(AppError.dataNotFound))
                return
            }
            
            do {
                //create decodable object from data
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completion(Result.success(decodedObject))
            } catch let error {
                completion(Result.failure(AppError.jsonParsingError(error as! DecodingError)))
            }
        })
        
        task.resume()
    }

    
}

/// Usage
 
//dataRequest(with: "https://api.openweathermap.org/geo/1.0/direct?q=London&limit=15&appid=3a5fabe12f5bccdfca69c983db89f6bb", objectType: WeatherModel.self) { (result: Result) in
//switch result {
//case .success(let object):
//    print(object)
//case .failure(let error):
//    print(error)
//}
//}

