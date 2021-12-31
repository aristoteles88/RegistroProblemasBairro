//
//  ProblemTableViewController.swift
//  Projeto1
//
//  Created by Aristóteles Júnior on 31/12/21.
//

import UIKit
import CoreData

class ProblemTableViewController: UITableViewController {

    var fetchedResultsController: NSFetchedResultsController<Problem>!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadProblems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        

        if let problemViewController = segue.destination as? ProblemViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            problemViewController.problem = fetchedResultsController.object(at: indexPath)
        }
        
    }

    func loadProblems() {
        let fetchRequest: NSFetchRequest<Problem> = Problem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "problemCell", for: indexPath) as? ProblemTableViewCell else {
            return UITableViewCell()
        }
        
        let problem = fetchedResultsController.object(at: indexPath)
        cell.configureWith(problem)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let problem  = fetchedResultsController.object(at: indexPath)
            context.delete(problem)
            try? context.save()
        }
    }

}

extension ProblemTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        tableView.reloadData()
    }
}
