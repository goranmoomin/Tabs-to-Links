import Cocoa

class TabTableCellView: NSView, LoadableView {
    // MARK: - IBOutlet Properties
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var urlLabel: NSTextField!
    @IBOutlet weak var includeCheckBox: NSButton!

    // MARK: - Properties
    var mainView: NSView?
    var viewController: SafariExtensionViewController!

    var model: Model {
        viewController.model
    }

    var index = 0

    // MARK: - Init
    init(
        with viewController: SafariExtensionViewController,
        at index: Int
    ) {
        super.init(frame: .zero)
        _ = load(fromNIBNamed: "TabTableCellView")
        self.viewController = viewController
        self.index = index
        update()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - IBAction Methods
    @IBAction func onIncludeCheckBoxClick(_ sender: NSButton) {
        model.tabs[index].isIncluded = !model.tabs[index].isIncluded
        viewController.update()
        update()
    }

    // MARK: - Custom Methods
    internal func update() {
        titleLabel.stringValue = model.tabs[index].title ?? "(nil)"
        urlLabel.stringValue = model.tabs[index].url?.absoluteString ?? "(nil)"
        includeCheckBox.state = model.tabs[index].isIncluded ? .on : .off
    }
}
