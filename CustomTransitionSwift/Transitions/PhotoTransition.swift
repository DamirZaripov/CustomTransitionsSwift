//
//  PhotoTransition.swift
//  CustomTransitionSwift
//
//  Created by Damir Zaripov on 26.04.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

class PhotoTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let durationTime = 2.0
    var currentCell: PhotoCollectionViewCell?
    var currentImage: UIImage?
    var selectedFrame: CGRect?
    var isPresenting = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return durationTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to), var toVC = toViewController.view, var fromVC = fromViewController.view else { return }
        
        let containerView = transitionContext.containerView
        let photoImageView = UIImageView(frame: selectedFrame!)
        photoImageView.image = currentImage
        
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.0
   
        containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0.0
        containerView.addSubview(backgroundView)
        containerView.addSubview(photoImageView)
        
        let photoVC = toViewController as! PhotoViewController
        let newFrame = photoVC.photoImageVIiew.frame

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { [weak self] in
            
            guard let strongSelf = self else { return }
            backgroundView.alpha = 1.0
            photoImageView.frame = newFrame
            
        }) { (isFinished) in
            fromViewController.view.alpha = 0.0
            toViewController.view.alpha = 1.0
            backgroundView.removeFromSuperview()
            photoImageView.removeFromSuperview()
            transitionContext.completeTransition(isFinished)
        }
    }
    
}
