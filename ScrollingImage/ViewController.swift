import UIKit
import ImageScrollView

extension UIView {
    func setupToFill(superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}

class ViewController: UIViewController {

    var imScrollView: ImageScrollView!
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        imScrollView = ImageScrollView(frame: view.frame)
        imScrollView.setupToFill(superView: view)
        imScrollView.allowPanWithoutZoom = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imScrollView.image = UIImage(named: "ultimatecake.png")
        imScrollView.imageView.contentMode = .scaleAspectFit
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        imScrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapAction() {
        if (imScrollView.tag == 0) {
            imScrollView.image = UIImage(named: "meowTheMagnificent.jpg")
            imScrollView.tag = 1
        }
        else {
            imScrollView.image = UIImage(named: "ultimatecake.png")
            imScrollView.tag = 0
        }
    }
}
