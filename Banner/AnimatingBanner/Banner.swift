//
//  ErrorBanner.swift
//  Debx
//
//  Created by Zarif Ahmed on 3/10/16.
//  Copyright © 2016 Ymedialabs. All rights reserved.
//

import UIKit

///Description: Handles error banner view
class Banner: UIView {
    
    //MARK: IBOutlets
    @IBOutlet weak var bannerLabel: UILabel!
    
    //MARK: Variables
    let labelHeightPadding : CGFloat = 25
    
    //MARK: Default initialization
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: User Defined Methods
    /// Use this method to diplay the banner
    func displayBanner(parentView: UIView?, bannerText : String, onCompletion: @escaping () -> Void) {
        
        /// Set label constraints
        bannerLabel.text = bannerText
        bannerLabel.alpha = 0.0
        
        /// Calculate the height reuired for the banner based on the text. We will animate the banner to this height.
        let bannerHeight = self.heightForView(text: bannerText, font: UIFont.systemFont(ofSize: 14, weight: UIFontWeightThin), width: UIScreen.main.bounds.size.width)
        
        /// The initial height of the banner will be 0, as we are animating the height constraint
        self.frame = CGRect.init(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 0.0)
        
        /// If a container view is passed the banner will be added on it or else on the window
        if let containerView = parentView {
            containerView.addSubview(self)
        }
        else {
            AppDelegate.getAppDelegate().window?.addSubview(self)
        }
        
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            
            ///animate height of banner
            self.frame = CGRect.init(x: 0, y: UIScreen.main.bounds.size.height - bannerHeight, width: UIScreen.main.bounds.size.width, height: bannerHeight)
            
        }) { (completed) -> Void in
            
            /// Unhide labelZ by changing alpha
            UIView.animate(withDuration: 0.3, animations: {
                self.bannerLabel.alpha = 1.0
                
            }, completion: { (flag) in
                
                /// Show the banner for 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    
                    /// Hide label by changing alpha
                    UIView.animate(withDuration: 0.3, animations: {
                        self.bannerLabel.alpha = 0.0
                        
                    }, completion: { (flag) in
                        
                        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                            
                            /// Animate the banner back to it's intial frame
                            self.frame = CGRect.init(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 0.0)
                            
                        }) { (completed) -> Void in
                            
                            self.removeFromSuperview()
                            onCompletion()
                        }
                    })
                }
            })
        }
    }
    
    
    func removeBanner() {
        
        self.removeFromSuperview()
    }
    
    
    
    /** Returns the height of label with padding depending on the text contained in it. */
    func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        
        let label = UILabel(frame: CGRect.init(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height + labelHeightPadding
    }
    
    
}
