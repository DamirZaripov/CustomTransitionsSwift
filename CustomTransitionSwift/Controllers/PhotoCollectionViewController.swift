//
//  PhotoCollectionViewController.swift
//  CustomTransitionSwift
//
//  Created by Damir Zaripov on 26.04.2018.
//  Copyright © 2018 iOSLab. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"
private let photoSegueIdentifier = "photoSegue"

class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate {

    var images = [UIImage]()
    let startImageNameNumber = 0
    let endImageNameNumber = 5
    var photoTransition = PhotoTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in startImageNameNumber...endImageNameNumber {
            guard let image = UIImage(named: "\(i)") else { return }
            images.append(image)
        }
   
        self.navigationController?.delegate = self
        prepareCollectionView()
    }

    func prepareCollectionView() {
        guard let collectionView = self.collectionView else { return }
        let nib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
    
        let image = images[indexPath.row]
        cell.prepare(with: image)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let imageWidth = UIScreen.main.bounds.width / 2 - flowLayout.minimumInteritemSpacing
        return CGSize(width: imageWidth, height: imageWidth)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.row]
        
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
        photoTransition.currentCell = cell
        photoTransition.currentImage = image
        let theAttributes:UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
        photoTransition.selectedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)
        
        performSegue(withIdentifier: photoSegueIdentifier, sender: image)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == photoSegueIdentifier {
            guard let image = sender as? UIImage else { return }
            let destinationViewController = segue.destination as! PhotoViewController
            destinationViewController.photo = image
            destinationViewController.transitioningDelegate = self
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return photoTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

extension PhotoCollectionViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
       
        photoTransition.isPresenting = (operation == .push)
        return photoTransition
    }
    
}
