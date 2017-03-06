//
//  MovieListViewModelProtocol.swift
//  MyMovies
//
//  Created by Douglas Taquary on 28/02/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import Foundation

public protocol MovieListViewModelProtocol {    
    var items: UInt { get }
    var emptyListViewModel: TitleDescriptionViewModelProtocol? { get }
}

public struct MovieListViewModel: MovieListViewModelProtocol {
    public let items: UInt
    public var emptyListViewModel: TitleDescriptionViewModelProtocol?
}

extension MovieListViewModel {
    
    public init() {

        items = 0
        emptyListViewModel = EmptyListViewModel()
    }
}

