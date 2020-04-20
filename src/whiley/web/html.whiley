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
public function class<S,A>(string text) -> Attribute<S,A>:
    return { key: "class", value: text }
    
// cols
// colspan
// content
// dattime
// disabled
public function disabled<S,A>() -> Attribute<S,A>:
    return { key: "disabled", value: "" }

// download
// for
public function sfor<S,A>(string text) -> Attribute<S,A>:
    return { key: "for", value: text }

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
public function id<S,A>(string text) -> Attribute<S,A>:
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
public function name<S,A>(string text) -> Attribute<S,A>:
    return { key: "name", value: text }

// novalidate
// onabort
// onblur
// oncanplay
// oncanplaythrough
// onchange

public function style<S,A>(string text) -> Attribute<S,A>:
    return { key: "style", value: text }

public function tYpe<S,A>(string text) -> Attribute<S,A>:
    return { key: "type", value: text }

public function tabindex<S,A>(int index) -> Attribute<S,A>:
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
public type handler<E,S,A> is function(E,S)->(S,A[])

public type EventAttribute<S,A> is {
    string event,
    handler<Event,S,A> handler
}

public type MouseEventAttribute<S,A> is {
    string mouseEvent,
    handler<MouseEvent,S,A> handler
}

public type KeyboardEventAttribute<S,A> is {
    string keyEvent,
    handler<KeyboardEvent,S,A> handler
}

// onafterprint
// onbeforeprint
// onnbeforeunload
// onchange
public function change<S,A>(handler<MouseEvent,S,A> handler) -> Attribute<S,A>:
    return { mouseEvent: "change", handler: handler }

public function click<S,A>(handler<MouseEvent,S,A> handler) -> Attribute<S,A>:
    return { mouseEvent: "click", handler: handler }

// oncopy
public function dblclick<S,A>(handler<MouseEvent,S,A> handler) -> Attribute<S,A>:
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
public function focus<S,A>(handler<Event,S,A> handler) -> Attribute<S,A>:
    return { event: "focus", handler: handler }

// onhashchange
// oninput
// onkeydown
public function keydown<S,A>(handler<KeyboardEvent,S,A> handler) -> Attribute<S,A>:
    return { keyEvent: "keydown", handler: handler }

// onkeypress
public function keypress<S,A>(handler<KeyboardEvent,S,A> handler) -> Attribute<S,A>:
    return { keyEvent: "keypress", handler: handler }

// onkeyup
public function keyup<S,A>(handler<KeyboardEvent,S,A> handler) -> Attribute<S,A>:
    return { keyEvent: "keyup", handler: handler }

// onload
// onloadeddata
// onloadedmetadata
// onloadstart
// onmessage

// onmousedown
public function mousedown<S,A>(handler<MouseEvent,S,A> handler) -> Attribute<S,A>:
    return { mouseEvent: "mousedown", handler: handler }

// onmousemove
public function mousemove<S,A>(handler<MouseEvent,S,A> handler) -> Attribute<S,A>:
    return { mouseEvent: "mousemove", handler: handler }

// onmouseout
// onmouseover
public function mouseover<S,A>(handler<MouseEvent,S,A> handler) -> Attribute<S,A>:
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

public type Attribute<S,A> is TextAttribute |
                            EventAttribute<S,A> |
                            MouseEventAttribute<S,A> |
                            KeyboardEventAttribute<S,A>

// ==================================================================
// Node
// ==================================================================

public type Element<S,A> is {
    string name,
    Attribute<S,A>[] attributes,
    Node<S,A>[] children    
}

public type Node<S,A> is  Element<S,A> | string

public function element<S,A>(string tag, Node<S,A> child) -> Node<S,A>:
    return element<S,A>(tag, [id<S,A>("");0], [child])

public function element<S,A>(string tag, Node<S,A>[] children) -> Node<S,A>:
    return element<S,A>(tag, [id<S,A>("");0], children)

public function element<S,A>(string tag, Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return element<S,A>(tag, attributes, [child])

public function element<S,A>(string tag, Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return { name: tag, attributes: attributes, children: children }

// ==================================================================
// Basic
// ==================================================================


// h1
public function h1<S,A>(Node<S,A> child) -> Node<S,A>:
    return h1<S,A>([id<S,A>("");0], [child])

public function h1<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return h1<S,A>([id<S,A>("");0], children)

public function h1<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return h1<S,A>(attributes, [child])

public function h1<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("h1",attributes,children)

// h2

public function h2<S,A>(Node<S,A> child) -> Node<S,A>:
    return h2<S,A>([id<S,A>("");0], [child])

public function h2<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return h2<S,A>([id<S,A>("");0], children)
    
public function h2<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return h2<S,A>(attributes, [child])

public function h2<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("h2",attributes,children)

// h3
public function h3<S,A>(Node<S,A> child) -> Node<S,A>:
    return h3<S,A>([id<S,A>("");0], [child])

public function h3<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return h3<S,A>([id<S,A>("");0], children)

public function h3<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return h3<S,A>(attributes, [child])

public function h3<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("h3",attributes,children)

// h4
public function h4<S,A>(Node<S,A> child) -> Node<S,A>:
    return h4<S,A>([id<S,A>("");0], [child])

public function h4<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return h4<S,A>([id<S,A>("");0], children)

public function h4<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return h4<S,A>(attributes, [child])

public function h4<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("h4",attributes,children)

// h5
public function h5<S,A>(Node<S,A> child) -> Node<S,A>:
    return h5<S,A>([id<S,A>("");0], [child])

public function h5<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return h5<S,A>([id<S,A>("");0], children)

public function h5<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return h5<S,A>(attributes, [child])

public function h5<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("h5",attributes,children)

// h6
public function h6<S,A>(Node<S,A> child) -> Node<S,A>:
    return h6<S,A>([id<S,A>("");0], [child])

public function h6<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return h6<S,A>([id<S,A>("");0], children)

public function h6<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return h6<S,A>(attributes, [child])

public function h6<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("h6",attributes,children)

// p
public function p<S,A>(Node<S,A> child) -> Node<S,A>:
    return p<S,A>([id<S,A>("");0],[child])

public function p<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return p<S,A>([id<S,A>("");0],children)

public function p<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return p<S,A>(attributes,[child])

public function p<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("p",attributes,children)

// br
public function br<S,A>() -> Node<S,A>:
    return br<S,A>([id<S,A>("");0])

public function br<S,A>(Attribute<S,A>[] attributes) -> Node<S,A>:
    return element("br", attributes, ["";0])

// hr
public function hr<S,A>() -> Node<S,A>:
    return hr<S,A>([id<S,A>("");0])

public function hr<S,A>(Attribute<S,A>[] attributes) -> Node<S,A>:
    return element("hr", attributes, ["";0])

// ==================================================================
// Formatting
// ==================================================================

// abbr
public function abbr<S,A>(Node<S,A> child) -> Node<S,A>:
    return abbr<S,A>([id<S,A>("");0], [child])

public function abbr<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return abbr<S,A>([id<S,A>("");0], children)

public function abbr<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return abbr<S,A>(attributes, [child])

public function abbr<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("abbr",attributes,children)

// address
public function address<S,A>(Node<S,A> child) -> Node<S,A>:
    return address<S,A>([id<S,A>("");0], [child])

public function address<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return address<S,A>([id<S,A>("");0], children)

public function address<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return address<S,A>(attributes, [child])

public function address<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("address",attributes,children)

// b
public function b<S,A>(Node<S,A> child) -> Node<S,A>:
    return b<S,A>([id<S,A>("");0], [child])

public function b<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return b<S,A>([id<S,A>("");0], children)

public function b<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return b<S,A>(attributes, [child])

public function b<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("b",attributes,children)

// blockquote
public function blockquote<S,A>(Node<S,A> child) -> Node<S,A>:
    return blockquote<S,A>([id<S,A>("");0], [child])

public function blockquote<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return blockquote<S,A>([id<S,A>("");0], children)

public function blockquote<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return blockquote<S,A>(attributes, [child])

public function blockquote<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("blockquote",attributes,children)

// bdi
// bdo
// big

// center
public function center<S,A>(Node<S,A> child) -> Node<S,A>:
    return center<S,A>([id<S,A>("");0], [child])

public function center<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return center<S,A>([id<S,A>("");0], children)

public function center<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return center<S,A>(attributes, [child])

public function center<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("center",attributes,children)

// cite
public function cite<S,A>(Node<S,A> child) -> Node<S,A>:
    return cite<S,A>([id<S,A>("");0], [child])

public function cite<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return cite<S,A>([id<S,A>("");0], children)

public function cite<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return cite<S,A>(attributes, [child])

public function cite<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("cite",attributes,children)

// code
public function code<S,A>(Node<S,A> child) -> Node<S,A>:
    return code<S,A>([id<S,A>("");0], [child])

public function code<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return code<S,A>([id<S,A>("");0], children)

public function code<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return code<S,A>(attributes, [child])

public function code<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("code",attributes,children)

// del
// dfn

// em
public function em<S,A>(Node<S,A> child) -> Node<S,A>:
    return em<S,A>([id<S,A>("");0], [child])

public function em<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return em<S,A>([id<S,A>("");0], children)

public function em<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return em<S,A>(attributes, [child])

public function em<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("em",attributes,children)

// font
public function font<S,A>(Node<S,A> child) -> Node<S,A>:
    return font<S,A>([id<S,A>("");0], [child])

public function font<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return font<S,A>([id<S,A>("");0], children)

public function font<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return font<S,A>(attributes, [child])

public function font<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("font",attributes,children)

// i
public function i<S,A>(Node<S,A> child) -> Node<S,A>:
    return i<S,A>([id<S,A>("");0], [child])

public function i<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return i<S,A>([id<S,A>("");0], children)

public function i<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return i<S,A>(attributes, [child])

public function i<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("i",attributes,children)

// ins
// kbd
// mark
// meter
// pre
public function pre<S,A>(Node<S,A> child) -> Node<S,A>:
    return pre<S,A>([id<S,A>("");0], [child])

public function pre<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return pre<S,A>([id<S,A>("");0], children)

public function pre<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return pre<S,A>(attributes, [child])

public function pre<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("pre",attributes,children)

// progress

// q
public function q<S,A>(Node<S,A> child) -> Node<S,A>:
    return q<S,A>([id<S,A>("");0], [child])

public function q<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return q<S,A>([id<S,A>("");0], children)

public function q<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return q<S,A>(attributes, [child])

public function q<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("q",attributes,children)

// rp
// rt
// ruby
// s
public function s<S,A>(Node<S,A> child) -> Node<S,A>:
    return s<S,A>([id<S,A>("");0], [child])

public function s<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return s<S,A>([id<S,A>("");0], children)

public function s<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return s<S,A>(attributes, [child])

public function s<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("s",attributes,children)

// samp

// small
public function small<S,A>(Node<S,A> child) -> Node<S,A>:
    return small<S,A>([id<S,A>("");0], [child])

public function small<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return small<S,A>([id<S,A>("");0], children)

public function small<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return small<S,A>(attributes, [child])

public function small<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("small",attributes,children)

// strike
public function strike<S,A>(Node<S,A> child) -> Node<S,A>:
    return strike<S,A>([id<S,A>("");0], [child])

public function strike<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return strike<S,A>([id<S,A>("");0], children)

public function strike<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return strike<S,A>(attributes, [child])

public function strike<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("strike",attributes,children)

// strong
public function strong<S,A>(Node<S,A> child) -> Node<S,A>:
    return strong<S,A>([id<S,A>("");0], [child])

public function strong<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return strong<S,A>([id<S,A>("");0], children)

public function strong<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return strong<S,A>(attributes, [child])

public function strong<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("strong",attributes,children)

// sub
public function sub<S,A>(Node<S,A> child) -> Node<S,A>:
    return sub<S,A>([id<S,A>("");0], [child])

public function sub<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return sub<S,A>([id<S,A>("");0], children)

public function sub<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return sub<S,A>(attributes, [child])

public function sub<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("sub",attributes,children)

// sup
public function sup<S,A>(Node<S,A> child) -> Node<S,A>:
    return sup<S,A>([id<S,A>("");0], [child])

public function sup<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return sup<S,A>([id<S,A>("");0], children)

public function sup<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return sup<S,A>(attributes, [child])

public function sup<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("sup",attributes,children)

// template
// time
// tt

// u
public function u<S,A>(Node<S,A> child) -> Node<S,A>:
    return u<S,A>([id<S,A>("");0], [child])

public function u<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return u<S,A>([id<S,A>("");0], children)

public function u<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return u<S,A>(attributes, [child])

public function u<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("u",attributes,children)

// var
// wbr

// ==================================================================
// Form Tags
// ==================================================================

// form
public function form<S,A>(Node<S,A> child) -> Node<S,A>:
    return form<S,A>([id<S,A>("");0], [child])

public function form<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return form<S,A>([id<S,A>("");0], children)

public function form<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return form<S,A>(attributes, [child])

public function form<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("form",attributes,children)

// input
public function input<S,A>(Node<S,A> child) -> Node<S,A>:
    return input<S,A>([id<S,A>("");0], [child])

public function input<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return input<S,A>([id<S,A>("");0], children)

public function input<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return input<S,A>(attributes, [child])

public function input<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("input",attributes,children)

// textarea
public function textarea<S,A>(Node<S,A> child) -> Node<S,A>:
    return textarea<S,A>([id<S,A>("");0], [child])

public function textarea<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return textarea<S,A>([id<S,A>("");0], children)

public function textarea<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return textarea<S,A>(attributes, [child])

public function textarea<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("textarea",attributes,children)

// button
public function button<S,A>(Node<S,A> child) -> Node<S,A>:
    return button<S,A>([id<S,A>("");0], [child])

public function button<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return button<S,A>([id<S,A>("");0], children)

public function button<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return button<S,A>(attributes, [child])

public function button<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("button",attributes,children)

// select
public function select<S,A>(Node<S,A> child) -> Node<S,A>:
    return select<S,A>([id<S,A>("");0], [child])

public function select<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return select<S,A>([id<S,A>("");0], children)

public function select<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return select<S,A>(attributes, [child])

public function select<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("select",attributes,children)

// optgroup
public function optgroup<S,A>(Node<S,A> child) -> Node<S,A>:
    return optgroup<S,A>([id<S,A>("");0], [child])

public function optgroup<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return optgroup<S,A>([id<S,A>("");0], children)

public function optgroup<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return optgroup<S,A>(attributes, [child])

public function optgroup<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("optgroup",attributes,children)

// option
public function option<S,A>(Node<S,A> child) -> Node<S,A>:
    return option<S,A>([id<S,A>("");0], [child])

public function option<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return option<S,A>([id<S,A>("");0], children)

public function option<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return option<S,A>(attributes, [child])

public function option<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("option",attributes,children)

// label
public function label<S,A>(Node<S,A> child) -> Node<S,A>:
    return label<S,A>([id<S,A>("");0], [child])

public function label<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return label<S,A>([id<S,A>("");0], children)

public function label<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return label<S,A>(attributes, [child])

public function label<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("label",attributes,children)

// fieldset
public function fieldset<S,A>(Node<S,A> child) -> Node<S,A>:
    return fieldset<S,A>([id<S,A>("");0], [child])

public function fieldset<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return fieldset<S,A>([id<S,A>("");0], children)

public function fieldset<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return fieldset<S,A>(attributes, [child])

public function fieldset<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("fieldset",attributes,children)

// legend
public function legend<S,A>(Node<S,A> child) -> Node<S,A>:
    return legend<S,A>([id<S,A>("");0], [child])

public function legend<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return legend<S,A>([id<S,A>("");0], children)

public function legend<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return legend<S,A>(attributes, [child])

public function legend<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("legend",attributes,children)

// datalist
public function datalist<S,A>(Node<S,A> child) -> Node<S,A>:
    return datalist<S,A>([id<S,A>("");0], [child])

public function datalist<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return datalist<S,A>([id<S,A>("");0], children)

public function datalist<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return datalist<S,A>(attributes, [child])

public function datalist<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("datalist",attributes,children)

// output
public function output<S,A>(Node<S,A> child) -> Node<S,A>:
    return output<S,A>([id<S,A>("");0], [child])

public function output<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return output<S,A>([id<S,A>("");0], children)

public function output<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return output<S,A>(attributes, [child])

public function output<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("output",attributes,children)


// ==================================================================
// Frames
// ==================================================================

// frame
// frameset
// noframes

public function iframe<S,A>(Node<S,A> child) -> Node<S,A>:
    return iframe<S,A>([id<S,A>("");0], [child])

public function iframe<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return iframe<S,A>([id<S,A>("");0], children)

public function iframe<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return iframe<S,A>(attributes, [child])

public function iframe<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("iframe",attributes,children)

// ==================================================================
// Images
// ==================================================================

// img
public function img<S,A>(Node<S,A> child) -> Node<S,A>:
    return img<S,A>([id<S,A>("");0], [child])

public function img<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return img<S,A>([id<S,A>("");0], children)

public function img<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return img<S,A>(attributes, [child])

public function img<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("img",attributes,children)

// map
public function map<S,A>(Node<S,A> child) -> Node<S,A>:
    return map<S,A>([id<S,A>("");0], [child])

public function map<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return map<S,A>([id<S,A>("");0], children)

public function map<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return map<S,A>(attributes, [child])

public function map<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("map",attributes,children)

// area
public function area<S,A>(Node<S,A> child) -> Node<S,A>:
    return area<S,A>([id<S,A>("");0], [child])

public function area<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return area<S,A>([id<S,A>("");0], children)

public function area<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return area<S,A>(attributes, [child])

public function area<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("area",attributes,children)

// canvas
public function canvas<S,A>(Node<S,A> child) -> Node<S,A>:
    return canvas<S,A>([id<S,A>("");0], [child])

public function canvas<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return canvas<S,A>([id<S,A>("");0], children)

public function canvas<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return canvas<S,A>(attributes, [child])

public function canvas<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("canvas",attributes,children)

// figcaption
public function figcaption<S,A>(Node<S,A> child) -> Node<S,A>:
    return figcaption<S,A>([id<S,A>("");0], [child])

public function figcaption<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return figcaption<S,A>([id<S,A>("");0], children)

public function figcaption<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return figcaption<S,A>(attributes, [child])

public function figcaption<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("figcaption",attributes,children)

// figure
public function figure<S,A>(Node<S,A> child) -> Node<S,A>:
    return figure<S,A>([id<S,A>("");0], [child])

public function figure<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return figure<S,A>([id<S,A>("");0], children)

public function figure<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return figure<S,A>(attributes, [child])

public function figure<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("figure",attributes,children)

// picture
public function picture<S,A>(Node<S,A> child) -> Node<S,A>:
    return picture<S,A>([id<S,A>("");0], [child])

public function picture<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return picture<S,A>([id<S,A>("");0], children)

public function picture<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return picture<S,A>(attributes, [child])

public function picture<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("picture",attributes,children)

// svg
public function svg<S,A>(Node<S,A> child) -> Node<S,A>:
    return svg<S,A>([id<S,A>("");0], [child])

public function svg<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return svg<S,A>([id<S,A>("");0], children)

public function svg<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return svg<S,A>(attributes, [child])

public function svg<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("svg",attributes,children)

// ==================================================================
// Links
// ==================================================================

// a
public function a<S,A>(Node<S,A> child) -> Node<S,A>:
    return a<S,A>([id<S,A>("");0], [child])

public function a<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return a<S,A>([id<S,A>("");0], children)

public function a<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return a<S,A>(attributes, [child])

public function a<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("a",attributes,children)

// link
public function link<S,A>(Node<S,A> child) -> Node<S,A>:
    return link<S,A>([id<S,A>("");0], [child])

public function link<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return link<S,A>([id<S,A>("");0], children)

public function link<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return link<S,A>(attributes, [child])

public function link<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("link",attributes,children)

// nav
public function nav<S,A>(Node<S,A> child) -> Node<S,A>:
    return nav<S,A>([id<S,A>("");0], [child])

public function nav<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return nav<S,A>([id<S,A>("");0], children)

public function nav<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return nav<S,A>(attributes, [child])

public function nav<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("nav",attributes,children)

// ==================================================================
// Lists
// ==================================================================

// ul
public function ul<S,A>(Node<S,A> child) -> Node<S,A>:
    return ul<S,A>([id<S,A>("");0], [child])

public function ul<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return ul<S,A>([id<S,A>("");0], children)

public function ul<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return ul<S,A>(attributes, [child])

public function ul<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("ul",attributes,children)

// ol
public function ol<S,A>(Node<S,A> child) -> Node<S,A>:
    return ol<S,A>([id<S,A>("");0], [child])

public function ol<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return ol<S,A>([id<S,A>("");0], children)

public function ol<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return ol<S,A>(attributes, [child])

public function ol<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("ol",attributes,children)

// li
public function li<S,A>(Node<S,A> child) -> Node<S,A>:
    return li<S,A>([id<S,A>("");0], [child])

public function li<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return li<S,A>([id<S,A>("");0], children)

public function li<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return li<S,A>(attributes, [child])

public function li<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("li",attributes,children)

// dl
public function dl<S,A>(Node<S,A> child) -> Node<S,A>:
    return dl<S,A>([id<S,A>("");0], [child])

public function dl<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return dl<S,A>([id<S,A>("");0], children)

public function dl<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return dl<S,A>(attributes, [child])

public function dl<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("dl",attributes,children)

// dt
public function dtr<S,A>(Node<S,A> child) -> Node<S,A>:
    return dtr<S,A>([id<S,A>("");0], [child])

public function dtr<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return dtr<S,A>([id<S,A>("");0], children)

public function dtr<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return dtr<S,A>(attributes, [child])

public function dtr<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("dtr",attributes,children)

// dd
public function dd<S,A>(Node<S,A> child) -> Node<S,A>:
    return dd<S,A>([id<S,A>("");0], [child])

public function dd<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return dd<S,A>([id<S,A>("");0], children)

public function dd<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return dd<S,A>(attributes, [child])

public function dd<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("dd",attributes,children)

// ==================================================================
// Tables
// ==================================================================

// table
public function table<S,A>(Node<S,A> child) -> Node<S,A>:
    return table<S,A>([id<S,A>("");0], [child])

public function table<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return table<S,A>([id<S,A>("");0], children)

public function table<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return table<S,A>(attributes, [child])

public function table<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("table",attributes,children)

// caption
public function caption<S,A>(Node<S,A> child) -> Node<S,A>:
    return caption<S,A>([id<S,A>("");0], [child])

public function caption<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return caption<S,A>([id<S,A>("");0], children)

public function caption<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return caption<S,A>(attributes, [child])

public function caption<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("caption",attributes,children)

// th
public function th<S,A>(Node<S,A> child) -> Node<S,A>:
    return th<S,A>([id<S,A>("");0], [child])

public function th<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return th<S,A>([id<S,A>("");0], children)

public function th<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return th<S,A>(attributes, [child])

public function th<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("th",attributes,children)

// tr
public function tr<S,A>(Node<S,A> child) -> Node<S,A>:
    return tr<S,A>([id<S,A>("");0], [child])

public function tr<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return tr<S,A>([id<S,A>("");0], children)

public function tr<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return tr<S,A>(attributes, [child])

public function tr<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("tr",attributes,children)

// td
public function td<S,A>(Node<S,A> child) -> Node<S,A>:
    return td<S,A>([id<S,A>("");0], [child])

public function td<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return td<S,A>([id<S,A>("");0], children)

public function td<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return td<S,A>(attributes, [child])

public function td<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("td",attributes,children)

// thead
public function thead<S,A>(Node<S,A> child) -> Node<S,A>:
    return thead<S,A>([id<S,A>("");0], [child])

public function thead<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return thead<S,A>([id<S,A>("");0], children)

public function thead<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return thead<S,A>(attributes, [child])

public function thead<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("thead",attributes,children)

// tbody
public function tbody<S,A>(Node<S,A> child) -> Node<S,A>:
    return tbody<S,A>([id<S,A>("");0], [child])

public function tbody<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return tbody<S,A>([id<S,A>("");0], children)

public function tbody<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return tbody<S,A>(attributes, [child])

public function tbody<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("tbody",attributes,children)

// tfoot
public function tfoot<S,A>(Node<S,A> child) -> Node<S,A>:
    return tfoot<S,A>([id<S,A>("");0], [child])

public function tfoot<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return tfoot<S,A>([id<S,A>("");0], children)

public function tfoot<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return tfoot<S,A>(attributes, [child])

public function tfoot<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("tfoot",attributes,children)

// col
public function col<S,A>(Node<S,A> child) -> Node<S,A>:
    return col<S,A>([id<S,A>("");0], [child])

public function col<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return col<S,A>([id<S,A>("");0], children)

public function col<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return col<S,A>(attributes, [child])

public function col<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("col",attributes,children)

// colgroup
public function colgroup<S,A>(Node<S,A> child) -> Node<S,A>:
    return colgroup<S,A>([id<S,A>("");0], [child])

public function colgroup<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return colgroup<S,A>([id<S,A>("");0], children)

public function colgroup<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return colgroup<S,A>(attributes, [child])

public function colgroup<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("colgroup",attributes,children)

// ==================================================================
// Style and Semantics
// ==================================================================

// style

// div
public function div<S,A>(Node<S,A> child) -> Node<S,A>:
    return div<S,A>([id<S,A>("");0],[child])

public function div<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return div<S,A>([id<S,A>("");0],children)

public function div<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return div<S,A>(attributes,[child])

public function div<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("div",attributes,children)

// span
public function span<S,A>(Node<S,A> child) -> Node<S,A>:
    return span<S,A>([id<S,A>("");0],[child])

public function span<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return span<S,A>([id<S,A>("");0],children)

public function span<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return span<S,A>(attributes,[child])

public function span<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("span",attributes,children)

// header
public function header<S,A>(Node<S,A> child) -> Node<S,A>:
    return header<S,A>([id<S,A>("");0],[child])

public function header<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return header<S,A>([id<S,A>("");0],children)

public function header<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return header<S,A>(attributes,[child])

public function header<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("header",attributes,children)

// footer
public function footer<S,A>(Node<S,A> child) -> Node<S,A>:
    return footer<S,A>([id<S,A>("");0],[child])

public function footer<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return footer<S,A>([id<S,A>("");0],children)

public function footer<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return footer<S,A>(attributes,[child])

public function footer<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("footer",attributes,children)

// main
public function main<S,A>(Node<S,A> child) -> Node<S,A>:
    return main<S,A>([id<S,A>("");0],[child])

public function main<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return main<S,A>([id<S,A>("");0],children)

public function main<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return main<S,A>(attributes,[child])

public function main<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("main",attributes,children)

// section
public function section<S,A>(Node<S,A> child) -> Node<S,A>:
    return section<S,A>([id<S,A>("");0],[child])

public function section<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return section<S,A>([id<S,A>("");0],children)

public function section<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return section<S,A>(attributes,[child])

public function section<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("section",attributes,children)

// article
public function article<S,A>(Node<S,A> child) -> Node<S,A>:
    return article<S,A>([id<S,A>("");0],[child])

public function article<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return article<S,A>([id<S,A>("");0],children)

public function article<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return article<S,A>(attributes,[child])

public function article<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("article",attributes,children)

// aside
public function aside<S,A>(Node<S,A> child) -> Node<S,A>:
    return aside<S,A>([id<S,A>("");0],[child])

public function aside<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return aside<S,A>([id<S,A>("");0],children)

public function aside<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return aside<S,A>(attributes,[child])

public function aside<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("aside",attributes,children)

// details
public function details<S,A>(Node<S,A> child) -> Node<S,A>:
    return details<S,A>([id<S,A>("");0],[child])

public function details<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return details<S,A>([id<S,A>("");0],children)

public function details<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return details<S,A>(attributes,[child])

public function details<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("details",attributes,children)

// dialog
public function dialog<S,A>(Node<S,A> child) -> Node<S,A>:
    return dialog<S,A>([id<S,A>("");0],[child])

public function dialog<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return dialog<S,A>([id<S,A>("");0],children)

public function dialog<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return dialog<S,A>(attributes,[child])

public function dialog<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("dialog",attributes,children)

// summary
public function summary<S,A>(Node<S,A> child) -> Node<S,A>:
    return summary<S,A>([id<S,A>("");0],[child])

public function summary<S,A>(Node<S,A>[] children) -> Node<S,A>:
    return summary<S,A>([id<S,A>("");0],children)

public function summary<S,A>(Attribute<S,A>[] attributes, Node<S,A> child) -> Node<S,A>:
    return summary<S,A>(attributes,[child])

public function summary<S,A>(Attribute<S,A>[] attributes, Node<S,A>[] children) -> Node<S,A>:
    return element("summary",attributes,children)

// ========================================================
// To HTML
// ========================================================

public type ActionProcessor<S,A> is {
    // processor for mouse events
    method mouse(MouseEvent,handler<MouseEvent,S,A>),
    // processor for keyboard events
    method keyboard(KeyboardEvent,handler<KeyboardEvent,S,A>),
    // processor for other events
    method other(Event,handler<Event,S,A>)
}

/**
 * Convert an HTML model into concrete DOM nodes using a given
 * Document to construct new items, and processor for actions arising.
 */ 
public method to_dom<S,A>(Node<S,A> node, ActionProcessor<S,A> processor, dom::Document doc) -> (dom::Node r):
    if node is string:
        // Construct a text node
        return doc->createTextNode(node)
    else:
        dom::Element element = doc->createElement(node.name)
        // Recursively construct children
        for i in 0..|node.children|:
            // Construct child element
            dom::Node child = to_dom<S,A>(node.children[i],processor,doc)
            // Append to this element
            element->appendChild(child)
        // Recursively configure attributes
        for j in 0..|node.attributes|:
            Attribute<S,A> attr = node.attributes[j]
            // Dispatch on attribute type
            if attr is TextAttribute:
                element->setAttribute(attr.key,attr.value)                
            else if attr is MouseEventAttribute<S,A>:
                handler<MouseEvent,S,A> handler = attr.handler
                element->addEventListener(attr.mouseEvent,&(dom::MouseEvent e -> processor.mouse(to_mouse_event(e),handler)))
            else if attr is KeyboardEventAttribute<S,A>:
                // Add key event listener
                handler<KeyboardEvent,S,A> handler = attr.handler                
                element->addEventListener(attr.keyEvent,&(dom::KeyboardEvent e -> processor.keyboard(to_key_event(e),handler)))
            else:
                handler<Event,S,A> handler = attr.handler                
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
