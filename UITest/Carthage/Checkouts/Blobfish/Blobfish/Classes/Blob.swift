//
//  Error.swift
//  Blobfish
//
//  Created by Kasper Welner on 13/03/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation
import UIKit

/**
 A *Blob* is an entitiy that encapsulates all the information needed
 by Blobfish to show a meaningful error message. This includes text, style,
 button titles and actions.
 */

public struct Blob {
    /**
     The displayed title. if *style* is *.Overlay*, this will be all the user sees.
     */
    public let title: String
    
    /**
     The display style of the overlay.
     */
    public let style: Style
    
    /**
     The default implementation of Blobfish shows a status bar overlay for *.Overlay*
     and a native *UIAlertController* alert for the *.Alert* case.
    */
    public enum Style {
        case overlay
        case alert(message:String?, actions: [AlertAction])
    }

    public struct AlertAction {
        public typealias Handler = (() -> Void)

        public let title: String
        public let handler: Handler?

        public init(title: String, handler: Handler?) {
            self.title   = title
            self.handler = handler
        }
    }

    public init(title: String, style: Style) {
        self.title = title
        self.style = style
    }
}
