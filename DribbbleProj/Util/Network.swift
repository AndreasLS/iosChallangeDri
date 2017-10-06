//
//  Network.swift
//  DribbbleProj
//
//  Created by Andre Luiz Salla on 04/10/17.
//  Copyright © 2017 Andre Luiz Salla. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkResult<T> where T: Parseable {
        case success(result: T?)
        case failure(message: String)
}

final class ApiAccess<T> where T: Parseable {
    
    class func listPopularShots(page: Int, _ completion: @escaping (NetworkResult<ArrayParseable<T>>)->()) {
        NetworkAccess<ArrayParseable<T>>.get(endPoint: .listPopularShots, parameters: ["sort" : "views", "per_page" : 20, "page" : page], completion: completion)
    }
    
}


//Internal
fileprivate enum EndPoints {
    case listPopularShots
    
    var fullUrl: String {
        var url = "https://api.dribbble.com/v1/"
        switch self {
        case .listPopularShots: url += "shots/"
        }
        return url
    }
    
    static var accessToken: String {return "___"}
}

fileprivate class NetworkAccess<T> where T: Parseable {
    
    class func get(endPoint: EndPoints, parameters: [String: Any]? = nil, completion: @escaping (NetworkResult<T>)->()) {
        guard let url = URL.init(string: endPoint.fullUrl) else {
            return
        }
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: ["Authorization" : "Bearer " + EndPoints.accessToken]).responseData { (response) in
            if response.result.isSuccess {
                completion(NetworkResult<T>.success(result: T.init(response.data)))
            } else {
                completion(NetworkResult<T>.failure(message: response.error?.localizedDescription ?? DribbbleStrings.erroDesconhecido.string))
            }
        }.resume()
    }
    
}
