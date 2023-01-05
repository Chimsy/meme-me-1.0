//
//  MemeDetailViewController.swift
//  MemeMe 1.0
//
//  Created by Golden Chimusinde on 2023/01/05.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    // MARK: Properties and Outlets
    var meme: Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView!.image = meme.memedImage
    }
    
}
