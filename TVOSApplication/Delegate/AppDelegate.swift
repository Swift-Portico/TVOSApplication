//
//  AppDelegate.swift
//  TVOSApplication
//
//  Created by Pradeep's Macbook on 04/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = self.setupTabbar()
        window?.makeKeyAndVisible()
        return true
    }
    
    private func setupTabbar() -> UITabBarController {
        let homeVC = getViewControllerInstantiation(with: "HomeViewController", for: "Home")
        let searchVC = getViewControllerInstantiation(with: "SearchViewController", for: "Search")
        let profileVC = getViewControllerInstantiation(with: "ProfileViewController", for: "Profile")
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [homeVC, searchVC, profileVC]
        return tabbarController
    }
    
    private func getViewControllerInstantiation(with identifier: String, for title: String) -> UIViewController {
        let genericVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: identifier)
        genericVC.tabBarItem.title = title
        return genericVC
    }
}

