//
//  MovieModel.swift
//  MyMovies
//
//  Created by Douglas Taquary on 14/02/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import Foundation
import Moya_SwiftyJSONMapper
import SwiftyJSON

final class MovieModel : ALSwiftyJSONAble {
    
    let title: String
    let year: String
    
    let rated: String
    let released: String
    let runtime: String
    let genre: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let language: String
    let country: String
    let awards: String
    let poster: String
    
    let metascore: String
    let imdbRating: String
    let imdbVotes: String
    let imdbID: String
    let type: String
    let response: String
    
    required init?(jsonData:JSON){
        //self.args = jsonData["args"].object as? [String : String]
        
        self.title = jsonData["Title"].stringValue
        self.year = jsonData["Year"].stringValue
        
        self.rated = jsonData["Rated"].stringValue
        self.released = jsonData["Released"].stringValue
        self.runtime = jsonData["Runtime"].stringValue
        self.genre = jsonData["Genre"].stringValue
        self.director = jsonData["Director"].stringValue
        self.writer = jsonData["Writer"].stringValue
        self.actors = jsonData["Actors"].stringValue
        self.plot = jsonData["Plot"].stringValue
        self.language = jsonData["Language"].stringValue
        self.country = jsonData["Country"].stringValue
        self.awards = jsonData["Awards"].stringValue

        self.poster = jsonData["Poster"].stringValue
        
        self.metascore = jsonData["Released"].stringValue
        self.imdbRating = jsonData["ImdbRating"].stringValue
        self.imdbVotes = jsonData["ImdbVotes"].stringValue
        self.imdbID = jsonData["ImdbID"].stringValue
        self.type = jsonData["Type"].stringValue
        self.response = jsonData["Response"].stringValue
    }
    
}


