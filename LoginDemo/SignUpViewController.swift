//
//  ViewController.swift
//  LoginDemo
//
//  Created by Administrator on 06/04/17.
//  Copyright © 2017 Zerones. All rights reserved.
//

import UIKit

extension UIButton {
    
    var cornerRadius : CGFloat {
        set{
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            self.setNeedsDisplay()
        }
        get{
            return self.layer.cornerRadius
        }
    }
}

@IBDesignable
class RoundedButton : UIButton {
    
    @IBInspectable var cornerRadii: CGFloat = 0.0 {
        didSet{
            self.cornerRadius = cornerRadii
            //oldValue
        }
        willSet{

            //newValue
        }
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = cornerRadii
        self.layer.masksToBounds = true
        //self.layoutIfNeeded()
        self.setNeedsDisplay()
    }
    
}


class SignUpViewController: UIViewController {

    @IBOutlet weak var myScrollView: UIScrollView!
  
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var firstNameErrorLabel: UILabel!
    @IBOutlet weak var const_scrollview_height: NSLayoutConstraint!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTextFieldBorder(textField: firstnameField)
        getFieldVal()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(willChangeKeyboradHeight(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    func willChangeKeyboradHeight(notification : NSNotification) {
        print("notification ==>> \(notification.userInfo)")
        
        if let value : CGRect = notification.userInfo!["UIKeyboardFrameEndUserInfoKey"] as? CGRect{
            
            const_scrollview_height.constant = value.height
        }

    }

    override var shouldAutorotate: Bool{
        return true
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        print("fromInterfaceOrientation ==>> \(fromInterfaceOrientation)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func addTextFieldBorder(textField : UITextField){
        let border = CALayer()
        let width = CGFloat(2.0)
        //border.borderColor = UIColor(red: 0x00, green: 0x79, blue:0x6B, alpha: 1).cgColor
        border.borderColor = UIColor(rgb: 0x00796B).cgColor
            //UIColor.darkGray.cgColor
        
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    

    func getFieldVal(){
        firstnameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            firstNameErrorLabel.isHidden = false
            return
        }
        firstNameErrorLabel.isHidden = true
        
    }
    
    @IBAction func buttonHideKeyboard(){
    
        self.view.endEditing(true)
    }
    
}

extension SignUpViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
       
        //const_scrollview_height.constant = 260
        
        myScrollView.scrollRectToVisible(textField.superview!.frame, animated: true)
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        //const_scrollview_height.constant = 0
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason){
        
        //const_scrollview_height.constant = 0

    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool{
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        textField.resignFirstResponder()
        
        if let view = textField.superview{
            if let nextView = view.superview?.viewWithTag(view.tag + 1){
                
                if let nextTextField = nextView.viewWithTag(1) as? UITextField{
                    nextTextField.becomeFirstResponder()
                }
            }
        }
        
        return true
    }
    
}




