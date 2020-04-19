package web

import to_string from std::ascii
import string from js::core
import w3c::dom

// ==================================================================
// Textual Attributes
// ==================================================================

public type TextAttribute is {
    string key,
    string value
}

// accept
// accept-charset
// accesskey
// action
// align
// alt
// async
// autocomplete
// autofocus
// autoplay
// charset
// checked
// cite
// class
public function class<T,A>(string text) -> Attribute<T,A>:
    return { key: "class", value: text }
    
// cols
// colspan
// content
// dattime
// disabled
public function disabled<T,A>() -> Attribute<T,A>:
    return { key: "disabled", value: "" }

// download
// for
// form
// formaction
// headers
// height
// hidden
// high
// href
// hreflang
// http-equiv

// id
public function id<T,A>(string text) -> Attribute<T,A>:
    return { key: "id", value: text }

// ismap
// kind
// label
// lang
// list
// loop
// low
// max
// maxlength
// media
// method
// min
// multiple
// muted

// name
public function name<T,A>(string text) -> Attribute<T,A>:
    return { key: "name", value: text }

// novalidate
// onabort
// onblur
// oncanplay
// oncanplaythrough
// onchange

public function style<T,A>(string text) -> Attribute<T,A>:
    return { key: "style", value: text }

public function tabindex<T,A>(int index) -> Attribute<T,A>:
    return { key: "tabindex", value: (string) to_string(index) }


// ==================================================================
// Event Attributes
// ==================================================================

public type Event is {    
    int timeStamp   
}

public type MouseEvent is {
    bool altKey,
    int button,
    int buttons,
    int clientX,
    int clientY,
    bool ctrlKey,
    bool metaKey,
    int movementX,
    int movementY,
    int offsetX,
    int offsetY,
    int pageX,
    int pageY,
    int region,
    int screenX,
    int screenY,
    bool shiftKey    
}

public type KeyboardEvent is {
    bool altKey,
    string code,
    bool ctrlKey,
    bool isComposing,
    string key,
    int keyCode,
    int location,
    bool metaKey,
    bool repeat,
    bool shiftKey    
}

// A simple event handler
public type handler<E,T,A>  is function(E,T)->(T,A)

public type EventAttribute<T,A> is {
    string event,
    handler<Event,T,A> handler
}

public type MouseEventAttribute<T,A> is {
    string mouseEvent,
    handler<MouseEvent,T,A> handler
}

public type KeyboardEventAttribute<T,A> is {
    string keyEvent,
    handler<KeyboardEvent,T,A> handler
}

// onafterprint
// onbeforeprint
// onnbeforeunload
// onchange
public function change<T,A>(handler<MouseEvent,T,A> handler) -> Attribute<T,A>:
    return { mouseEvent: "change", handler: handler }

public function click<T,A>(handler<MouseEvent,T,A> handler) -> Attribute<T,A>:
    return { mouseEvent: "click", handler: handler }

// oncopy
public function dblclick<T,A>(handler<MouseEvent,T,A> handler) -> Attribute<T,A>:
    return { mouseEvent: "dblclick", handler: handler }

// ondrag
// ondragend
// ondragleave
// ondragover
// ondragstart
// ondurationchange
// onemptied
// onended
// onerror
// onfocus
public function focus<T,A>(handler<Event,T,A> handler) -> Attribute<T,A>:
    return { event: "focus", handler: handler }

// onhashchange
// oninput
// onkeydown
public function keydown<T,A>(handler<KeyboardEvent,T,A> handler) -> Attribute<T,A>:
    return { keyEvent: "keydown", handler: handler }

// onkeypress
public function keypress<T,A>(handler<KeyboardEvent,T,A> handler) -> Attribute<T,A>:
    return { keyEvent: "keypress", handler: handler }

// onkeyup
public function keyup<T,A>(handler<KeyboardEvent,T,A> handler) -> Attribute<T,A>:
    return { keyEvent: "keyup", handler: handler }

// onload
// onloadeddata
// onloadedmetadata
// onloadstart
// onmessage

// onmousedown
public function mousedown<T,A>(handler<MouseEvent,T,A> handler) -> Attribute<T,A>:
    return { mouseEvent: "mousedown", handler: handler }

// onmousemove
public function mousemove<T,A>(handler<MouseEvent,T,A> handler) -> Attribute<T,A>:
    return { mouseEvent: "mousemove", handler: handler }

// onmouseout
// onmouseover
public function mouseover<T,A>(handler<MouseEvent,T,A> handler) -> Attribute<T,A>:
    return { mouseEvent: "mouseover", handler: handler }

// onmouseup
// onmousewheel
// onoffline
// ononline
// onpagehide
// onpageshow
// onpopstate
// onresize
// onstorage
// onunload

// ==================================================================
// Attributes
// ==================================================================

public type Attribute<T,A> is TextAttribute |
                            EventAttribute<T,A> |
                            MouseEventAttribute<T,A> |
                            KeyboardEventAttribute<T,A>

// ==================================================================
// Node
// ==================================================================

public type Element<T,A> is {
    string name,
    Attribute<T,A>[] attributes,
    Node<T,A>[] children    
}

public type Node<T,A> is  Element<T,A> | string

public function element<T,A>(string tag, Node<T,A> child) -> Node<T,A>:
    return element<T,A>(tag, [id<T,A>("");0], [child])

public function element<T,A>(string tag, Node<T,A>[] children) -> Node<T,A>:
    return element<T,A>(tag, [id<T,A>("");0], children)

public function element<T,A>(string tag, Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return element<T,A>(tag, attributes, [child])

public function element<T,A>(string tag, Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return { name: tag, attributes: attributes, children: children }

// ==================================================================
// Basic
// ==================================================================


// h1
public function h1<T,A>(Node<T,A> child) -> Node<T,A>:
    return h1<T,A>([id<T,A>("");0], [child])

public function h1<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return h1<T,A>([id<T,A>("");0], children)

public function h1<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return h1<T,A>(attributes, [child])

public function h1<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("h1",attributes,children)

// h2
public function h2<T,A>(Node<T,A> child) -> Node<T,A>:
    return h2<T,A>([id<T,A>("");0], [child])

public function h2<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return h2<T,A>([id<T,A>("");0], children)
    
public function h2<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return h2<T,A>(attributes, [child])

public function h2<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("h2",attributes,children)

// h3
public function h3<T,A>(Node<T,A> child) -> Node<T,A>:
    return h3<T,A>([id<T,A>("");0], [child])

public function h3<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return h3<T,A>([id<T,A>("");0], children)

public function h3<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return h3<T,A>(attributes, [child])

public function h3<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("h3",attributes,children)

// h4
public function h4<T,A>(Node<T,A> child) -> Node<T,A>:
    return h4<T,A>([id<T,A>("");0], [child])

public function h4<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return h4<T,A>([id<T,A>("");0], children)

public function h4<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return h4<T,A>(attributes, [child])

public function h4<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("h4",attributes,children)

// h5
public function h5<T,A>(Node<T,A> child) -> Node<T,A>:
    return h5<T,A>([id<T,A>("");0], [child])

public function h5<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return h5<T,A>([id<T,A>("");0], children)

public function h5<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return h5<T,A>(attributes, [child])

public function h5<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("h5",attributes,children)

// h6
public function h6<T,A>(Node<T,A> child) -> Node<T,A>:
    return h6<T,A>([id<T,A>("");0], [child])

public function h6<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return h6<T,A>([id<T,A>("");0], children)

public function h6<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return h6<T,A>(attributes, [child])

public function h6<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("h6",attributes,children)

// p
public function p<T,A>(Node<T,A> child) -> Node<T,A>:
    return p<T,A>([id<T,A>("");0],[child])

public function p<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return p<T,A>([id<T,A>("");0],children)

public function p<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return p<T,A>(attributes,[child])

public function p<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("p",attributes,children)

// br
public function br<T,A>() -> Node<T,A>:
    return br<T,A>([id<T,A>("");0])

public function br<T,A>(Attribute<T,A>[] attributes) -> Node<T,A>:
    return element("br", attributes, ["";0])

// hr
public function hr<T,A>() -> Node<T,A>:
    return hr<T,A>([id<T,A>("");0])

public function hr<T,A>(Attribute<T,A>[] attributes) -> Node<T,A>:
    return element("hr", attributes, ["";0])

// ==================================================================
// Formatting
// ==================================================================

// abbr
public function abbr<T,A>(Node<T,A> child) -> Node<T,A>:
    return abbr<T,A>([id<T,A>("");0], [child])

public function abbr<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return abbr<T,A>([id<T,A>("");0], children)

public function abbr<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return abbr<T,A>(attributes, [child])

public function abbr<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("abbr",attributes,children)

// address
public function address<T,A>(Node<T,A> child) -> Node<T,A>:
    return address<T,A>([id<T,A>("");0], [child])

public function address<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return address<T,A>([id<T,A>("");0], children)

public function address<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return address<T,A>(attributes, [child])

public function address<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("address",attributes,children)

// b
public function b<T,A>(Node<T,A> child) -> Node<T,A>:
    return b<T,A>([id<T,A>("");0], [child])

public function b<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return b<T,A>([id<T,A>("");0], children)

public function b<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return b<T,A>(attributes, [child])

public function b<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("b",attributes,children)

// blockquote
public function blockquote<T,A>(Node<T,A> child) -> Node<T,A>:
    return blockquote<T,A>([id<T,A>("");0], [child])

public function blockquote<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return blockquote<T,A>([id<T,A>("");0], children)

public function blockquote<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return blockquote<T,A>(attributes, [child])

public function blockquote<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("blockquote",attributes,children)

// bdi
// bdo
// big

// center
public function center<T,A>(Node<T,A> child) -> Node<T,A>:
    return center<T,A>([id<T,A>("");0], [child])

public function center<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return center<T,A>([id<T,A>("");0], children)

public function center<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return center<T,A>(attributes, [child])

public function center<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("center",attributes,children)

// cite
public function cite<T,A>(Node<T,A> child) -> Node<T,A>:
    return cite<T,A>([id<T,A>("");0], [child])

public function cite<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return cite<T,A>([id<T,A>("");0], children)

public function cite<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return cite<T,A>(attributes, [child])

public function cite<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("cite",attributes,children)

// code
public function code<T,A>(Node<T,A> child) -> Node<T,A>:
    return code<T,A>([id<T,A>("");0], [child])

public function code<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return code<T,A>([id<T,A>("");0], children)

public function code<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return code<T,A>(attributes, [child])

public function code<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("code",attributes,children)

// del
// dfn

// em
public function em<T,A>(Node<T,A> child) -> Node<T,A>:
    return em<T,A>([id<T,A>("");0], [child])

public function em<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return em<T,A>([id<T,A>("");0], children)

public function em<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return em<T,A>(attributes, [child])

public function em<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("em",attributes,children)

// font
public function font<T,A>(Node<T,A> child) -> Node<T,A>:
    return font<T,A>([id<T,A>("");0], [child])

public function font<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return font<T,A>([id<T,A>("");0], children)

public function font<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return font<T,A>(attributes, [child])

public function font<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("font",attributes,children)

// i
public function i<T,A>(Node<T,A> child) -> Node<T,A>:
    return i<T,A>([id<T,A>("");0], [child])

public function i<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return i<T,A>([id<T,A>("");0], children)

public function i<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return i<T,A>(attributes, [child])

public function i<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("i",attributes,children)

// ins
// kbd
// mark
// meter
// pre
public function pre<T,A>(Node<T,A> child) -> Node<T,A>:
    return pre<T,A>([id<T,A>("");0], [child])

public function pre<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return pre<T,A>([id<T,A>("");0], children)

public function pre<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return pre<T,A>(attributes, [child])

public function pre<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("pre",attributes,children)

// progress

// q
public function q<T,A>(Node<T,A> child) -> Node<T,A>:
    return q<T,A>([id<T,A>("");0], [child])

public function q<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return q<T,A>([id<T,A>("");0], children)

public function q<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return q<T,A>(attributes, [child])

public function q<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("q",attributes,children)

// rp
// rt
// ruby
// s
public function s<T,A>(Node<T,A> child) -> Node<T,A>:
    return s<T,A>([id<T,A>("");0], [child])

public function s<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return s<T,A>([id<T,A>("");0], children)

public function s<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return s<T,A>(attributes, [child])

public function s<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("s",attributes,children)

// samp

// small
public function small<T,A>(Node<T,A> child) -> Node<T,A>:
    return small<T,A>([id<T,A>("");0], [child])

public function small<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return small<T,A>([id<T,A>("");0], children)

public function small<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return small<T,A>(attributes, [child])

public function small<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("small",attributes,children)

// strike
public function strike<T,A>(Node<T,A> child) -> Node<T,A>:
    return strike<T,A>([id<T,A>("");0], [child])

public function strike<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return strike<T,A>([id<T,A>("");0], children)

public function strike<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return strike<T,A>(attributes, [child])

public function strike<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("strike",attributes,children)

// strong
public function strong<T,A>(Node<T,A> child) -> Node<T,A>:
    return strong<T,A>([id<T,A>("");0], [child])

public function strong<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return strong<T,A>([id<T,A>("");0], children)

public function strong<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return strong<T,A>(attributes, [child])

public function strong<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("strong",attributes,children)

// sub
public function sub<T,A>(Node<T,A> child) -> Node<T,A>:
    return sub<T,A>([id<T,A>("");0], [child])

public function sub<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return sub<T,A>([id<T,A>("");0], children)

public function sub<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return sub<T,A>(attributes, [child])

public function sub<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("sub",attributes,children)

// sup
public function sup<T,A>(Node<T,A> child) -> Node<T,A>:
    return sup<T,A>([id<T,A>("");0], [child])

public function sup<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return sup<T,A>([id<T,A>("");0], children)

public function sup<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return sup<T,A>(attributes, [child])

public function sup<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("sup",attributes,children)

// template
// time
// tt

// u
public function u<T,A>(Node<T,A> child) -> Node<T,A>:
    return u<T,A>([id<T,A>("");0], [child])

public function u<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return u<T,A>([id<T,A>("");0], children)

public function u<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return u<T,A>(attributes, [child])

public function u<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("u",attributes,children)

// var
// wbr

// ==================================================================
// Form Tags
// ==================================================================

// form
public function form<T,A>(Node<T,A> child) -> Node<T,A>:
    return form<T,A>([id<T,A>("");0], [child])

public function form<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return form<T,A>([id<T,A>("");0], children)

public function form<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return form<T,A>(attributes, [child])

public function form<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("form",attributes,children)

// input
public function input<T,A>(Node<T,A> child) -> Node<T,A>:
    return input<T,A>([id<T,A>("");0], [child])

public function input<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return input<T,A>([id<T,A>("");0], children)

public function input<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return input<T,A>(attributes, [child])

public function input<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("input",attributes,children)

// textarea
public function textarea<T,A>(Node<T,A> child) -> Node<T,A>:
    return textarea<T,A>([id<T,A>("");0], [child])

public function textarea<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return textarea<T,A>([id<T,A>("");0], children)

public function textarea<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return textarea<T,A>(attributes, [child])

public function textarea<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("textarea",attributes,children)

// button
public function button<T,A>(Node<T,A> child) -> Node<T,A>:
    return button<T,A>([id<T,A>("");0], [child])

public function button<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return button<T,A>([id<T,A>("");0], children)

public function button<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return button<T,A>(attributes, [child])

public function button<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("button",attributes,children)

// select
public function select<T,A>(Node<T,A> child) -> Node<T,A>:
    return select<T,A>([id<T,A>("");0], [child])

public function select<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return select<T,A>([id<T,A>("");0], children)

public function select<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return select<T,A>(attributes, [child])

public function select<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("select",attributes,children)

// optgroup
public function optgroup<T,A>(Node<T,A> child) -> Node<T,A>:
    return optgroup<T,A>([id<T,A>("");0], [child])

public function optgroup<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return optgroup<T,A>([id<T,A>("");0], children)

public function optgroup<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return optgroup<T,A>(attributes, [child])

public function optgroup<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("optgroup",attributes,children)

// option
public function option<T,A>(Node<T,A> child) -> Node<T,A>:
    return option<T,A>([id<T,A>("");0], [child])

public function option<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return option<T,A>([id<T,A>("");0], children)

public function option<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return option<T,A>(attributes, [child])

public function option<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("option",attributes,children)

// label
public function label<T,A>(Node<T,A> child) -> Node<T,A>:
    return label<T,A>([id<T,A>("");0], [child])

public function label<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return label<T,A>([id<T,A>("");0], children)

public function label<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return label<T,A>(attributes, [child])

public function label<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("label",attributes,children)

// fieldset
public function fieldset<T,A>(Node<T,A> child) -> Node<T,A>:
    return fieldset<T,A>([id<T,A>("");0], [child])

public function fieldset<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return fieldset<T,A>([id<T,A>("");0], children)

public function fieldset<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return fieldset<T,A>(attributes, [child])

public function fieldset<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("fieldset",attributes,children)

// legend
public function legend<T,A>(Node<T,A> child) -> Node<T,A>:
    return legend<T,A>([id<T,A>("");0], [child])

public function legend<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return legend<T,A>([id<T,A>("");0], children)

public function legend<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return legend<T,A>(attributes, [child])

public function legend<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("legend",attributes,children)

// datalist
public function datalist<T,A>(Node<T,A> child) -> Node<T,A>:
    return datalist<T,A>([id<T,A>("");0], [child])

public function datalist<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return datalist<T,A>([id<T,A>("");0], children)

public function datalist<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return datalist<T,A>(attributes, [child])

public function datalist<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("datalist",attributes,children)

// output
public function output<T,A>(Node<T,A> child) -> Node<T,A>:
    return output<T,A>([id<T,A>("");0], [child])

public function output<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return output<T,A>([id<T,A>("");0], children)

public function output<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return output<T,A>(attributes, [child])

public function output<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("output",attributes,children)


// ==================================================================
// Frames
// ==================================================================

// frame
// frameset
// noframes

public function iframe<T,A>(Node<T,A> child) -> Node<T,A>:
    return iframe<T,A>([id<T,A>("");0], [child])

public function iframe<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return iframe<T,A>([id<T,A>("");0], children)

public function iframe<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return iframe<T,A>(attributes, [child])

public function iframe<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("iframe",attributes,children)

// ==================================================================
// Images
// ==================================================================

// img
public function img<T,A>(Node<T,A> child) -> Node<T,A>:
    return img<T,A>([id<T,A>("");0], [child])

public function img<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return img<T,A>([id<T,A>("");0], children)

public function img<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return img<T,A>(attributes, [child])

public function img<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("img",attributes,children)

// map
public function map<T,A>(Node<T,A> child) -> Node<T,A>:
    return map<T,A>([id<T,A>("");0], [child])

public function map<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return map<T,A>([id<T,A>("");0], children)

public function map<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return map<T,A>(attributes, [child])

public function map<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("map",attributes,children)

// area
public function area<T,A>(Node<T,A> child) -> Node<T,A>:
    return area<T,A>([id<T,A>("");0], [child])

public function area<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return area<T,A>([id<T,A>("");0], children)

public function area<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return area<T,A>(attributes, [child])

public function area<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("area",attributes,children)

// canvas
public function canvas<T,A>(Node<T,A> child) -> Node<T,A>:
    return canvas<T,A>([id<T,A>("");0], [child])

public function canvas<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return canvas<T,A>([id<T,A>("");0], children)

public function canvas<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return canvas<T,A>(attributes, [child])

public function canvas<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("canvas",attributes,children)

// figcaption
public function figcaption<T,A>(Node<T,A> child) -> Node<T,A>:
    return figcaption<T,A>([id<T,A>("");0], [child])

public function figcaption<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return figcaption<T,A>([id<T,A>("");0], children)

public function figcaption<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return figcaption<T,A>(attributes, [child])

public function figcaption<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("figcaption",attributes,children)

// figure
public function figure<T,A>(Node<T,A> child) -> Node<T,A>:
    return figure<T,A>([id<T,A>("");0], [child])

public function figure<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return figure<T,A>([id<T,A>("");0], children)

public function figure<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return figure<T,A>(attributes, [child])

public function figure<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("figure",attributes,children)

// picture
public function picture<T,A>(Node<T,A> child) -> Node<T,A>:
    return picture<T,A>([id<T,A>("");0], [child])

public function picture<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return picture<T,A>([id<T,A>("");0], children)

public function picture<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return picture<T,A>(attributes, [child])

public function picture<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("picture",attributes,children)

// svg
public function svg<T,A>(Node<T,A> child) -> Node<T,A>:
    return svg<T,A>([id<T,A>("");0], [child])

public function svg<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return svg<T,A>([id<T,A>("");0], children)

public function svg<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return svg<T,A>(attributes, [child])

public function svg<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("svg",attributes,children)

// ==================================================================
// Links
// ==================================================================

// a
public function a<T,A>(Node<T,A> child) -> Node<T,A>:
    return a<T,A>([id<T,A>("");0], [child])

public function a<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return a<T,A>([id<T,A>("");0], children)

public function a<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return a<T,A>(attributes, [child])

public function a<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("a",attributes,children)

// link
public function link<T,A>(Node<T,A> child) -> Node<T,A>:
    return link<T,A>([id<T,A>("");0], [child])

public function link<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return link<T,A>([id<T,A>("");0], children)

public function link<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return link<T,A>(attributes, [child])

public function link<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("link",attributes,children)

// nav
public function nav<T,A>(Node<T,A> child) -> Node<T,A>:
    return nav<T,A>([id<T,A>("");0], [child])

public function nav<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return nav<T,A>([id<T,A>("");0], children)

public function nav<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return nav<T,A>(attributes, [child])

public function nav<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("nav",attributes,children)

// ==================================================================
// Lists
// ==================================================================

// ul
public function ul<T,A>(Node<T,A> child) -> Node<T,A>:
    return ul<T,A>([id<T,A>("");0], [child])

public function ul<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return ul<T,A>([id<T,A>("");0], children)

public function ul<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return ul<T,A>(attributes, [child])

public function ul<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("ul",attributes,children)

// ol
public function ol<T,A>(Node<T,A> child) -> Node<T,A>:
    return ol<T,A>([id<T,A>("");0], [child])

public function ol<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return ol<T,A>([id<T,A>("");0], children)

public function ol<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return ol<T,A>(attributes, [child])

public function ol<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("ol",attributes,children)

// li
public function li<T,A>(Node<T,A> child) -> Node<T,A>:
    return li<T,A>([id<T,A>("");0], [child])

public function li<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return li<T,A>([id<T,A>("");0], children)

public function li<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return li<T,A>(attributes, [child])

public function li<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("li",attributes,children)

// dl
public function dl<T,A>(Node<T,A> child) -> Node<T,A>:
    return dl<T,A>([id<T,A>("");0], [child])

public function dl<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return dl<T,A>([id<T,A>("");0], children)

public function dl<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return dl<T,A>(attributes, [child])

public function dl<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("dl",attributes,children)

// dt
public function dtr<T,A>(Node<T,A> child) -> Node<T,A>:
    return dtr<T,A>([id<T,A>("");0], [child])

public function dtr<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return dtr<T,A>([id<T,A>("");0], children)

public function dtr<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return dtr<T,A>(attributes, [child])

public function dtr<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("dtr",attributes,children)

// dd
public function dd<T,A>(Node<T,A> child) -> Node<T,A>:
    return dd<T,A>([id<T,A>("");0], [child])

public function dd<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return dd<T,A>([id<T,A>("");0], children)

public function dd<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return dd<T,A>(attributes, [child])

public function dd<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("dd",attributes,children)

// ==================================================================
// Tables
// ==================================================================

// table
public function table<T,A>(Node<T,A> child) -> Node<T,A>:
    return table<T,A>([id<T,A>("");0], [child])

public function table<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return table<T,A>([id<T,A>("");0], children)

public function table<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return table<T,A>(attributes, [child])

public function table<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("table",attributes,children)

// caption
public function caption<T,A>(Node<T,A> child) -> Node<T,A>:
    return caption<T,A>([id<T,A>("");0], [child])

public function caption<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return caption<T,A>([id<T,A>("");0], children)

public function caption<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return caption<T,A>(attributes, [child])

public function caption<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("caption",attributes,children)

// th
public function th<T,A>(Node<T,A> child) -> Node<T,A>:
    return th<T,A>([id<T,A>("");0], [child])

public function th<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return th<T,A>([id<T,A>("");0], children)

public function th<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return th<T,A>(attributes, [child])

public function th<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("th",attributes,children)

// tr
public function tr<T,A>(Node<T,A> child) -> Node<T,A>:
    return tr<T,A>([id<T,A>("");0], [child])

public function tr<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return tr<T,A>([id<T,A>("");0], children)

public function tr<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return tr<T,A>(attributes, [child])

public function tr<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("tr",attributes,children)

// td
public function td<T,A>(Node<T,A> child) -> Node<T,A>:
    return td<T,A>([id<T,A>("");0], [child])

public function td<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return td<T,A>([id<T,A>("");0], children)

public function td<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return td<T,A>(attributes, [child])

public function td<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("td",attributes,children)

// thead
public function thead<T,A>(Node<T,A> child) -> Node<T,A>:
    return thead<T,A>([id<T,A>("");0], [child])

public function thead<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return thead<T,A>([id<T,A>("");0], children)

public function thead<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return thead<T,A>(attributes, [child])

public function thead<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("thead",attributes,children)

// tbody
public function tbody<T,A>(Node<T,A> child) -> Node<T,A>:
    return tbody<T,A>([id<T,A>("");0], [child])

public function tbody<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return tbody<T,A>([id<T,A>("");0], children)

public function tbody<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return tbody<T,A>(attributes, [child])

public function tbody<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("tbody",attributes,children)

// tfoot
public function tfoot<T,A>(Node<T,A> child) -> Node<T,A>:
    return tfoot<T,A>([id<T,A>("");0], [child])

public function tfoot<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return tfoot<T,A>([id<T,A>("");0], children)

public function tfoot<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return tfoot<T,A>(attributes, [child])

public function tfoot<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("tfoot",attributes,children)

// col
public function col<T,A>(Node<T,A> child) -> Node<T,A>:
    return col<T,A>([id<T,A>("");0], [child])

public function col<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return col<T,A>([id<T,A>("");0], children)

public function col<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return col<T,A>(attributes, [child])

public function col<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("col",attributes,children)

// colgroup
public function colgroup<T,A>(Node<T,A> child) -> Node<T,A>:
    return colgroup<T,A>([id<T,A>("");0], [child])

public function colgroup<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return colgroup<T,A>([id<T,A>("");0], children)

public function colgroup<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return colgroup<T,A>(attributes, [child])

public function colgroup<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("colgroup",attributes,children)

// ==================================================================
// Style and Semantics
// ==================================================================

// style

// div
public function div<T,A>(Node<T,A> child) -> Node<T,A>:
    return div<T,A>([id<T,A>("");0],[child])

public function div<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return div<T,A>([id<T,A>("");0],children)

public function div<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return div<T,A>(attributes,[child])

public function div<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("div",attributes,children)

// span
public function span<T,A>(Node<T,A> child) -> Node<T,A>:
    return span<T,A>([id<T,A>("");0],[child])

public function span<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return span<T,A>([id<T,A>("");0],children)

public function span<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return span<T,A>(attributes,[child])

public function span<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("span",attributes,children)

// header
public function header<T,A>(Node<T,A> child) -> Node<T,A>:
    return header<T,A>([id<T,A>("");0],[child])

public function header<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return header<T,A>([id<T,A>("");0],children)

public function header<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return header<T,A>(attributes,[child])

public function header<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("header",attributes,children)

// footer
public function footer<T,A>(Node<T,A> child) -> Node<T,A>:
    return footer<T,A>([id<T,A>("");0],[child])

public function footer<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return footer<T,A>([id<T,A>("");0],children)

public function footer<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return footer<T,A>(attributes,[child])

public function footer<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("footer",attributes,children)

// main
public function main<T,A>(Node<T,A> child) -> Node<T,A>:
    return main<T,A>([id<T,A>("");0],[child])

public function main<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return main<T,A>([id<T,A>("");0],children)

public function main<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return main<T,A>(attributes,[child])

public function main<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("main",attributes,children)

// section
public function section<T,A>(Node<T,A> child) -> Node<T,A>:
    return section<T,A>([id<T,A>("");0],[child])

public function section<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return section<T,A>([id<T,A>("");0],children)

public function section<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return section<T,A>(attributes,[child])

public function section<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("section",attributes,children)

// article
public function article<T,A>(Node<T,A> child) -> Node<T,A>:
    return article<T,A>([id<T,A>("");0],[child])

public function article<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return article<T,A>([id<T,A>("");0],children)

public function article<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return article<T,A>(attributes,[child])

public function article<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("article",attributes,children)

// aside
public function aside<T,A>(Node<T,A> child) -> Node<T,A>:
    return aside<T,A>([id<T,A>("");0],[child])

public function aside<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return aside<T,A>([id<T,A>("");0],children)

public function aside<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return aside<T,A>(attributes,[child])

public function aside<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("aside",attributes,children)

// details
public function details<T,A>(Node<T,A> child) -> Node<T,A>:
    return details<T,A>([id<T,A>("");0],[child])

public function details<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return details<T,A>([id<T,A>("");0],children)

public function details<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return details<T,A>(attributes,[child])

public function details<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("details",attributes,children)

// dialog
public function dialog<T,A>(Node<T,A> child) -> Node<T,A>:
    return dialog<T,A>([id<T,A>("");0],[child])

public function dialog<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return dialog<T,A>([id<T,A>("");0],children)

public function dialog<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return dialog<T,A>(attributes,[child])

public function dialog<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("dialog",attributes,children)

// summary
public function summary<T,A>(Node<T,A> child) -> Node<T,A>:
    return summary<T,A>([id<T,A>("");0],[child])

public function summary<T,A>(Node<T,A>[] children) -> Node<T,A>:
    return summary<T,A>([id<T,A>("");0],children)

public function summary<T,A>(Attribute<T,A>[] attributes, Node<T,A> child) -> Node<T,A>:
    return summary<T,A>(attributes,[child])

public function summary<T,A>(Attribute<T,A>[] attributes, Node<T,A>[] children) -> Node<T,A>:
    return element("summary",attributes,children)

// ========================================================
// To HTML
// ========================================================

public type EventProcessor<T,A> is {
    // processor for mouse events
    method mouse(MouseEvent,handler<MouseEvent,T,A>),
    // processor for keyboard events
    method keyboard(KeyboardEvent,handler<KeyboardEvent,T,A>),
    // processor for other events
    method other(Event,handler<Event,T,A>)
}

/**
 * Convert an HTML model into concrete DOM nodes using a given
 * Document to construct new items, and processor for actions arising.
 */ 
public method to_dom<T,A>(Node<T,A> node, EventProcessor<T,A> processor, dom::Document doc) -> (dom::Node r):
    if node is string:
        // Construct a text node
        return doc->createTextNode(node)
    else:
        dom::Element element = doc->createElement(node.name)
        // Recursively construct children
        for i in 0..|node.children|:
            // Construct child element
            dom::Node child = to_dom<T,A>(node.children[i],processor,doc)
            // Append to this element
            element->appendChild(child)
        // Recursively configure attributes
        for j in 0..|node.attributes|:
            Attribute<T,A> attr = node.attributes[j]
            // Dispatch on attribute type
            if attr is TextAttribute:
                element->setAttribute(attr.key,attr.value)                
            else if attr is MouseEventAttribute<T,A>:
                handler<MouseEvent,T,A> handler = attr.handler
                element->addEventListener(attr.mouseEvent,&(dom::MouseEvent e -> processor.mouse(to_mouse_event(e),handler)))
            else if attr is KeyboardEventAttribute<T,A>:
                // Add key event listener
                handler<KeyboardEvent,T,A> handler = attr.handler                
                element->addEventListener(attr.keyEvent,&(dom::KeyboardEvent e -> processor.keyboard(to_key_event(e),handler)))
            else:
                handler<Event,T,A> handler = attr.handler                
                element->addEventListener(attr.event,&(dom::Event e -> processor.other(to_event(e),handler)))
            // Done
        return element

// Convert a DOM Event into an HTML (i.e. functional) view.
method to_event(dom::Event event) -> html::Event:
     return {timeStamp: event->timeStamp}

// Convert a DOM Mouse Event into an HTML (i.e. functional) view.
method to_mouse_event(dom::MouseEvent event) -> MouseEvent:
    return {
      altKey: event->altKey,
      button: event->button,
      buttons: event->buttons,
      clientX: event->clientX,
      clientY: event->clientY,
      ctrlKey: event->ctrlKey,
      metaKey: event->metaKey,
      movementX: event->movementX,
      movementY: event->movementY,
      offsetX: event->offsetX,
      offsetY: event->offsetY,
      pageX: event->pageX,
      pageY: event->pageY,
      region: event->region,
      screenX: event->screenX,
      screenY: event->screenY,
      shiftKey:  event->shiftKey
    }

// Convert a DOM Keyboard Event into an HTML (i.e. functional) view.
method to_key_event(dom::KeyboardEvent event) -> KeyboardEvent:
    return {
      altKey: event->altKey,
      code: event->code,
      ctrlKey: event->ctrlKey,
      isComposing: event->isComposing,
      key: event->key,
      keyCode: event->keyCode,
      location: event->location,
      metaKey: event->metaKey,
      repeat: event->repeat,
      shiftKey: event->shiftKey
    }
