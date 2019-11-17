
class Filter {
    submethod CALL-ME(@scalar) {
        say "Filtering " ~ @scalar.perl
    }
}