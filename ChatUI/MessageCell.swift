//
//  MessageCell.swift
//  ssssssss
//
//  Created by Igor Smirnov on 14/02/2018.
//  Copyright © 2018 IS. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageTextLabel: UILabel!

    @IBOutlet weak var messageViewLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageViewRightConstraint: NSLayoutConstraint!

    @IBOutlet weak var messageTextBackView: UIView!

    static var ownColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
    static var nonOwnColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)

    func setup(message: Message) {
        dateLabel.text = "\(message.date)"
        messageTextLabel.text = message.text
        messageTextLabel.numberOfLines = 0
        messageTextLabel.lineBreakMode = .byWordWrapping
        messageTextBackView.backgroundColor = message.isOwn ? MessageCell.ownColor : MessageCell.nonOwnColor
        messageTextBackView.layer.cornerRadius = 6.0
        messageViewLeftConstraint.constant = message.isOwn ? 64.0 : 16.0
        messageViewRightConstraint.constant = !message.isOwn ? 64.0 : 16.0
        messageTextBackView.layer.shadowColor = UIColor.black.cgColor
        messageTextBackView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        messageTextBackView.layer.shadowOpacity = 0.3
        messageTextBackView.layer.shadowRadius = 0.5
        //messageTextBackView.layer.masksToBounds = false
    }

}
