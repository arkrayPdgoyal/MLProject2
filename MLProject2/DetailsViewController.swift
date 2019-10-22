//
//  DetailsViewController.swift
//  MLProject2
//
//  Created by Patch Louise Goyal on 10/15/19.
//  Copyright © 2019 Arkray. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var capturedImageView: UIImageView!
     @IBOutlet weak var classificationLabel: UILabel!
    
    
    var capturedImage: UIImage!
    var classifier: String!
    var pickedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        capturedImageView.image = capturedImage
        classificationLabel.text = classifier
      

    }

    
    //MARK: FUNCTION
    
}
