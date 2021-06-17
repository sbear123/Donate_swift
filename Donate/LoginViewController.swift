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
        if let user = UserDefaults.standard.value(forKey: "id") {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabViewController = storyBoard.instantiateViewController(withIdentifier: "View") as!UITabBarController
            tabViewController.modalPresentationStyle = .fullScreen
            self.present(tabViewController, animated: true, completion: nil)
        }
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
    
    @IBAction func Login(_ sugue: UIStoryboardSegue) {
        var results:String = "fail"
        
        // 1. 전송할 값 준비
        let id = (self.ID.text)!
        let pw = (self.Password.text)!
        let param: Dictionary = ["id": id, "password": pw] // JSON 객체로 변환할 딕셔너리 준비
        
        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
        print(param)
        
        
        // 2. URL 객체 정의
        let url = URL(string: "http://10.80.161.36:8081/Donate/login.api");
        
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
                var dataDIctionary:[String:String]?
                dataDIctionary = try! JSONSerialization.jsonObject(with: dJson,options:[]) as! [String:String]
                if let dJsonDic = dataDIctionary{
                    print(dJsonDic)
                    if let result = dJsonDic["result"]{
                        results = result
                        print(result)
                        print (results)
                    }
                }
            }
            print("responseString = \(responseString)")
            if results == "ok"{
                DispatchQueue.main.async {
                    let msg = "로그인을 성공하셨습니다."
                    let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default) {(_) in
                        UserDefaults.standard.set(self.ID.text, forKey: "id")
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let tabViewController = storyBoard.instantiateViewController(withIdentifier: "View") as!UITabBarController
                        tabViewController.modalPresentationStyle = .fullScreen
                        self.present(tabViewController, animated: true, completion: nil)
                    })
                    self.ID.text = ""
                    self.Password.text = ""
                    self.present (alert, animated:false)
                }
            }else if results == "fail"{
                //alert창 띄우기
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "", message: "아이디 혹은 비밀번호를 잘못입력하셨습니다.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인", style: .default) {(_) in}
                    alert.addAction(okAction)
                    self.present (alert, animated:false)
                }
            }
        }
        // 6. POST 전송
        task.resume()
    }
}
