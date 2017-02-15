//
//  MovieTableDatasource.swift
//  MyMovies
//
//  Created by Douglas Taquary on 10/02/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit
import CoreData

final class MovieTableDatasource: NSObject, MoviesTableViewDatasource {
    
    var titles:[NSManagedObject] = []
    weak var tableView: UITableView?
    weak var delegate: UITableViewDelegate?
    
    required init(titles: [NSManagedObject], tableView: UITableView, delegate: UITableViewDelegate) {
        self.titles = titles
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        tableView.register(cellType: MovieViewCell.self)
        self.setupTableView()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieViewCell.self)
        let nameOfMovie = self.titles[indexPath.row]
        cell.name.text = nameOfMovie.value(forKey: "title") as? String
        return cell
    }
}

class MovieTableDelegate: NSObject, UITableViewDelegate {
    
    let delegate: MoviesDelegate
    
    init(_ delegate: MoviesDelegate) {
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MovieViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelectMovie(at: indexPath)
    }
}
