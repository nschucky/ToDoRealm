//
//  Task.swift
//  ToDoRealm
//
//  Created by Antonio Alves on 10/31/17.
//  Copyright © 2017 Antonio Alves. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var name = ""
    @objc dynamic var dueDate = Date()
    @objc dynamic var isItHighPriority = false
}
