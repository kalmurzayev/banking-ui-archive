//
//  SBCalendarControlView.swift
//  SkyBank
//
//  Created on 6/14/17.
//  Copyright © 2017 Onsolut LLC. All rights reserved.
//

import Foundation
import UIKit;
/// Block containing left and right shift buttons with label in the middle
class SBCalendarControlView: UIView {
    static let heightDefault: CGFloat = 24;
    
    var leftButton: UIButton?;
    var rightButton: UIButton?;
    var titleLabel: UILabel?;
    // MARK: - init methods
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.initiateViews();
    }
    
    convenience init() {
        self.init(frame: CGRect.zero);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    /// Helper function to initiate all subviews and add effects
    private func initiateViews() {
        self.leftButton = UIButton();
        self.leftButton?.frame = CGRect(
            x:0, y:0,
            width: KVCalendarGlobals.ICONBUTTON_WIDTH,
            height: KVCalendarGlobals.ICONBUTTON_WIDTH
        );
//        self.leftButton?.setImage(SBAssets.chevronLeftBlue.image, for: .normal);
        self.addSubview(self.leftButton!);
        
        self.rightButton = UIButton();
        self.rightButton?.frame = CGRect(
            x: self.frame.width - KVCalendarGlobals.ICONBUTTON_WIDTH,
            y: 0,
            width: KVCalendarGlobals.ICONBUTTON_WIDTH,
            height: KVCalendarGlobals.ICONBUTTON_WIDTH
        );
//        self.rightButton.setImage(SBAssets.chevronRightBlue.image, for: .normal);
        self.addSubview(self.rightButton!);
        
        self.titleLabel = UILabel();
        self.titleLabel?.frame = CGRect(
            x:self.leftButton!.frame.maxX,
            y:0,
            width:self.frame.width - self.leftButton!.frame.width - self.rightButton!.frame.width,
            height:KVCalendarGlobals.ICONBUTTON_WIDTH
        );
        self.titleLabel?.textColor = KVCalendarGlobals.colors.textfield;
        self.titleLabel?.font = KVCalendarGlobals.FONT_DEFAULT;
        self.titleLabel?.textAlignment = .center;
        self.addSubview(self.titleLabel!);
    }
}
