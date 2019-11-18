

class SpellContext is rw {
    has @.filters;
    has $.register is rw;
    has %.memory;

    method TWEAK {
        $.register = 0 unless defined self.register;
    }

}