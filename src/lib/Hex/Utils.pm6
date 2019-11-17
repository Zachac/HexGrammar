
class Utils {
    
    submethod mash(@scalars) {
        my $val = 0;

        for @scalars {
            $val = $val +< 8;
            $val += $_;
        }

        return $val;
    }
}