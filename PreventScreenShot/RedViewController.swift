//
//  ViewController.swift
//  PreventScreenShot
//
//  Created by M3ts LLC on 3/2/22.
//

import UIKit

class RedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
     /* This code below used to hide some view and screen when user screen shot */
     self.view.setScreenCaptureProtection()
     self.view.makeSecure()
        
    // In the code above we are adding ourselves as an observer to notification userDidTakeScreenshotNotification  and catching with function didTakeScreenShot which will get triggered anytime a user tries to take a screenshot. At this point in time as a developer, we have the opportunity to handle in a way we want for our app. For eg. show a warning message and then kill the app after informing the user. Here is a gif that captures it.
    NotificationCenter.default.addObserver(self, selector: #selector(didTakeScreenshot(notification:)), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
      if isRecording() {
          print("Do something for privacy")
       self.view.makeSecure()
     } else {
          print("No recording")
       }
    }
    
    @objc func didTakeScreenshot(notification:Notification) -> Void {
        print("Screen Shot Taken") // At this point in time as a developer, we have the opportunity to handle in a way we want for our app. For eg. show a warning message and then kill the app after informing the user. Here is a gif that captures it.
        let alert = UIAlertController(title: "Screen Shot", message: "Screen Shot Taken !", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // We can decide to check for recording by calling the method isRecording. We can call this method depending on our needs. We can either call it on different states of our view life cycle or having a timer to check for this. Here is a demo that shows screen recording detection.
    func isRecording() ->Bool {
        for screen in UIScreen.screens {
            if (screen.isCaptured) {
                print("screen is recorded")
                return true
            }
        }
        return false
    }
}

// This function below help prevent the screen shot
private extension UIView {
    // This function hide the view when it taken the screen shot
    func setScreenCaptureProtection() {
        guard superview != nil else {
            for subview in subviews { //to avoid layer cyclic crash, when it is a topmost view, adding all its subviews in textfield's layer, TODO: Find a better logic.
                subview.setScreenCaptureProtection()
            }
            return
        }
        let guardTextField = UITextField()
        guardTextField.backgroundColor = .red
        guardTextField.translatesAutoresizingMaskIntoConstraints = false
        guardTextField.isSecureTextEntry = true
        addSubview(guardTextField)
        guardTextField.isUserInteractionEnabled = false
        sendSubviewToBack(guardTextField)
        layer.superlayer?.addSublayer(guardTextField.layer)
        guardTextField.layer.sublayers?.first?.addSublayer(layer)
        guardTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        guardTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        guardTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        guardTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
    
    func makeSecure() {
        DispatchQueue.main.async {
            let field = UITextField()
            field.isSecureTextEntry = true
            self.addSubview(field)
            field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.layer.superlayer?.addSublayer(field.layer)
            field.layer.sublayers?.first?.addSublayer(self.layer)
        }
    }
}
