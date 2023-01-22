
# Recursion or Binary Tree Implementation Assembly

In this repo, I implemented the recursion solution of the mFibonacci algorithm and committed the required changes to traverse(LRN) a binary tree, which has a similar solution algorithm.

# mFibonacci Description

mFibonacci Sequence: Each number in the modified Fibonacci Sequence is computed by using the
mathematical expression given below:

Fn = Fn−1 + 2 ∗ Fn−2 where n≥2, F0 = 1 and F1 = 1.

So, the sequence is: 1, 1, 3, 5, 11, 21, 43, 85, 171 and so on

# C/C++ equivalent of the algorithm

```C++
int mfibonacci(int x){
	if(x < 2) return 1;
	else return mfibonacci(x-1) + 2*mfibonacci(x-2);
}

//////////or

template <class T>
void Postorder (TreeNode<T> *t, void visit(T& item)) //visit func corresponds to OutStr in our example
{
   // the recursive scan terminates on a empty subtree
   if (t != NULL)
   {    //LRN Traverse
      Postorder<T> (t->Left(),  visit);  // descend left
      Postorder<T> (t->Right(), visit); // descend right
      visit(t->data);               // visit the node
   }
}
```