//
//  UIViewController+Extensions.swift
//  ToDoRealm
//
//  Created by Antonio Alves on 10/31/17.
//  Copyright © 2017 Antonio Alves. All rights reserved.
//

import UIKit

extension UIViewController {
    class func instance() -> Self {
        let storyboardName = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.initialViewController()
    }
    
    class func instantiateNavigation() -> UINavigationController {
        let storyboardName = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.initialNavigationController()
    }
}

