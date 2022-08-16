//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Golden Chimusinde on 2022/08/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtFieldTop: UITextField!
    @IBOutlet weak var txtFieldBottom: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func shareButtonAction(_ sender: Any) {
        
        print("\nℹ️ MemeMe: Did Press Share Button  \n✅")
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        print("\nℹ️ MemeMe: Did Press Cancel Button \n✅")
    }
    
    @IBAction func cameraButtonAction(_ sender: Any) {
        print("\nℹ️ MemeMe: Did Press Camera Button \n✅")
    }
    
    @IBAction func albumButtonAcrion(_ sender: Any) {
        print("\nℹ️ MemeMe: Did Press Album Button \n✅")
    }
    
}

