//
//  PhotoViewController.swift
//  CustomTransitionSwift
//
//  Created by Damir Zaripov on 26.04.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoImageVIiew: UIImageView!
    var photo: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView(with: photo)
        // Do any additional setup after loading the view.
    }

    func setupImageView(with image: UIImage) {
        photoImageVIiew.image = image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
