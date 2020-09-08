//
//  SecondViewController.swift
//  Donate
//
//  Created by 박지현 on 2020/09/04.
//  Copyright © 2020 Parkjihyun. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var name:  UITextField!
    @IBOutlet weak var email: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func Goback(){
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func changeProfile(){
        
        self.presentingViewController?.dismiss(animated: true)
    }

}

