//
//  ViewController.swift
//  Student_manager
//
//  Created by Ngoc on 6/21/19.
//  Copyright © 2019 Ngoc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var detailImage: UIImageView!{
        didSet{
            if detailImage.image == nil {
                detailImage.image = UIImage(named: "noPhotoFound")
            }
        }
    }
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textPhone: UITextField!
    @IBOutlet weak var textClass: UITextField!
    
    var detailStudent: Student?
    var indexPath: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if indexPath != nil {
            textName.text = detailStudent?.name
            textPhone.text = String(detailStudent!.phone)
            textClass.text = detailStudent?.classes
            detailImage.image = detailStudent?.image
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnSave(_ sender: Any) {
        
        if indexPath != nil {
            detailStudent?.name = textName.text
            detailStudent?.classes = textClass.text
            detailStudent?.image = detailImage.image
            detailStudent?.phone = Int32(textPhone.text!) ?? 0
        } else {
            let student = Student(context: AppDelegate.context)
            student.name = textName.text
            student.phone = Int32(textPhone.text!) ?? 0
            student.classes = textClass.text
            student.image = detailImage.image
        }
        
        AppDelegate.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onCleckLibrary(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        detailImage.image = image
        dismiss(animated: true, completion: nil)
    }
    
}

