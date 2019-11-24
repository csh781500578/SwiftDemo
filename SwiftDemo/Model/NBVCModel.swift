//
//  NBVCModel.swift
//  SwiftDemo
//
//  Created by 陈思行 on 2019/11/23.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import Foundation

class NBVCModel: HandyJSON {
    var messages : [NBVCListModel]?
    
    required init() {
        
    }
}

class NBVCListModel: HandyJSON {
    var date : String?
    var open = true
    var list :[NBVCObjcModel]?
    
    required init() {
        
    }
}


class NBVCObjcModel: HandyJSON {
    var name: String?
    var viewController : String?
    
    required init() {
        
    }
}
