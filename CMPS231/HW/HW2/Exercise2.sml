(*Definition of a tree*)
datatype Node = Leaf of int
 | NonLeaf of int * Node * Node

(*1*)
val myTree = NonLeaf(2, Leaf(1), NonLeaf(4, Leaf(3), Leaf(5)))
(*2*)
fun nodeValue(node: Node): int =
  case node of
    Leaf(value) => value
  | NonLeaf(value, _, _) => value

(*3*)
fun treeSize(node: Node): int =
  case node of
    Leaf(_) => 1
  | NonLeaf(_, left, right) => 1 + treeSize(left) + treeSize(right)

(*4*)
fun numLeaves(node: Node): int =
  case node of
    Leaf(_) => 1
    | NonLeaf(_, left, right) => numLeaves(left) + numLeaves(right)

(*5*)
fun numGreaterThan(node: Node, n: int): int =
   case node of
    Leaf(value) => if value > n then 1 else 0
    | NonLeaf(value, left, right) =>
      if value > n
      then 1 + numGreaterThan(left, n) + numGreaterThan(right, n)
      else numGreaterThan(left, n) + numGreaterThan(right, n)
(*6*)
fun traverseTree(node: Node, leafFn: int -> 'a, nonLeafFn: (int * 'a * 'a) -> 'a): 'a =
   case node of
    Leaf(value) => leafFn(value)
    | NonLeaf(value, left, right) =>
        nonLeafFn(value, traverseTree(left, leafFn, nonLeafFn), traverseTree(right, leafFn, nonLeafFn))

(*7*)
fun treeSize(node: Node): int =
    traverseTree(node, fn _ => 1, fn (_, leftSize, rightSize) => 1 + leftSize + rightSize)
