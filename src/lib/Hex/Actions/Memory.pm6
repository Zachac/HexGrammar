
use Hex::Utils;

#| Add value to spell register
class ActionAdd {
    submethod CALL-ME($context, @scalars) {
        $context.register += @scalars.sum;
    }
}

#| Subtract value from spell register
class ActionSub {
    submethod CALL-ME($context, @scalars) {
        $context.register -= @scalars.sum;
    }
}

#| Get value from memory and put it into the register
class ActionGet {
    submethod CALL-ME($context, @scalars) {
        my $mash = Utils.mash(@scalars);
        my $value = $context.memory{$mash};
        
        if defined $value {
            $context.memory{$mash} = 0;
            $context.register = $value;
        } else {
            $context.register = 0;
        }
    }
}

#| Put value from register into memory
class ActionPut {
    submethod CALL-ME($context, @scalars) {
        my $mash = Utils.mash(@scalars);
        $context.memory{$mash} = $context.register;
        $context.register = 0;
    }
}