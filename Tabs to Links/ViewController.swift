import Cocoa
import SafariServices.SFSafariApplication

class ViewController: NSViewController {
    @IBOutlet var appNameLabel: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.appNameLabel.stringValue = "Tabs to Links";
    }

    @IBAction func openSafariExtensionPreferences(_ sender: AnyObject?) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: "io.pcr910303.Tabs-to-Links-Extension") { error in
            if let _ = error {
                // Insert code to inform the user that something went wrong.

            }
        }
    }

}
