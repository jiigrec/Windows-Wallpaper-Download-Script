#use stricts;
use warnings;
use LWP::Simple;
my $imageTitre;
my $index;
my $base;
my $index2;
my $ligne;
my $val1;
my $imageLine;
my $index3;
my $val2;
my $index4;
my $imageLien;
my $val3;
my $index5;
my $file;
my $val4;
my $adress;
my $verif = 0;
my $osname = $^O;
my $path;


if ($osname = "MSWin32")
{
	$path = "Wallpapers\\";
}
else
{
	$path = "Wallpapers/"
}


print "Windows Wallpapers download tool\nBy Jean-Yves Roda, c 1999-2015\n\nEnter the windows wallpapers page link:\nEx: http://windows.microsoft.com/en-us/windows/wallpaper?T1=places\n";
$adress = <>;
chomp $adress;
print "Fetching page.\n";
getstore($adress, 'wallpaper.html');
print "Fetch successful.\n";
open(my $fh, '<', 'wallpaper.html') or die "Cannot open file !\nBad link ?\n";
print "Reading page ...\n";
while (my $line = <$fh>)
{
	$index = index($line, 'galleryGrid');
	$base = -1;
	if ($index != $base)
	{
		$verif = 1;
		$imageLine = $line;
		$index2 = index($line, 'headingM');
		while($index2 != $base)
		{
			$val1 = $index2 + 10;
			$imageTitre = substr($imageLine, $val1);
			$index3 = index($imageTitre, '>');
			$val2 = $index3 - 4;
			$imageTitre = substr($imageTitre, 0, $val2);
			print "found image: $imageTitre.\n";
			$index4 = index($imageLine, 'navigationLink');
			$val3 = $index4 + 22;
			$imageLien = substr($imageLine, $val3);
			$index5 = index($imageLien, '>');
			$val4 = $index5 - 1;
			$imageLien = substr($imageLien, 0, $val4);
			#print "Lien de téléchargement: $imageLien\n";
			print "Downloading ...\n";
			$file = $path . $imageTitre . ".jpg";
			getstore($imageLien, $file);
			print "Downloaded.\n";
			$imageLine = substr($imageLine, $val3);
			$index2 = index($imageLine, 'headingM');
		}
	}
}

print "Reading done.\n";

if($verif == 0)
{
	print "No pictures found !\nBad link ?\n";
}
close $fh;


