
#| Filter entities and set spell affect targets
class Filter {
    submethod CALL-ME($context, @scalars) {
        my $method = shift @scalars;

        if $method == 0 {
            my $mashed = Filter.mash(@scalars);
            push $context.filters, { $_.id == $mashed };
        } elsif $method == 10 {
            my $sum = @scalars.sum;
            push $context.filters, { $_.wheight >= $sum }
        } elsif $method == 11 {
            my $sum = @scalars.sum;
            push $context.filters, { $_.wheight <= $sum }
        } else {
            die "You feel the mana splash out into the room.";
        }
    }

    submethod mash(@scalars) {
        my $val = 0;

        for @scalars {
            $val = $val +< 8;
            $val += $_;
        }

        return $val;
    }
}