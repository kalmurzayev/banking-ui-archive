//
//  KVCalendarGlobals.swift
//  Banking UI Archive
//
//  Created by Azamat Kalmurzayev on 2/1/18.
//  Copyright © 2018 Azamat Kalmurzayev. All rights reserved.
//

import Foundation;
import UIKit;
enum KVCalendarGlobals {
    enum margins {
        static let XS: CGFloat = 8;
        static let S: CGFloat = 12;
        static let M: CGFloat = 16;
    }
    enum colors {
        static let main: UIColor = .blue;
        static let border: UIColor = .gray;
        static let textfield: UIColor = .green;
    }
    static let FONT_DEFAULT = UIFont(
        name: "Helvetica-Neue", size: 15
    );
    static let FONT_DESCRIPTION = UIFont(
        name: "Helvetica-Neue", size: 12
    );
    static let CORNER_RADIUS_DEFAULT: CGFloat = 4.0;
    static let ICONBUTTON_WIDTH: CGFloat = 24;
    static let SHOWHIDE_ANIMATION_DURATION = 0.2;
}
