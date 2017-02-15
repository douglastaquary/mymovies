//
//  MovieAPI.swift
//  MyMovies
//
//  Created by Douglas Taquary on 11/02/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Moya_SwiftyJSONMapper

protocol JSONMappableTargetType: TargetType {
    var responseType: ALSwiftyJSONAble.Type { get }
}

let MovieProvider =  RxMoyaProvider<MovieAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])

enum MovieAPI {
    case movie(name: String)
}

extension MovieAPI: JSONMappableTargetType {
    
    var baseURL: URL { return URL(string: "http://www.omdbapi.com")! }
    
    var path: String {
        switch self {
        case .movie:
            return "/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .movie:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        
        switch self {
            
        case .movie(let name):
            return ["t": name]
        }
    }
    
    var responseType: ALSwiftyJSONAble.Type {
        switch self {
        case .movie:
            return MovieModel.self
        }
    }
    
    var task: Task {
        return .request
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}


