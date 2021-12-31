//
//  EditViewController.swift
//  Projeto1
//
//  Created by Aristóteles Júnior on 27/12/21.
//

import UIKit

class ProblemFormViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldLocation: UITextField!
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var buttonAddEdit: UIButton!
    
    var problem: Problem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let problem = problem {
            title = "Editar registro"
            textFieldName.text = problem.name
            textFieldLocation.text = problem.location
            textViewDescription.text = problem.problemDescription
            if let photo = problem.photo {
                imageViewPhoto.image = UIImage(data: photo)
            }
            buttonAddEdit.setTitle("Alterar", for: .normal)
        }
    }
    
    
    @IBAction func selectPhoto(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar foto", message: "De onde você deseja escolher a foto?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default) { _ in
                self.selectImage(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }
        
        let albumAction = UIAlertAction(title: "Álbum de fotos", style: .default) { _ in
            self.selectImage(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(albumAction)
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { _ in
            self.selectImage(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
    
    func selectImage(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        if problem == nil {
            problem = Problem(context: context)
        }
        
        problem?.name = textFieldName.text
        problem?.location = textFieldLocation.text
        problem?.problemDescription = textViewDescription.text
        problem?.photo = imageViewPhoto.image?.jpegData(compressionQuality: 1.0)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}

extension ProblemFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageViewPhoto.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}

