#!/usr/bin/perl
# vim: set ft=perl:

use strict;
use Test::More 'no_plan'; #tests => 180;
use FindBin qw/$Bin/;

use SQL::Translator;
use SQL::Translator::Parser::SQLite 'parse';
use SQL::Translator::Schema::Constants;

my $file = "$Bin/data/sqlite/create.sql";

{
    local $/;
    open my $fh, "<$file" or die "Can't read file '$file': $!\n";
    my $data = <$fh>;
    my $t = SQL::Translator->new;
    parse($t, $data);

    my $schema = $t->schema;

    my @tables = $schema->get_tables;
    is( scalar @tables, 2, 'Parsed two tables' );

    my $t1 = shift @tables;
    is( $t1->name, 'person', "'Person' table" );

    my $t2 = shift @tables;
    is( $t2->name, 'pet', "'Pet' table" );

    my @views = $schema->get_views;
    is( scalar @views, 1, 'Parsed one views' );

    my @triggers = $schema->get_triggers;
    is( scalar @triggers, 1, 'Parsed one triggers' );
}
