//
//  RoundedShadowView.swift
//  MLProject2
//
//  Created by Erish Latorre on 9/27/19.
//  Copyright © 2019 Arkray. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {

    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 15
        self.layer.shadowOpacity = 0.75
        self.layer.cornerRadius = self.frame.height / 2
    }
}
