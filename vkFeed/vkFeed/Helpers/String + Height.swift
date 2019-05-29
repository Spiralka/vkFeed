//
//  String + Height.swift
//  vkFeed
//
//  Created by  Евгений on 29/05/2019.
//  Copyright © 2019 LosAnatoly Inc. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return ceil(size.height)
    }
}
