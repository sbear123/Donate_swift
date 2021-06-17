//
//  FirstViewController.swift
//  Donate
//
//  Created by 박지현 on 2020/09/04.
//  Copyright © 2020 Parkjihyun. All rights reserved.
//

import UIKit
import WebKit

class website: UIViewController, UIWebViewDelegate, WKUIDelegate {
    @IBOutlet weak var webView: WKWebView!
    var url: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webView.url = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }


}
