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
    
        var photoImageViewFromVC: UIImageView!
        
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to),
            let toVC = toViewController.view, let fromVC = fromViewController.view else { return }
        
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
        
        
        if let photoVC = toViewController as? PhotoViewController {
            photoImageViewFromVC = photoVC.photoImageView
        } else if let photoVC = fromViewController as? PhotoViewController {
            photoImageViewFromVC = photoVC.photoImageView
        }
        
        if (isPresenting) {
            backgroundView.alpha = 1.0
            fromVC.alpha = 0.0
            photoImageView.frame = photoImageViewFromVC.frame
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { [weak self] in
            
            guard let strongSelf = self else { return }
            if (strongSelf.isPresenting) {
                backgroundView.alpha = 0.0
                toVC.alpha = 1.0
                guard let selectedFrame = self?.selectedFrame else { return }
                photoImageView.frame = selectedFrame
            } else {
                backgroundView.alpha = 1.0
                photoImageView.frame = photoImageViewFromVC.frame
            }
            
        }) { [weak self] (isFinished) in
            
            guard let strongSelf = self else { return }
            if (strongSelf.isPresenting) {
                transitionContext.completeTransition(isFinished)
            } else {
                fromVC.alpha = 0.0
                toVC.alpha = 1.0
                backgroundView.removeFromSuperview()
                photoImageView.removeFromSuperview()
                transitionContext.completeTransition(isFinished)
            }
        }
    }
    
}
