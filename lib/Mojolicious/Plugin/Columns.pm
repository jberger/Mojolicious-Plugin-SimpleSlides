package Mojolicious::Plugin::Columns;

our $VERSION = '0.01';
$VERSION = eval $VERSION;

use Mojo::Base 'Mojolicious::Plugin';

has 'column_template'  => 'column_plugin_column';
has 'columns_template' => 'column_plugin_columns';

has 'column_width';

has 'vertical_align' => 'top';

sub register {
  my ($self, $app, $conf) = @_;

  push @{ $app->renderer->classes }, __PACKAGE__;

  $self->$_($conf->{$_}) for keys( $conf || {} );

  $app->helper( columns => sub {
    return $self unless @_ > 1;
    return $self->columns(@_);
  });
  $app->helper( column => sub { $self->column(@_) } );
}

sub column {
  my $plugin = shift;
  my $c = shift;

  my $content = pop || return;
  $content = ref $content ? $content->() : $content;

  my %args = @_;
  my $style = '';

  my $width = delete $args{width} // $plugin->column_width;        #/# highlight fix
  if ( $width ) {
    $style .= "width: $width%;";
  }

  if ( my $align = delete $args{vertical_align} || $plugin->vertical_align ) {
    $style .= "vertical-align: $align;";
  }
 
  return $c->render( 
    partial => 1, 
    'columns.style' => $style,
    'columns.column' => $content, 
    template => $plugin->column_template,
  );
}

sub columns {
  my $plugin = shift;
  my $c = shift;
  return unless @_;
  my $content = shift->();
  return $c->render( 
    partial => 1, 
    'columns.content' => $content,
    template => $plugin->columns_template,
  );
}

1;

__DATA__

@@ column_plugin_column.html.ep
% my @tag = qw/div class column/;
% if ( my $style = stash 'columns.style' ) { push @tag, style => $style } 
%= tag @tag, begin
  %= stash 'columns.column'
% end

@@ column_plugin_columns.html.ep
<div class="columns-wrapper">
  <div class="columns">
    %= stash 'columns.content'
  </div>
</div>

