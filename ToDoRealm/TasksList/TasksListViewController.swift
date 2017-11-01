//
//  TasksListViewController.swift
//  ToDoRealm
//
//  Created by Antonio Alves on 10/31/17.
//  Copyright © 2017 Antonio Alves. All rights reserved.
//

import UIKit
import RealmSwift

class TasksListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortSegmentControl: UISegmentedControl!
    var searchController: UISearchController!
    
    fileprivate var tasks: Results<Task>!
    
    fileprivate var taskToken: NotificationToken?
    let realm = try! Realm()
    fileprivate var searchResults: Results<Task>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        readTasksUpdateUI()
        
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Tasks"
        searchController.searchBar.searchBarStyle = .minimal
        tableView.tableHeaderView?.addSubview(searchController.searchBar)
        definesPresentationContext = true
        
    }
    
    fileprivate func readTasksUpdateUI() {
        tasks = realm.objects(Task.self).sorted(byKeyPath: "isItHighPriority", ascending: false)
        taskToken = tasks.observe { [weak self] changes in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                tableView.applyChanges(deletions: deletions, insertions: insertions, modifications: modifications)
                tableView.reloadData()
            case .error:
                break
            }
            self?.title = "\(self?.tasks.count ?? 0) Tasks"
        }
    }
    
    fileprivate func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    fileprivate func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    fileprivate func filterResultsWithSearchString(_ searchString: String) {
        let predicate = NSPredicate(format: "name CONTAINS [c]%@", searchString)
        searchResults = realm.objects(Task.self).filter(predicate).sorted(byKeyPath: "name", ascending: true)
    }

    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        let createViewController = CreateTaskViewController.instantiateNavigation()
        present(createViewController, animated: true, completion: nil)
    }
    
    @IBAction func sortSegmentControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            tasks = tasks.sorted(byKeyPath: "isItHighPriority", ascending: false)
            tableView.reloadData()
        case 1:
            tasks = tasks.sorted(byKeyPath: "dueDate", ascending: true)
            tableView.reloadData()
        default: return
        }
    }
}

extension TasksListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? searchResults.count : tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        let task = isFiltering() ? searchResults[indexPath.row] : tasks[indexPath.row]
        cell.configureCellForTask(task)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToBeDeleted = isFiltering() ? searchResults[indexPath.row] : tasks[indexPath.row]
            try! realm.write {
                realm.delete(taskToBeDeleted)
            }
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let task = isFiltering() ? searchResults[indexPath.row] : tasks[indexPath.row]
        let editNavigation = CreateTaskViewController.instantiateNavigation()
        let editTaskViewController = editNavigation.viewControllers.first as! CreateTaskViewController
        editTaskViewController.task = task
        present(editNavigation, animated: true, completion: nil)
    }
}

// MARK: - UISearchResultsUpdating
extension TasksListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print("we here")
        filterResultsWithSearchString(searchController.searchBar.text!)
        tableView.reloadData()
    }
    
}

// MARK: - UISearchBarDelegate
extension TasksListViewController:  UISearchBarDelegate {
    
}

