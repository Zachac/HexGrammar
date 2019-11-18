use World::Element::Element;
use World::Entities::Entity;
use Hex::SpellContext;

class Luminous is Element {

    method effect(SpellContext $context, Entity $e) {
        $e.health += $context.register;
    }
}
