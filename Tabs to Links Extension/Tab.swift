import Foundation

class Tab {
    // MARK: - Properties
    var title: String?
    var url: URL?
    var isIncluded: Bool

    // MARK: - Init
    init(title: String?, url: URL?) {
        self.title = title
        self.url = url
        self.isIncluded = true
    }
}
