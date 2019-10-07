//
//  OnBoardingViewController.swift
//  MLProject2
//
//  Created by Patch Louise Goyal on 10/7/19.
//  Copyright © 2019 Arkray. All rights reserved.
//

import UIKit
import paper_onboarding

class OnBoardingViewController: UIViewController {

   
    @IBOutlet weak var onBoardingView: PaperOnboarding!
    @IBOutlet weak var skipButtonTapped: UIButton!
    @IBOutlet weak var getStartedButtonTapped: UIButton!
    
    
    fileprivate let items = [
           OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "tap.png"),
                              title: "",
                              description: "Tap Screen",
                              pageIcon: #imageLiteral(resourceName: "tap.png"),
                              color: UIColor(red: 220/255.0, green: 237/255.0, blue: 200/255.0, alpha: 1.0),
                              titleColor: UIColor.white,
                              descriptionColor: UIColor(red: 27/255.0, green: 94/255.0, blue: 32/255.0, alpha: 1.0),
                              titleFont: titleFont,
                              descriptionFont: descriptionFont) as AnyObject,
           
           OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "photo-camera.png"),
                              title: "",
                              description: "Capture Photo",
                              pageIcon: #imageLiteral(resourceName: "photo-camera.png"),
                              color: UIColor(red: 220/255.0, green: 237/255.0, blue: 200/255.0, alpha: 1.0),
                              titleColor: UIColor.white, descriptionColor: UIColor(red: 27/255.0, green: 94/255.0, blue: 32/255.0, alpha: 1.0),
                              titleFont: titleFont,
                              descriptionFont: descriptionFont),
           
           
           OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "verified.png"),
                              title: "",
                              description: "Verify Food",
                              pageIcon: #imageLiteral(resourceName: "verified.png"),
                              color: UIColor(red: 220/255.0, green: 237/255.0, blue: 200/255.0, alpha: 1.0),
                              titleColor: UIColor.white,
                              descriptionColor: UIColor(red: 27/255.0, green: 94/255.0, blue: 32/255.0, alpha: 1.0),
                              titleFont: titleFont,
                              descriptionFont: descriptionFont),
       
       
           ] as [AnyObject]
       
    
    
    
    
    
    func onboardingItemsCount() -> Int {
            return 3
        }
        
        func onboardingConfigurationItem(_: OnboardingContentViewItem, index _: Int) {
            
        }
       
        func onboardingWillTransitonToIndex(_ index: Int) {
            if index == 1 || index == 0 {
                skipButtonTapped.isHidden = false
                getStartedButtonTapped.layer.removeAllAnimations()
                UIView.animate(withDuration: 0.2, animations: {
                    self.getStartedButtonTapped.alpha = 0
                })
            }
        }
        
        func onboardingDidTransitonToIndex(_ index: Int) {
            if index == 2 {
                skipButtonTapped.isHidden = true
                buttonPulseAnimation(button: getStartedButtonTapped)
                UIView.animate(withDuration: 0.5, animations: {
                    self.getStartedButtonTapped.alpha = 1
                })
            }else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.getStartedButtonTapped.alpha = 0
                })
            }
        }
        
        func onboardingItem(at index: Int) -> OnboardingItemInfo {
            
            return  items [index] as! OnboardingItemInfo
        }

    }
    //MARK: Constant



extension OnBoardingViewController {
   
   private static let titleFont = UIFont(name: "AvenirNext-Bold", size: 30)!
   private static let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 20)!

}
