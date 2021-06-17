//
//  SecondViewController.swift
//  Donate
//
//  Created by 박지현 on 2020/09/04.
//  Copyright © 2020 Parkjihyun. All rights reserved.
//

import UIKit

class BrandViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var idxs = [Int]()
    var titles = [String]()
    var urls = [String]()
    var images = [String]()
    var tags = [String]()
    var stag: String = ""
    var length: Int! = 0
    var index: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getJson()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(idxs.count)
        var idxLeng: Int!
        idxLeng = self.idxs.count
        return idxLeng
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath) as! WebSitesView
        print(indexPath.row)
        
        print(self.titles[indexPath.row])
        cell.titleLabel.text = self.titles[indexPath.row]
        getImageFromWeb(self.images[indexPath.row]) { (image) in
            if let image = image {
                cell.ImageView.image = image
            }
        }
        cell.tagLabel.text = self.tags[indexPath.row]
        cell.urlLabel.text = self.urls[indexPath.row]
        return cell
    }
    
    func getJson () {
        // 1. URL 객체 정의
        let url = URL(string: "http://10.80.161.36:8081/Donate/site.api");
        
        // 2. URLRequest 객체 정의 및 요청 내용 담기
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        // 3. URLSession 객체를 통해 전송 및 응답값 처리 로직 작성
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            guard let data = data, error == nil else {                                                 // check for fundamental networking error

                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
            }
            let responseString = String(data: data, encoding: .utf8)
            let dataJson:Data? = responseString!.data(using: .utf8)
            if let dJson = dataJson{
                var dataDIctionary: [[String: Any]]?
                dataDIctionary = try! JSONSerialization.jsonObject(with: dJson,options:[]) as! [[String: Any]]
                if let dJsonDic = dataDIctionary{
                    for dataIndex in dJsonDic{
                        self.idxs.append(dataIndex["idx"] as! Int)
                        self.titles.append(dataIndex["siteName"] as! String)
                        self.images.append(dataIndex["picture"] as! String)
                        self.urls.append(dataIndex["url"] as! String)
                        self.getTag(idx: (dataIndex["idx"] as! Int))
                    }
                }
            }
            print(self.tags)
            self.tableView.reloadData()
            print("responseString = \(responseString)")
        }
        // 6. POST 전송
        task.resume()
    }
    
    func getTag(idx: Int) {
        
        let param: Dictionary = ["idx": (idx+1)] // JSON 객체로 변환할 딕셔너리 준비
        
        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
        
        // 2. URL 객체 정의
        let url = URL(string: "http://10.80.161.36:8081/Donate/tag.api");
        
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
            let responseString = String(data: data, encoding: .utf8)
            let dataJson:Data? = responseString!.data(using: .utf8)
            if let dJson = dataJson{
                var dataDIctionary:[[String:Any]]?
                dataDIctionary = try! JSONSerialization.jsonObject(with: dJson,options:[]) as! [[String:Any]]
                if let dJsonDic = dataDIctionary{
                    for dataIndex in dJsonDic{
                        self.stag += " #" + (dataIndex["tag"] as! String)
                    }
                }
            }
            self.tags.append(self.stag)
            self.stag = ""
            print("responseString = \(responseString)")
        }
        // 6. POST 전송
        task.resume()
    }
    func getImageFromWeb(_ urlString: String, closure: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: urlString) else {
            return closure(nil)
        }
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("error: \(String(describing: error))")
                return closure(nil)
            }
            guard response != nil else {
                print("no response")
                return closure(nil)
            }
            guard data != nil else {
                print("no data")
                return closure(nil)
            }
            DispatchQueue.main.async {
                closure(UIImage(data: data!))
            }
        }; task.resume()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let surl = urls[indexPath.row]
        if let url = URL(string: surl) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

