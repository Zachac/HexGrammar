
use Hex::Utils;

#| Filter entities based on their entity_id
class FilterId {
    submethod CALL-ME($context, @scalars) {
        my $mashed = Utils.mash(@scalars);
        push $context.filters, { $_.id == $mashed };
    }
}

#| Filter entities, remove if their wheight is above the sum of the scalars
class FilterWheightAbove {
    submethod CALL-ME($context, @scalars) {
        my $sum = @scalars.sum;
        push $context.filters, { $_.wheight <= $sum }
    }
}

#| Filter entities, remove if their wheight is below the sum of the scalars
class FilterWheightBelow {
    submethod CALL-ME($context, @scalars) {
        my $sum = @scalars.sum;
        push $context.filters, { $_.wheight <= $sum }
    }
}