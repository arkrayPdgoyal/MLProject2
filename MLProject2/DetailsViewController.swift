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
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var caloriesView: UIView!
    @IBOutlet weak var totalFatView: UIView!
    @IBOutlet weak var cholesterolView: UIView!
    @IBOutlet weak var classificationLabel: UILabel!
    
    
    var capturedImage: UIImage!
    var classifier: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        capturedImageView.image = capturedImage
        classificationLabel.text = classifier
        showDetailsView()

    }

    
    //MARK: FUNCTION
    
    func showDetailsView() {
    
        detailsView.layer.shadowColor = UIColor.black.cgColor
        detailsView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        detailsView.layer.shadowRadius = 1.0
        detailsView.layer.shadowOpacity = 70
        detailsView.layer.cornerRadius = 15.0
        detailsView.isHidden = false
        
        caloriesView.layer.cornerRadius = 15.0
        caloriesView.isHidden = false
        
        totalFatView.layer.cornerRadius = 15.0
        totalFatView.isHidden = false
        
        cholesterolView.layer.cornerRadius = 15.0
        cholesterolView.isHidden = false
        
    }
   
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
}
