//
//  MoviesTableViewDataSource.swift
//  MyMovies
//
//  Created by Douglas Taquary on 07/02/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit

protocol MoviesTableViewDatasource: UITableViewDataSource {
    associatedtype T
    var titles:[T] {get}
    weak var tableView: UITableView? {get}
    weak var delegate: UITableViewDelegate? {get}
    
    init(titles: [T], tableView: UITableView, delegate: UITableViewDelegate)
    
    func setupTableView()
}

extension MoviesTableViewDatasource {
    func setupTableView() {
        self.tableView?.dataSource = self
        self.tableView?.delegate = self.delegate
        self.tableView?.reloadData()
    }
}
