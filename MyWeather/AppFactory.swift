//
//  TabBarController.swift
//  MyWeather
//
//  Created by Александр Денисов on 10.04.2024.
//

import UIKit

final class AppFactory {
    
    func buildTabBar() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
        buildMain(),
        buildFavorites()
        ]
        
        tabBarController.selectedIndex = 0
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.unselectedItemTintColor = .gray
        tabBarController.tabBar.backgroundColor = .white
        
        return tabBarController
    }
    
    private func buildMain() -> UINavigationController {
        let vc = MainViewController()
        let vcTabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "cloud.sun.fill"), selectedImage: nil)
        vc.tabBarItem = vcTabBarItem
        
        let nav = UINavigationController(rootViewController: vc)
        
        
        return nav
    }
    
    private func buildFavorites() -> UINavigationController {
        let vc = FavoritesViewController()
        let vcTabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "star.fill"), selectedImage: nil)
        vc.tabBarItem = vcTabBarItem
        
        let nav = UINavigationController(rootViewController: vc)
        
        return nav
    }
    
}
