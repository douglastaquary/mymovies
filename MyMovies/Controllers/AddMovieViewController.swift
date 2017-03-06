//
//  AddMovieViewController.swift
//  MyMovies
//
//  Created by Douglas Taquary on 05/03/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit
import CoreData

protocol AddMovieDelegate {
    func didEnd()
}

class AddMovieViewController: UIViewController {
    
    @IBOutlet weak var addMovieTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var dataManager = MovieDataManager()
    
    var namesOfMovies: [NSManagedObject] = []
}

extension AddMovieViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.addTarget(self, action: #selector(addMovie), for: .touchUpInside)
        addButton.layer.borderWidth = 1.0
        addButton.layer.borderColor = UIColor.purple.cgColor
        
        //Cancel button
        cancelButton.addTarget(self, action: #selector(didEnd), for: .touchUpInside)
    }
}

extension AddMovieViewController: MovieDataManagerType {
    
    func saveNameOfMovie(with name: String) {
        let managedContext = dataManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Title", in: managedContext)!
        let movie = NSManagedObject(entity: entity, insertInto: managedContext)
        
        movie.setValue(name, forKey: "title")
        
        do {
            try managedContext.save()
            didEnd()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func addMovie() {
        guard let movie = addMovieTextField.text else {
            return
        }
        self.saveNameOfMovie(with: movie)
    }
}

extension AddMovieViewController: AddMovieDelegate {
    func didEnd() {
        self.dismiss(animated: true, completion: nil)
    }
}





