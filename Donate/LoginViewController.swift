//
//  SecondViewController.swift
//  Donate
//
//  Created by 박지현 on 2020/09/04.
//  Copyright © 2020 Parkjihyun. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var ID: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet var show: UIButton!
    @IBOutlet var login: UIButton!
    
    var height = 0
    var showPW = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ID.delegate = self
        self.Password.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification , object: nil)
        
        login.layer.cornerRadius = 10.0
        
        ID.font = UIFont(name: "Normal font", size: 15)
        Password.font = UIFont(name: "Normal font", size: 15)
    }
    
    @IBAction func TouchShow () {
        if !showPW {
            self.show.setImage(UIImage(systemName: "eye"), for: .normal)
            showPW = true
            self.Password.isSecureTextEntry = false

        }else {
            self.show.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            showPW = false
            self.Password.isSecureTextEntry = true
        }
    }
    
    override func touchesBegan (_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.ID:
            self.Password.becomeFirstResponder()
        default:
            self.Password.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    @objc func keyboardWillAppear(_ sender: NotificationCenter){
        if (height == 0){
            self.view.frame.origin.y -= 150
            self.height += 150
        }
    }
    
    @objc func keyboardWillDisappear(_ sender: NotificationCenter){
        self.view.frame.origin.y += 150
        self.height = 0
    }
    
    @IBAction func GoSignUp(){
        guard let signup = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") else{
            return
        }
        signup.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(signup,animated: true)
    }

}
