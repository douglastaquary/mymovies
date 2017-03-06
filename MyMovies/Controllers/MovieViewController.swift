//
//  MovieViewController.swift
//  MyMovies
//
//  Created by Douglas Taquary on 10/02/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import CoreData

final class MovieViewController: UIViewController {
    
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var releseadMovie: UILabel!
    @IBOutlet weak var durationMovie: UILabel!
    @IBOutlet weak var genreMovie: UILabel!
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var writer: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var awards: UILabel!
    @IBOutlet weak var votes: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    @IBOutlet weak var message: UILabel!
    
    var movie = Variable<MovieModel?>(nil)
    var nameOfMovie: String?
    var apiManager: Networking!
    var dataManager = MovieDataManager()
}

extension MovieViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = false
        self.activityLoading.isHidden = false
        self.activityLoading.startAnimating()
        self.message.text = "Procurando filme..."
        
        searchMovie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = movie.value?.title ?? ""
    }
}

extension MovieViewController {
    func setupView() {
        
        let nameOfMovie = movie.value?.title ?? ""
        titleMovie.text = nameOfMovie.isEmpty ? "Nenhum Filme foi encontrado! " : nameOfMovie
        
        let year = movie.value?.year ?? ""
        movieYear.text = year.isEmpty ? "" : year
        
        let released = movie.value?.released ?? ""
        releseadMovie.text = released.isEmpty ? "" : released
        
        let duration = movie.value?.runtime ?? ""
        durationMovie.text = duration.isEmpty ? "" : duration
        
        let genre = movie.value?.genre ?? ""
        genreMovie.text = genre.isEmpty ? "" : genre
        
        let directorMovie = movie.value?.director ?? ""
        director.text = directorMovie.isEmpty ? "" : directorMovie
        
        let actorsMovie = movie.value?.actors ?? ""
        actors.text = actorsMovie.isEmpty ? "" : actorsMovie
        
        let writerMovie = movie.value?.writer ?? ""
        writer.text = writerMovie.isEmpty ? "" : writerMovie
        
        let ratingToMovie = movie.value?.rated ?? ""
        rating.text = ratingToMovie.isEmpty ? "" : ratingToMovie
        
        let awardsOfMovie = movie.value?.awards ?? ""
        awards.text = awardsOfMovie.isEmpty ? "" : awardsOfMovie
        
        let votesToMovie = movie.value?.imdbVotes ?? ""
        votes.text = votesToMovie.isEmpty ? "" : votesToMovie

        title = nameOfMovie
        
        thumb.download(image: movie.value?.poster ?? "")
    }
}

extension MovieViewController {

    func searchMovie() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let context = dataManager.persistentContainer.viewContext
        
        fetchRequest.predicate = NSPredicate(format: "title == %@", nameOfMovie!)
        do{
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                downloadMovie(nameOfMovie!)
            } else if results.count > 0 {
                let movie = results[0] as! NSManagedObject
                
                print("\n Fonte de Dados: \nCoreData: \(movie)\n")
                
                titleMovie.text = movie.value(forKey: "title") as? String
                movieYear.text = movie.value(forKey: "year") as? String
                releseadMovie.text = movie.value(forKey: "released") as? String
                durationMovie.text = movie.value(forKey: "runtime") as? String
                genreMovie.text = movie.value(forKey: "genre") as? String
                director.text = movie.value(forKey: "director") as? String
                actors.text = movie.value(forKey: "actors") as? String
                writer.text = movie.value(forKey: "writer") as? String
                rating.text = movie.value(forKey: "rated") as? String
                votes.text = movie.value(forKey: "imdbVotes") as? String
                awards.text = movie.value(forKey: "awards") as? String
                thumb.download(image: movie.value(forKey: "poster") as! String)
                
                self.activityLoading.stopAnimating()
                self.activityLoading.isHidden = true
                self.loadingView.isHidden = true
                self.message.isHidden = true
                
            } else {
                self.activityLoading.stopAnimating()
                self.activityLoading.isHidden = true
                self.message.text = "Nenhum filme encontrado 📹"
            }
        
        } catch{
            fatalError("Error is retriving titles items")
        }
    }
}


extension MovieViewController {
    func downloadMovie(_ title: String) {
        MovieProvider.request(MovieAPI.movie(name: title)) { (result) -> () in
            switch result {
            case let .success(response):
                do {
                    //Fix error para nenhum filme econtrado: response = false
                    let currentmovie = try response.map(to: MovieModel.self)
                    self.movie.value = currentmovie
                    self.setupView()
                    self.activityLoading.isHidden = true
                    self.loadingView.isHidden = true
                    self.message.isHidden = true
                } catch {
                    print("\n--> \(error)")
                    self.activityLoading.isHidden = true
                    self.loadingView.alpha = 1
                    self.message.text = "Nenhum filme encontrado 📹"
                    
                }
            case let .failure(error):
                self.activityLoading.isHidden = true
                self.loadingView.alpha = 1
                self.message.text = "Sem conexão com a internet ⚙️"
                print(error)
            }
        }
    }
}

