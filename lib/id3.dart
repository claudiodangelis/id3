library id3;

import 'dart:io';

class Id3{

  final List<String> id3versions = ['No ID3', 'ID3v1','ID3v2.2','ID3v2.3','ID3v2.4'];
  final List<String> id3v22Frames = ['BUF','CNT','COM','CRA','CRM','ETC','EQU','GEO','IPL','LNK','MCI','MLL','PIC','POP','REV','RVA','SLT','STC','TAL','TBP','TCM','TCO','TCR','TDA','TDY','TEN','TFT','TIM','TKE','TLA','TLE','TMT','TOA','TOF','TOL','TOR','TOT','TP1','TP2','TP3','TP4','TPA','TPB','TRC','TRD','TRK','TSI','TSS','TT1','TT2','TT3','TXT','TXX','TYE','UFI','ULT','WAF','WAR','WAS','WCP','WPB','WXX'];
  final List<String> id3v23Frames = ['AENC','APIC','ASPI','COMM','COMR','ENCR','EQU2','ETCO','GEOB','GRID','LINK','MCDI','MLLT','OWNE','PRIV','PCNT','POPM','POSS','RBUF','RVA2','RVRB','SEEK','SIGN','SYLT','SYTC','TALB','TBPM','TCOM','TCON','TCOP','TDEN','TDLY','TDOR','TDRC','TDRL','TDTG','TENC','TEXT','TFLT','TIPL','TIT1','TIT2','TIT3','TKEY','TLAN','TLEN','TMCL','TMED','TMOO','TOAL','TOFN','TOLY','TOPE','TOWN','TPE1','TPE2','TPE3','TPE4','TPOS','TPRO','TPUB','TRCK','TRSN','TRSO','TSOA','TSOP','TSOT','TSRC','TSSE','TSST','TXXX','UFID','USER','USLT','WCOM','WCOP','WOAF','WOAR','WOAS','WORS','WPAY','WPUB','WXXX'];
  final List<List<String>> framesList = [
    [],
    [],
    ['BUF','CNT','COM','CRA','CRM','ETC','EQU','GEO','IPL','LNK','MCI','MLL','PIC','POP','REV','RVA','SLT','STC','TAL','TBP','TCM','TCO','TCR','TDA','TDY','TEN','TFT','TIM','TKE','TLA','TLE','TMT','TOA','TOF','TOL','TOR','TOT','TP1','TP2','TP3','TP4','TPA','TPB','TRC','TRD','TRK','TSI','TSS','TT1','TT2','TT3','TXT','TXX','TYE','UFI','ULT','WAF','WAR','WAS','WCP','WPB','WXX'],
    [],
    ['AENC','APIC','ASPI','COMM','COMR','ENCR','EQU2','ETCO','GEOB','GRID','LINK','MCDI','MLLT','OWNE','PRIV','PCNT','POPM','POSS','RBUF','RVA2','RVRB','SEEK','SIGN','SYLT','SYTC','TALB','TBPM','TCOM','TCON','TCOP','TDEN','TDLY','TDOR','TDRC','TDRL','TDTG','TENC','TEXT','TFLT','TIPL','TIT1','TIT2','TIT3','TKEY','TLAN','TLEN','TMCL','TMED','TMOO','TOAL','TOFN','TOLY','TOPE','TOWN','TPE1','TPE2','TPE3','TPE4','TPOS','TPRO','TPUB','TRCK','TRSN','TRSO','TSOA','TSOP','TSOT','TSRC','TSSE','TSST','TXXX','UFID','USER','USLT','WCOM','WCOP','WOAF','WOAR','WOAS','WORS','WPAY','WPUB','WXXX'],

    ];

  int id3v;
  int headerPadding;

  String artist;
  String title;
  String album;
  String year;
  Map<String,String> data = {};


  Map<String,List<int>> framesIndex = {};
  Map<String,String> frames = {};

  Id3(File theFile){
    if( ! theFile.name.toLowerCase().endsWith('.mp3')){
      throw new ExpectException('Could not read ID3 tags from a non-mp3 file.');
    }
    List<int> bc = theFile.readAsBytesSync();
      // bc = binaryContents
      if(new String.fromCharCodes(bc.getRange(0, 3)) == 'ID3' ){
        // Fourth byte determines revision number
        switch(bc[3]){
          case 2:
            this.id3v = 2;
            headerPadding = 3;
            break;
          case 3:
            this.id3v = 3;
            break;
          case 4:
            this.id3v = 4;
            headerPadding = 4;
            break;
        }

        String prevFrame = null;

        for (var i = 10; i<bc.length ; i++ ){
         if(bc[i] == 0 && bc[i+1] == 0  && bc[i+3]==0){
           var frame = new String.fromCharCodes(bc.getRange(i-headerPadding-1,headerPadding));
           if( ! framesList[id3v].contains(frame) ){
             print(i);
             break;
           }
           if(prevFrame!=null ){
             framesIndex[prevFrame].add(i-headerPadding);
             int start = framesIndex[prevFrame][0] + 7;
             int end = framesIndex[prevFrame][1] - start;
             frames[prevFrame]=new String.fromCharCodes(bc.getRange(start,end));
             }
           framesIndex[frame]=[];
           framesIndex[frame].add(i-headerPadding);
           prevFrame=frame;
         }
       }

        for (String frame in frames.keys){
          this.data[frame]=frames[frame];
        }
      }
    }
}