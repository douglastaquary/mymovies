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

}

extension MovieViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = false
        self.activityLoading.isHidden = false
        self.activityLoading.startAnimating()
        self.message.text = "Procurando filme..."
        downloadMovie(nameOfMovie!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = movie.value?.title ?? ""
    }
}

extension MovieViewController {
    func setupView() {
        
        let nameOfFilme = movie.value?.title ?? ""
        titleMovie.text = nameOfFilme.isEmpty ? "Nenhum nome" : nameOfFilme
        
        let year = movie.value?.year ?? ""
        movieYear.text = year.isEmpty ? "Sem descrição" : year
        
        let released = movie.value?.released ?? ""
        releseadMovie.text = released.isEmpty ? "Sem descrição" : released
        
        let duration = movie.value?.runtime ?? ""
        durationMovie.text = duration.isEmpty ? "Sem descrição" : duration
        
        let genre = movie.value?.genre ?? ""
        genreMovie.text = genre.isEmpty ? "Sem descrição" : genre
        
        let directorMovie = movie.value?.director ?? ""
        director.text = directorMovie.isEmpty ? "Sem descrição" : directorMovie
        
        let actorsMovie = movie.value?.actors ?? ""
        actors.text = actorsMovie.isEmpty ? "Sem descrição" : actorsMovie
        
        let writerMovie = movie.value?.writer ?? ""
        writer.text = writerMovie.isEmpty ? "Sem descrição" : writerMovie
        
        let ratingToMovie = movie.value?.rated ?? ""
        rating.text = ratingToMovie.isEmpty ? "Sem descrição" : ratingToMovie
        
        let awardsOfMovie = movie.value?.awards ?? ""
        awards.text = awardsOfMovie.isEmpty ? "Sem descrição" : awardsOfMovie
        
        let votesToMovie = movie.value?.imdbVotes ?? ""
        votes.text = votesToMovie.isEmpty ? "Sem descrição" : votesToMovie

        title = nameOfFilme
        
        thumb.download(image: movie.value?.poster ?? "")
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

