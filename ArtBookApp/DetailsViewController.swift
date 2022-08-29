//
//  DetailsViewController.swift
//  ArtBookApp
//
//  Created by Felipe Augusto Correia on 21/08/22.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide Keyboard Gesture Recognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        //Tap Image Recognizer
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
    }
    
    //Hide Keyboard Function
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    //Select Image Function
    @objc func selectImage() {
        //Selecting media from the user library
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        //Present like the alerts
        present(picker, animated: true, completion: nil)
    }
    
    //DidFinishPicking? the photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    //Save button Clicked Function
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        //Acessando a função Save Context, dentro do AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //Acessando nossa entidade "Paintings"
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        //Preenchendo os atributos da entidade "Paintings"
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text, forKey: "artist")
        
        //Convertendo o ano de String para Int
        if let year = Int(yearText.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        
        //Criando um ID
        newPainting.setValue(UUID(), forKey: "id")
        
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("Sucess")
        } catch {
            print("Error")
        }
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
