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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        image.layer.cornerRadius = 0.5 * image.bounds.size.width
        image.clipsToBounds = true

    }

    @IBAction func Profile(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let ProfileViewController = storyBoard.instantiateViewController(withIdentifier: "Profile") 
        ProfileViewController.modalPresentationStyle = .fullScreen
        self.present(ProfileViewController, animated: true, completion: nil)
    }
    
    @IBAction func Password(){
        
    }
    
    @IBAction func Logout(){
        self.presentingViewController?.dismiss(animated: true)
    }

}

