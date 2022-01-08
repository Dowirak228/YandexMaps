//
//  CustomTabBarController.swift
//  YandexMapsDemo
//
//  Created by NODIR KARIMOV on 07/01/22.
//

import UIKit
import SnapKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabFrame = tabBar.frame
        tabFrame.size.height = 65
        tabFrame.origin.y = view.frame.size.height - tabFrame.size.height
        tabBar.frame = tabFrame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.7862602472, green: 0.7896603942, blue: 0.8003454804, alpha: 1)
        tabBar.tintColor = .black
        
        let firstViewController = UINavigationController(rootViewController: FirstViewController())
        tabbarImage(vc: firstViewController, image: "icon1")
        
        let secondViewController = SecondViewController()
        tabbarImage(vc: secondViewController, image: "icon2")
        
        let thirdViewController = UIViewController()
        tabbarImage(vc: thirdViewController, image: "icon3")
        
        viewControllers = [firstViewController, secondViewController, thirdViewController]

        selectedIndex = 1
        
        cornerRadiusOfTabbar()
        topShadowTabbar()
    }
    
    func tabbarImage(vc: UIViewController, image: String) {
        vc.tabBarItem.image = UIImage(named: "\(image)")?.withRenderingMode(.alwaysTemplate).withBaselineOffset(fromBottom: tabBar.frame.height / 5)
    }
    
    func cornerRadiusOfTabbar() {
        //corner radius
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 30
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func topShadowTabbar() {
        delegate = self
        //shadow
        tabBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 10
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundColor = UIColor.white
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
    }
}
