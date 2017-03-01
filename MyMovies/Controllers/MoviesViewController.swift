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

    let dataManager = MovieDataManager()
    
    var tableDatasource: MovieTableDatasource?
    var tableDelegate: MovieTableDelegate?

    var namesOfMovies: [NSManagedObject] = []

    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: MovieListViewModelProtocol = {
        return MovieListViewModel()
    }()
}

extension MoviesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBarItem()
        title = "Meus Filmes"
    }
}

extension MoviesViewController {
    override func viewWillAppear(_ animated: Bool) {

        loadData()
        
        if namesOfMovies.isEmpty {
           update()
        } else {
            self.setupTableView(with: namesOfMovies)
            self.tableView.reloadData()
        }
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

extension MoviesViewController: MovieDataManagerType {
    func saveNameOfMovie(with name: String) {
        let managedContext = dataManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Title", in: managedContext)!
        let movie = NSManagedObject(entity: entity, insertInto: managedContext)
        
        movie.setValue(name, forKey: "title")
        
        do {
            try managedContext.save()
            self.namesOfMovies.append(movie)
            self.tableView.reloadData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

extension MoviesViewController {

    func update() {
        tableView.reloadData()
        if let emptyListViewModel = viewModel.emptyListViewModel {
            let backgroundView = TitleDescriptionView()
            backgroundView.viewModel = emptyListViewModel
            tableView.backgroundView = backgroundView
        } else {
            tableView.backgroundView = nil
        }
    }
}


extension MoviesViewController {
    
    func setUpNavBarItem() {
        navigationController?.navigationBar
            .topItem?
            .rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,target: self, action: #selector(showAlert))
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Novo Filme", message: "Adicionar um novo filme", preferredStyle: .alert)
        
        let saveMovie = UIAlertAction(title: "Salvar", style: .default) { [unowned self] action in
            guard let movieName = alert.textFields?.first,
                let nameOfmovieToSave = movieName.text else {
                    return
            }
            self.saveNameOfMovie(with: nameOfmovieToSave)
            self.loadData()
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField()
        alert.addAction(saveMovie)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    func loadData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Title")
        let context = dataManager.persistentContainer.viewContext
        do{
            let results = try context.fetch(fetchRequest)
            namesOfMovies = results as! [NSManagedObject]
            tableView.reloadData()
        }catch{
            fatalError("Error is retriving titles items")
        }
    }
}

