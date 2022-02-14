//
//  AppDelegate.swift
//  lagos-github-users
//
//  Created by Beulah Ana on 09/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let vc = UINavigationController(rootViewController: UsersVC()) 
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        return true
    }

   


}

