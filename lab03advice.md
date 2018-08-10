

# Lab 3 Advice & Excellent Related Material

Hey! First off, sorry that I couldn't answer everyone's questions for this week's lab - marking was a doozee, but
Johnson and I will be working hard to make the process as fast and effective as we can (that is, it shouldn't take
two hours anymore rip). If you had any lingering questions from the lab, then hopefully you got yourself to a help session! In case that wasn't possible, I've got a few _pointers_ to help you master linked structures (and make this lab and the upcoming LinkedList exam a piece of cake)

> ### Learning Objectives
> - Understanding the question given last lab (Sorted insertion into a sorted linked list)
> - (Extended) Improving the efficiency of our sorted insert by modifying our struct.
> - Understand how to build a rudimentary unit testing suite in C!
> - Come away with a _formula_ to attack problems you haven't seen before.
> - Leave with a sense of - shit, there's so much I can do, but so little time. Feels shitty, but it's actually a healthy feeling.

## What's the difference between Singly vs. Doubly linked lists?

Let's consider the question that we went asking around to poor, unsuspecting souls who just wanted their lab marked off. The implementation of ```IntListInsertInOrder``` (the same procedure you had to implement for lab01) has a logical error. Given the input list ```[1,3,4]``` and the value to insert ```2```, it produces the list ```[1,3,2,4]```. How can the procedure be fixed?

```C
void IntListInsertInOrder(IntList L, int v) {
  struct IntListNode *new = newIntListNode(v);
  if (L->size == 0) {
    new->next = L->first;
    L->first = new;
  } else {
    struct IntListNode *curr = L->first;
    while (curr != NULL && curr->data < v) {
      curr = curr->next;
    }    
    new->next = curr->next;
    curr->next = new;
  }
  L->size++;
  if (new->next == NULL) {
    L->last = new;
  }
}
```
Since ```2``` was inserted in the middle of the list, we know we're looking in the else case. Now first try to run the loop in your head (preferably on paper) and work out what value ```curr``` has when the loop terminates. Brain check yourself and ask, is this correct, can I insert from this node held in curr? 

Now that you know that there's something wrong with the node you stop at when the loop terminates, you can either:
- Blame the body of the loop
- Blame the conditional of the loop.
Which one is more likely? Since the body of the loop simply moves curr further down the list i.e. ```curr = curr->next```, it's probably more to do with the condition guarding the loop.



## Can we do sorted insert into a data structure faster? (MOAR FASTNESS)

Ok, if you completely understand the previous section, try this on for size. Currently,
inserting a value into our sorted linked lists (whether singly or doubly linked) takes is
in order **O(N)**. I assume Ashesh has covered how to determine algorithmic complexity, but if he hasn't, I highly
recommend you look at [Khan Academy's guide to asymptotic notation](https://www.khanacademy.org/computing/computer-science/algorithms/asymptotic-notation/a/asymptotic-notation) as it's going to be helpful
in future labs. Anyway back to the problem, we could do HEAPS better than **O(N)** are you kidding me!?

One problem that our linked list approach has is that it must observe ALL elements less than that of which
we're trying to insert. Is there a way we can change the struct (change the representation of the data structure
that holds our integers) so that we could _skip_ observing some elements? (Hint: Consider what we do in binary search on sorted arrays. Why can't we do just-as-fast binary search on linked lists? How can you modify your struct so that this is possible?)

This is difficult! Don't be disheartened if you can't get it, but the return on investment on even _attempting_ this problem is huge!

## A simple unit test for those confused on Task 2, Lab 3.

