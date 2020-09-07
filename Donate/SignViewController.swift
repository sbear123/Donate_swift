//
//  SecondViewController.swift
//  Donate
//
//  Created by 박지현 on 2020/09/04.
//  Copyright © 2020 Parkjihyun. All rights reserved.
//

import UIKit

class SignViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var signup: UIButton!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var ID: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var CheckPW: UITextField!
    @IBOutlet var showPWB:UIButton!
    @IBOutlet var showPWCB:UIButton!
    
    var height = 0
    var showPW = false
    var showPWC = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.Name.delegate = self
        self.Email.delegate = self
        self.ID.delegate = self
        self.Password.delegate = self
        self.CheckPW.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification , object: nil)
        
        signup.layer.cornerRadius = 10.0
        
        ID.font = UIFont(name: "Normal font", size: 15)
        Password.font = UIFont(name: "Normal font", size: 15)
        Name.font = UIFont(name: "Normal font", size: 15)
        Email.font = UIFont(name: "Normal font", size: 15)
        CheckPW.font = UIFont(name: "Normal font", size: 15)
    }
    
    @IBAction func TouchShow () {
        if !showPW {
            self.showPWB.setImage(UIImage(systemName: "eye"), for: .normal)
            showPW = true
            self.Password.isSecureTextEntry = false

        }else {
            self.showPWB.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            showPW = false
            self.Password.isSecureTextEntry = true
        }
    }
    
    @IBAction func TouchShowPWC () {
        if !showPW {
            self.showPWCB.setImage(UIImage(systemName: "eye"), for: .normal)
            showPWC = true
            self.CheckPW.isSecureTextEntry = false

        }else {
            self.showPWCB.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            showPWC = false
            self.CheckPW.isSecureTextEntry = true
        }
    }
    
    override func touchesBegan (_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.Name:
            self.Email.becomeFirstResponder()
        case self.Email:
            self.ID.becomeFirstResponder()
        case self.ID:
            self.Password.becomeFirstResponder()
        case self.Password:
            self.CheckPW.becomeFirstResponder()
        default:
            self.CheckPW.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    @objc func keyboardWillAppear(_ sender: NotificationCenter){
        if (height != 200){
            self.view.frame.origin.y -= 200
            self.height += 200
        }
    }
    
    @objc func keyboardWillDisappear(_ sender: NotificationCenter){
        self.view.frame.origin.y += CGFloat(self.height)
        self.height = 0
    }
    
    @IBAction func GoLogin(){
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func SignUp(){
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
}

