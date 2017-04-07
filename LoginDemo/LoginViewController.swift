//
//  ViewController.swift
//  LoginDemo
//
//  Created by Administrator on 06/04/17.
//  Copyright © 2017 Zerones. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var buttonAvata: UIButton!
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonAvataPressed(_ sender: Any) {
        
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)

        }
        
        
    }

}

extension LoginViewController : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        if let image : UIImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            buttonAvata.setImage(image, for: UIControlState.normal)
        }
        else if let image : UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            buttonAvata.setImage(image, for: UIControlState.normal)
        }
        picker.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
     
        print("imagePickerControllerDidCancel ")
        picker.dismiss(animated: true, completion: nil)

    }

}


