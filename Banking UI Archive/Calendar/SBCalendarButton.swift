//
//  SBCalendarButton.swift
//  SkyBank
//
//  Created on 6/14/17.
//  Copyright © 2017 Onsolut LLC. All rights reserved.
//

import Foundation
import UIKit;

/// 45px high submit button
class SBCalendarButton: UIButton {
    static let heightDefault: CGFloat = 44;
    /// Overriding method to change appearance and add custom views
    ///
    /// - Parameter rect: Drawing rectangular
    override func draw(_ rect: CGRect) {
        super.draw(rect);
        self.titleLabel?.font = KVCalendarGlobals.FONT_DEFAULT;
        self.layer.cornerRadius = KVCalendarGlobals.CORNER_RADIUS_DEFAULT;
        self.layer.masksToBounds = true;
    }
    
    /// Overriding laying subviews to change background color
    override func layoutSubviews() {
        super.layoutSubviews();
        self.backgroundColor = KVCalendarGlobals.colors.main;
    }
    
    /// Disables button and changes its color
    func disable() {
        self.backgroundColor = KVCalendarGlobals.colors.border;
        self.setTitleColor(KVCalendarGlobals.colors.border, for: .normal);
        self.isEnabled = false;
    }
    
    /// Enables button and changes its color to brand blue
    func enable() {
        self.backgroundColor = KVCalendarGlobals.colors.main;
        self.setTitleColor(UIColor.white, for: .normal);
        self.isEnabled = true;
    }
}
