#if os(iOS)
import UIPredicateEditor

public typealias PredicateEditorLayout = UIPredicateEditorLayout
#endif

#if os(macOS)
public typealias PredicateEditorLayout = Any
#endif
