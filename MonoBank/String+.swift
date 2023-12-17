//
//  String+.swift
//  MetaMarket
//
//  Created by dan phi on 07/07/2023.
//  Copyright © 2023 Richard Neitzke. All rights reserved.
//


import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func toDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        return formatter.date(from: self)
    }

    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }

    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string
        return decoded ?? self
    }
    
    func withBoldText(boldText: String, fullStringFont: UIFont, boldFont: UIFont) -> NSAttributedString {
        let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: fullStringFont])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont]
        var ranges = [NSRange]()
        let ns = self as NSString
        var startRange = NSMakeRange(0, self.count)
        
        while ns.range(of: boldText, range: startRange).location != NSNotFound {
            let range = ns.range(of: boldText, range: startRange)
            ranges.append(range)
            startRange = NSMakeRange(range.location + range.length, self.count - range.location - range.length)
            fullString.addAttributes(boldFontAttribute, range: range)
        }
        return fullString
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, count) ..< count]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                            upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
