//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Jonathan T. Miles on 8/1/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewWillAppear(_ animated: Bool) {
        updateViews()
    }
    
    // MARK: - View functions
    func updateViews() {
        if let memory = memory {
            self.titleTextField.text = "Edit Memory"
            photoImageView.image = UIImage(data: memory.imageData)
            titleTextField.text = memory.title
            bodyTextView.text = memory.bodyText
        } else {
            self.titleTextField.text = "Add Memory"
        }
    }
    
    
    // MARK: - Button functions
    
    @IBAction func addPhoto(_ sender: Any) {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        if authorizationStatus == .authorized {
            presentImagePickerController()
        } else if authorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                guard status == .authorized else { return }
                if status == .authorized {
                    self.presentImagePickerController()
                }
            }
            
        }
    }
    
    @IBAction func saveMemory(_ sender: Any) {
        guard let image = photoImageView.image,
            let imageData = UIImagePNGRepresentation(image),
            let title = titleTextField.text,
            let bodyText = bodyTextView.text else { return }
        if memory == nil {
            memoryController?.createMemory(withTitle: title, bodyText: bodyText, imageData: imageData)
        } else {
            guard let memory = memory else { return }
            memoryController?.updateMemory(memory: memory, withTitle: title, bodyText: bodyText, imageData: imageData)
        }
    }
    
    // MARK: - ImagePickerController functions
    
    func presentImagePickerController() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            return
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        photoImageView.image = image
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Properties
    
    var memory: Memory?
    var memoryController: MemoryController?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
}
