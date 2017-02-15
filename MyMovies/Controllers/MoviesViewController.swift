//
//  MoviesViewController.swift
//  MyMovies
//
//  Created by Douglas Taquary on 07/02/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit
import CoreData

protocol MoviesDelegate {
    func didSelectMovie(at index: IndexPath)
}

final class MoviesViewController: UIViewController {
    
    //var provider: Networking!
    
    let dataManager = MovieDataManager()

    var tableDatasource: MovieTableDatasource?
    var tableDelegate: MovieTableDelegate?

    var namesOfMovies: [NSManagedObject] = []

    @IBOutlet weak var tableView: UITableView!
}

extension MoviesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        namesOfMovies.append(contentsOf: dataManager.fetchTitles())
        self.setupTableView(with: namesOfMovies)
        setUpNavBarItem()
        title = "My Movies"

    }
}

extension MoviesViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // namesOfMovies.append(contentsOf: dataManager.fetchTitles())
        //print("\n --> \(namesOfMovies.count)\n")
    }
}

extension MoviesViewController {
    func setupTableView(with titles: [NSManagedObject]) {
        self.namesOfMovies = titles
        tableDelegate = MovieTableDelegate(self)
        tableDatasource = MovieTableDatasource(titles: namesOfMovies, tableView: self.tableView, delegate: tableDelegate!)
    }
}

extension MoviesViewController: MoviesDelegate {
    func didSelectMovie(at index: IndexPath) {
        guard let nextController = Storyboard.Main.movieViewControllerScene
            .viewController() as? MovieViewController else {
                return
        }
        
        let nameOfMovie = namesOfMovies[index.row]
        nextController.nameOfMovie = nameOfMovie.value(forKey: "title") as? String
        self.navigationController?.pushViewController(nextController, animated: true)
    }
}


extension MoviesViewController {
    
    func setUpNavBarItem() {
        navigationController?.navigationBar
            .topItem?
            .rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,target: self, action: #selector(showAlert))
    }
    
    func showAlert() {
        let alert =
            UIAlertController(
                title: "Novo filme",
                message: "Adicionar um novo filme",
                preferredStyle: .alert)
        
        let saveMovie =
            UIAlertAction(title: "Salvar",
                          style: .default) { [unowned self] action in
                                            
        guard let movieName = alert.textFields?.first,
            let nameOfmovieToSave = movieName.text else {
                return
        }
                                            
        self.dataManager.saveNameOfMovie(with: nameOfmovieToSave)
        self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        alert.addTextField()
        alert.addAction(saveMovie)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

