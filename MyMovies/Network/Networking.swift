//
//  Networking.swift
//  MyMovies
//
//  Created by Douglas Taquary on 10/02/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import Foundation
import Moya
import RxSwift

struct Networking {
    var provider =  RxMoyaProvider<MovieAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    init() {
        provider = RxMoyaProvider<MovieAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    }
}

