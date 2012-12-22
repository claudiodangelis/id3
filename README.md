#id3

Dart library to handle ID3 tags of MP3 files.

Go to [project page](http://www.claudiodangelis.it/projects/id3) for extra details.

## Usage

In `pubspec.yaml`:

	dependencies:
	  id3:
	    git: git://github.com/claudiodangelis/id3.git

Then

	import 'package:id3/id3.dart';


### Example usage:

You can run:


	dart example/tags.dart /path/to/song.mp3 


or

	import 'dart:io';
	import 'package:id3/id3.dart';
	
	main(){
	  File theFile = new File('/path/to/my/awesome/song.mp3');
	  Id3 mySong = new Id3(theFile);
	  print('Artist: ${mySong.artist}');
	  print('Title: ${mySong.title}');
	}
	
		
## TODO


- Id3v1
- Id3v1.1
- Id3v2.2
- Id3v2.3
- Images export
- Write support
- Track length
- ID3 version upgrade/downgrade
- Exceptions handling


## BUGS

[GitHub issues](https://github.com/claudiodangelis/id3/issues)

## CREDITS

Songs in examples are composed and performed by the [Stereo Nose Noise](https://soundcloud.com/stereonosenoise) band.

References

- [id3.org](http://id3.org/)

## AUTHORS

 [Claudio "Dawson" d'Angelis](http://www.claudiodangelis.it/about)
 
 
Feel free to fork and contribute.