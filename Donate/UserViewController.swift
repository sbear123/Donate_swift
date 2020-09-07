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
    @IBOutlet var photo: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        image.layer.cornerRadius = 0.5 * image.bounds.size.width
        image.clipsToBounds = true
        
        photo.layer.cornerRadius = 0.5 * photo.bounds.size.width
        photo.clipsToBounds = true

    }

    @IBAction func Profile(){
        
    }
    
    @IBAction func Password(){
        
    }
    
    @IBAction func Logout(){
        
    }

}

