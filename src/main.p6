#!/usr/bin/env perl6
use lib 'src/lib';
use Spell;

multi MAIN(*@args) {
    my $spell = @args.join;
    my $result = Spell.parse($spell, actions => SpellActions.new);
    
    unless ($result) {
        say "The spell fizzles out along with any mana you put into it.";
    }
}

multi MAIN() {
    say "usage main.p6 spell"
}