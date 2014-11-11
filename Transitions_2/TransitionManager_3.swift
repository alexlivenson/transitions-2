//
//  TransitionManager3.swift
//  Transitions_2
//
//  Created by alex livenson on 11/9/14.
//  Copyright (c) 2014 alex.livenson. All rights reserved.
//

import UIKit

class TransitionManager_3: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning,
UIViewControllerTransitioningDelegate, UIViewControllerInteractiveTransitioning {
    
    private var interactive = false
    private var isPresenting = false
    private var enterPanGesture: UIScreenEdgePanGestureRecognizer!
    
    /*
    Link gesture to transition
    1. tell transition when to start
    2. tell the transition how far through the transition it should be (0 - 100)
    3. Tell the transition when to complete
    */
    
    var sourceVC: UIViewController! {
        didSet {
            self.enterPanGesture = UIScreenEdgePanGestureRecognizer()
            self.enterPanGesture.addTarget(self, action: "handleOnStagePan:")
            self.enterPanGesture.edges = UIRectEdge.Left
            self.sourceVC.view.addGestureRecognizer(self.enterPanGesture)
        }
    }
    
    func handleOnStagePan(pan: UIPanGestureRecognizer) {
        
        // how much distance panned relative to parent view
        let translation = pan.translationInView(pan.view!)
        
        // do some calculations to get in percentage
        let d = translation.x / CGRectGetWidth(pan.view!.bounds) * 0.5
        println("Value is : \(d)")
        
        // now deal with different states from gesture reconginzer
        switch(pan.state) {
        case UIGestureRecognizerState.Began:
            // set interactive flag to true
            self.interactive = true
            
            // trigger the start of transition
            self.sourceVC.performSegueWithIdentifier("presentMenu", sender: self)
            break
        case UIGestureRecognizerState.Changed :
            // update progress of transitions
            self.updateInteractiveTransition(d)
            break
        default: // .Ended, .Cancelled, .Failed ...
            // return flag to false and finished the transition
            self.interactive = false
            self.finishInteractiveTransition()
        }
        
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let container: UIView = transitionContext.containerView()
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let screens: (from: UIViewController, to: UIViewController) = (fromVC, toVC)
        
        // calcuate which vc is in front
        let mainVC = !self.isPresenting ? screens.to as UIViewController : screens.from as UIViewController
        let menuVC = !self.isPresenting ? screens.from as MenuViewController : screens.to as MenuViewController
        
        // Prepare the menuVC to be presented
        if self.isPresenting {
            self.offStageMenuViewController(menuVC)
        }
        
        container.addSubview(mainVC.view)
        container.addSubview(menuVC.view)
        
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
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactive ? self : nil
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactive ? self : nil
    }
    
}
