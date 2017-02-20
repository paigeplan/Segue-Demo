//
//  ViewController.swift
//  PupProfile
//
//  Created by Paige Plander on 2/19/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var previewImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// Opens the user's library, allowing them to choose a photo
    ///
    /// - Parameter sender: The "Add Photo From Library" Button
    @IBAction func chooseFromLibrary(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    /// Sets the Image View's image to the one chosen by the user
    ///
    /// - Parameters:
    ///   - picker: The image picker (user's library)
    ///   - info: data needed to create the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        previewImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }

    
    /// Send any data to other MVC's before this MVC disappears
    ///
    /// - Parameters:
    ///   - segue: the segue between this MVC and the MVC we are about to go to
    ///   - sender: the button/table view/ etc. that instigated this segue
    ///             In this app, it is either the "View Photo" or "View Name" button
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // If the user tapped the "View Photo" button, this condition is true
        if segue.identifier == "mainToPhotoView" {
            // try to cast the destination View Controller as a PhotoViewController
            if let destinationVC = segue.destination as? PhotoViewController {
                if let userImage = previewImageView.image {
                    // imageToDisplay is a instance variable I defined in PhotoViewController
                    destinationVC.imageToDisplay = userImage
                }
            }
        }
            
        // If the user tapped the "View Photo" button, this condition is true
        else if segue.identifier == "mainToTextView" {
            // try to cast the destination View Controller as a TextViewController
            if let destinationVC = segue.destination as? TextViewController {
                if let username = nameTextField.text {
                    // stringToDisplay is a instance variable I defined in TextViewController
                    if username != "" {
                        destinationVC.stringToDisplay = username
                    }
                }
            }
        }
    }
}

