//
//  NBRequestViewController.swift
//  Demo
//
//  Created by hanrychen on 2019/11/11.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit

class NBRequestViewController: UIViewController {
    
    var request: NBRequest = NBRequest()
    var response: Data?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        title = request.title
        
        view.addSubview(requestView)
        requestView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(view.frame.height/2)
        }
        
        view.addSubview(responseView)
        responseView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(requestView.snp.bottom)
        }
        
        requestData()
        
        loadData()
    }
    
    func loadData() {
        var reqs : [String: Any] = [:]
        if let json = request.toJSON() {
            for dic in json {
                reqs[dic.key] = dic.value
            }
        }
        if let data = response {
            let text = String(data: data, encoding: String.Encoding.utf8)
            responseView.text = convertJson(text)
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: reqs, options: [])
            let text = String(data: data, encoding: String.Encoding.utf8)
            requestView.text = convertJson(text)
        } catch {
            
        }
        
    }
    
    func convertJson(_ text: String?) -> String {
        var string = ""
        var space = ""
        let unit = "    "
        for str in text ?? "" {
            let newStr = String(str)
            if newStr == "{" {
                space = space + unit
            }
            if newStr == "}" {
                space = String(space.suffix(4))
            }
            
            if newStr == "}" {
                string.append("\n")
                string.append(space)
            }
            string.append(newStr)
            if newStr == "{" || newStr == "," {
                string.append("\n")
                string.append(space)
            }
        }
        return string
    }
    
    func requestData() {
        if let url = URL.init(string: request.url) {
            let headers = HTTPHeaders([
                HTTPHeader(name: "1", value: "one"),
                HTTPHeader(name: "2", value: "two"),
                HTTPHeader(name: "3", value: "three"),
                HTTPHeader(name: "4", value: "four"),
                HTTPHeader(name: "1", value: "five")
                ])
            let _ = AF.request(url, method: HTTPMethod.get, parameters: request.login, encoder: URLEncodedFormParameterEncoder.default, headers: headers, interceptor: nil).response {[weak self] (response) in
                self?.response = response.data
                self?.loadData()
            }
        }
    }
    
    lazy var requestView: UITextView = {
        let view = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.font = UIFont.systemFont(ofSize: 16)
        view.isEditable = false
        return view
    }()

    lazy var responseView: UITextView = {
        let view = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.font = UIFont.systemFont(ofSize: 16)
        view.isEditable = false
        return view
    }()
}
