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
    var moreTextButtonFrame: CGRect
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
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        //MARK: postLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: .zero)
        
        var showMoreTextButton = false
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.height(width: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minigiedPostLimitsLines
            
            if height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        //MARK: moreTextButtonFrame
        
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)

        //MARK: attacmentFrame
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        var attacmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: .zero)

        if let attachment = photoAttachment {
            let photoHeight: Float = Float(attachment.height)
            let photoWidtht: Float = Float(attachment.width)

            let ratio = CGFloat(photoHeight / photoWidtht)
            attacmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        }
        
        //MARK: bottomViewFrame
        let bottomViewTop = max(postLabelFrame.maxY, attacmentFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))

        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(postLabelFrame: postLabelFrame,
                     moreTextButtonFrame: moreTextButtonFrame,
                     attacmentFrame: attacmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
    }
    
   
}

