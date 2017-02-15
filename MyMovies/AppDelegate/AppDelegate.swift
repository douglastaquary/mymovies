//
//  AppDelegate.swift
//  MyMovies
//
//  Created by Douglas Taquary on 07/02/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let dataManager = MovieDataManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        ApperanceHelper.customizeNavigationBar()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        dataManager.saveContext()
    }
}

