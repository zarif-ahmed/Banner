//
//  ViewController.swift
//  Banner
//
//  Created by Zarif Ahmed on 2/2/17.
//  Copyright © 2017 Zarif Ahmed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var bannerView: Banner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: IBAction
    @IBAction func animateBanner(_ sender: Any) {
        
        removeBannerView()
        
        bannerView = Bundle.main.loadNibNamed("Banner", owner: self, options: nil)?.first as? Banner
        bannerView?.displayBanner(parentView: self.view, bannerText: "Hey There! This is a test banner example.", onCompletion: { [weak self] in
            
            self?.removeBannerView()
        })
        
    }
    
    
    //MARK: User Defined
    func removeBannerView() {
        
        if bannerView != nil {
            bannerView?.removeBanner()
            bannerView?.removeFromSuperview()
            bannerView = nil
        }
    }
    
}

