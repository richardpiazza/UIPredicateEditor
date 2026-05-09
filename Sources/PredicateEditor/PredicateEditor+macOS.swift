#if canImport(SwiftUI) && os(macOS)
import SwiftUI

struct AppKitPredicateEditor: NSViewRepresentable {

  class Coordinator {
    let predicate: Binding<NSPredicate>

    init(predicate: Binding<NSPredicate>) {
      self.predicate = predicate
    }

    @objc @MainActor func predicateEditorDidChange(_ sender: NSPredicateEditor) {
      guard let predicate = sender.predicate else {
        return
      }

      self.predicate.wrappedValue = predicate
    }
  }

  @Binding var predicate: NSPredicate
  var rowTemplates: [NSPredicateEditorRowTemplate]

  func makeCoordinator() -> Coordinator {
    Coordinator(
      predicate: $predicate,
    )
  }

  func makeNSView(context: Context) -> NSPredicateEditor {
    let view = NSPredicateEditor(frame: .zero)
    view.rowTemplates = rowTemplates
    view.target = context.coordinator
    view.action = #selector(context.coordinator.predicateEditorDidChange(_:))
    return view
  }

  func updateNSView(_ predicateEditor: NSPredicateEditor, context _: Context) {
    predicateEditor.objectValue = predicate
  }
}
#endif
