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


print "Outil de téléchargement de fonds d'écran Windows\nPar Jean-Yves Roda, c 1999-2015\n\nEntrez l'adresse de la page de téléchargement des fonds d'écrans Windows:\nEx: http://windows.microsoft.com/fr-fr/windows/wallpaper?T1=places\n";
$adress = <>;
chomp $adress;
print "Début du téléchargement.\n";
getstore($adress, 'wallpaper.html');
print "Téléchargement terminé\n";


open(my $fh, '<', 'wallpaper.html') or die "Impossible d'ouvrir le fichier !\nMauvais lien ?\n";

print "Début de lecture du fichier html.\n";

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
			print "Trouvé une image: $imageTitre.\n";
			$index4 = index($imageLine, 'navigationLink');
			$val3 = $index4 + 22;
			$imageLien = substr($imageLine, $val3);
			$index5 = index($imageLien, '>');
			$val4 = $index5 - 1;
			$imageLien = substr($imageLien, 0, $val4);
			print "Lien de téléchargement: $imageLien\n";
			print "Début du téléchargement.\n";
			$file = $imageTitre . ".jpg";
			getstore($imageLien, $file);
			print "Téléchargement terminé.\n";
			$imageLine = substr($imageLine, $val3);
			$index2 = index($imageLine, 'headingM');
		}
	}
}

print "Lecture terminée.\n";

if($verif == 0)
{
	print "Aucune image trouvée !\nMauvais lien ?\n";
}

close $fh;