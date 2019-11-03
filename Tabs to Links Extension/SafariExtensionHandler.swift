import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    // MARK: - Properties
    var model: Model {
        SafariExtensionViewController.shared.model
    }

    // MARK: - Overrides
    override func popoverViewController() -> SafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

    override func popoverWillShow(in window: SFSafariWindow) {
        window.getAllPageProperties { properties in
            self.model.tabs = properties.map { Tab(withProperties: $0) }
            DispatchQueue.main.async {
                self.popoverViewController().tableView.reloadData()
            }
        }
    }
}

extension SFSafariWindow {
    func getAllPages(completionHandler: @escaping ([SFSafariPage]) -> Void) {
        getAllTabs { tabs in
            var currentTabCount = 0
            var pages: [SFSafariPage] = []
            tabs.forEach { tab in
                tab.getPagesWithCompletionHandler { pagesOfTab in
                    currentTabCount += 1
                    pages.append(contentsOf: pagesOfTab ?? [])
                    if currentTabCount == tabs.count {
                        completionHandler(pages)
                    }
                }
            }
        }
    }

    func getAllPageProperties(
        completionHandler: @escaping ([SFSafariPageProperties]) -> Void
    ) {
        getAllPages { pages in
            var currentPageCount = 0
            var pageProperties: [SFSafariPageProperties] = []
            pages.forEach { page in
                page.getPropertiesWithCompletionHandler { properties in
                    currentPageCount += 1
                    if let properties = properties {
                        pageProperties.append(properties)
                    }
                    if currentPageCount == pages.count {
                        completionHandler(pageProperties)
                    }
                }
            }
        }
    }
}

extension Tab {
    convenience init(withProperties properties: SFSafariPageProperties?) {
        self.init(title: properties?.title, url: properties?.url)
    }
}
