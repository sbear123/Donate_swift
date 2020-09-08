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
        self.view.frame.origin.y += CGFloat(self.height)
        self.height = 0
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
    
    @IBAction func SignUp(_ sender: Any){
        var results:String = "fail"
        
        // 1. 전송할 값 준비
        let id = (self.ID.text)!
        let name = (self.Name.text)!
        let email = (self.Email.text)!
        let pw = (self.Password.text)!
        let param: Dictionary = ["id": id, "password": pw,  "name": name, "email": email] // JSON 객체로 변환할 딕셔너리 준비
        
        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
        print(param)
        
        
        // 2. URL 객체 정의
        let url = URL(string: "http://localhost:8081/Donate/register.api");
        
        // 3. URLRequest 객체 정의 및 요청 내용 담기
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        // 5. URLSession 객체를 통해 전송 및 응답값 처리 로직 작성
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            let responseString = String(data: data, encoding: .utf8)
            let dataJson:Data? = responseString!.data(using: .utf8)
            if let dJson = dataJson{
                var dataDIctionary:[String:Any]?
                dataDIctionary = try! JSONSerialization.jsonObject(with: dJson,options:[]) as! [String:Any]
                if let dJsonDic = dataDIctionary{
                    print(dJsonDic)
                    if let result = dJsonDic["result"]{
                        results = result as! String
                    }
                }
            }
            print("responseString = \(responseString)")
        }
        
        // 6. POST 전송
        task.resume()
        
        if results == "ok"{
            let alert = UIAlertController(title: "성공", message: "회원가입을 성공하셨습니다. 로그인을 해 주세요.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default) {(action) in}
            alert.addAction(okAction)
            self.present (alert, animated:false, completion: nil)
            self.presentingViewController?.dismiss(animated: true)
        }else{
            //alert창 띄우기
            let alert = UIAlertController(title: "동일한 아이디 존재", message: "동일한 아이디를 사용하는 사람이 있습니다. 다른 아이디를 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default) {(action) in}
            alert.addAction(okAction)
            self.present (alert, animated:false, completion: nil)
        }
    }
    
}

