//
//  ViewController.swift
//  MLProject2
//
//  Created by Patch Goyal on 9/27/19.
//  Copyright © 2019 Arkray. All rights reserved.
//

import UIKit
import AVFoundation
import CoreML
import Vision


enum FlashState {
    case off
    case on
}

let imageON = UIImage(named: "flashON.png")
let imageOFF = UIImage(named: "flashOFF.png")
      
      

class ViewController: UIViewController, UINavigationControllerDelegate {
    
        
    @IBOutlet weak var openLibraryView: UIView!
    @IBOutlet weak var capturedImageView: RoundedImageView!
    @IBOutlet weak var identificationLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var flashButton: RoundedButton!
    @IBOutlet weak var cameraView: UIView! 
    @IBOutlet weak var roundedLabelView: RoundedShadowView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var captureSession: AVCaptureSession!
    var cameraOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var photoData: Data?
    
    var flashControlState: FlashState = .off
    
    var speechSynthesizer = AVSpeechSynthesizer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityIndicator.isHidden = true
        flashButton.setImage(imageOFF, for: .normal)
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer.frame = cameraView.bounds
        speechSynthesizer.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCameraView))
        tap.numberOfTouchesRequired = 1
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera!)
            
            if captureSession.canAddInput(input) == true {
                captureSession.addInput(input)
            }
            
            cameraOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddOutput(cameraOutput) == true {
                captureSession.addOutput(cameraOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
                previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                
                cameraView.layer.addSublayer(previewLayer!)
                cameraView.addGestureRecognizer(tap)
                captureSession.startRunning()
                
                openLibrarySetup()
            }
            
        } catch {
            debugPrint(error)
        }
        
    }
        
    @objc func didTapCameraView() {
        
        self.cameraView.isUserInteractionEnabled = false
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        let settings = AVCapturePhotoSettings()
        
        settings.previewPhotoFormat = settings.embeddedThumbnailPhotoFormat
            
        if flashControlState == .off {
            settings.flashMode = .off
        } else {
            settings.flashMode = .on
        }
            cameraOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func resultMethod(request: VNRequest, error: Error?) {
        //handle changing the label text
        guard let results = request.results as? [VNClassificationObservation]  else{ return }
        
        for classification in results {
            if classification.confidence < 0.5 {
                let unknownObjectMessage = "I'm not sure what this is. Please try again."
                self.identificationLabel.text = unknownObjectMessage
                synthesizeSpeech(fromString: unknownObjectMessage)
                self.percentageLabel.text = ""
                break
            } else {
                let identification = classification.identifier
                let confidence = Int(classification.confidence * 100)
                self.identificationLabel.text = identification
                self.percentageLabel.text = "CONFIDENCE: \(confidence)%"
                let completeSentence = "This looks like = \(identification) and I'm \(confidence) percent"
                synthesizeSpeech(fromString: completeSentence)
                break
            }
        }
    }
    
    func synthesizeSpeech(fromString string: String) {
        let speechUtterance = AVSpeechUtterance(string: string)
        speechSynthesizer.speak(speechUtterance)
    }
   
    //Update Result Method when Photo is From Library
    
    func updatedResultMethod(request: VNRequest, error: Error?) {
      //code
    }
    
    //Open Library View Tap Gesture
    func openLibrarySetup() {
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        openLibraryView.addGestureRecognizer(tapGesture)
    
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    
    @IBAction func flashButtonTapped(_ sender: Any) {
        switch flashControlState {
        case .off:
            //flashButton.setTitle("FLASH ON", for: .normal)
            flashButton.setImage(imageON, for: .normal)
            flashControlState = .on
        case .on:
            //flashButton.setTitle("FLASH OFF", for: .normal)
            flashButton.setImage(imageOFF, for: .normal)
            flashControlState = .off
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
       // guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        //code here
    }
}

extension ViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            debugPrint(error)
        } else {
            photoData = photo.fileDataRepresentation()
            
            do {
                let model = try VNCoreMLModel(for: JapFoodClassifier().model)
                let request = VNCoreMLRequest(model: model, completionHandler: resultMethod)
                let handler = VNImageRequestHandler(data: photoData!)
                try handler.perform([request])
            } catch {
                debugPrint(error)
            }
            let image = UIImage(data: photoData!)
            self.capturedImageView.image = image
        }
    }
}


extension ViewController: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.cameraView.isUserInteractionEnabled = true
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
}
