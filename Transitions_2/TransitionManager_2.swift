//
//  TransitionManager_2.swift
//  Transitions_2
//
//  Created by alex livenson on 11/4/14.
//  Copyright (c) 2014 alex.livenson. All rights reserved.
//

import UIKit

class TransitionManager_2: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    private var isPresenting = false
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // Get References
        let container:UIView = transitionContext.containerView()
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let screens:(from: UIViewController, to: UIViewController) = (fromVC, toVC)
        
        // calculate who is in front
        let mainVC = !self.isPresenting ? screens.to as UIViewController : screens.from as UIViewController
        let menuVC = !self.isPresenting ? screens.from as MenuViewController : screens.to as MenuViewController
        
        // Need to add this to container to faciliate animation
        let menuView = menuVC.view
        let mainView = mainVC.view
        
        
        // Prepare the menuVC to be presented
        if self.isPresenting {
            self.offStageMenuViewController(menuVC)
        }
        
        container.addSubview(mainView)
        container.addSubview(menuView)
        
        let duration = transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, delay: 0.0,
            usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8,
            options: nil,
            animations: {
                if self.isPresenting {
                    self.onStageMenuViewController(menuVC)
                } else {
                    self.offStageMenuViewController(menuVC)
                }
                
            }, completion: { (finished:Bool) in
                transitionContext.completeTransition(true)
                UIApplication.sharedApplication().keyWindow?.addSubview(screens.to.view)
        })
        
    }
    
    func offStage(amount: CGFloat) -> CGAffineTransform {
        return CGAffineTransformMakeTranslation(amount, 0)
    }
    
    func offStageMenuViewController(menuVC: MenuViewController) {
        menuVC.view.alpha = 0
        let offSetTop:CGFloat = 300
        let offSetMiddle:CGFloat = 150
        let offSetBottom:CGFloat = 50
        
        // prepare menu items to slide in (Also this is why need the view controller)
        menuVC.imgAudio.transform = offStage(-offSetTop)
        menuVC.imgChat.transform = offStage(offSetTop)
        
        menuVC.imgLink.transform = offStage(-offSetMiddle)
        menuVC.imgCamera.transform = offStage(offSetMiddle)

        menuVC.imgQuote.transform = offStage(-offSetBottom)
        menuVC.imgText.transform = offStage(offSetBottom)
    }
    
    func onStageMenuViewController(menuVC: MenuViewController) {
        // fade out
        menuVC.view.alpha = 1
        
        // items slide out
        menuVC.imgAudio.transform = CGAffineTransformIdentity
        menuVC.imgChat.transform = CGAffineTransformIdentity
        
        menuVC.imgLink.transform = CGAffineTransformIdentity
        menuVC.imgCamera.transform = CGAffineTransformIdentity
        
        menuVC.imgQuote.transform = CGAffineTransformIdentity
        menuVC.imgText.transform = CGAffineTransformIdentity

    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = false
        return self
    }
    
}
