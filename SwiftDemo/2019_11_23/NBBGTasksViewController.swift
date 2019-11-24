//
//  NBBGTasksViewController.swift
//  SwiftDemo
//
//  Created by 陈思行 on 2019/11/23.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit
import BackgroundTasks

@available(iOS 13.0, *)
class NBBGTasksViewController: UIViewController {
    
    var processRequest = BGProcessingTaskRequest(identifier: "BGProcessingTaskRequest")
    var refreshRequest = BGAppRefreshTaskRequest(identifier: "BGAppRefreshTaskRequest")

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        loadData()
    }
    
    func loadData() {
        if #available(iOS 13.0, *) {
            
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
}
