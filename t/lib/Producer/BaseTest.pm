package Producer::BaseTest;

#
# A trivial little sub-class to test sub-classing the TT::Base producer.
#

use base qw/SQL::Translator::Producer::TT::Base/;

# Make sure we use our new class as the producer
sub produce { return __PACKAGE__->new( translator => shift )->run; };

sub tt_schema { local $/ = undef; \<DATA>; }

sub tt_vars { ( foo => "bar" ); }

sub tt_config { ( INTERPOLATE => 1 ); }

1;

__DATA__
Hello World
Tables: [% schema.get_tables %]
[% table = schema.get_tables.first -%]

$table
------
Fields: $table.field_names.join