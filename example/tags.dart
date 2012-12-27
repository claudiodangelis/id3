import 'dart:io';
import 'package:id3/id3.dart';

main(){
  var mp3file = new File(new Options().arguments[0]);
  Id3 mySong = new Id3(mp3file);
  print('Id3 version: ${mySong.versions[mySong.id3v]}');
  print('Tag size: ${mySong.tagSize}');
  print('Artist: ${mySong.artist}');
  print('Title: ${mySong.title}');
}