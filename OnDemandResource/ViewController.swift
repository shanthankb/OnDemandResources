//
//  ViewController.swift
//  OnDemandResource
//
//  Created by Shanthan on 11/04/19.
//  Copyright © 2019 Shanthan. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    
    private var initialAssests = NSBundleResourceRequest(tags: Set(["Initial"]))
    private lazy var photoTwoAssests: NSBundleResourceRequest? = nil
}

extension ViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.refreshScreen()
        self.loadOnDemandAssets()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //discardOnDemandAssets()
        super.viewWillDisappear(animated)
    }
}

extension ViewController {//Private methods

    private func loadOnDemandAssets() {
        
        initialAssests.beginAccessingResources(completionHandler: { [weak self](error) in
            if let _ = error { return }
            DispatchQueue.main.async {
                self?.refreshScreen()
            }
        })
    }
    
    private func discardOnDemandAssets() {
        
        initialAssests.endAccessingResources()
        photoTwoAssests?.endAccessingResources()
        photoTwoAssests = nil
    }
    
    private func refreshScreen() {
        
        firstImage.image = UIImage(named: "Photo1")
        secondImage.image = UIImage(named: "Photo2")
    }
}

extension ViewController {//IBActions
    
    @IBAction func videoAction(_ sender: Any) {
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pdfViewController = storyboard.instantiateViewController(withIdentifier: "PDFViewController") as? PDFViewController
        self.navigationController?.pushViewController(pdfViewController ?? UIViewController(), animated: true)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        
        if photoTwoAssests != nil {
            photoTwoAssests?.endAccessingResources()
            photoTwoAssests = nil
        }
        
        photoTwoAssests = NSBundleResourceRequest(tags: Set(["PhotoTwo"]))
        photoTwoAssests?.conditionallyBeginAccessingResources(completionHandler: { [weak self] (state) in
            guard state == false  else {
                DispatchQueue.main.async {
                    self?.refreshScreen()
                }
                return
            }
            
            self?.photoTwoAssests?.beginAccessingResources(completionHandler: { [weak self](error) in
                if let _ = error { return }
                DispatchQueue.main.async {
                    self?.refreshScreen()
                }
            })
        })
    }
}
