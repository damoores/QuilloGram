//
//  ViewController.swift
//  QuilloGram
//
//  Created by Jeremy Moore on 6/20/16.
//  Copyright © 2016 Jeremy Moore. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, Setup {

    @IBOutlet weak var imageView: UIImageView!
    
    lazy var imagePicker = UIImagePickerController()

    
    func setup() {
        self.navigationItem.title = "Quillogram"
    }
    
    func setupAppearance() {
        self.imageView.layer.cornerRadius = 5.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Add an Image", message: "Select image source.", preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) in
            self.presentImagePicker(.Camera)
        }
        let photosAction = UIAlertAction(title: "Photo Roll", style: .Default) { (action) in
            self.presentImagePicker(.PhotoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photosAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func presentImagePicker (sourceType: UIImagePickerControllerSourceType) {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        guard let image = self.imageView.image else { return }
        API.shared.write(Post(image: image)) { (success) in
            if success {
                
                UIImageWriteToSavedPhotosAlbum(self.imageView.image!, nil, nil, nil)
            }
        }
    }
    
//    func saveSuccess(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafePointer<Void>) {
//        if error == nil {
//        let alert = UIAlertController(title: "Success!", message: "Image saved to photo library", preferredStyle: .Alert)
//        let OKActtion = UIAlertAction(title: "OK", style: .Default) { (action) in
//            self.dismissViewControllerAnimated(true, completion: nil)
//        }
//        alert.addAction(OKActtion)
//        self.presentViewController(alert, animated: true, completion: nil)
//    }
//    }
    @IBAction func editButtonPressed(sender: AnyObject) {
        
        func presentActionSheet() {
            let actionSheet = UIAlertController(title: "Choose Filter", message: "Please select a filter to apply.", preferredStyle: .ActionSheet)
            let blackAndWhiteAction = UIAlertAction(title: "Black & White", style: .Default) { (action) in
                guard let image = self.imageView.image else { return }
                
                Filters.blackAndWhite(image) { (theImage) in
                    self.imageView.image = theImage
                }
            }
            let vintageAction = UIAlertAction(title: "Vintage", style: .Default) { (action) in
                guard let image = self.imageView.image else { return }
                
                Filters.vintage(image) { (theImage) in
                    self.imageView.image = theImage
                }
            }
            let chromeAction = UIAlertAction(title: "Chrome", style: .Default) { (action) in
                guard let image = self.imageView.image else { return }
                
                Filters.chrome(image) { (theImage) in
                    self.imageView.image = theImage
                }
            }
            let blurAction = UIAlertAction(title: "Circle", style: .Default) { (action) in
                guard let image = self.imageView.image else { return }
                
                Filters.blur(image) { (theImage) in
                    self.imageView.image = theImage
                }
            }
            let skewAction = UIAlertAction(title: "Skew", style: .Default) { (action) in
                guard let image = self.imageView.image else { return }
                
                Filters.skew(image) { (theImage) in
                    self.imageView.image = theImage
                }

            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            actionSheet.addAction(blackAndWhiteAction)
            actionSheet.addAction(vintageAction)
            actionSheet.addAction(chromeAction)
            actionSheet.addAction(blurAction)
            actionSheet.addAction(skewAction)

            actionSheet.addAction(cancelAction)
            
            self.presentViewController(actionSheet, animated: true, completion: nil)
        }
        
        presentActionSheet()
    }
    
    //MARK: UIImagePickerController Delegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
    }
}

