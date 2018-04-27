//
//  PhotoViewController.swift
//  CustomTransitionSwift
//
//  Created by Damir Zaripov on 26.04.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    var photo: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView(with: photo)
        initNavigationBar()
    }

    func setupImageView(with image: UIImage) {
        photoImageView.image = image
    }
    
    func initNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        guard let navigationBarFrame = navigationController?.navigationBar.frame else { return }
        let navigationBar = UINavigationBar(frame: navigationBarFrame)
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        self.view.addSubview(navigationBar)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        let navigationBarItem = UINavigationItem(title: "Test")
        navigationBarItem.leftBarButtonItem = cancelButton
        navigationBar.setItems([navigationBarItem], animated: true)
    }
    
    @objc
    func close() {
        navigationController?.popViewController(animated: true)
    }
    
}
