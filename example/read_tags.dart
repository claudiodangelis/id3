import 'dart:io';
import 'package:id3/id3.dart';


main(){
  Directory currentDir = new Directory.current();
  var d = new Directory.fromPath(new Path('${currentDir.path}/example'));
  DirectoryLister lister = d.list();

  lister.onFile = (String filename) {
    if(filename.toLowerCase().endsWith('.mp3')){
      File theFile = new File(filename);

      Id3 mySong = new Id3(theFile);
      print(filename);
      for ( var frame in mySong.data.keys){
        print(frame);
        print(mySong.data[frame]);
      }
    }
  };



}