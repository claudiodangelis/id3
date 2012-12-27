part of id3;

class Id3{

   final List<String> versions = ['No ID3', 'ID3v1','ID3v2.2','ID3v2.3','ID3v2.4'];
   final List<String> framesExpr = [
    '',
    '',
    'BUF|CNT|COM|CRA|CRM|ETC|EQU|GEO|IPL|LNK|MCI|MLL|PIC|POP|REV|RVA|SLT|STC|TAL|TBP|TCM|TCO|TCR|TDA|TDY|TEN|TFT|TIM|TKE|TLA|TLE|TMT|TOA|TOF|TOL|TOR|TOT|TP1|TP2|TP3|TP4|TPA|TPB|TRC|TRD|TRK|TSI|TSS|TT1|TT2|TT3|TXT|TXX|TYE|UFI|ULT|WAF|WAR|WAS|WCP|WPB|WXX',
    'AENC|APIC|COMM|COMR|ENCR|EQUA|ETCO|GEOB|GRID|IPLS|LINK|MCDI|MLLT|OWNE|PRIV|PCNT|POPM|POSS|RBUF|RVAD|RVRB|SYLT|SYTC|TALB|TBPM|TCOM|TCON|TCOP|TDAT|TDLY|TENC|TEXT|TFLT|TIME|TIT1|TIT2|TIT3|TKEY|TLAN|TLEN|TMED|TOAL|TOFN|TOLY|TOPE|TORY|TOWN|TPE1|TPE2|TPE3|TPE4|TPOS|TPUB|TRCK|TRDA|TRSN|TRSO|TSIZ|TSRC|TSSE|TYER|TXXX|UFID|USER|USLT|WCOM|WCOP|WOAF|WOAR|WOAS|WORS|WPAY|WPUB|WXXX',
    'AENC|APIC|AS PI|COMM|COMR|ENCR|EQU2|ETCO|GEOB|GRID|LINK|MCDI|MLLT|OWNE|PRIV|PCNT|POPM|POSS|RBUF|RVA2|RVRB|SEEK|SIGN|SYLT|SYTC|TALB|TBPM|TCOM|TCON|TCOP|TDEN|TDLY|TDOR|TDRC|TDRL|TDTG|TENC|TEXT|TFLT|TIPL|TIT1|TIT2|TIT3|TKEY|TLAN|TLEN|TMCL|TMED|TMOO|TOAL|TOFN|TOLY|TOPE|TOWN|TPE1|TPE2|TPE3|TPE4|TPOS|TPRO|TPUB|TRCK|TRSN|TRSO|TSOA|TSOP|TSOT|TSRC|TSSE|TSST|TXXX|UFID|USER|USLT|WCOM|WCOP|WOAF|WOAR|WOAS|WORS|WPAY|WPUB|WXXX',

    ];

  int id3v;

  String artist;
  String title;

  int tagSize;

  Map<String,String> data = {};

  Id3(File theFile){
    if( ! theFile.name.toLowerCase().endsWith('.mp3')){
      throw new ExpectException('Could not read ID3 tags from a non-mp3 file.');
    }
    List<int> bc = theFile.readAsBytesSync();
      // bc = binaryContents
      if(new String.fromCharCodes(bc.getRange(0, 3)) == 'ID3' ){

        // Fourth byte determines revision number

        this.id3v = bc[3];

        this.tagSize = bc[9] & 0x7f | ((bc[8]& 0x7f) << 7) | ((bc[7]& 0x7f) << 14) | ((bc[6] & 0x7f) << 21);
        String tag = new String.fromCharCodes(bc.getRange(0, tagSize));
        RegExp re = new RegExp(framesExpr[id3v]);
        List<String> chunks = tag.split(re);

        int cnt = 1;
        for ( var match in re.allMatches(tag)){
          this.data[tag.substring(match.start, match.end)] = chunks[cnt];
          cnt++;
        }

        switch(this.id3v){

          case 2:
            this.artist = this.data['TP1'];
            this.title = this.data['TT2'];
            break;

          case 3:
            this.artist = this.data['TPE1'];
            this.title= this.data['TIT2'];
            break;

          case 4:
            this.artist = this.data['TPE1'];
            this.title= this.data['TIT2'];
            break;
        }
      } else if (new String.fromCharCodes(bc.getRange(bc.length-128, 3))=='TAG'){
;
        String tag = new String.fromCharCodes(bc.getRange(bc.length-128, 128));
        this.id3v = 1;
        this.title = tag.substring(3, 33);
        this.artist= tag.substring(33, 63);

        this.tagSize = 128;


      } else {
        this.id3v = 0;
      }
    }
}