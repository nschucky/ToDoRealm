//
//  Storyboard+Extensions.swift
//  ToDoRealm
//
//  Created by Antonio Alves on 10/31/17.
//  Copyright © 2017 Antonio Alves. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func initialViewController<T: UIViewController>() -> T {
        return self.instantiateInitialViewController() as! T
    }
    func initialNavigationController<T: UINavigationController>() -> T {
        return self.instantiateInitialViewController() as! T
    }
}
