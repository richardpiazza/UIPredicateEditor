#if canImport(SwiftUI) && os(iOS)
import SwiftUI
import UIPredicateEditor

struct UIKitPredicateEditor: UIViewControllerRepresentable {

  class Coordinator: PredicateControllerDelegate {
    let predicate: Binding<NSPredicate>

    init(predicate: Binding<NSPredicate>) {
      self.predicate = predicate
    }

    func predicateDidChangeForPredicateController(_ predicateController: PredicateController) {
      guard let predicate = predicateController.predicate else {
        return
      }

      self.predicate.wrappedValue = predicate
    }
  }

  @Binding var predicate: NSPredicate
  var rowTemplates: [UIPredicateEditorRowTemplate]
  var layout: UIPredicateEditorLayout?

  func makeCoordinator() -> Coordinator {
    Coordinator(
      predicate: $predicate,
    )
  }

  func makeUIViewController(context: Context) -> UIPredicateEditorViewController {
    let controller = UIPredicateEditorViewController(
      predicate: predicate,
      rowTemplates: rowTemplates,
      layout: layout ?? UIPredicateEditorLayout.preparedLayout(),
    )
    controller.predicateController.delegate = context.coordinator
    return controller
  }

  func updateUIViewController(_ viewController: UIPredicateEditorViewController, context _: Context) {
    viewController.predicate = predicate
  }
}
#endif
