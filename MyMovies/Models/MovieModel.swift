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
import CoreData

final class MovieModel : ALSwiftyJSONAble {
    
    var dataManager = MovieDataManager()
    
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
        
        saveMovie()
    }
    
}


extension MovieModel {
    func saveMovie() {
        let managedContext = dataManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)!
        let movie = NSManagedObject(entity: entity, insertInto: managedContext)
        
        movie.setValue(title, forKey: "title")
        movie.setValue(year, forKey: "year")
        movie.setValue(rated, forKey: "rated")
        movie.setValue(released, forKey: "released")
        movie.setValue(runtime, forKey: "runtime")
        movie.setValue(genre, forKey: "genre")
        movie.setValue(director, forKey: "director")
        movie.setValue(writer, forKey: "writer")
        movie.setValue(actors, forKey: "actors")
        movie.setValue(plot, forKey: "plot")
        movie.setValue(language, forKey: "language")
        movie.setValue(country, forKey: "country")
        movie.setValue(awards, forKey: "awards")
        movie.setValue(poster, forKey: "poster")
        movie.setValue(metascore, forKey: "metascore")
        movie.setValue(imdbRating, forKey: "imdbRating")
        movie.setValue(imdbVotes, forKey: "imdbVotes")
        movie.setValue(imdbID, forKey: "imdbID")
        movie.setValue(type, forKey: "type")
        movie.setValue(response, forKey: "response")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}


