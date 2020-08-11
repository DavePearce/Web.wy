package web

import string from js::core
import web::html

/**
 * Update a given node.
 */
public type Update<S,A> is {
    (null|html::Attribute<S,A>)[] attributes,
    Operation<S,A>[] children
}

/**
 * Replace an entire subtree with a given node.
 */
public type Replace<S,A> is { html::Node<S,A> node }

/**
 * Represents operations which can be applied to a tree
 */
public type Operation<S,A> is  Update<S,A> | Replace<S,A> | null

/**
 * Construct the diff between virtual DOM trees, one representing the
 * state before and the other representing the state after.
 */
public function create<S,A>(html::Node<S,A> before, html::Node<S,A> after) -> Operation<S,A>:
    if before == after:
        // No change!
        return null
    else if (before is string) || (after is string) || (before.name != after.name):
        // Node type differs, so must replace
        return {node:after}
    else:
        // Extract children
        html::Node<S,A>[] bChildren = before.children
        html::Node<S,A>[] aChildren = after.children
        // Construct initial set of operations        
        Operation<S,A>[] operations = [null; |after.children|]
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
        // FIXME: diff attributes!
        return {attributes:after.attributes, children: operations}