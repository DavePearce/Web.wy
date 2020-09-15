package web

import to_string from std::ascii
import string from js::core
import w3c::dom

import Action from web::io

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
public function class<S>(string text) -> Attribute<S>:
    return { key: "class", value: text }
    
// cols
// colspan
// content
// dattime
// disabled
public function disabled<S>() -> Attribute<S>:
    return { key: "disabled", value: "" }

// download
// for
public function sfor<S>(string text) -> Attribute<S>:
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
public function id<S>(string text) -> Attribute<S>:
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
public function name<S>(string text) -> Attribute<S>:
    return { key: "name", value: text }

// novalidate
// onabort
// onblur
// oncanplay
// oncanplaythrough
// onchange

public function style<S>(string text) -> Attribute<S>:
    return { key: "style", value: text }

public function tYpe<S>(string text) -> Attribute<S>:
    return { key: "type", value: text }

public function tabindex<S>(int index) -> Attribute<S>:
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
public type handler<E,S> is function(E,S)->(S,Action<S>[])

public type EventAttribute<S> is {
    string event,
    handler<Event,S> handler
}

public type MouseEventAttribute<S> is {
    string mouseEvent,
    handler<MouseEvent,S> handler
}

public type KeyboardEventAttribute<S> is {
    string keyEvent,
    handler<KeyboardEvent,S> handler
}

// onafterprint
// onbeforeprint
// onnbeforeunload
// onchange
public function change<S>(handler<MouseEvent,S> handler) -> Attribute<S>:
    return { mouseEvent: "change", handler: handler }

public function click<S>(handler<MouseEvent,S> handler) -> Attribute<S>:
    return { mouseEvent: "click", handler: handler }

// oncopy
public function dblclick<S>(handler<MouseEvent,S> handler) -> Attribute<S>:
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
public function focus<S>(handler<Event,S> handler) -> Attribute<S>:
    return { event: "focus", handler: handler }

// onhashchange
// oninput
// onkeydown
public function keydown<S>(handler<KeyboardEvent,S> handler) -> Attribute<S>:
    return { keyEvent: "keydown", handler: handler }

// onkeypress
public function keypress<S>(handler<KeyboardEvent,S> handler) -> Attribute<S>:
    return { keyEvent: "keypress", handler: handler }

// onkeyup
public function keyup<S>(handler<KeyboardEvent,S> handler) -> Attribute<S>:
    return { keyEvent: "keyup", handler: handler }

// onload
// onloadeddata
// onloadedmetadata
// onloadstart
// onmessage

// onmousedown
public function mousedown<S>(handler<MouseEvent,S> handler) -> Attribute<S>:
    return { mouseEvent: "mousedown", handler: handler }

// onmousemove
public function mousemove<S>(handler<MouseEvent,S> handler) -> Attribute<S>:
    return { mouseEvent: "mousemove", handler: handler }

// onmouseout
// onmouseover
public function mouseover<S>(handler<MouseEvent,S> handler) -> Attribute<S>:
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

public type Attribute<S> is TextAttribute |
                            EventAttribute<S> |
                            MouseEventAttribute<S> |
                            KeyboardEventAttribute<S>

// ==================================================================
// Node
// ==================================================================

public type Element<S> is {
    string name,
    Attribute<S>[] attributes,
    Node<S>[] children    
}

public type Node<S> is  Element<S> | string

public function element<S>(string tag, Node<S> child) -> Node<S>:
    return element<S>(tag, [id<S>("");0], [child])

public function element<S>(string tag, Node<S>[] children) -> Node<S>:
    return element<S>(tag, [id<S>("");0], children)

public function element<S>(string tag, Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return element<S>(tag, attributes, [child])

public function element<S>(string tag, Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return { name: tag, attributes: attributes, children: children }

// ==================================================================
// Basic
// ==================================================================


// h1
public function h1<S>(Node<S> child) -> Node<S>:
    return h1<S>([id<S>("");0], [child])

public function h1<S>(Node<S>[] children) -> Node<S>:
    return h1<S>([id<S>("");0], children)

public function h1<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return h1<S>(attributes, [child])

public function h1<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("h1",attributes,children)

// h2

public function h2<S>(Node<S> child) -> Node<S>:
    return h2<S>([id<S>("");0], [child])

public function h2<S>(Node<S>[] children) -> Node<S>:
    return h2<S>([id<S>("");0], children)
    
public function h2<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return h2<S>(attributes, [child])

public function h2<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("h2",attributes,children)

// h3
public function h3<S>(Node<S> child) -> Node<S>:
    return h3<S>([id<S>("");0], [child])

public function h3<S>(Node<S>[] children) -> Node<S>:
    return h3<S>([id<S>("");0], children)

public function h3<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return h3<S>(attributes, [child])

public function h3<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("h3",attributes,children)

// h4
public function h4<S>(Node<S> child) -> Node<S>:
    return h4<S>([id<S>("");0], [child])

public function h4<S>(Node<S>[] children) -> Node<S>:
    return h4<S>([id<S>("");0], children)

public function h4<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return h4<S>(attributes, [child])

public function h4<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("h4",attributes,children)

// h5
public function h5<S>(Node<S> child) -> Node<S>:
    return h5<S>([id<S>("");0], [child])

public function h5<S>(Node<S>[] children) -> Node<S>:
    return h5<S>([id<S>("");0], children)

public function h5<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return h5<S>(attributes, [child])

public function h5<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("h5",attributes,children)

// h6
public function h6<S>(Node<S> child) -> Node<S>:
    return h6<S>([id<S>("");0], [child])

public function h6<S>(Node<S>[] children) -> Node<S>:
    return h6<S>([id<S>("");0], children)

public function h6<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return h6<S>(attributes, [child])

public function h6<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("h6",attributes,children)

// p
public function p<S>(Node<S> child) -> Node<S>:
    return p<S>([id<S>("");0],[child])

public function p<S>(Node<S>[] children) -> Node<S>:
    return p<S>([id<S>("");0],children)

public function p<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return p<S>(attributes,[child])

public function p<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("p",attributes,children)

// br
public function br<S>() -> Node<S>:
    return br<S>([id<S>("");0])

public function br<S>(Attribute<S>[] attributes) -> Node<S>:
    return element("br", attributes, ["";0])

// hr
public function hr<S>() -> Node<S>:
    return hr<S>([id<S>("");0])

public function hr<S>(Attribute<S>[] attributes) -> Node<S>:
    return element("hr", attributes, ["";0])

// ==================================================================
// Formatting
// ==================================================================

// abbr
public function abbr<S>(Node<S> child) -> Node<S>:
    return abbr<S>([id<S>("");0], [child])

public function abbr<S>(Node<S>[] children) -> Node<S>:
    return abbr<S>([id<S>("");0], children)

public function abbr<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return abbr<S>(attributes, [child])

public function abbr<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("abbr",attributes,children)

// address
public function address<S>(Node<S> child) -> Node<S>:
    return address<S>([id<S>("");0], [child])

public function address<S>(Node<S>[] children) -> Node<S>:
    return address<S>([id<S>("");0], children)

public function address<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return address<S>(attributes, [child])

public function address<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("address",attributes,children)

// b
public function b<S>(Node<S> child) -> Node<S>:
    return b<S>([id<S>("");0], [child])

public function b<S>(Node<S>[] children) -> Node<S>:
    return b<S>([id<S>("");0], children)

public function b<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return b<S>(attributes, [child])

public function b<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("b",attributes,children)

// blockquote
public function blockquote<S>(Node<S> child) -> Node<S>:
    return blockquote<S>([id<S>("");0], [child])

public function blockquote<S>(Node<S>[] children) -> Node<S>:
    return blockquote<S>([id<S>("");0], children)

public function blockquote<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return blockquote<S>(attributes, [child])

public function blockquote<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("blockquote",attributes,children)

// bdi
// bdo
// big

// center
public function center<S>(Node<S> child) -> Node<S>:
    return center<S>([id<S>("");0], [child])

public function center<S>(Node<S>[] children) -> Node<S>:
    return center<S>([id<S>("");0], children)

public function center<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return center<S>(attributes, [child])

public function center<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("center",attributes,children)

// cite
public function cite<S>(Node<S> child) -> Node<S>:
    return cite<S>([id<S>("");0], [child])

public function cite<S>(Node<S>[] children) -> Node<S>:
    return cite<S>([id<S>("");0], children)

public function cite<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return cite<S>(attributes, [child])

public function cite<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("cite",attributes,children)

// code
public function code<S>(Node<S> child) -> Node<S>:
    return code<S>([id<S>("");0], [child])

public function code<S>(Node<S>[] children) -> Node<S>:
    return code<S>([id<S>("");0], children)

public function code<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return code<S>(attributes, [child])

public function code<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("code",attributes,children)

// del
// dfn

// em
public function em<S>(Node<S> child) -> Node<S>:
    return em<S>([id<S>("");0], [child])

public function em<S>(Node<S>[] children) -> Node<S>:
    return em<S>([id<S>("");0], children)

public function em<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return em<S>(attributes, [child])

public function em<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("em",attributes,children)

// font
public function font<S>(Node<S> child) -> Node<S>:
    return font<S>([id<S>("");0], [child])

public function font<S>(Node<S>[] children) -> Node<S>:
    return font<S>([id<S>("");0], children)

public function font<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return font<S>(attributes, [child])

public function font<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("font",attributes,children)

// i
public function i<S>(Node<S> child) -> Node<S>:
    return i<S>([id<S>("");0], [child])

public function i<S>(Node<S>[] children) -> Node<S>:
    return i<S>([id<S>("");0], children)

public function i<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return i<S>(attributes, [child])

public function i<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("i",attributes,children)

// ins
// kbd
// mark
// meter
// pre
public function pre<S>(Node<S> child) -> Node<S>:
    return pre<S>([id<S>("");0], [child])

public function pre<S>(Node<S>[] children) -> Node<S>:
    return pre<S>([id<S>("");0], children)

public function pre<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return pre<S>(attributes, [child])

public function pre<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("pre",attributes,children)

// progress

// q
public function q<S>(Node<S> child) -> Node<S>:
    return q<S>([id<S>("");0], [child])

public function q<S>(Node<S>[] children) -> Node<S>:
    return q<S>([id<S>("");0], children)

public function q<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return q<S>(attributes, [child])

public function q<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("q",attributes,children)

// rp
// rt
// ruby
// s
public function s<S>(Node<S> child) -> Node<S>:
    return s<S>([id<S>("");0], [child])

public function s<S>(Node<S>[] children) -> Node<S>:
    return s<S>([id<S>("");0], children)

public function s<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return s<S>(attributes, [child])

public function s<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("s",attributes,children)

// samp

// small
public function small<S>(Node<S> child) -> Node<S>:
    return small<S>([id<S>("");0], [child])

public function small<S>(Node<S>[] children) -> Node<S>:
    return small<S>([id<S>("");0], children)

public function small<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return small<S>(attributes, [child])

public function small<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("small",attributes,children)

// strike
public function strike<S>(Node<S> child) -> Node<S>:
    return strike<S>([id<S>("");0], [child])

public function strike<S>(Node<S>[] children) -> Node<S>:
    return strike<S>([id<S>("");0], children)

public function strike<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return strike<S>(attributes, [child])

public function strike<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("strike",attributes,children)

// strong
public function strong<S>(Node<S> child) -> Node<S>:
    return strong<S>([id<S>("");0], [child])

public function strong<S>(Node<S>[] children) -> Node<S>:
    return strong<S>([id<S>("");0], children)

public function strong<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return strong<S>(attributes, [child])

public function strong<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("strong",attributes,children)

// sub
public function sub<S>(Node<S> child) -> Node<S>:
    return sub<S>([id<S>("");0], [child])

public function sub<S>(Node<S>[] children) -> Node<S>:
    return sub<S>([id<S>("");0], children)

public function sub<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return sub<S>(attributes, [child])

public function sub<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("sub",attributes,children)

// sup
public function sup<S>(Node<S> child) -> Node<S>:
    return sup<S>([id<S>("");0], [child])

public function sup<S>(Node<S>[] children) -> Node<S>:
    return sup<S>([id<S>("");0], children)

public function sup<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return sup<S>(attributes, [child])

public function sup<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("sup",attributes,children)

// template
// time
// tt

// u
public function u<S>(Node<S> child) -> Node<S>:
    return u<S>([id<S>("");0], [child])

public function u<S>(Node<S>[] children) -> Node<S>:
    return u<S>([id<S>("");0], children)

public function u<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return u<S>(attributes, [child])

public function u<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("u",attributes,children)

// var
// wbr

// ==================================================================
// Form Tags
// ==================================================================

// form
public function form<S>(Node<S> child) -> Node<S>:
    return form<S>([id<S>("");0], [child])

public function form<S>(Node<S>[] children) -> Node<S>:
    return form<S>([id<S>("");0], children)

public function form<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return form<S>(attributes, [child])

public function form<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("form",attributes,children)

// input
public function input<S>(Node<S> child) -> Node<S>:
    return input<S>([id<S>("");0], [child])

public function input<S>(Node<S>[] children) -> Node<S>:
    return input<S>([id<S>("");0], children)

public function input<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return input<S>(attributes, [child])

public function input<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("input",attributes,children)

// textarea
public function textarea<S>(Node<S> child) -> Node<S>:
    return textarea<S>([id<S>("");0], [child])

public function textarea<S>(Node<S>[] children) -> Node<S>:
    return textarea<S>([id<S>("");0], children)

public function textarea<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return textarea<S>(attributes, [child])

public function textarea<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("textarea",attributes,children)

// button
public function button<S>(Node<S> child) -> Node<S>:
    return button<S>([id<S>("");0], [child])

public function button<S>(Node<S>[] children) -> Node<S>:
    return button<S>([id<S>("");0], children)

public function button<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return button<S>(attributes, [child])

public function button<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("button",attributes,children)

// select
public function select<S>(Node<S> child) -> Node<S>:
    return select<S>([id<S>("");0], [child])

public function select<S>(Node<S>[] children) -> Node<S>:
    return select<S>([id<S>("");0], children)

public function select<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return select<S>(attributes, [child])

public function select<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("select",attributes,children)

// optgroup
public function optgroup<S>(Node<S> child) -> Node<S>:
    return optgroup<S>([id<S>("");0], [child])

public function optgroup<S>(Node<S>[] children) -> Node<S>:
    return optgroup<S>([id<S>("");0], children)

public function optgroup<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return optgroup<S>(attributes, [child])

public function optgroup<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("optgroup",attributes,children)

// option
public function option<S>(Node<S> child) -> Node<S>:
    return option<S>([id<S>("");0], [child])

public function option<S>(Node<S>[] children) -> Node<S>:
    return option<S>([id<S>("");0], children)

public function option<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return option<S>(attributes, [child])

public function option<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("option",attributes,children)

// label
public function label<S>(Node<S> child) -> Node<S>:
    return label<S>([id<S>("");0], [child])

public function label<S>(Node<S>[] children) -> Node<S>:
    return label<S>([id<S>("");0], children)

public function label<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return label<S>(attributes, [child])

public function label<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("label",attributes,children)

// fieldset
public function fieldset<S>(Node<S> child) -> Node<S>:
    return fieldset<S>([id<S>("");0], [child])

public function fieldset<S>(Node<S>[] children) -> Node<S>:
    return fieldset<S>([id<S>("");0], children)

public function fieldset<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return fieldset<S>(attributes, [child])

public function fieldset<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("fieldset",attributes,children)

// legend
public function legend<S>(Node<S> child) -> Node<S>:
    return legend<S>([id<S>("");0], [child])

public function legend<S>(Node<S>[] children) -> Node<S>:
    return legend<S>([id<S>("");0], children)

public function legend<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return legend<S>(attributes, [child])

public function legend<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("legend",attributes,children)

// datalist
public function datalist<S>(Node<S> child) -> Node<S>:
    return datalist<S>([id<S>("");0], [child])

public function datalist<S>(Node<S>[] children) -> Node<S>:
    return datalist<S>([id<S>("");0], children)

public function datalist<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return datalist<S>(attributes, [child])

public function datalist<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("datalist",attributes,children)

// output
public function output<S>(Node<S> child) -> Node<S>:
    return output<S>([id<S>("");0], [child])

public function output<S>(Node<S>[] children) -> Node<S>:
    return output<S>([id<S>("");0], children)

public function output<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return output<S>(attributes, [child])

public function output<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("output",attributes,children)


// ==================================================================
// Frames
// ==================================================================

// frame
// frameset
// noframes

public function iframe<S>(Node<S> child) -> Node<S>:
    return iframe<S>([id<S>("");0], [child])

public function iframe<S>(Node<S>[] children) -> Node<S>:
    return iframe<S>([id<S>("");0], children)

public function iframe<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return iframe<S>(attributes, [child])

public function iframe<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("iframe",attributes,children)

// ==================================================================
// Images
// ==================================================================

// img
public function img<S>(Node<S> child) -> Node<S>:
    return img<S>([id<S>("");0], [child])

public function img<S>(Node<S>[] children) -> Node<S>:
    return img<S>([id<S>("");0], children)

public function img<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return img<S>(attributes, [child])

public function img<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("img",attributes,children)

// map
public function map<S>(Node<S> child) -> Node<S>:
    return map<S>([id<S>("");0], [child])

public function map<S>(Node<S>[] children) -> Node<S>:
    return map<S>([id<S>("");0], children)

public function map<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return map<S>(attributes, [child])

public function map<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("map",attributes,children)

// area
public function area<S>(Node<S> child) -> Node<S>:
    return area<S>([id<S>("");0], [child])

public function area<S>(Node<S>[] children) -> Node<S>:
    return area<S>([id<S>("");0], children)

public function area<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return area<S>(attributes, [child])

public function area<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("area",attributes,children)

// canvas
public function canvas<S>(Node<S> child) -> Node<S>:
    return canvas<S>([id<S>("");0], [child])

public function canvas<S>(Node<S>[] children) -> Node<S>:
    return canvas<S>([id<S>("");0], children)

public function canvas<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return canvas<S>(attributes, [child])

public function canvas<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("canvas",attributes,children)

// figcaption
public function figcaption<S>(Node<S> child) -> Node<S>:
    return figcaption<S>([id<S>("");0], [child])

public function figcaption<S>(Node<S>[] children) -> Node<S>:
    return figcaption<S>([id<S>("");0], children)

public function figcaption<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return figcaption<S>(attributes, [child])

public function figcaption<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("figcaption",attributes,children)

// figure
public function figure<S>(Node<S> child) -> Node<S>:
    return figure<S>([id<S>("");0], [child])

public function figure<S>(Node<S>[] children) -> Node<S>:
    return figure<S>([id<S>("");0], children)

public function figure<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return figure<S>(attributes, [child])

public function figure<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("figure",attributes,children)

// picture
public function picture<S>(Node<S> child) -> Node<S>:
    return picture<S>([id<S>("");0], [child])

public function picture<S>(Node<S>[] children) -> Node<S>:
    return picture<S>([id<S>("");0], children)

public function picture<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return picture<S>(attributes, [child])

public function picture<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("picture",attributes,children)

// svg
public function svg<S>(Node<S> child) -> Node<S>:
    return svg<S>([id<S>("");0], [child])

public function svg<S>(Node<S>[] children) -> Node<S>:
    return svg<S>([id<S>("");0], children)

public function svg<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return svg<S>(attributes, [child])

public function svg<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("svg",attributes,children)

// ==================================================================
// Links
// ==================================================================

// a
public function a<S>(Node<S> child) -> Node<S>:
    return a<S>([id<S>("");0], [child])

public function a<S>(Node<S>[] children) -> Node<S>:
    return a<S>([id<S>("");0], children)

public function a<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return a<S>(attributes, [child])

public function a<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("a",attributes,children)

// link
public function link<S>(Node<S> child) -> Node<S>:
    return link<S>([id<S>("");0], [child])

public function link<S>(Node<S>[] children) -> Node<S>:
    return link<S>([id<S>("");0], children)

public function link<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return link<S>(attributes, [child])

public function link<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("link",attributes,children)

// nav
public function nav<S>(Node<S> child) -> Node<S>:
    return nav<S>([id<S>("");0], [child])

public function nav<S>(Node<S>[] children) -> Node<S>:
    return nav<S>([id<S>("");0], children)

public function nav<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return nav<S>(attributes, [child])

public function nav<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("nav",attributes,children)

// ==================================================================
// Lists
// ==================================================================

// ul
public function ul<S>(Node<S> child) -> Node<S>:
    return ul<S>([id<S>("");0], [child])

public function ul<S>(Node<S>[] children) -> Node<S>:
    return ul<S>([id<S>("");0], children)

public function ul<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return ul<S>(attributes, [child])

public function ul<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("ul",attributes,children)

// ol
public function ol<S>(Node<S> child) -> Node<S>:
    return ol<S>([id<S>("");0], [child])

public function ol<S>(Node<S>[] children) -> Node<S>:
    return ol<S>([id<S>("");0], children)

public function ol<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return ol<S>(attributes, [child])

public function ol<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("ol",attributes,children)

// li
public function li<S>(Node<S> child) -> Node<S>:
    return li<S>([id<S>("");0], [child])

public function li<S>(Node<S>[] children) -> Node<S>:
    return li<S>([id<S>("");0], children)

public function li<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return li<S>(attributes, [child])

public function li<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("li",attributes,children)

// dl
public function dl<S>(Node<S> child) -> Node<S>:
    return dl<S>([id<S>("");0], [child])

public function dl<S>(Node<S>[] children) -> Node<S>:
    return dl<S>([id<S>("");0], children)

public function dl<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return dl<S>(attributes, [child])

public function dl<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("dl",attributes,children)

// dt
public function dtr<S>(Node<S> child) -> Node<S>:
    return dtr<S>([id<S>("");0], [child])

public function dtr<S>(Node<S>[] children) -> Node<S>:
    return dtr<S>([id<S>("");0], children)

public function dtr<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return dtr<S>(attributes, [child])

public function dtr<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("dtr",attributes,children)

// dd
public function dd<S>(Node<S> child) -> Node<S>:
    return dd<S>([id<S>("");0], [child])

public function dd<S>(Node<S>[] children) -> Node<S>:
    return dd<S>([id<S>("");0], children)

public function dd<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return dd<S>(attributes, [child])

public function dd<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("dd",attributes,children)

// ==================================================================
// Tables
// ==================================================================

// table
public function table<S>(Node<S> child) -> Node<S>:
    return table<S>([id<S>("");0], [child])

public function table<S>(Node<S>[] children) -> Node<S>:
    return table<S>([id<S>("");0], children)

public function table<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return table<S>(attributes, [child])

public function table<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("table",attributes,children)

// caption
public function caption<S>(Node<S> child) -> Node<S>:
    return caption<S>([id<S>("");0], [child])

public function caption<S>(Node<S>[] children) -> Node<S>:
    return caption<S>([id<S>("");0], children)

public function caption<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return caption<S>(attributes, [child])

public function caption<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("caption",attributes,children)

// th
public function th<S>(Node<S> child) -> Node<S>:
    return th<S>([id<S>("");0], [child])

public function th<S>(Node<S>[] children) -> Node<S>:
    return th<S>([id<S>("");0], children)

public function th<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return th<S>(attributes, [child])

public function th<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("th",attributes,children)

// tr
public function tr<S>(Node<S> child) -> Node<S>:
    return tr<S>([id<S>("");0], [child])

public function tr<S>(Node<S>[] children) -> Node<S>:
    return tr<S>([id<S>("");0], children)

public function tr<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return tr<S>(attributes, [child])

public function tr<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("tr",attributes,children)

// td
public function td<S>(Node<S> child) -> Node<S>:
    return td<S>([id<S>("");0], [child])

public function td<S>(Node<S>[] children) -> Node<S>:
    return td<S>([id<S>("");0], children)

public function td<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return td<S>(attributes, [child])

public function td<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("td",attributes,children)

// thead
public function thead<S>(Node<S> child) -> Node<S>:
    return thead<S>([id<S>("");0], [child])

public function thead<S>(Node<S>[] children) -> Node<S>:
    return thead<S>([id<S>("");0], children)

public function thead<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return thead<S>(attributes, [child])

public function thead<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("thead",attributes,children)

// tbody
public function tbody<S>(Node<S> child) -> Node<S>:
    return tbody<S>([id<S>("");0], [child])

public function tbody<S>(Node<S>[] children) -> Node<S>:
    return tbody<S>([id<S>("");0], children)

public function tbody<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return tbody<S>(attributes, [child])

public function tbody<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("tbody",attributes,children)

// tfoot
public function tfoot<S>(Node<S> child) -> Node<S>:
    return tfoot<S>([id<S>("");0], [child])

public function tfoot<S>(Node<S>[] children) -> Node<S>:
    return tfoot<S>([id<S>("");0], children)

public function tfoot<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return tfoot<S>(attributes, [child])

public function tfoot<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("tfoot",attributes,children)

// col
public function col<S>(Node<S> child) -> Node<S>:
    return col<S>([id<S>("");0], [child])

public function col<S>(Node<S>[] children) -> Node<S>:
    return col<S>([id<S>("");0], children)

public function col<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return col<S>(attributes, [child])

public function col<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("col",attributes,children)

// colgroup
public function colgroup<S>(Node<S> child) -> Node<S>:
    return colgroup<S>([id<S>("");0], [child])

public function colgroup<S>(Node<S>[] children) -> Node<S>:
    return colgroup<S>([id<S>("");0], children)

public function colgroup<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return colgroup<S>(attributes, [child])

public function colgroup<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("colgroup",attributes,children)

// ==================================================================
// Style and Semantics
// ==================================================================

// style

// div
public function div<S>(Node<S> child) -> Node<S>:
    return div<S>([id<S>("");0],[child])

public function div<S>(Node<S>[] children) -> Node<S>:
    return div<S>([id<S>("");0],children)

public function div<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return div<S>(attributes,[child])

public function div<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("div",attributes,children)

// span
public function span<S>(Node<S> child) -> Node<S>:
    return span<S>([id<S>("");0],[child])

public function span<S>(Node<S>[] children) -> Node<S>:
    return span<S>([id<S>("");0],children)

public function span<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return span<S>(attributes,[child])

public function span<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("span",attributes,children)

// header
public function header<S>(Node<S> child) -> Node<S>:
    return header<S>([id<S>("");0],[child])

public function header<S>(Node<S>[] children) -> Node<S>:
    return header<S>([id<S>("");0],children)

public function header<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return header<S>(attributes,[child])

public function header<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("header",attributes,children)

// footer
public function footer<S>(Node<S> child) -> Node<S>:
    return footer<S>([id<S>("");0],[child])

public function footer<S>(Node<S>[] children) -> Node<S>:
    return footer<S>([id<S>("");0],children)

public function footer<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return footer<S>(attributes,[child])

public function footer<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("footer",attributes,children)

// main
public function main<S>(Node<S> child) -> Node<S>:
    return main<S>([id<S>("");0],[child])

public function main<S>(Node<S>[] children) -> Node<S>:
    return main<S>([id<S>("");0],children)

public function main<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return main<S>(attributes,[child])

public function main<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("main",attributes,children)

// section
public function section<S>(Node<S> child) -> Node<S>:
    return section<S>([id<S>("");0],[child])

public function section<S>(Node<S>[] children) -> Node<S>:
    return section<S>([id<S>("");0],children)

public function section<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return section<S>(attributes,[child])

public function section<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("section",attributes,children)

// article
public function article<S>(Node<S> child) -> Node<S>:
    return article<S>([id<S>("");0],[child])

public function article<S>(Node<S>[] children) -> Node<S>:
    return article<S>([id<S>("");0],children)

public function article<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return article<S>(attributes,[child])

public function article<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("article",attributes,children)

// aside
public function aside<S>(Node<S> child) -> Node<S>:
    return aside<S>([id<S>("");0],[child])

public function aside<S>(Node<S>[] children) -> Node<S>:
    return aside<S>([id<S>("");0],children)

public function aside<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return aside<S>(attributes,[child])

public function aside<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("aside",attributes,children)

// details
public function details<S>(Node<S> child) -> Node<S>:
    return details<S>([id<S>("");0],[child])

public function details<S>(Node<S>[] children) -> Node<S>:
    return details<S>([id<S>("");0],children)

public function details<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return details<S>(attributes,[child])

public function details<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("details",attributes,children)

// dialog
public function dialog<S>(Node<S> child) -> Node<S>:
    return dialog<S>([id<S>("");0],[child])

public function dialog<S>(Node<S>[] children) -> Node<S>:
    return dialog<S>([id<S>("");0],children)

public function dialog<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return dialog<S>(attributes,[child])

public function dialog<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("dialog",attributes,children)

// summary
public function summary<S>(Node<S> child) -> Node<S>:
    return summary<S>([id<S>("");0],[child])

public function summary<S>(Node<S>[] children) -> Node<S>:
    return summary<S>([id<S>("");0],children)

public function summary<S>(Attribute<S>[] attributes, Node<S> child) -> Node<S>:
    return summary<S>(attributes,[child])

public function summary<S>(Attribute<S>[] attributes, Node<S>[] children) -> Node<S>:
    return element("summary",attributes,children)

// ========================================================
// Event coercions
// ========================================================

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
