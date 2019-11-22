//
//  WebViewController.swift
//  SwiftDemo
//
//  Created by hanrychen on 2019/11/22.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(wkWebView)
        view.addSubview(webView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let filePath = Bundle.main.path(forResource: "animate", ofType: "html") else {
            return
        }
        do {
            let string = try String.init(contentsOfFile: filePath)
            self.wkWebView.loadHTMLString(string, baseURL: nil)
            self.webView.loadHTMLString(string, baseURL: nil)
        } catch {
            
        }
    }

    
    lazy var wkWebView: WKWebView = {
        let con = WKWebViewConfiguration()
        var rect = self.view.bounds
        rect.size.height = rect.height/2
        let view = WKWebView(frame: rect, configuration: con)
        view.uiDelegate = self
        view.navigationDelegate = self
        return view
    }()
    
    lazy var webView: UIWebView = {
        var rect = self.view.bounds
        rect.origin.y =  rect.height/2
        rect.size.height = rect.height/2
        let view = UIWebView(frame: rect)
        view.delegate = self
        return view
    }()
}

extension WebViewController : WKUIDelegate, WKNavigationDelegate, UIWebViewDelegate {
    
}
