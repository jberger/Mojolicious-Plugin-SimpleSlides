use Mojolicious::Lite;

use Test::More;
use Test::Mojo;

plugin 'SimpleSlides';

my $t = Test::Mojo->new;

$t->get_ok('/1')
  ->status_is(200)
  ->text_is( '#main' => 'Hello World' );

$t->get_ok('/2')
  ->status_is(404);

done_testing;

__DATA__

@@ 1.html.ep

Hello World
