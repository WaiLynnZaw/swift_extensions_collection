import Foundation
import UIKit
extension NSBundle {
    var versionName: String? {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var versionBundle: String? {
        return self.infoDictionary?["CFBundleVersion"] as? String
    }
}