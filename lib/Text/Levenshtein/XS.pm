package Text::Levenshtein::XS;
use 5.008_008;

require Exporter;
*import = \&Exporter::import;

$Text::Levenshtein::XS::VERSION = '0.1';
@Text::Levenshtein::XS::EXPORT_OK = qw/distance/;

eval {
    require XSLoader;
    XSLoader::load(__PACKAGE__, $Text::Levenshtein::XS::VERSION);
    1;
} or do {
    require DynaLoader;
    DynaLoader::bootstrap(__PACKAGE__, $Text::Levenshtein::XS::VERSION);
    sub dl_load_flags {0} # Prevent DynaLoader from complaining and croaking
};




sub distance {
    # shift shift is faster than $_[0] $_[1]
    return Text::Levenshtein::XS::xs_distance( [unpack('U*', shift)], [unpack('U*',shift)]);
}

1;

=encoding utf8

=head1 NAME

Text::Levenshtein::XS - XS Levenshtein edit distance.

=head1 SYNOPSIS

	use Text::Levenshtein::XS qw/distance/;

	print distance('Neil','Niel');
	# prints 2

=head1 DESCRIPTION

Returns the number of edits (insert,delete,substitute) required to turn the source string into the target string. XS implementation (requires a C compiler). Works correctly with utf8.

	use Text::Levenshtein::XS qw/distance/;
	use utf8;

	distance('ⓕⓞⓤⓡ','ⓕⓤⓞⓡ'), 
	# prints 2

=head1 METHODS

=head2 distance

Arguments: source string and target string.


Returns: int that represents the edit distance between the two argument. Stops calculations and returns -1 if max distance is set and reached.

Wrapper function to take the edit distance between a source and target string using XS algorithm implementation.

	use Text::Levenshtein::XS qw/distance/;
	print distance('Neil','Niel');
	# prints 2

=head1 NOTES

Drop in replacement for L<Text::LevenshteinXS>

=back

=head1 SEE ALSO

=over 4

=item * L<Text::Levenshtein::Damerau>

=item * L<Text::Levenshtein::Damerau::PP>

=item * L<Text::Levenshtein::Damerau::XS>

=item * L<Text::Fuzzy>

=back

=head1 BUGS

Please report bugs to:

L<https://rt.cpan.org/Public/Dist/Display.html?Name=Text-Levenshtein-XS>

=head1 AUTHOR

Nick Logan <F<ugexe@cpan.com>>

=head1 LICENSE AND COPYRIGHT

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut