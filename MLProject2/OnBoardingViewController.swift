//
//  OnBoardingViewController.swift
//  MLProject2
//
//  Created by Patch Louise Goyal on 10/28/19.
//  Copyright © 2019 Arkray. All rights reserved.
//

import UIKit
import paper_onboarding

class OnBoardingViewController: UIViewController, PaperOnboardingDelegate, PaperOnboardingDataSource {

    
    @IBOutlet weak var onBoardingView: PaperOnboarding!
    @IBOutlet weak var skipButtonTapped: UIButton!
    @IBOutlet weak var getStartedTapped: UIButton!

    override func viewDidLoad() {
        onBoardingView.dataSource = self
        onBoardingView.delegate = self
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let descriptionColor = UIColor(red: 38/255.0, green: 198/255.0, blue: 218/255.0, alpha: 1.0)
        let backgroundColor = UIColor(red: 227/255.0, green: 248/255.0, blue: 250/255.0, alpha: 1.0)
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 18)
        
        let tap = UIImage(named: "tap") as UIImage?
        let capture = UIImage(named: "photo-camera") as UIImage?
        let verify = UIImage(named: "verified") as UIImage?
        
        
        return [
        OnboardingItemInfo(informationImage: tap!,
                           title: "",
                           description: "Tap Screen",
                           pageIcon: tap!,
                           color: backgroundColor,
                           titleColor: UIColor.white,
                           descriptionColor: descriptionColor,
                           titleFont: titleFont!,
                           descriptionFont: descriptionFont!),
        
        OnboardingItemInfo(informationImage: capture!,
                           title: "",
                           description: "Capture Photo",
                           pageIcon: capture!,
                           color: backgroundColor,
                           titleColor: UIColor.white,
                           descriptionColor: descriptionColor,
                           titleFont: titleFont!,
                           descriptionFont: descriptionFont!),
        
        OnboardingItemInfo(informationImage: verify!,
                           title: "",
                           description: "Check Captured Food",
                           pageIcon: verify!,
                           color: backgroundColor,
                           titleColor: UIColor.white,
                           descriptionColor: descriptionColor,
                           titleFont: titleFont!,
                           descriptionFont: descriptionFont!)
        
        
        
        
        ] [index]
    }

    func onboardingConfigurationItem(_: OnboardingContentViewItem, index _: Int) {
        
    }
    
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 1 || index == 0 {
            skipButtonTapped.isHidden = false
            getStartedTapped.layer.removeAllAnimations()
            UIView.animate(withDuration: 0.2, animations: {
                self.getStartedTapped.alpha = 0
            })
        }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2 {
            skipButtonTapped.isHidden = true
            buttonPulseAnimation(button: getStartedTapped)
            UIView.animate(withDuration: 0.5, animations: {
                self.getStartedTapped.alpha = 1
            })
        }else {
            UIView.animate(withDuration: 0.2, animations: {
                self.getStartedTapped.alpha = 0
            })
        }
    }
}
    
