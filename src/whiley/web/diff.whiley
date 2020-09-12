package web

import std::math
import string from js::core
import web::html

/**
 * Represents the set of operations which can be applied to a tree,
 * where <code>null</code> indicates to keep the tree "as is".  In
 * essence, when creating a diff of two tree's we end up creating tree
 * of operations which encode the differences.  In the worst case, the
 * two trees are completely different and the result is a tree with a
 * single operation to replace the entire tree.  The following illustrates:
 *
 *      DIV                    DIV
 *     /   \                  /   \
 *    /     \        =>      /     \
 * "hello" "world"      "goodbye" "world"
 *
 * Here, we have a top-level div with two text children and we are
 * replacing the contents of the first child.  The diff of these two
 * trees is then the following tree of operations:
 *
 *       UPDATE
 *      /      \
 *   REPLACE   null
 *     |
 * "goodbyte"
 *
 * When applying this operation to the top-level DIV, it replaces the
 * left child with "goodbye" and leaves the right-child untouched.
 * Observe that, if the right operation were not "null" then the
 * right-child would be removed.
 */
public type NodeOperation<S,A> is Update<S,A> | Replace<S,A> | null

/**
 * An operation for (partially) updating the contents of a given DOM
 * node.  There are two parts: firstly, update the attributes;
 * secondly, update the children as necessary.  
 */
public type Update<S,A> is {
    AttributeOperation<S,A>[] attributes,
    NodeOperation<S,A>[] children
}

/**
 * Replace an entire subtree with a given DOM node.  This is fairly
 * straightforward.
 */ 
public type Replace<S,A> is { html::Node<S,A> node }

/**
 * Represents an operation on the style of a DOM node.  We're either
 * going to apply some attribute, or remove some existing attribute.
 */
public type AttributeOperation<S,A> is null | {
    (null|html::Attribute<S,A>) before,
    (null|html::Attribute<S,A>) after
}

/**
 * Construct the diff between virtual DOM trees, one representing the
 * state before and the other representing the state after.
 */
public function create<S,A>(html::Node<S,A> before, html::Node<S,A> after) -> NodeOperation<S,A>:
    if before == after:
        // No change!
        return null
    else if (before is string) || (after is string) || (before.name != after.name):
        // Node type differs, so must replace
        return {node:after}
    else:
        // Diff children
        NodeOperation<S,A>[] childOps = diff_children<S,A>(before.children,after.children)      
        // Diff attributes
        AttributeOperation<S,A>[] attrOps = diff_attributes<S,A>(before.attributes,after.attributes)
        // Done
        return {attributes:attrOps, children: childOps}

/**
 * Construct appropriate diff of children between two nodes.
 */
private function diff_children<S,A>(html::Node<S,A>[] bChildren, html::Node<S,A>[] aChildren ) -> (NodeOperation<S,A>[] rs):
    // Construct initial set of operations        
    NodeOperation<S,A>[] operations = [null; |aChildren|]
    //
    if |bChildren| < |aChildren|:
        // Update children in common
        for i in 0..|bChildren|:
            operations[i] = create(bChildren[i],aChildren[i])
        // Append remainder
        for i in |bChildren| .. |aChildren|:
            operations[i] = Replace{node:aChildren[i]}                
    else:
        // Update all children
        for i in 0..|aChildren|:
            operations[i] = create(bChildren[i],aChildren[i])
    // Done
    return operations

/**
 * Construct appropriate set of operations for updating the attributes
 */
private function diff_attributes<S,A>(html::Attribute<S,A>[] bAttributes, html::Attribute<S,A>[] aAttributes) -> (AttributeOperation<S,A>[] rs):
    // Determine common number of attributes
    int m = math::min(|bAttributes|,|aAttributes|)    
    // Include all existing attributes
    int n = |bAttributes|
    // Include any new attributes
    n = n + (|aAttributes| - m)
    // Create array to hold them all
    AttributeOperation<S,A>[] ops = [{before:null,after:null}; n]
    // Apply replacements    
    for i in 0..m:
        html::Attribute<S,A> b = bAttributes[i]
        html::Attribute<S,A> a = aAttributes[i]
        //
        if b != a:
            ops[i] = {before:b,after:a}
        else:
            ops[i] = null
    // Apply removals
    for i in m .. |bAttributes|:
        html::Attribute<S,A> b = bAttributes[i]    
        ops[i+m] = {before: b, after: null}
    // Apply additions
    for i in m .. |aAttributes|:
        html::Attribute<S,A> a = bAttributes[i]    
        ops[i+|bAttributes|] = {before: null, after: a}
    // Done
    return ops
    
            
    