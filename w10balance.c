
/*
 *  Christmas Cleaning!
 *
 *  Move-fast-break-everything Adrian was in a rush to balance a christmas tree of ornaments
 *  where each ornament has a mass. Unfortunately, if this tree of objects isn't balanced,
 *  then all of his work will topple over (and for some reason, he's building this tree
 *  ontop of the quad at its most busy period.. many people will get rekt). Help people
 *  not get rekt by completing the isBalanced check!
 *
 *  We define balanced:
 *      - mass of the ornaments on the left and right subtrees are equal.
 *      - height from the leaves to the root of the tree from left and right subtrees don't differ by more than 1.
 *                abs(height(left) - height(right)) <= 1
 *      - the subtrees are balanced
 *
 */

typedef struct tree {
  int mass;
  int massOfWholeTree;     // defined as the sum of all the ornament masses in the tree
  int height;
  struct tree left;
  struct tree right;
} *Tree;

/* COMPLETE THE ISBALANCED FUNCTION */
int isBalanced(Tree t) {
  if (t == NULL) return 1;
  return ___ && ___ && ___ && ___;
}

int heightOfTree(Tree t) {
  if (t == NULL) return 0;
  return t->height;
}

int massOfTree(Tree t) {
  if (t == NULL) return 0;
  return t->massOfWholeTree;
}
