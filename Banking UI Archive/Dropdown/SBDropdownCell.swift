//
//  SBDropdownCell.swift
//  SkyBank
//
//  Created on 6/12/17.
//  Copyright © 2017 Onsolut LLC. All rights reserved.
//

import Foundation
import UIKit;

class SBDropdownCell: UITableViewCell {
    private var selectImageView: UIImageView?;
    var customImage: UIImage?;
    var isChecked: Bool = false;
    /// Overriding method to change appearance and add custom views
    ///
    /// - Parameter rect: Drawing rectangular
    override func draw(_ rect: CGRect) {
        super.draw(rect);
        if self.selectImageView == nil {
            self.selectImageView = UIImageView();
            self.contentView.addSubview(self.selectImageView!);
        }
        self.selectImageView?.frame = CGRect(
            x: self.frame.width - KVCalendarGlobals.margins.M - 24,
            y: self.frame.height / 2 - 12,
            width: 24,
            height: 24);
        if self.customImage != nil {
            self.selectImageView?.image = customImage;
        } else {
//            self.selectImageView?.image = SBAssets.success.image;
            self.selectImageView!.alpha = self.isChecked ? 1 : 0;
        }
    }
    
    /// Factory method to create
    ///
    /// - Returns: SBDropdownCell instance
    static func instance() -> SBDropdownCell {
        let cell = SBDropdownCell(style: .default, reuseIdentifier: "DropdownCell");
        cell.textLabel?.font = KVCalendarGlobals.FONT_DEFAULT;
        cell.textLabel?.textColor = KVCalendarGlobals.colors.textfield;
        cell.selectionStyle = .none;
        return cell;
    }
}
