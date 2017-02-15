//
//  MovieNetworkModel.swift
//  MyMovies
//
//  Created by Douglas Taquary on 10/02/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieNetworkModelType {
    var movie: Variable<MovieModel?> { get }
    func downloadMovie(_ title: String)
}

class MovieNetworkModel: MovieNetworkModelType {
    
    var movie = Variable<MovieModel?>(nil)
    
    var apiManager: Networking = Networking()

    fileprivate func setup() {}
    
    func downloadMovie(_ title: String) {
        MovieProvider.request(MovieAPI.movie(name: title)) { (result) -> () in
            switch result {
            case let .success(response):
                do {
                    let currentmovie = try response.map(to: MovieModel.self)
                    self.movie.value = currentmovie
                    print("\n\(String(describing: self.movie.value?.actors))\n")
                } catch {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
