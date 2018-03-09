//
//  ViewController.swift
//  ssssssss
//
//  Created by Igor Smirnov on 14/02/2018.
//  Copyright © 2018 IS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var topGradientView: UIView!
    @IBOutlet weak var bottomView: UIView!

    var model: [Message] = []
    let gradientLayer = CAGradientLayer()
    var isKeyboardShown = false

    deinit {
        unscribeFromKeyboardAppearance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
        model.append(Message(text: "first nah", date: Date(), isOwn: true))
        model.append(Message(text: "third hjfgas jdfgaksdjf aksdj fgajsdhfg kasjdhfg aksjd fasdfhgas dhjfg aksdfjhg aksdjfsa", date: Date()))
        model.append(Message(text: "Пятое", date: Date(), isOwn: true))
        tableView.reloadData()
        tableView.dataSource = self
        tableView.delegate = self

        tableView.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi)

        messageTextField.delegate = self

        gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0.0).cgColor]
        topGradientView.layer.addSublayer(gradientLayer)
        subscribeKeyboardAppearance()
    }

    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = topGradientView.bounds
    }

    @IBAction func sendMessageButtonAction(_ sender: Any) {
        guard let text = messageTextField.text, text != "" else { return }
        let indexPath = IndexPath(row: 0, section: 0)
        model.insert(Message(text: text, date: Date(), isOwn: true), at: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.top)
        tableView.endUpdates()
        tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
        messageTextField.text = ""
        //self.view.endEditing(true)
    }

    @IBAction func tapOnTableViewAction(_ sender: Any) {
        self.view.endEditing(true)
    }

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        let message = self.model[indexPath.row]
        cell.setup(message: message)
        cell.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi)
        return cell
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var message = model[indexPath.row]
        guard message.isNew else { return }
        let initialTransform = cell.transform
        cell.transform = initialTransform.scaledBy(x: 2.5, y: 2.5)
        cell.frame.origin.x = tableView.frame.width
        cell.alpha = 0.0
        message.isNew = false
        self.model[indexPath.row] = message
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0.1,
            options: .curveEaseIn,
            animations: {
                cell.transform = initialTransform
                cell.frame.origin.x = 0.0
                cell.alpha = 1.0
            },
            completion: { completed in
                cell.transform = initialTransform
                cell.frame.origin.x = 0.0
            }
        )
    }

}

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessageButtonAction(self)
        //self.view.endEditing(true)
        return true
    }
}

//MARK: keyboard appereance
private extension ViewController {
    func subscribeKeyboardAppearance() {

        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { notification in
            guard
                !self.isKeyboardShown,
                let userInfo = notification.userInfo,
                let keyboardSizeValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
                let animationDurationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber,
                let animationCurveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
                else { return }

            let keyboardSize = keyboardSizeValue.cgRectValue.size
            let animationDuration = animationDurationValue.doubleValue
            let animationCurve = UIViewAnimationCurve(rawValue: animationCurveValue.intValue) ?? .easeInOut

            UIView.animate(
                withDuration: animationDuration,
                delay: 0.0,
                options: UIViewAnimationOptions(curve: animationCurve),
                animations: {
                    //self.view.frame.origin.y -= keyboardSize.height
                    self.view.frame.size.height -= keyboardSize.height
                    self.view.layoutIfNeeded()
                },
                completion: { completed in self.isKeyboardShown = true }
            )

        }

        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) { notification in
            guard
                self.isKeyboardShown,
                let userInfo = notification.userInfo,
                let keyboardSizeValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
                let animationDurationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber,
                let animationCurveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
                else { return }

            let keyboardSize = keyboardSizeValue.cgRectValue.size
            let animationDuration = animationDurationValue.doubleValue
            let animationCurve = UIViewAnimationCurve(rawValue: animationCurveValue.intValue) ?? .easeInOut

            UIView.animate(
                withDuration: animationDuration,
                delay: 0.0,
                options: UIViewAnimationOptions(curve: animationCurve),
                animations: {
                    //self.view.frame.origin.y += keyboardSize.height
                    self.view.frame.size.height += keyboardSize.height
                    self.view.layoutIfNeeded()
                },
                completion: { completed in self.isKeyboardShown = false }
            )
        }
    }
    
    func unscribeFromKeyboardAppearance() {
        NotificationCenter.default.removeObserver(self)
    }
    
}
