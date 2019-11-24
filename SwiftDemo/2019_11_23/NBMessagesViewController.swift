//
//  NBMessagesViewController.swift
//  SwiftDemo
//
//  Created by 陈思行 on 2019/11/23.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit
import Messages

class NBMessagesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = MSMessagesAppViewController()
        vc.requestPresentationStyle(MSMessagesAppPresentationStyle.expanded)
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func loadData() {
        
    }

}
