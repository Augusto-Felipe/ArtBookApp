//
//  DetailsViewController.swift
//  ArtBookApp
//
//  Created by Felipe Augusto Correia on 21/08/22.
//

import UIKit

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
    
    //DidFinishPicking?
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as! UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    //Save button Clicked Function
    @IBAction func saveButtonClicked(_ sender: Any) {
        print("Test")
    }
    
}
