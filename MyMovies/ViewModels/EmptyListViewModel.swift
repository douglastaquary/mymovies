//
//  EmptyListViewModel.swift
//  MyMovies
//
//  Created by Douglas Taquary on 28/02/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import Foundation

public struct EmptyListViewModel: TitleDescriptionViewModelProtocol {
    
    public let title: NSAttributedString
    public let description: NSAttributedString
    public let flexibleHeight: Bool
}

extension EmptyListViewModel {
    
    public init() {
        let style: StyleProvider = Style()
        
        title = NSAttributedString(string: "Bem vindo",
                                   font: style.title1,
                                   color: style.textColor)
        
        description = NSAttributedString(string: "Adicione seu primeiro Filme no botão \"+\"",
                                         font: style.body,
                                         color: style.textLightColor)
        
        flexibleHeight = true
    }
}
