#if canImport(SwiftUI)
import SwiftUI

/// SwiftUI view which allows for the manipulation of an `NSPredicate`.
///
/// This view works on multiple platforms and presents native UI using either:
/// * UIKitPredicateEditor: A `UIViewControllerRepresentable` which proxies the
///   `UIPredicateEditorViewController`.
/// * AppKitPredicateEditor: A `NSViewRepresentable` which proxies the `NSPredicateEditor`
///   view native to macOS.
///
/// In keeping with other system SwiftUI types, a `Binding` to an `NSPredicate` is utilized to
/// provide two-way notification of updates to the predicate as the UI controls are used.
public struct PredicateEditor: View {

  @Binding var predicate: NSPredicate
  var rowTemplates: [PredicateEditorRowTemplate]
  var layout: PredicateEditorLayout?

  /// Initialize a `PredicateEditor` view.
  ///
  /// - parameters:
  ///   - predicate: Binding to a `NSPredicate` which will be updated based on UI changes.
  ///   - rowTemplates: Templates which describes the available predicates and how to display them.
  ///   - layout: (UIKit only, see `UIPredicateEditorViewController`)
  public init(
    predicate: Binding<NSPredicate>,
    rowTemplates: [PredicateEditorRowTemplate],
    layout: PredicateEditorLayout? = nil,
  ) {
    _predicate = predicate
    self.rowTemplates = rowTemplates
    self.layout = layout
  }

  public var body: some View {
    #if os(iOS)
    UIKitPredicateEditor(
      predicate: $predicate,
      rowTemplates: rowTemplates,
      layout: layout,
    )
    #elseif os(macOS)
    AppKitPredicateEditor(
      predicate: $predicate,
      rowTemplates: rowTemplates,
    )
    #endif
  }
}

#Preview {
  @Previewable @State var predicate: NSPredicate = NSCompoundPredicate(
    orPredicateWithSubpredicates: [
      NSPredicate(format: "%K CONTAINS[cd] %@", "name", "bob"),
    ],
  )
  PredicateEditor(
    predicate: $predicate,
    rowTemplates: [
      .defaultCompoundTemplate,
      PredicateEditorRowTemplate(
        leftExpressions: [
          NSExpression(forKeyPath: "name"),
        ],
        rightExpressionAttributeType: .stringAttributeType,
        modifier: .direct,
        operators: [
          .equalTo,
          .contains,
          .beginsWith,
        ],
        options: .diacriticInsensitive,
      ),
    ],
  )
  .onChange(of: predicate) { _, newValue in
    print("Compound=\(newValue is NSCompoundPredicate); \(newValue.predicateFormat)")
  }
}
#endif
