//
//  SBDropdown.swift
//  SkyBank
//
//  Created on 6/12/17.
//  Copyright © 2017 Onsolut LLC. All rights reserved.
//

import Foundation
import UIKit;
import Tactile;

/// Object powering a single row in Dropdown List UITableView
class SBDropdownItem: NSObject {
    var title: String?;
    var image: UIImage?;
    
    required init(title: String, image: UIImage? = nil) {
        super.init();
        self.title = title;
        self.image = image;
    }
}

/// Class conforming to this protocol must provide quantitative info about dropdown
protocol SBDropdownDelegate: class {
    
    /// Delegate returns number of items in dropdown
    ///
    /// - Parameter dropdown: dropdown instance
    /// - Returns: number of items
    func numberOfItems(in dropdown: SBDropdown) -> Int;
    
    /// Delegate defines an Item instance for particular index
    ///
    /// - Parameters:
    ///   - dropdown: dropdown instance
    ///   - index: index value
    /// - Returns: SBDropdownItem instance
    func dropdown(_ dropdown: SBDropdown, itemAt index: Int) -> SBDropdownItem;
    
    /// Event handler by delegate when an item in dropdown is tapped
    ///
    /// - Parameters:
    ///   - dropdown: instance
    ///   - index: tapped item index
    func dropdown(_ dropdown: SBDropdown, didSelectAt index: Int);
    
    /// Method to resolve if dropdown should close on selecting row at Index
    ///
    /// - Parameters:
    ///   - dropdown: dropdown instance
    ///   - index: selection index
    /// - Returns: true if should be closed
    func dropdown(_ dropdown: SBDropdown, shouldCloseOnSelecting index: Int) -> Bool;
}

class SBDropdown: UIView, UITableViewDataSource, UITableViewDelegate {
    static let heightDefault: CGFloat = 40;
    private var _titleLabel: UILabel?;
    private var _greyLine: SBStateLineView?;
    private var _arrowView: UIImageView?;
    var selectionLabel: UILabel?;
    var dropdownList: UITableView?;
    var listHeight: CGFloat = 220;
    var isExpanded: Bool = false;
    var dropdownItemHeight: CGFloat = 40;
    weak var delegate: SBDropdownDelegate?;
    var selectedIndex: Int = -1 {
        didSet {
            if self.delegate != nil {
                let item = self.delegate!.dropdown(self, itemAt: self.selectedIndex);
                self.selectionLabel?.text = item.title;
            }
        }
    };
    
    // MARK: - Init functions
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
    
    /// Overriding method to change appearance and add custom views
    ///
    /// - Parameter rect: Drawing rectangular
    override func draw(_ rect: CGRect) {
        super.draw(rect);
    }
    
    /// Helper function to initiate and layout all subviews
    private func initiateViews() {
        self.backgroundColor = UIColor.white;
        // setting up title label
        _titleLabel = UILabel();
        _titleLabel?.frame = CGRect(
            x: 0,
            y: 0,
            width: self.frame.width / 2,
            height: 14);
        _titleLabel?.textColor = KVCalendarGlobals.colors.border;
        _titleLabel?.text = "Filter";
        _titleLabel?.font = KVCalendarGlobals.FONT_DESCRIPTION;
        self.addSubview(self._titleLabel!);
        
        // setting up selection label
        self.selectionLabel = UILabel();
        self.selectionLabel?.frame = CGRect(
            x: 0,
            y: self._titleLabel!.frame.origin.y + self._titleLabel!.frame.height + KVCalendarGlobals.margins.XS / 2,
            width: self.frame.width - KVCalendarGlobals.ICONBUTTON_WIDTH,
            height: 16);
        self.selectionLabel?.textColor = KVCalendarGlobals.colors.textfield;
        self.selectionLabel?.font = KVCalendarGlobals.FONT_DEFAULT;
        self.addSubview(self.selectionLabel!);
        
        // setting up arrow image
        _arrowView = UIImageView();
        _arrowView?.frame = CGRect(
            x: self.frame.width - KVCalendarGlobals.ICONBUTTON_WIDTH,
            y: self.selectionLabel!.frame.origin.y - KVCalendarGlobals.margins.XS / 2,
            width: KVCalendarGlobals.ICONBUTTON_WIDTH,
            height: KVCalendarGlobals.ICONBUTTON_WIDTH
        );
//        _arrowView.image = SBAssets.chevronDownBlue.image;
        self.addSubview(self._arrowView!);
        
        // setting up greyLine
        self._greyLine = SBStateLineView(
            origin: CGPoint(
                x: 0,
                y: self.frame.height - SBStateLineView.heightDefault
            ),
            width: self.frame.width);
        self.addSubview(self._greyLine!);
        
        self.setupTapEvents();
    }
    
    // MARK: - actions
    /// Reveals the dropdown list
    func openDropdown() {
        
        self.superview!.addSubview(self.dropdownList!);
        UIView.animate(withDuration: 0.2, animations: {
            self._arrowView!.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0);
            self.dropdownList?.alpha = 1;
            self._greyLine?.isOn = true;
        });
    }
    
    /// Hides the dropdown list
    func closeDropdown() {
        UIView.animate(withDuration: 0.2, animations: {
            self._arrowView!.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) * 180.0);
            self.dropdownList?.alpha = 0;
            self._greyLine?.isOn = false;
        }, completion: {_ in
            self.dropdownList?.removeFromSuperview();
        });
    }
    
    // MARK: - Table View delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.delegate != nil {
            return self.delegate!.numberOfItems(in: self);
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SBDropdownCell.instance();
        cell.isChecked = self.selectedIndex == indexPath.row;
        if self.delegate != nil {
            let item = self.delegate!.dropdown(self, itemAt: indexPath.row);
            cell.textLabel?.text = item.title;
            cell.customImage = item.image;
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previous = self.selectedIndex;
        self.selectedIndex = indexPath.row;
        
        if self.delegate != nil {
            if self.delegate!.dropdown(self, shouldCloseOnSelecting: self.selectedIndex) {
                self.isExpanded = false;
                self.closeDropdown();
            }
            self.delegate?.dropdown(self, didSelectAt: self.selectedIndex);
        }
        tableView.beginUpdates();
        tableView.reloadRows(at: [IndexPath(row: previous, section: 0), IndexPath(row: self.selectedIndex, section: 0)], with: .none);
        tableView.endUpdates();
    }
    
    // MARK: - Helper functions
    /// Helper function to configure tap event on dropdown
    private func setupTapEvents() {
        self.selectionLabel?.isUserInteractionEnabled = true;
        self.selectionLabel?.tap(self.dropdownTapped);
        self._arrowView?.isUserInteractionEnabled = true;
        self._arrowView?.tap(self.dropdownTapped);
    }
    
    /// Helper function to create dropdown list
    private func initDropdownList() {
        self.dropdownList = UITableView();
        self.dropdownList?.frame = CGRect(
            x: self.frame.origin.x,
            y: self.frame.maxY,
            width: self.frame.width,
            height: self.listHeight
        );
        self.dropdownList?.separatorStyle = .none;
        self.dropdownList?.allowsSelection = true;
        self.dropdownList?.delegate = self;
        self.dropdownList?.dataSource = self;
        self.dropdownList?.alwaysBounceVertical = false;
        self.dropdownList?.alpha = 0;
    }
    
    /// Dropdown tap event handler
    ///
    /// - Parameter gesture: Gesture Recognizer instance
    private func dropdownTapped(gesture: UITapGestureRecognizer) {
        if self.dropdownList == nil {
            self.initDropdownList();
        }
        
        self.isExpanded = !self.isExpanded;
        if self.isExpanded {
            self.openDropdown();
        } else {
            self.closeDropdown();
        }
    }
}
