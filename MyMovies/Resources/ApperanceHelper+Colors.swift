//
//  ApperanceHelper.swift
//  MyMovies
//
//  Created by Douglas Taquary on 15/02/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//


import Foundation
import UIKit

struct ApperanceHelper {
    
    static func customizeNavigationBar() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
    }
}

public func getRandomColor() -> UIColor{
    let red:CGFloat = CGFloat(drand48())
    let green:CGFloat = CGFloat(drand48())
    let blue:CGFloat = CGFloat(drand48())
    
    return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
}
