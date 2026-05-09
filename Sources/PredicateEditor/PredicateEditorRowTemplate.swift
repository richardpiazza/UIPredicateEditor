#if os(iOS)
import UIPredicateEditor

public typealias PredicateEditorRowTemplate = UIPredicateEditorRowTemplate
#endif

#if os(macOS)
import AppKit

public typealias PredicateEditorRowTemplate = NSPredicateEditorRowTemplate

public extension NSPredicateEditorRowTemplate {
  /// Initializes and returns a “pop-up-pop-up-pop-up”–style row template.
  ///
  /// This convenience initializer maps the following as required by `NSPredicateEditorRowTemplate`:
  /// * `NSCompoundPredicate.LogicalType` to `NSNumber`
  /// * `NSComparisonPredicate.Options` to `Int`
  ///
  /// - parameters:
  ///   - leftExpressions: An array of `NSExpression` objects that represent the left side of a predicate.
  ///   - rightExpressions: An array of `NSExpression` objects that represent the right side of a predicate.
  ///   - modifier: A modifier for the predicate (see `NSComparisonPredicate.Modifier` for possible values).
  ///   - operators: An array specifying the operator type (see `NSComparisonPredicate.Operator` for possible values).
  ///   - options: Options for the predicate (see `NSComparisonPredicate.Options` for possible values).
  /// - returns: A row template of the “pop-up-pop-up-pop-up” form, with the left and right pop-ups
  ///   representing the left and right expression arrays `leftExpressions` and `rightExpressions`,
  ///   and the center pop-up representing the operators.
  convenience init(
    leftExpressions: [NSExpression],
    rightExpressions: [NSExpression],
    modifier: NSComparisonPredicate.Modifier,
    operators: [NSComparisonPredicate.Operator],
    options: NSComparisonPredicate.Options,
  ) {
    self.init(
      leftExpressions: leftExpressions,
      rightExpressions: rightExpressions,
      modifier: modifier,
      operators: operators.map {
        NSNumber(value: $0.rawValue)
      },
      options: Int(options.rawValue),
    )
  }

  /// Initializes and returns a “pop-up-pop-up-view”–style row template.
  ///
  /// This convenience initializer maps the following as required by `NSPredicateEditorRowTemplate`:
  /// * `NSCompoundPredicate.LogicalType` to `NSNumber`
  /// * `NSComparisonPredicate.Options` to `Int`
  ///
  /// - parameters:
  ///   - leftExpressions: An array of `NSExpression` objects that represent the left side of a predicate.
  ///   - attributeType: An attribute type for the right side of a predicate. This value dictates the type of view created,
  ///     and how the control’s object value is coerced before putting it into a predicate.
  ///   - modifier: A modifier for the predicate (see `NSComparisonPredicate.Modifier` for possible values).
  ///   - operators: An array of operator types. (see `NSComparisonPredicate.Operator` for possible values).
  ///   - options: Options for the predicate (see `NSComparisonPredicate.Options` for possible values).
  /// - returns: A row template initialized using the specified arguments.
  convenience init(
    leftExpressions: [NSExpression],
    rightExpressionAttributeType attributeType: NSAttributeType,
    modifier: NSComparisonPredicate.Modifier,
    operators: [NSComparisonPredicate.Operator],
    options: NSComparisonPredicate.Options,
  ) {
    self.init(
      leftExpressions: leftExpressions,
      rightExpressionAttributeType: attributeType,
      modifier: modifier,
      operators: operators.map {
        NSNumber(value: $0.rawValue)
      },
      options: Int(options.rawValue),
    )
  }

  /// Initializes and returns a row template suitable for displaying compound predicates.
  ///
  /// This convenience initializer maps the `NSCompoundPredicate.LogicalType` to a `NSNumber`
  /// required by `NSPredicateEditorRowTemplate`.
  ///
  /// - parameters:
  ///   - compoundTypes: An array of compound predicate types. See `NSCompoundPredicate.LogicalType`
  ///     for possible values.
  /// - returns: A row template initialized for displaying compound predicates of the types specified by
  ///   compoundTypes.
  convenience init(
    compoundTypes: [NSCompoundPredicate.LogicalType],
  ) {
    self.init(
      compoundTypes: compoundTypes.map {
        NSNumber(value: $0.rawValue)
      },
    )
  }
}
#endif

public extension PredicateEditorRowTemplate {
  /// A single compound row template that provides the `.and`, `.or` and `.not` types.
  @MainActor static let defaultCompoundTemplate = PredicateEditorRowTemplate(
    compoundTypes: [
      .and,
      .or,
      .not,
    ],
  )
}
