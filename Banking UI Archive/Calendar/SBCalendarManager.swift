//
//  SBCalendarManager.swift
//  SkyBank
//
//  Created on 6/13/17.
//  Copyright © 2017 Onsolut LLC. All rights reserved.
//

import Foundation;
import CVCalendar;

protocol SBCalendarManagerDelegate: class {
    /// Event method when user selects a date in calendar
    ///
    /// - Parameter date: CVDate instance
    func didSelectDate(date: CVDate);
    /// Event method when a month View is presented, can be used to update month labels
    ///
    /// - Parameter date: CVDate instance
    func didSwitchMonth(date: CVDate);
}

/// Singleton class that handles all appearance and animation delegate methods for calendar.
/// This class can have multiple delegates subscribed.
class SBCalendarManager: NSObject, CVCalendarViewDelegate, CVCalendarViewAppearanceDelegate {
    static let shared = SBCalendarManager();
    static let selectedCircleSize: CGFloat = 24;
    var _delegates: [SBCalendarManagerDelegate] = [];
    
    /// Method to subscribe a class to Calendar manager
    ///
    /// - Parameter delegate: Object conforming to SBCalendarManagerDelegate
    func subscribe(_ delegate: SBCalendarManagerDelegate) {
        self._delegates.append(delegate);
    }
    
    // MARK: - Calendar delegate methods
    
    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {
        self._delegates.forEach({
            $0.didSelectDate(date: dayView.date);
        });
    }
    func firstWeekday() -> Weekday {
        return .monday;
    }
    func presentationMode() -> CalendarMode {
        return .monthView;
    }
    func shouldScrollOnOutDayViewSelection() -> Bool {
        return false;
    }
    func shouldAutoSelectDayOnWeekChange() -> Bool {
        return false;
    }
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return false;
    }
    func shouldShowWeekdaysOut() -> Bool {
        return true;
    }
    func shouldSelectDayView(_ dayView: DayView) -> Bool {
        return true;
    }

    func presentedDateUpdated(_ date: CVDate) {
        self._delegates.forEach({
            $0.didSwitchMonth(date: date);
        });
    }
    
    // MARK: - Calendar Appearance delegate methods
    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont {
        return KVCalendarGlobals.FONT_DEFAULT!;
    }
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false;
    }
    func dayLabelWeekdayFont() -> UIFont {
        return KVCalendarGlobals.FONT_DEFAULT!;
    }
    func dayLabelPresentWeekdayFont() -> UIFont {
        return KVCalendarGlobals.FONT_DEFAULT!;
    }
    func dayLabelPresentWeekdayBoldFont() -> UIFont {
        return KVCalendarGlobals.FONT_DEFAULT!;
    }
    func dayLabelPresentWeekdayHighlightedFont() -> UIFont {
        return KVCalendarGlobals.FONT_DEFAULT!;
    }
    func dayLabelPresentWeekdaySelectedFont() -> UIFont {
        return KVCalendarGlobals.FONT_DEFAULT!;
    }
    func dayLabelWeekdayHighlightedFont() -> UIFont {
        return KVCalendarGlobals.FONT_DEFAULT!;
    }
    func dayLabelWeekdaySelectedFont() -> UIFont {
        return KVCalendarGlobals.FONT_DEFAULT!;
    }
    
    // Text Sizing
    func dayLabelSize(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> CGFloat {
        return SBCalendarManager.selectedCircleSize;
    }
    func dayLabelWeekdayTextSize() -> CGFloat {
        return SBCalendarManager.selectedCircleSize;
    }
    func dayLabelWeekdayHighlightedTextSize() -> CGFloat {
        return SBCalendarManager.selectedCircleSize;
    }
    func dayLabelWeekdaySelectedTextSize() -> CGFloat {
        return SBCalendarManager.selectedCircleSize;
    }
    func dayLabelPresentWeekdayTextSize() -> CGFloat {
        return SBCalendarManager.selectedCircleSize;
    }
    func dayLabelPresentWeekdayHighlightedTextSize() -> CGFloat {
        return SBCalendarManager.selectedCircleSize;
    }
    func dayLabelPresentWeekdaySelectedTextSize() -> CGFloat {
        return SBCalendarManager.selectedCircleSize;
    }
    
    func dayLabelWeekdaySelectedBackgroundColor() -> UIColor {
        return KVCalendarGlobals.colors.main;
    }
    func dayLabelWeekdaySelectedBackgroundAlpha() -> CGFloat {
        return 1.0;
    }
    func dayLabelPresentWeekdaySelectedBackgroundColor() -> UIColor {
        return KVCalendarGlobals.colors.main;
    }
    func dayLabelPresentWeekdaySelectedBackgroundAlpha() -> CGFloat {
        return 1.0;
    }
}
