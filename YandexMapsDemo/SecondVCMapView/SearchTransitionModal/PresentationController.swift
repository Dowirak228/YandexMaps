//
//  PresentationController.swift
//  YandexMapsDemo
//
//  Created by NODIR KARIMOV on 07/01/22.
//

import UIKit

class PresentationController: UIPresentationController {
    
    let blackView = UIView()
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    
    var statusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
            blackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.blackView.isUserInteractionEnabled = true
            self.blackView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * (1 - (701 / 736))),
               size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height *
                                (701 / 736)))
    }
    
    override func presentationTransitionWillBegin() {
        self.blackView.alpha = 0
        self.containerView?.addSubview(blackView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blackView.alpha = 0.7
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blackView.alpha = 0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            self.blackView.removeFromSuperview()
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.roundCorners([.topLeft, .topRight], radius: 22)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blackView.frame = containerView!.bounds
    }
    
    @objc func dismissController(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

