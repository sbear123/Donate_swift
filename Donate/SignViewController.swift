//
//  SecondViewController.swift
//  Donate
//
//  Created by 박지현 on 2020/09/04.
//  Copyright © 2020 Parkjihyun. All rights reserved.
//

import UIKit

class SignViewController: UIViewController {

    @IBOutlet var signup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signup.layer.cornerRadius = 10.0
        
    }
    
    @IBAction func GoLogin(){
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func SignUp(){
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
}

