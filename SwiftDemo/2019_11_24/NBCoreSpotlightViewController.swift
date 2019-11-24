//
//  NBCoreSpotlightViewController.swift
//  SwiftDemo
//
//  Created by 陈思行 on 2019/11/24.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit
import CoreSpotlight
import Contacts

class NBCoreSpotlightViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        loadData()
    }
    
    func loadData() {
        
        CSSearchableIndex(name: "hanrychen", protectionClass: FileProtectionType.complete).deleteAllSearchableItems { (error) in
            print(error ?? "删除所有")
        }
        let handler = CSIndexExtensionRequestHandler()
        let query = CSSearchQuery(queryString: "", attributes: nil)
        
        
        let set = CSSearchableItemAttributeSet(itemContentType: CSSearchableItemActionType)
        let string = CSLocalizedString(localizedStrings: ["en":"席娜", "fr":"Chanson"])
        set.displayName = string.localizedString()
        set.title = "18603093046"
        set.contentDescription = "CSSearchableItemAttributeSetCSSearchableItemAttributeSetCSSearchableItemAttributeSet"
        set.thumbnailData = UIImage.init(named: "person_beautician")?.pngData()
        
        if let key = CSCustomAttributeKey(keyName: "com_mycompany_myapp_keyname", searchable: true, searchableByDefault: true, unique: true, multiValued: true) {
            set.setValue("hanrychen" as NSString, forCustomKey: key)
        }
        let item = CSSearchableItem(uniqueIdentifier: CSSearchableItemActivityIdentifier, domainIdentifier: "hanrychen", attributeSet: set)
//        let person = CSPerson(displayName: string.localizedString(), handles: ["18603093046"], handleIdentifier: CNContactPhoneNumbersKey)
        
        CSSearchableIndex(name: "hanrychen", protectionClass: FileProtectionType.complete).indexSearchableItems([item]) { (error) in
            print(error ?? "搜索完成")
        }
        
        
    }

}
