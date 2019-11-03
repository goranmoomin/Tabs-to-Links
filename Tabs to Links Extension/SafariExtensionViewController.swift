import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    // MARK: - IBOutlet Properties
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var selectOrDeselectAllButton: NSButton!
    @IBOutlet weak var shareLinksButton: NSButton!

    // MARK: - Properties
    var model = Model()

    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width: 320, height: 480)
        return shared
    }()

    // MARK: - IBAction Methods
    @IBAction func onSelectOrDeselectAllButtonClick(_ sender: NSButton) {
        if model.tabs.reduce(true, { $0 && $1.isIncluded }) {
            model.tabs.forEach { $0.isIncluded = false }
        } else {
            model.tabs.forEach { $0.isIncluded = true }
        }

        update()
        tableView.reloadData()
    }

    @IBAction func onShareLinksButtonClick(_ sender: NSButton) {
        let sharingServicePicker = NSSharingServicePicker(items: [NSAttributedString()])
        sharingServicePicker.show(
            relativeTo: sender.bounds,
            of: sender,
            preferredEdge: .minY
        )
    }

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        update()
    }

    // MARK: - Custom Methods
    internal func update() {
        if model.tabs.reduce(true, { $0 && $1.isIncluded }) {
            selectOrDeselectAllButton.title = "Deselect All"
        } else {
            selectOrDeselectAllButton.title = "Select All"
        }
    }
}

// MARK: - NSTableViewDataSource
extension SafariExtensionViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return model.tabs.count
    }
}

// MARK: - NSTableViewDelegate
extension SafariExtensionViewController: NSTableViewDelegate {
    func tableView(
        _ tableView: NSTableView,
        viewFor tableColumn: NSTableColumn?,
        row: Int
    ) -> NSView? {
        let view = TabTableCellView(with: self, at: row)
        return view
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 63.0
    }
}
