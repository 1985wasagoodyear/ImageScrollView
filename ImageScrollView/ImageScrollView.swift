import UIKit

open class ImageScrollView: UIScrollView {

    // MARK: - Properties
    
    open var image: UIImage! {
        didSet {
            imageView.image = image
            updateConstraintsForSize(bounds.size)
            zoomScale = minimumZoomScale
        }
    }
    
    open var allowPanWithoutZoom = false
    
    open private(set) var imageView: UIImageView!
    
    // MARK: - Internal Re-sizing Constraints for content ImageView
    
    private var imageViewTopConstraint: NSLayoutConstraint!
    private var imageViewLeadingConstraint: NSLayoutConstraint!
    private var imageViewTrailingConstraint: NSLayoutConstraint!
    private var imageViewBottomConstraint: NSLayoutConstraint!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }
    
    private func commonSetup() {
        let imView = UIImageView()
        imView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imView)
        
        // add constraints
        imageViewTopConstraint = NSLayoutConstraint(item: imView,
                                                         attribute: .top,
                                                         relatedBy: .equal,
                                                         toItem: self,
                                                         attribute: .top,
                                                         multiplier: 1.0,
                                                         constant: 0.0)
        imageViewLeadingConstraint = NSLayoutConstraint(item: imView,
                                                         attribute: .leading,
                                                         relatedBy: .equal,
                                                         toItem: self,
                                                         attribute: .leading,
                                                         multiplier: 1.0,
                                                         constant: 0.0)
        imageViewTrailingConstraint = NSLayoutConstraint(item: imView,
                                                         attribute: .trailing,
                                                         relatedBy: .equal,
                                                         toItem: self,
                                                         attribute: .trailing,
                                                         multiplier: 1.0,
                                                         constant: 0.0)
        imageViewBottomConstraint = NSLayoutConstraint(item: imView,
                                                         attribute: .bottom,
                                                         relatedBy: .equal,
                                                         toItem: self,
                                                         attribute: .bottom,
                                                         multiplier: 1.0,
                                                         constant: 0.0)
        imageViewTopConstraint.isActive = true
        imageViewLeadingConstraint.isActive = true
        imageViewTrailingConstraint.isActive = true
        imageViewBottomConstraint.isActive = true
        
        addConstraints([imageViewTopConstraint,
                             imageViewLeadingConstraint,
                             imageViewTrailingConstraint,
                             imageViewBottomConstraint])
        
        imageView = imView
        delegate = self
    }
    
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        
        if allowPanWithoutZoom == false {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        minimumZoomScale = minScale
        }
        else {
            minimumZoomScale = 1.0
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        updateMinZoomScaleForSize(bounds.size)
    }
    
    fileprivate func updateConstraintsForSize(_ size: CGSize) {
        if allowPanWithoutZoom == false {
            let yOffset = max(0, (size.height - imageView.frame.height) / 2)
            imageViewTopConstraint.constant = yOffset
            imageViewBottomConstraint.constant = yOffset
            
            let xOffset = max(0, (size.width - imageView.frame.width) / 2)
            imageViewLeadingConstraint.constant = xOffset
            imageViewTrailingConstraint.constant = xOffset
        }
        else {
            imageViewTopConstraint.constant = (size.height - imageView.frame.height) / 2
            imageViewBottomConstraint.constant = (size.height - imageView.frame.height) / 2
            
            imageViewLeadingConstraint.constant = (size.width - imageView.frame.width) / 2
            imageViewTrailingConstraint.constant = (size.width - imageView.frame.width) / 2
        }
        layoutIfNeeded()
    }
}

extension ImageScrollView: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(bounds.size)
    }
}

