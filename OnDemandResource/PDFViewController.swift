//
//  PDFViewController.swift
//  OnDemandResource
//
//  Created by Shanthan on 26/04/19.
//  Copyright © 2019 Shanthan. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    private lazy var pdfAssests = NSBundleResourceRequest(tags: Set(["pdf"]))

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let path = Bundle.main.path(forResource: "document", ofType: "pdf") {
//            if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
//                (self.view as? PDFView)?.displayMode = .singlePageContinuous
//                (self.view as? PDFView)?.autoScales = true
//                (self.view as? PDFView)?.displayDirection = .vertical
//                (self.view as? PDFView)?.document = pdfDocument
//            }
//        }
        
        pdfAssests.beginAccessingResources(completionHandler: { [weak self](error) in
            if let _ = error { return }
            DispatchQueue.main.async {
                if let path = Bundle.main.path(forResource: "document", ofType: "pdf") {
                    if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
                        (self?.view as? PDFView)?.displayMode = .singlePageContinuous
                        (self?.view as? PDFView)?.autoScales = true
                        (self?.view as? PDFView)?.displayDirection = .vertical
                        (self?.view as? PDFView)?.document = pdfDocument
                    }
                }
            }
        })
        
       
    }
}
