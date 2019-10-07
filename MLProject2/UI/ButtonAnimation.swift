//
//  ButtonAnimation.swift
//  MLProject2
//
//  Created by Patch Louise Goyal on 10/7/19.
//  Copyright © 2019 Arkray. All rights reserved.
//

import UIKit

func buttonPulseAnimation(button: UIButton) {
    
    let pulse = CASpringAnimation(keyPath: "transform.scale")
    pulse.duration = 0.6
    pulse.fromValue = 1.0
    pulse.toValue = 1.12
    pulse.autoreverses = true
    pulse.repeatCount = 1
    pulse.initialVelocity = 0.5
    pulse.damping = 0.8
    
    let animationGroup = CAAnimationGroup()
    animationGroup.duration = 2.7
    animationGroup.repeatCount = 1000
    animationGroup.animations = [pulse]
    
    button.layer.add(animationGroup, forKey: nil)
}

