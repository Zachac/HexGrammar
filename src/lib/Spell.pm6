use Hex::Actions::Filter;

grammar Spell {
    token TOP { <SPELL> [<.SEP> <SPELL>]* <.SEP>? }
    token SPELL { <SCALAR>+ <.SEP> <ACTION> }
    token SEP { X }
    token SCALAR { <[0..9A..F]><[0..9A..F]> }
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

    method TOP($match) {
        return unless $match.pos == $match.orig.chars;
        
        $_.made()() for $match<SPELL>
    }

    method SPELL ($match) {
        my @scalars = ();
        push @scalars, $_.made for $match<SCALAR>;

        $match.make({$match<ACTION>.made()(@scalars)})
    }

    method SCALAR ($match) {
        $match.make(:16($match.Str))
    }

    method ACTION:sym<FILTER>($match) { $match.make(Filter); }
}
