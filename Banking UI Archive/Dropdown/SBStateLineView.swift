//
//  SBStateLineView.swift
//  SkyBank
//
//  Created on 6/12/17.
//  Copyright © 2017 Onsolut LLC. All rights reserved.
//

import Foundation
import UIKit;

/// Gray line used in textFields and other places (turns on and off)
class SBStateLineView: UIView {
    static let heightDefault: CGFloat = 2;
    var highlightedHeight: CGFloat = 3;
    var isOn: Bool = false {
        didSet {
            if !oldValue && self.isOn {
                UIView.animate(withDuration: KVCalendarGlobals.SHOWHIDE_ANIMATION_DURATION, animations: {
                    
                    self.backgroundColor = KVCalendarGlobals.colors.main;
                });
            } else if oldValue && !self.isOn {
                UIView.animate(withDuration: KVCalendarGlobals.SHOWHIDE_ANIMATION_DURATION, animations: {
                    self.backgroundColor = KVCalendarGlobals.colors.border;
                });
            }
        }
    }
    
    // MARK: - Init functions
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.initiateViews();
    }
    
    /// Convenience initiator
    ///
    /// - Parameters:
    ///   - origin: (x, y) origin point
    ///   - width: rectangular width
    convenience init(origin: CGPoint, width: CGFloat) {
        self.init(frame: CGRect(origin: origin, size: CGSize(width: width, height: SBStateLineView.heightDefault)));
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    /// Helper function to initiate and layout all subviews
    private func initiateViews() {
        self.layer.cornerRadius = 1;
        self.layer.masksToBounds = true;
        self.backgroundColor = KVCalendarGlobals.colors.border;
    }
}
