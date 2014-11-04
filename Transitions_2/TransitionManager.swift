//
//  MenuTransitionManager.swift
//  Transitions_2
//
//  Created by alex livenson on 11/3/14.
//  Copyright (c) 2014 alex.livenson. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    private var presenting = false
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView()
        // In previous example we used tansitionContext.viewForKey -> But for this we need the controller
        let fromVC:UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC:UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let screens: (from: UIViewController, to: UIViewController) = (fromVC, toVC)
        
        // assign reference for menu and main vc
        let bottomVC = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        let menuVC = !self.presenting ? screens.from as MenuViewController : screens.to as MenuViewController
        
        let bottomView = bottomVC.view
        let menuView = menuVC.view
        
        // prepare the menu
        if self.presenting {
            menuView.alpha = 0
        }
        
        container.addSubview(bottomView)
        container.addSubview(menuView)
        
        let duration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, delay:0.0, options:nil,
            animations: {
                menuView.alpha = self.presenting ? 1 : 0
            }, completion: { (finished:Bool) in
                transitionContext.completeTransition(true)
                // Fix weird bug
                UIApplication.sharedApplication().keyWindow?.addSubview(screens.to.view)
        })
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    // Gets called first (Main -> Menu)
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
        
}
