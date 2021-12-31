//
//  ProblemViewController.swift
//  Projeto1
//
//  Created by Aristóteles Júnior on 27/12/21.
//

import UIKit
import CoreData

class ProblemViewController: UIViewController {
    
    var problem: Problem?
    
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreen()
    }
    
    func prepareScreen() {
        if let problem = problem {
            if let photo = problem.photo {
                imageViewPhoto.image = UIImage(data: photo)
            }
            labelName.text = problem.name
            labelLocation.text = problem.location
            textViewDescription.text = problem.problemDescription
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let problemFormViewController = segue.destination as? ProblemFormViewController {
            problemFormViewController.problem = problem
        }
        
    }
    

}
