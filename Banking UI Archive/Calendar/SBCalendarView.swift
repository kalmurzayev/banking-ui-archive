//
//  SBCalendarView.swift
//  SkyBank
//
//  Created on 6/14/17.
//  Copyright © 2017 Onsolut LLC. All rights reserved.
//

import Foundation
import UIKit;
import CVCalendar;

protocol SBCalendarDelegate: class {
    func didSelectDate( calendar: SBCalendarView, date: CVDate);
}

class SBCalendarView: UIView, SBCalendarManagerDelegate {
    static let heightDefault: CGFloat = 200;
    var calendarControl: SBCalendarControlView?;
    var calendarView: CVCalendarView?;
    weak var delegate: SBCalendarDelegate?;
    // MARK: - init methods
    override init(frame: CGRect) {
        super.init(frame: frame);
        SBCalendarManager.shared.subscribe(self);
        self.initiateViews();
    }
    
    convenience init() {
        self.init(frame: CGRect.zero);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        // Commit frames' updates
        self.calendarView?.commitCalendarViewUpdate()
    }
    
    // MARK: - SBCalendarManager Delegate
    func didSelectDate(date: CVDate) {
        self.delegate?.didSelectDate(calendar: self, date: date);
    }
    
    func didSwitchMonth(date: CVDate) {
        let formatter = DateFormatter();
        self.calendarControl?.titleLabel?.text = formatter.monthSymbols[date.month - 1];
    }
    
    /// Helper function to initiate all subviews and add effects
    private func initiateViews() {
        self.setupCalendar();
        self.setupCalendarControl();
        self.backgroundColor = UIColor.white;
    }
    
    @objc func swipeLeft() {
        self.calendarView?.loadPreviousView();
    }
    
    @objc func swipeRight() {
        self.calendarView?.loadNextView();
    }
    
    /// Helper function to create top calendar control bar
    private func setupCalendarControl() {
        self.calendarControl = SBCalendarControlView(frame: CGRect(
            x: 0, y:0,
            width: self.frame.width,
            height: SBCalendarControlView.heightDefault
        ));
        self.calendarControl?.leftButton?.addTarget(self, action: #selector(swipeLeft), for: .touchUpInside);
        self.calendarControl?.rightButton?.addTarget(self, action: #selector(swipeRight), for: .touchUpInside);
        let formatter = DateFormatter();
        let month = formatter.monthSymbols[self.calendarView!.presentedDate.month - 1]
        self.calendarControl?.titleLabel?.text = month;
        self.addSubview(self.calendarControl!);
    }
    
    /// Helper function to initiate calendar
    private func setupCalendar() {
        self.calendarView = CVCalendarView(frame: CGRect(
            x: 0,
            y: SBCalendarControlView.heightDefault + KVCalendarGlobals.margins.M,
            width: self.frame.width,
            height: self.frame.height - SBCalendarControlView.heightDefault + KVCalendarGlobals.margins.M
        ));
        self.calendarView?.calendarAppearanceDelegate = SBCalendarManager.shared;
        self.calendarView?.calendarDelegate = SBCalendarManager.shared;
        self.addSubview(self.calendarView!);
    }
}
