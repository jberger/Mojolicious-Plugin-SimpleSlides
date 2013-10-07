use Mojolicious::Lite;
use Test::More;
use Test::Mojo;

plugin 'Columns';

any '/' => 'columns';

isa_ok app->columns, 'Mojolicious::Plugin::Columns', 'columns helper returns instance without args';

my $t = Test::Mojo->new;

$t->get_ok('/')
  ->text_is('.columns .column:nth-of-type(1)', 'Hello')
  ->text_is('.columns .column:nth-of-type(2)', 'World');

done_testing;

__DATA__

@@ columns.html.ep

%= columns begin
  %= column begin
    Hello
  % end
  %= column begin
    World
  % end
% end
