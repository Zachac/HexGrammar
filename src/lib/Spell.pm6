

grammar Spell {
    token TOP { <SPELL> [<.SEP> <SPELL>]* }
    token SPELL { <SCALAR> <.SEP> <ACTION> }
    token SEP { X }
    token SCALAR { <DIGIT>+ }
    token DIGIT { <[0..9A..F]><[0..9A..F]> }
    proto token ACTION {*}
    token ACTION:sym<FILTER> { 728 }
    token ACTION:sym<INVERT> { 2DE }
    token ACTION:sym<LOAD> { 778 }
    token ACTION:sym<RESET> { F2E }
    token ACTION:sym<DUMP> { 115 }
    token ACTION:sym<ADD> { AC3 }
    token ACTION:sym<SUB> { FEB }
    token ACTION:sym<COMBINE> { 8C8 }
    token ACTION:sym<EXCRIBE> { 2F8 }
    token ACTION:sym<INSCRIBE> { 74E }
}

class SpellActions {
    has @scale;

    method SCALAR ($match) {
        @scale = ();
        push @scale, :16($_.Str) for $match<DIGIT>;
    }

    method ACTION:sym<FILTER>($match) {
        say "filtering with " ~ @scale.perl;
    }
}
