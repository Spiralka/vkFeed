//
//  GalleryCollectionViewCell.swift
//  vkFeed
//
//  Created by  Евгений on 07/06/2019.
//  Copyright © 2019 LosAnatoly Inc. All rights reserved.
//

import Foundation
import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "GalleryCollectionViewCell"
    let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9098039216, alpha: 1)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myImageView)
        
        myImageView.fillSuperview()
    }
    
    override func prepareForReuse() {
        myImageView.image = nil
    
    }
    
    func set(imageUrl: String?){
        myImageView.set(imageURL: imageUrl)
    }
    
    override func layoutSubviews() {
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = 10
        self.layer.shadowRadius = 3
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 2.5, height: 4)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
