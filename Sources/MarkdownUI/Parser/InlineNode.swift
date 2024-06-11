import Foundation

enum InlineNode: Hashable {
  case text(String)
  case softBreak
  case lineBreak
  case code(String)
  case html(String)
  case emphasis(_ children: [InlineNode])
  case strong(_ children: [InlineNode])
  case strikethrough(_ children: [InlineNode])
  case link(destination: String, _ children: [InlineNode])
  case image(source: String, _ children: [InlineNode])
}

extension InlineNode {
  var children: [InlineNode] {
    get {
      switch self {
      case .emphasis(let children):
        return children
      case .strong(let children):
        return children
      case .strikethrough(let children):
        return children
      case .link(_, let children):
        return children
      case .image(_, let children):
        return children
      default:
        return []
      }
    }

    set {
      switch self {
      case .emphasis:
        self = .emphasis(newValue)
      case .strong:
        self = .strong(newValue)
      case .strikethrough:
        self = .strikethrough(newValue)
      case .link(let destination, _):
        self = .link(destination: destination, newValue)
      case .image(let source, _):
        self = .image(source: source, newValue)
      default:
        break
      }
    }
  }
}
