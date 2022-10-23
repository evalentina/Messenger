//
//  ChatViewController.swift
//  Messenger
//
//  Created by Валентина Евдокимова on 22.10.2022.
//

import UIKit
import MessageKit

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct Sender : SenderType {
    var senderId: String
    var displayName: String
    var photoURLString : String
    
    
}

class ChatViewController: MessagesViewController {
    
    private var messages = [Message]()
    private let sender = Sender(senderId: "", displayName: "Nastya Semenova", photoURLString: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messages.append(Message(sender: sender, messageId: "", sentDate: .now, kind: .text("Hello")))
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        
    }

}

extension ChatViewController : MessagesDisplayDelegate, MessagesLayoutDelegate, MessagesDataSource {
    func currentSender() -> SenderType {
        return sender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}
