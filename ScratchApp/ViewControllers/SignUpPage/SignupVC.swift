//
//  SignupVC.swift
//  ScratchApp
//
//  Created by HTS-676 on 01/01/25.
//

import UIKit
import CoreData
import Toast_Swift
import SKFloatingTextField

class SignupVC: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var Signup: UIButton!
    
    
    @IBOutlet weak var nameFloatTF: SKFloatingTextField!
    @IBOutlet weak var emailFloatTF: SKFloatingTextField!
    @IBOutlet weak var phoneNumFloatTF: SKFloatingTextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        nameTF.delegate = self
//        emailTF.delegate = self
//        phoneNumberTF.delegate = self
//        phoneNumberTF.addDoneButtonOnKeyboard()
        
        self.nameFloatTF.config(placeHolder: "Name", borderColor: .red, labelTxtL: "Name", lblTxtColor: .red, textColor: .black)
        nameFloatTF.delegate = self
        self.emailFloatTF.config(placeHolder: "email", borderColor: .red, labelTxtL: "email", lblTxtColor: .red, textColor: .black)
        emailFloatTF.delegate = self
        self.phoneNumFloatTF.config(placeHolder: "phone", borderColor: .red, labelTxtL: "phone", lblTxtColor: .red, textColor: .black)
        phoneNumFloatTF.delegate = self
        phoneNumFloatTF.keyBoardType = .numberPad
        phoneNumFloatTF.textField.addDoneButtonOnKeyboard()
        Signup.layer.cornerRadius = 10
        Signup.layer.masksToBounds = true

    }
    
    
    @IBAction func signupAct(_ sender: Any) {
        if self.nameFloatTF.text != "" && self.emailFloatTF.text != "" && self.phoneNumFloatTF.text != ""{
            if self.isValidEmail(text: self.emailFloatTF.text!){
                EntityManagement.shared.AddUser(name: self.nameFloatTF.text!, email_id: self.emailFloatTF.text!, phone_number: self.phoneNumFloatTF.text!, success: { (status) in
                    UserDefaults.standard.set(self.emailFloatTF.text!, forKey: "email_id")
                    let pageObj = TabbarController()
                    self.navigationController?.pushViewController(pageObj, animated: true)
                }, failure: {(error) in
                    debugPrint(error)
                })
            }else{
                self.view.makeToast("Please fill valid email")
            }
        }else{
            self.view.makeToast("Please fill the required details")
        }
    }
    
    func isValidEmail(text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
    

}

extension SignupVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UITextField{
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}

extension SignupVC: SKFlaotingTextFieldDelegate{
    func textFieldDidEndEditing(textField: SKFloatingTextField) {
        debugPrint("textFieldDidEndEditing")
    }
}

extension SKFloatingTextField{
    
    func config(placeHolder: String, borderColor: UIColor, labelTxtL: String, lblTxtColor: UIColor, textColor: UIColor){
        self.activeBorderColor = borderColor
        self.placeholder = placeHolder
        self.floatingLabelText = placeHolder
        self.floatingLabelColor = lblTxtColor
        self.textColor = textColor
        self.setCircularTFUI()
    }
}
