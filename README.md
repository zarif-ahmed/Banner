# Banner

Add the AnimatingBanner folder to your project. The folder consits of 2 files: Banner.swift and Banner.xib


You can initialize the banner by loading it from the Nib as given below

- Declare a variable bannerView in your class.
    `var bannerView: Banner?`

- Load it from Nib 
    `bannerView = Bundle.main.loadNibNamed("Banner", owner: self, options: nil)?.first as? Banner`


- Call the displayBanner() method by passing the "bannerText" parameter (message to be displayed). The parameter "parentView" is optional. If you don't provide this, the banner will be added to the UIWindow.
    
    `
    bannerView?.displayBanner(parentView: self.view, bannerText: "Hey There! This is a test banner example.", onCompletion: { [weak self] in
        self?.removeBannerView()
    })
    `



- Make sure you remove the existing banner by calling the below method before adding a new banner.

    `
    func removeBannerView() {

        if bannerView != nil {
            bannerView?.removeBanner()
            bannerView?.removeFromSuperview()
            bannerView = nil
        }
    }
    `



- Also, It is better to have a method in BaseVC that can be called from all view controllers if you will be using this component across the app.

    `
    func showBanner(text : String?) {

        removeBannerView()

        bannerView = Bundle.main.loadNibNamed(String(describing : ErrorBanner.self), owner: self, options: nil)?.first as? ErrorBanner

        bannerView?.displayBanner(parentView: self.view, title: text ?? "", onCompletion: { [weak self] in
            self?.removeBannerView()
        })
    }
    `


- NOTE:
    - Language used is Swift 3.0.2
    - Feel free to report any issues.
