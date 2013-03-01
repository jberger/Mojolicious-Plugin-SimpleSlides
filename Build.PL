#!/usr/bin/env perl

use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
  module_name        => 'Mojolicious::Plugin::SimpleSlides',
  dist_author        => 'Joel Berger <joel.a.berger@gmail.com>',
  license            => 'perl',
  configure_requires => { 
    'Module::Build' => 0.36
  },
  share_dir => 'lib/Mojolicious/Plugin/SimpleSlides/public',
  requires => {
    'Mojolicious' => '3.0',
    'File::ShareDir' => 0,
  },
);

$build->create_build_script;
