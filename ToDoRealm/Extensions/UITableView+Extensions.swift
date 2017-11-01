//
//  UITableView+Extensions.swift
//  ToDoRealm
//
//  Created by Antonio Alves on 10/31/17.
//  Copyright © 2017 Antonio Alves. All rights reserved.
//

import UIKit


extension UITableView {
    func applyChanges(section: Int = 0, deletions: [Int], insertions: [Int], modifications: [Int]) {
        beginUpdates()
        deleteRows(at: deletions.map(IndexPath.fromRow), with: .automatic)
        insertRows(at: insertions.map(IndexPath.fromRow), with: .automatic)
        reloadRows(at: modifications.map(IndexPath.fromRow), with: .none)
        endUpdates()
    }
}

extension IndexPath {
    static func fromRow(_ row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}
