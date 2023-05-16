unit Umd5;

interface
uses Windows;

function md5hash(const s: string): string;

implementation

function md5hash(const s: string): string;
var a: array[0..15] of byte;
  i: integer;

  LenHi, LenLo: longword;
  Index: DWord;
  HashBuffer: array[0..63] of byte;
  CurrentHash: array[0..3] of DWord;

  procedure Burn;
  begin
    LenHi := 0; LenLo := 0;
    Index := 0;
    FillChar(HashBuffer, Sizeof(HashBuffer), 0);
    FillChar(CurrentHash, Sizeof(CurrentHash), 0);
  end;

  procedure Init;
  begin
    Burn;
    CurrentHash[0] := $67452301;
    CurrentHash[1] := $EFCDAB89;
    CurrentHash[2] := $98BADCFE;
    CurrentHash[3] := $10325476;
  end;

  function LRot32(a, b: longword): longword;
  begin
    Result := (a shl b) or (a shr (32 - b));
  end;

  procedure Compress;
  var
    Data: array[0..15] of dword;
    A, B, C, D: dword;
  begin
    Move(HashBuffer, Data, Sizeof(Data));
    A := CurrentHash[0];
    B := CurrentHash[1];
    C := CurrentHash[2];
    D := CurrentHash[3];

    A := B + LRot32(A + (D xor (B and (C xor D))) + Data[0] + $D76AA478, 7);
    D := A + LRot32(D + (C xor (A and (B xor C))) + Data[1] + $E8C7B756, 12);
    C := D + LRot32(C + (B xor (D and (A xor B))) + Data[2] + $242070DB, 17);
    B := C + LRot32(B + (A xor (C and (D xor A))) + Data[3] + $C1BDCEEE, 22);
    A := B + LRot32(A + (D xor (B and (C xor D))) + Data[4] + $F57C0FAF, 7);
    D := A + LRot32(D + (C xor (A and (B xor C))) + Data[5] + $4787C62A, 12);
    C := D + LRot32(C + (B xor (D and (A xor B))) + Data[6] + $A8304613, 17);
    B := C + LRot32(B + (A xor (C and (D xor A))) + Data[7] + $FD469501, 22);
    A := B + LRot32(A + (D xor (B and (C xor D))) + Data[8] + $698098D8, 7);
    D := A + LRot32(D + (C xor (A and (B xor C))) + Data[9] + $8B44F7AF, 12);
    C := D + LRot32(C + (B xor (D and (A xor B))) + Data[10] + $FFFF5BB1, 17);
    B := C + LRot32(B + (A xor (C and (D xor A))) + Data[11] + $895CD7BE, 22);
    A := B + LRot32(A + (D xor (B and (C xor D))) + Data[12] + $6B901122, 7);
    D := A + LRot32(D + (C xor (A and (B xor C))) + Data[13] + $FD987193, 12);
    C := D + LRot32(C + (B xor (D and (A xor B))) + Data[14] + $A679438E, 17);
    B := C + LRot32(B + (A xor (C and (D xor A))) + Data[15] + $49B40821, 22);

    A := B + LRot32(A + (C xor (D and (B xor C))) + Data[1] + $F61E2562, 5);
    D := A + LRot32(D + (B xor (C and (A xor B))) + Data[6] + $C040B340, 9);
    C := D + LRot32(C + (A xor (B and (D xor A))) + Data[11] + $265E5A51, 14);
    B := C + LRot32(B + (D xor (A and (C xor D))) + Data[0] + $E9B6C7AA, 20);
    A := B + LRot32(A + (C xor (D and (B xor C))) + Data[5] + $D62F105D, 5);
    D := A + LRot32(D + (B xor (C and (A xor B))) + Data[10] + $02441453, 9);
    C := D + LRot32(C + (A xor (B and (D xor A))) + Data[15] + $D8A1E681, 14);
    B := C + LRot32(B + (D xor (A and (C xor D))) + Data[4] + $E7D3FBC8, 20);
    A := B + LRot32(A + (C xor (D and (B xor C))) + Data[9] + $21E1CDE6, 5);
    D := A + LRot32(D + (B xor (C and (A xor B))) + Data[14] + $C33707D6, 9);
    C := D + LRot32(C + (A xor (B and (D xor A))) + Data[3] + $F4D50D87, 14);
    B := C + LRot32(B + (D xor (A and (C xor D))) + Data[8] + $455A14ED, 20);
    A := B + LRot32(A + (C xor (D and (B xor C))) + Data[13] + $A9E3E905, 5);
    D := A + LRot32(D + (B xor (C and (A xor B))) + Data[2] + $FCEFA3F8, 9);
    C := D + LRot32(C + (A xor (B and (D xor A))) + Data[7] + $676F02D9, 14);
    B := C + LRot32(B + (D xor (A and (C xor D))) + Data[12] + $8D2A4C8A, 20);

    A := B + LRot32(A + (B xor C xor D) + Data[5] + $FFFA3942, 4);
    D := A + LRot32(D + (A xor B xor C) + Data[8] + $8771F681, 11);
    C := D + LRot32(C + (D xor A xor B) + Data[11] + $6D9D6122, 16);
    B := C + LRot32(B + (C xor D xor A) + Data[14] + $FDE5380C, 23);
    A := B + LRot32(A + (B xor C xor D) + Data[1] + $A4BEEA44, 4);
    D := A + LRot32(D + (A xor B xor C) + Data[4] + $4BDECFA9, 11);
    C := D + LRot32(C + (D xor A xor B) + Data[7] + $F6BB4B60, 16);
    B := C + LRot32(B + (C xor D xor A) + Data[10] + $BEBFBC70, 23);
    A := B + LRot32(A + (B xor C xor D) + Data[13] + $289B7EC6, 4);
    D := A + LRot32(D + (A xor B xor C) + Data[0] + $EAA127FA, 11);
    C := D + LRot32(C + (D xor A xor B) + Data[3] + $D4EF3085, 16);
    B := C + LRot32(B + (C xor D xor A) + Data[6] + $04881D05, 23);
    A := B + LRot32(A + (B xor C xor D) + Data[9] + $D9D4D039, 4);
    D := A + LRot32(D + (A xor B xor C) + Data[12] + $E6DB99E5, 11);
    C := D + LRot32(C + (D xor A xor B) + Data[15] + $1FA27CF8, 16);
    B := C + LRot32(B + (C xor D xor A) + Data[2] + $C4AC5665, 23);

    A := B + LRot32(A + (C xor (B or (not D))) + Data[0] + $F4292244, 6);
    D := A + LRot32(D + (B xor (A or (not C))) + Data[7] + $432AFF97, 10);
    C := D + LRot32(C + (A xor (D or (not B))) + Data[14] + $AB9423A7, 15);
    B := C + LRot32(B + (D xor (C or (not A))) + Data[5] + $FC93A039, 21);
    A := B + LRot32(A + (C xor (B or (not D))) + Data[12] + $655B59C3, 6);
    D := A + LRot32(D + (B xor (A or (not C))) + Data[3] + $8F0CCC92, 10);
    C := D + LRot32(C + (A xor (D or (not B))) + Data[10] + $FFEFF47D, 15);
    B := C + LRot32(B + (D xor (C or (not A))) + Data[1] + $85845DD1, 21);
    A := B + LRot32(A + (C xor (B or (not D))) + Data[8] + $6FA87E4F, 6);
    D := A + LRot32(D + (B xor (A or (not C))) + Data[15] + $FE2CE6E0, 10);
    C := D + LRot32(C + (A xor (D or (not B))) + Data[6] + $A3014314, 15);
    B := C + LRot32(B + (D xor (C or (not A))) + Data[13] + $4E0811A1, 21);
    A := B + LRot32(A + (C xor (B or (not D))) + Data[4] + $F7537E82, 6);
    D := A + LRot32(D + (B xor (A or (not C))) + Data[11] + $BD3AF235, 10);
    C := D + LRot32(C + (A xor (D or (not B))) + Data[2] + $2AD7D2BB, 15);
    B := C + LRot32(B + (D xor (C or (not A))) + Data[9] + $EB86D391, 21);

    Inc(CurrentHash[0], A);
    Inc(CurrentHash[1], B);
    Inc(CurrentHash[2], C);
    Inc(CurrentHash[3], D);
    Index := 0;
    FillChar(HashBuffer, Sizeof(HashBuffer), 0);
  end;


  procedure Update(const Buffer; Size: longword);
  var
    PBuf: ^byte;
  begin
    Inc(LenHi, Size shr 29);
    Inc(LenLo, Size * 8);
    if LenLo < (Size * 8) then
      Inc(LenHi);

    PBuf := @Buffer;
    while Size > 0 do
    begin
      if (Sizeof(HashBuffer) - Index) <= DWord(Size) then
      begin
        Move(PBuf^, HashBuffer[Index], Sizeof(HashBuffer) - Index);
        Dec(Size, Sizeof(HashBuffer) - Index);
        Inc(PBuf, Sizeof(HashBuffer) - Index);
        Compress;
      end
      else
      begin
        Move(PBuf^, HashBuffer[Index], Size);
        Inc(Index, Size);
        Size := 0;
      end;
    end;
  end;

  procedure Final(var Digest);
  begin
    HashBuffer[Index] := $80;
    if Index >= 56 then Compress;
    PDWord(@HashBuffer[56])^ := LenLo;
    PDWord(@HashBuffer[60])^ := LenHi;
    Compress;
    Move(CurrentHash, Digest, Sizeof(CurrentHash));
    Burn;
  end;


begin
  Init;
  Update(s[1], Length(s));
  Final(a);
  result := '';
  for i := 0 to 15 do
    result := result + IntToHex(a[i], 2);
  Burn;
end;
end.
