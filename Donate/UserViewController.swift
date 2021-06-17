//
//  SecondViewController.swift
//  Donate
//
//  Created by 박지현 on 2020/09/04.
//  Copyright © 2020 Parkjihyun. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet var logout: UIButton!
    @IBOutlet var profile: UIButton!
    @IBOutlet var password: UIButton!
    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        name.text = "admin"
        image.layer.cornerRadius = 0.5 * image.bounds.size.width
        image.clipsToBounds = true

    }

    @IBAction func Profile(){
        let profileAlert = UIAlertController(title: "프로필 설정", message: nil, preferredStyle: .alert)
        
        profileAlert.addTextField() { (tf) in
            tf.placeholder = "E-mail"
        }
        profileAlert.addTextField() { (tf) in
            tf.placeholder = "name"
            tf.isSecureTextEntry = true
        }
        
        profileAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        profileAlert.addAction(UIAlertAction(title: "완료", style: .destructive) { (_) in
            let email = profileAlert.textFields?[0].text ?? ""
            let name = profileAlert.textFields?[1].text ?? ""
            
            if self.changeProfile(email: email, name: name) {
                // 로그인 성공시 처리할 내용
                let msg = "프로필 수정에 성공하셨습니다."
                let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
            } else {
                let msg = "프로필 수정에 실패하셨습니다."
                let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
            }
            })
        self.present(profileAlert, animated: true)
    }
    
    @IBAction func Password(){
        let profileAlert = UIAlertController(title: "비밀번호 수정", message: nil, preferredStyle: .alert)
        
        profileAlert.addTextField() { (tf) in
            tf.placeholder = "Password"
        }
        
        profileAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        profileAlert.addAction(UIAlertAction(title: "완료", style: .destructive) { (_) in
            let pw = profileAlert.textFields?[0].text ?? ""
            
            if self.changePW(pw: pw) {
                // 로그인 성공시 처리할 내용
                let msg = "비밀번호 수정에 성공하셨습니다."
                let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
            } else {
                let msg = "비밀번호 수정에 실패하셨습니다."
                let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
            }
            })
        self.present(profileAlert, animated: true)
    }
    
    @IBAction func Logout(){
        let msg = "로그아웃하시겠습니까?"
        let alert = UIAlertController(title: "로그아웃", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive) { (_) in
            self.presentingViewController?.dismiss(animated: true)
        })
        self.present(alert, animated: true)
    }
    
    func changeProfile(email: String, name: String) -> Bool {
        return false
    }
    
    func changePW(pw: String) -> Bool {
        return false
    }

}

