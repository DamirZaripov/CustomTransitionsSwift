//
//  CustomInteractor.swift
//  CustomTransitionSwift
//
//  Created by Damir Zaripov on 27.04.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

class CustomInteractor: UIPercentDrivenInteractiveTransition {
    
    var navigationController: UINavigationController!
    var viewController: PhotoViewController!
    var shouldCompleteTransition = false
    var transitionInProgress = false
    var viewTranslationComplete: CGFloat = 0
    let zero = CGFloat(0)
    
    func attach(to photoVC: PhotoViewController) {
        viewController = photoVC
        navigationController = photoVC.navigationController
        setupGestureRecognizer(view: photoVC.view)
    }
    
    private func setupGestureRecognizer(view: UIView) {
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gestureRecognizer:))))
    }
    
    @objc
    func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        guard let superview = gestureRecognizer.view?.superview else { return }

        switch gestureRecognizer.state {
        case .began:
            transitionInProgress = true
            navigationController.popViewController(animated: true)
        case .cancelled, .ended, .changed:
            transitionInProgress = false
            viewTranslationComplete = zero
            if shouldCompleteTransition || gestureRecognizer.state == .cancelled {
                cancel()
            } else {
                finish()
            }
        default: return
        }
        
        gestureRecognizer.setTranslation(CGPoint.zero, in: superview)
    }
}
