//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Golden Chimusinde on 2022/08/15.
//

import UIKit

class MemeEditorViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    // MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtFieldTop: UITextField!
    @IBOutlet weak var txtFieldBottom: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTextField(textField: txtFieldTop, text: "TOP")
        setUpTextField(textField: txtFieldBottom, text: "BOTTOM")
        shareButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
        
#if targetEnvironment(simulator)
        cameraButton.isEnabled = false;
#else
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera);
#endif
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }

    // MARK: Generate & Send Meme
    func pickAnImageFromSource(source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            shareButton.isEnabled = true
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        //Hide Toolbar And Navigation Bar
        navigationBar.isHidden = true
        toolbar.isHidden = true
        
        // Render View To An Image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //Show Toolbar and Navigation Bar
        navigationBar.isHidden = false
        toolbar.isHidden = false
        
        return memedImage
    }
    
    func save() {
        // Create The Meme
        let memedImage = generateMemedImage()
        let meme = Meme(topText: txtFieldTop.text!, bottomText: txtFieldBottom.text!, originalImage: imageView.image, memedImage:memedImage)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    // MARK: IBActions
    @IBAction func albumButtonAcrion(_ sender: Any) {
        pickAnImageFromSource(source: .photoLibrary)
    }
    
    @IBAction func cameraButtonAction(_ sender: Any) {
        pickAnImageFromSource(source: .camera)
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityController.completionWithItemsHandler = { activity, success, items, error in
            
            if success {
                self.save()
            } else{
                DispatchQueue.main.async {
                    let alertMsg = "Alert message when something goes wrong when saving the meme"
                    let message = NSLocalizedString("Unable to save meme", comment: alertMsg)
                    let alertController = UIAlertController(title: "MemeMe", message: message, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            self.dismiss(animated: true, completion: nil)
            
        }
        
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        shareButton.isEnabled = false
        
        txtFieldTop.text = "TOP"
        txtFieldBottom.text = "BOTTOM"
        imageView.image = nil
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
