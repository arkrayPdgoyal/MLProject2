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
        super.viewDidLoad()
     
        setupPaperOnboardingView()
        
        view.bringSubviewToFront(skipButtonTapped)
        view.bringSubviewToFront(getStartedTapped)
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        //Add Constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let contraint = NSLayoutConstraint(item: onboarding,
                                               attribute: attribute,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: attribute,
                                               multiplier: 1,
                                               constant: 0)
            
            view.addConstraint(contraint)
        }
        
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
                           title: "Tap",
                           description: "Tap your screen",
                           pageIcon: tap!,
                           color: backgroundColor,
                           titleColor: UIColor.lightGray,
                           descriptionColor: descriptionColor,
                           titleFont: titleFont!,
                           descriptionFont: descriptionFont!),
        
        OnboardingItemInfo(informationImage: capture!,
                           title: "Capture",
                           description: "Capture food photo",
                           pageIcon: capture!,
                           color: backgroundColor,
                           titleColor: UIColor.lightGray,
                           descriptionColor: descriptionColor,
                           titleFont: titleFont!,
                           descriptionFont: descriptionFont!),
        
        OnboardingItemInfo(informationImage: verify!,
                           title: "Verify",
                           description: "Check captured food",
                           pageIcon: verify!,
                           color: backgroundColor,
                           titleColor: UIColor.lightGray,
                           descriptionColor: descriptionColor,
                           titleFont: titleFont!,
                           descriptionFont: descriptionFont!),
        
        
        
        
        ] [index]
    }

    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
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
    
