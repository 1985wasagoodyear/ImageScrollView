//
//  ImageScrollView.swift
//  ScrollingImage
//
//  Created by Kevin Yu on 11/14/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

import UIKit

open class ImageScrollView: UIScrollView {

    open var image: UIImage! {
        didSet {
            self.imageView.image = image
            self.updateConstraintsForSize(self.bounds.size)
            self.zoomScale = self.minimumZoomScale
        }
    }
    
    open var imageView: UIImageView!
    
    private var imageViewTopConstraint: NSLayoutConstraint!
    private var imageViewLeadingConstraint: NSLayoutConstraint!
    private var imageViewTrailingConstraint: NSLayoutConstraint!
    private var imageViewBottomConstraint: NSLayoutConstraint!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }
    
    private func commonSetup() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        // add constraints
    
        self.imageViewTopConstraint = NSLayoutConstraint(item: imageView,
                                                         attribute: .top,
                                                         relatedBy: .equal,
                                                         toItem: self,
                                                         attribute: .top,
                                                         multiplier: 1.0,
                                                         constant: 0.0)
        self.imageViewLeadingConstraint = NSLayoutConstraint(item: imageView,
                                                         attribute: .leading,
                                                         relatedBy: .equal,
                                                         toItem: self,
                                                         attribute: .leading,
                                                         multiplier: 1.0,
                                                         constant: 0.0)
        self.imageViewTrailingConstraint = NSLayoutConstraint(item: imageView,
                                                         attribute: .trailing,
                                                         relatedBy: .equal,
                                                         toItem: self,
                                                         attribute: .trailing,
                                                         multiplier: 1.0,
                                                         constant: 0.0)
        self.imageViewBottomConstraint = NSLayoutConstraint(item: imageView,
                                                         attribute: .bottom,
                                                         relatedBy: .equal,
                                                         toItem: self,
                                                         attribute: .bottom,
                                                         multiplier: 1.0,
                                                         constant: 0.0)
        self.imageViewTopConstraint.isActive = true
        self.imageViewLeadingConstraint.isActive = true
        self.imageViewTrailingConstraint.isActive = true
        self.imageViewBottomConstraint.isActive = true
        
        self.addConstraints([self.imageViewTopConstraint,
                             self.imageViewLeadingConstraint,
                             self.imageViewTrailingConstraint,
                             self.imageViewBottomConstraint])
        
        self.imageView = imageView
        self.delegate = self
    }
    
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        self.minimumZoomScale = minScale
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        updateMinZoomScaleForSize(self.bounds.size)
    }
    
    fileprivate func updateConstraintsForSize(_ size: CGSize) {
        
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        self.layoutIfNeeded()
    }
}

extension ImageScrollView: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.updateConstraintsForSize(self.bounds.size)
    }
}

