//
//  TabBarViewController.swift
//  InstagramRemake
//
//  Created by Octav Radulian on 22.03.2023.
//

import UIKit

//this is the tabBarController where we show what tab is selected

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let email = UserDefaults.standard.string(forKey: "email"),
              let username = UserDefaults.standard.string(forKey: "username") else {
            return
        }
        
        let currentUser = User(username: username,
                               email: email)
        
        //Define VCs to appear in the bottom bar
        
        let home = HomeViewController()
        let explore = ExploreViewController()
        let camera = CameraViewController()
        let activity = NotificationsViewController()
        let settings = ProfileViewController(user: currentUser)
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: explore)
        let nav3 = UINavigationController(rootViewController: camera)
        let nav4 = UINavigationController(rootViewController: activity)
        let nav5 = UINavigationController(rootViewController: settings)
      
        nav3.navigationItem.backButtonDisplayMode = .minimal
      
        //todo for loop
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label
        nav4.navigationBar.tintColor = .label
        nav5.navigationBar.tintColor = .label
        
        //Define the items for these VCs
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Camera", image: UIImage(systemName: "camera"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(systemName: "bell.badge"), tag: 4)
        nav5.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "person.circle"), tag: 5)
        
        
        //Set controllers
        self.setViewControllers([nav1, nav2, nav3, nav4, nav5], animated: false)
    }
    
}
