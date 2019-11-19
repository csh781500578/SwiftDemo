//
//  NBRequest.swift
//  Demo
//
//  Created by hanrychen on 2019/11/11.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit
@_exported import Alamofire
@_exported import HandyJSON
@_exported import SnapKit

class NBRequest: HandyJSON {
    var title: String?
    var path: String?
    var baseUrl: String = "http://www.hanrychen.com/nicebeauty/public/"
    var params: [String:Any]?
    var url : String {
        return self.baseUrl + (self.path ?? "")
    }
    
    var paramObjc: Encodable? {
        return self.login
    }
    
    var login: Login {
        return Login(mobile: self.params?["mobile"] as? String, code: self.params?["code"] as? String)
    }
    
    required init() {
        
    }
}

struct Login: Encodable {
    var mobile: String?
    var code: String?
}
