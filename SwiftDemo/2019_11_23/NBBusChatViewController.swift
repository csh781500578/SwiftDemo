//
//  NBBusChatViewController.swift
//  SwiftDemo
//
//  Created by 陈思行 on 2019/11/23.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit
import BusinessChat

/// 去这个地址注册企业聊天：https://register.apple.com/business/ui/2/services/manage
class NBBusChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.addSubview(button)

    }
    
    @objc func didSelectChatAction() {
        //Send Intent parameters to construct Business Chat URL
           let url = BCUrlConstructor(intentId: "INTENTID", groupId: "GROUPID", bodyParam: "PRESET TEXT")
            // Launch Business Chat
           UIApplication.shared.open(url)
    }

    func BCUrlConstructor (intentId: String, groupId: String, bodyParam: String) -> URL {
      let bizId = "" // Sets the Business ID
       // Construct Business Chat URL using business ID, intent ID, group ID, and preset body text
      let url : NSString = "https://bcrw.apple.com/sms:open?service=iMessage&recipient=urn:biz:\(bizId)&biz-intent-id=\(intentId)&bizgroup-id=\(groupId)&body=\(bodyParam)" as NSString
      let urlString : NSString = url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)! as NSString
      let bcUrl : NSURL = NSURL(string: urlString as String)!
      return bcUrl as URL
      }
    
    lazy var button: BCChatButton = {
        let view = BCChatButton(style: BCChatButton.Style.dark)
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 64)
        view.center = self.view.center
        view.addTarget(self, action: #selector(didSelectChatAction), for: UIControl.Event.touchUpInside)
        return view
    }()

}
