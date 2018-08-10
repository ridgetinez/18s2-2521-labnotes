

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

Let's consider the question that we went around asking to poor, unsuspecting souls who just wanted their lab marked off. The implementation of ```IntListInsertInOrder``` (the same procedure you had to implement for lab01) has a logical error. Given the input list ```[1,3,4]``` and the value to insert ```2```, it produces the list ```[1,3,2,4]```. How can the procedure be fixed?

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

Which one is more likely? Since the body of the loop simply moves curr further down the list i.e. ```curr = curr->next```, it's probably more to do with the condition guarding the loop. Hopefully you can read the following example and derive the new condition on the loop yourself.

Let's build it up from the ground up. LO AND BEHOLD! An IntList!

![INITIALLIST](https://github.com/ridgetinez/18s2-2521-labnotes/blob/master/images/03-05.png)

Let's say we want to do an ```IntListInsertInOrder(L, 7)```, where L is our above IntList. Cool!
So we know that we want the list to look like ```[2,3,7,8]``` but now the question is, where
do we stop our ```curr``` pointer so that we can successfully link our ```7``` to the list?

![SECONDLIST](https://github.com/ridgetinez/18s2-2521-labnotes/blob/master/images/03-02.png)

Well, if we chose **(c)**, then we can set the sevenNode's next to the eightNode, however we can't set the threeNode's next to the sevenNode! The reason why we can't is because from the eightNode alone, we can't access
the sevenNode (there's no link going back), hence we can't change sevenNode's next. If we stop at **(a)**, since we're not directly before the point of insertion (that's between 3 and 8) we can keep going forward. Hence we'd like to stop at **(b)** since it gives us both the ability to change the threeNode, and also have access to the eightNode by threeNode->next.

![THIRDLIST](https://github.com/ridgetinez/18s2-2521-labnotes/blob/master/images/03-03.png)

So bam. Now let's do the surgery and insert the sevenNode! Question is, which links do we update first? ThreeNode's
next currently points to eightNode, and after insertion, should be changed to the sevenNode. SevenNode's next should be eightNode. Suppose we changed threeNode's next to be sevenNode, we can do that. Then change sevenNode's next to eightNode... **urgh... uhh...** with what links? 

![FIFTHLIST](https://github.com/ridgetinez/18s2-2521-labnotes/blob/master/images/03-06.png)

Sure, I could use L->last, but what if this case was in the middle of the list and we didn't have this handy L->last reference? **We'd be screwed!** So we shouldn't do this surgery first, we should first change sevenNode's next to eightNode AND THEN change threeNode's next to sevenNode. You'll be running into this a lot in this week's lab, be careful and understand the order you link up your nodes! When in doubt do a drawing and become the computer and execute your linking code. The next images show the correct order of surgery.

![FOURTHLIST](https://github.com/ridgetinez/18s2-2521-labnotes/blob/master/images/03-01.png)
![SIXTHLIST](https://github.com/ridgetinez/18s2-2521-labnotes/blob/master/images/03-04.png)

So from this, we can takeaway:
- Always think whether you want curr to stop on the node you're thinking of, or just before the node you're thinking of. Typically the latter case is more applicable for insertions into singly linked lists, but *always* draw your linked lists and reason about them before you code anything.
- The order you do your pointer linking between nodes is really important! You don't want to lose information by overwriting a link that you actually need in the future :(
- Come to labs! Only you can prevent forest fires.

In this week's lab, you'll have access to current in the DLListRep. Think, do we have to do inserts into doubly linked lists like the way I just described? What's the difference between the two? (Hint: think about what you can get with the prev pointer in your DLLNodes!)


## Can we do sorted insert into a data structure faster? (MOAR FASTNESS)

Ok, if you completely understand the previous section, try this on for size. Currently,
inserting a value into our sorted linked lists (whether singly or doubly linked) takes is
in order **O(N)**. I assume Ashesh has covered how to determine algorithmic complexity, but if he hasn't, I highly
recommend you look at [Khan Academy's guide to asymptotic notation](https://www.khanacademy.org/computing/computer-science/algorithms/asymptotic-notation/a/asymptotic-notation) as it's going to be helpful
in future labs. Anyway back to the problem, we could do HEAPS better than **O(N)** are you kidding me!?

One problem that our linked list approach has is that it must observe ALL elements less than the value we're trying to insert. Is there a way we can change the struct (change the representation of the data structure
that holds our integers) so that we could _skip_ observing some elements? (Hint: Consider what we do in binary search on sorted arrays. Why can't we do just-as-fast binary search on linked lists? How can you modify your struct so that this is possible?)

This is difficult! Don't be disheartened if you can't get it, but the return on investment on even _attempting_ this problem is huge!

## A simple unit test for those confused on Task 2, Lab 3.

Below I've written a reaaally simple procedure which tests InsertAfter at different positions (num to move curr is given by moveNum). This is _just a skeleton!_ So ```TestTitlePrint, DLListMoveTo etc.``` is something you should implement. You should write tests that apply the methods DLListInsertAfter, DLListInsertBefore, DLListRemove on head, tail, and somewhere in the middle of different type of lists (empty, one full, some full etc.).

```C
void TestEdgeCasesInsertAfter(DLList L, int moveNum)
{
    /* moveNum - how many times you want to move L->curr forward, negative number for moving backwards */ 
    TestTitlePrint(moveNum);      // some function that prints out what's going to happen
    char *t = "It's really cold outside, they are calling it a major freeze, weeks ahead of normal. Man, we could use a big fat dose of global warming! - Trump";
    DLListMoveTo(L, moveNum);     // want to test at head, tail and somewhere in the middle
    putDLList(OUTSTREAM, L);      // print out the state of the list, curr and size
    DLListInsertAfter(L, t);      // do the operation
    putDLList(OUTSTREAM, L);      // print out the state of the list, curr and size
    assert(validDLList(L));       // run validDLList! IMPORTANT!
}
```

