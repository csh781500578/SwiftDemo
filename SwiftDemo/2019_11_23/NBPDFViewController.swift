//
//  NBPDFViewController.swift
//  SwiftDemo
//
//  Created by 陈思行 on 2019/11/23.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit
import PDFKit

class NBPDFViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.addSubview(pdfView)
        view.addSubview(thumbView)
        loadData()
    }
    
    func loadData() {
        let docu = NBFileClient.default.pdfData("danke.pdf")
        
//        var rect = self.view.bounds
//        rect.size.width = rect.size.width - 60
//        for index in 0..<(docu?.pageCount ?? 0) {
//            let page = docu?.page(at: index)
//            let an = PDFAnnotation(bounds: rect, forType: PDFAnnotationSubtype.text, withProperties: nil)
//            an.contents = "陈思行"
//            page?.addAnnotation(an)
//        }
        pdfView.document = docu
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(outline)
    }

    lazy var pdfView: PDFView = {
        var rect = self.view.bounds
        rect.size.width = rect.size.width - 60
        let view = PDFView(frame: rect)
        view.displayMode = .singlePageContinuous
        view.displaysAsBook = true
        view.autoScales = true
        view.delegate = self
        view.enableDataDetectors = true
        return view
    }()
    
    lazy var thumbView: PDFThumbnailView = {
        var rect = self.view.bounds
        rect.origin.x = rect.size.width - 60
        rect.size.width = 60
        let view = PDFThumbnailView(frame: rect)
        view.pdfView = self.pdfView
        view.thumbnailSize = CGSize(width: 45, height: 55)
        return view
    }()
    
    lazy var outline: PDFOutline = {
        let objc = PDFOutline()
        return objc
    }()
    
}

extension NBPDFViewController : PDFViewDelegate {

    func pdfViewWillClick(onLink sender: PDFView, with url: URL) {
        print(url)
    }
    
    func pdfViewParentViewController() -> UIViewController {
        print("pdfViewParentViewController")
        return self
    }
    
    func pdfViewPerformFind(_ sender: PDFView) {
        print(sender)
    }

    func pdfViewPerformGo(toPage sender: PDFView) {
        print(sender)
    }
    
    func pdfViewOpenPDF(_ sender: PDFView, forRemoteGoToAction action: PDFActionRemoteGoTo) {
        print(action.pageIndex)
    }
}
