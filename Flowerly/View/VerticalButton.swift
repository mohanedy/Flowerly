//
//  VerticalButton.swift
//  Flowerly
//
//  Created by Mohaned Yossry on 5/1/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class VerticalButton: UIButton {

    @IBInspectable public var padding: CGFloat = 20.0 {
        didSet {
            setNeedsLayout()
        }
    }

    override var intrinsicContentSize: CGSize {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)

        if let titleSize = titleLabel?.sizeThatFits(maxSize), let imageSize = imageView?.sizeThatFits(maxSize) {
            let width = ceil(max(imageSize.width, titleSize.width))
            let height = ceil(imageSize.height + titleSize.height + padding)

            return CGSize(width: width, height: height)
        }

        return super.intrinsicContentSize
    }

    override func layoutSubviews() {
        if let image = imageView?.image, let title = titleLabel?.attributedText {
            let imageSize = image.size
            let titleSize = title.size()

            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + padding), right: 0.0)
            imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + padding), left: 0.0, bottom: 0.0, right: -titleSize.width)
        }

        super.layoutSubviews()
    }

}
