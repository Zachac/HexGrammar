#!/usr/bin/env perl6
use lib 'src/lib';
use Hex::Spell;

multi MAIN(*@args) {
    my $spell = @args.join;
    my $result = Spell.parse($spell, actions => SpellActions.new);
    
    unless (defined($result) && $result.made) {
        say "The spell fizzles out along with any mana you put into it.";
    }
}

multi MAIN() {
    my $context = SpellActions.new;

    print "> ";
    while my $line = $*IN.get {
        my $result = Spell.parse($line, actions => $context);

        if $result {
            say "  " ~ $context.perl;
        } else {
            say "  The spell fizzles out along with any mana you put into it.";
        }

        print "> ";
    }
}