use Hex::Actions::Filters;
use Hex::Actions::Memory;
use Hex::SpellContext;

grammar Spell {
    token TOP { <SPELL> [<.SEP> <SPELL>]* <.SEP>? }
    token SPELL { <SCALAR>+ <.SEP> <ACTION> }
    token SEP { X }
    token SCALAR { <[0..9A..F]><[0..9A..F]> }
    
    proto token ACTION {*}

    # filter entities affected by the spell
    token ACTION:sym<FILTER_ID> { 728 }
    token ACTION:sym<FILTER_WHEIGHT_ABOVE> { 729 }
    token ACTION:sym<FILTER_WHEIGHT_BELOW> { 72A }

    # add/subtract values from register
    token ACTION:sym<ADD> { AC3 }
    token ACTION:sym<SUB> { AC4 }
    
    # get and put values into memory
    token ACTION:sym<GET> { 778 }
    token ACTION:sym<PUT> { 779 }
    
    # merge/craft things together
    # token ACTION:sym<SACRAFICE> { 8C8 }
    
    # store/load the current spell into the entities in the spell
    token ACTION:sym<EXCRIBE> { 74D }
    token ACTION:sym<INSCRIBE> { 74E }

    # release effects stored up till now
    token ACTION:sym<EXECUTE> { 115 }
}

class SpellActions is SpellContext {

    method TOP($match) {
        # return unless we matched the entire input
        return unless $match.pos == $match.orig.chars;
        
        try {
            $_.made()() for $match<SPELL>;
            CATCH { default { 
                say .message; 
                $match.make(False);
            } }
        }
    }

    method SPELL ($match) {
        my @scalars = ();
        push @scalars, $_.made for $match<SCALAR>;

        $match.make({$match<ACTION>.made()(self, @scalars)})
    }

    method SCALAR ($match) {
        $match.make(:16($match.Str))
    }

    method ACTION:sym<FILTER_ID>($match) { $match.make(FilterId); }
    method ACTION:sym<FILTER_WHEIGHT_ABOVE>($match) { $match.make(FilterWheightAbove); }
    method ACTION:sym<FILTER_WHEIGHT_BELOW>($match) { $match.make(FilterWheightBelow); }
    
    method ACTION:sym<ADD>($match) { $match.make(ActionAdd); }
    method ACTION:sym<SUB>($match) { $match.make(ActionSub); }
    
    method ACTION:sym<GET>($match) { $match.make(ActionGet); }
    method ACTION:sym<PUT>($match) { $match.make(ActionPut); }
}
