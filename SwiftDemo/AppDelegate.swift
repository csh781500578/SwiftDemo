//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by hanrychen on 2019/11/15.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit
@_exported import Alamofire
@_exported import HandyJSON
@_exported import SnapKit
import BackgroundTasks

fileprivate let backgroundTaskIdentifier = "com.nshipster.example.task.refresh"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {
            BGTaskScheduler.shared.register(forTaskWithIdentifier: backgroundTaskIdentifier, using: nil) { task in
                self.handleAppRefresh(task: task as! BGAppRefreshTask)
            }
        }

        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleAppRefresh()
    }

    lazy var backgroundURLSession : URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.nshipster.url-session.background")
        configuration.isDiscretionary = true
        configuration.timeoutIntervalForRequest = 30

        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }()

    func scheduleAppRefresh() {
        if #available(iOS 13.0, *) {
            let request = BGAppRefreshTaskRequest(identifier: backgroundTaskIdentifier)
            request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 10)

            do {
                try BGTaskScheduler.shared.submit(request)
            } catch {
                print("Couldn't schedule app refresh: \(error)")
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    @available(iOS 13.0, *)
    func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleAppRefresh()

        let url: URL = URL(fileReferenceLiteralResourceName: "")
        var dataTask = backgroundURLSession.dataTask(with: url) { (data, response, error) in
            
            task.setTaskCompleted(success: true)
        }

        task.expirationHandler = {
            dataTask.cancel()
        }

        dataTask.resume()
    }

}
