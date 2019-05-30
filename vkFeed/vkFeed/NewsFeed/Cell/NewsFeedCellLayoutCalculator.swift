//
//  NewsFeedCellLayoutCalculator.swift
//  vkFeed
//
//  Created by  Евгений on 29/05/2019.
//  Copyright © 2019 LosAnatoly Inc. All rights reserved.
//

import Foundation
import UIKit

struct Sizes: FeedCellSizes {
    
    var postLabelFrame: CGRect
    var attacmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
    
}



protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth

    }
    
 
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        let cardViewWidth = screenWidth - Contants.cardInsets.left - Contants.cardInsets.right
        
        //MARK: postLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Contants.postLabelInsets.left, y: Contants.postLabelInsets.top), size: .zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Contants.postLabelInsets.left - Contants.postLabelInsets.right
            let height = text.height(width: width, font: Contants.postLabelFont)
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: attacmentFrame
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Contants.postLabelInsets.top : postLabelFrame.maxY + Contants.postLabelInsets.bottom
        var attacmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: .zero)

        if let attachment = photoAttachment {
            let photoHeight: Float = Float(attachment.height)
            let photoWidtht: Float = Float(attachment.width)

            let ratio = CGFloat(photoHeight / photoWidtht)
            attacmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        }
        
        //MARK: bottomViewFrame
        let bottomViewTop = max(postLabelFrame.maxY, attacmentFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: cardViewWidth, height: Contants.bottomViewHeight))

        let totalHeight = bottomViewFrame.maxY + Contants.cardInsets.bottom
        
        return Sizes(postLabelFrame: postLabelFrame,
                     attacmentFrame: attacmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
    }
    
   
}

