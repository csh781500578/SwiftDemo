//
//  NBFileClient.swift
//  SwiftDemo
//
//  Created by 陈思行 on 2019/11/23.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit
import PDFKit

class NBFileClient: NSObject {
    static let `default` = NBFileClient()
    
    func jsonData(_ fileName: String) -> [String: AnyObject]? {
        guard let data = fileData(fileName) else {
            return nil
        }
        
        do {
            let diction = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            
            guard let json = diction as? [String: AnyObject] else {
                return nil
            }
            return json
        } catch {
            return nil
        }
    }
    
    func pdfData(_ fileName: String) -> PDFDocument? {
        guard let data = fileData(fileName) else {
            return nil
        }
        return PDFDocument(data: data)
    }
    
    
    fileprivate func fileData(_ fileName: String) -> Data? {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: nil) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            return data
        } catch {
            return nil
        }
        
    }
}
