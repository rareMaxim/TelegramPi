unit TelegaPi.Keyboard;

interface

uses
  System.JSON,
  System.Generics.Collections, System.SysUtils;

type
  TtgKeyAbstract = class abstract
  private
    FKey: TJSONObject;
  public
    constructor Create; virtual;
  end;

  TtgKeyInline = class(TtgKeyAbstract)
  public
    constructor Create(const AText, AData: string); reintroduce;
  end;

  TtgKeyboardButton = class(TtgKeyAbstract)
  public
    constructor Create(const AText: string); reintroduce;
    function RequestContact(const ARequestContact: Boolean): TtgKeyboardButton;
  end;

  ITgKeyboardCore<TKey: class> = interface
    ['{DE10B767-9493-4AE1-85F6-F4B7D00E5B8F}']
    function Wrap(AWrap: TFunc<Integer, Integer, TKey, Boolean>): ITgKeyboardCore<TKey>;
    function ToJson: string;
    procedure AddButton(ABtn: TKey);
    procedure AddRow;
  end;

  TtgKeyboardCore<TKey: class> = class(TInterfacedObject, ITgKeyboardCore<TKey>)
  private
    FKeys: TObjectList<TObjectList<TKey>>;
    FFields: TJSONObject;
    FWrap: TFunc<Integer, Integer, TKey, Boolean>;
  protected
    procedure ReBuild;
    procedure LoadBtn(AKeys: TArray < TArray < TKey >> );
  public
    procedure AddButton(ABtn: TKey);
    procedure AddRow;
    constructor Create(AKeys: TArray < TArray < TKey >> ); overload;
    // row, index, name
    function Wrap(AWrap: TFunc<Integer, Integer, TKey, Boolean>): ITgKeyboardCore<TKey>;
    destructor Destroy; override;
    function ToJson: string; virtual;
  end;

  ItgReplyKb = interface(ITgKeyboardCore<TtgKeyboardButton>)
    ['{17FA1D4E-35E6-4E79-A74E-0A85FC98B825}']
    function IsPersistent(const AIsPersistent: Boolean): ItgReplyKb;
    function ResizeKeyboard(const AResizeKeyboard: Boolean): ItgReplyKb;
    function OneTimeKeyboard(const AOneTimeKeyboard: Boolean): ItgReplyKb;
    function InputFieldPlaceholder(const APlaceholder: string): ItgReplyKb;
    function Selective(const ASelective: Boolean): ItgReplyKb;
    function ToJson: string;
  end;

  TtgReplyKb = class(TtgKeyboardCore<TtgKeyboardButton>, ItgReplyKb)
  private
    function KeyboardAsJson: TJSONArray;
  public
    function IsPersistent(const AIsPersistent: Boolean): ItgReplyKb;
    function ResizeKeyboard(const AResizeKeyboard: Boolean): ItgReplyKb;
    function OneTimeKeyboard(const AOneTimeKeyboard: Boolean): ItgReplyKb;
    function InputFieldPlaceholder(const APlaceholder: string): ItgReplyKb;
    function Selective(const ASelective: Boolean): ItgReplyKb;

    function ToJson: string; override;
  end;

  ItgInlineKb = interface(ITgKeyboardCore<TtgKeyInline>)
    ['{7DA2CF80-752A-4FAD-ACE9-77C33D241D1D}']
  end;

  TtgInlineKb = class(TtgKeyboardCore<TtgKeyInline>, ItgInlineKb)
  private
    FFields: TJSONObject;
    function KeyboardAsJson: TJSONArray;
  public
    constructor Create(AKeys: TArray < TArray < TtgKeyInline >> );
    destructor Destroy; override;
    function ToJson: string; override;
  end;

  TtgKeyboard = class
  public
    class function InlineKb(AKeys: TArray < TArray < TtgKeyInline >> ): ItgInlineKb;
    class function ReplyKb(AKeys: TArray < TArray < TtgKeyboardButton >> ): ItgReplyKb; overload;
    class function ReplyKb(AKeys: TArray < TArray < string >> ): ItgReplyKb; overload;
  end;

implementation

{ TtgKeyboard }
class function TtgKeyboard.InlineKb(AKeys: TArray < TArray < TtgKeyInline >> ): ItgInlineKb;
begin
  Result := TtgInlineKb.Create(AKeys);
end;

class function TtgKeyboard.ReplyKb(AKeys: TArray < TArray < TtgKeyboardButton >> ): ItgReplyKb;
begin
  Result := TtgReplyKb.Create(AKeys);
end;

class function TtgKeyboard.ReplyKb(AKeys: TArray < TArray < string >> ): ItgReplyKb;
begin
  Result := TtgReplyKb.Create([[]]);
  for var I := Low(AKeys) to High(AKeys) do
  begin
    Result.AddRow;
    for var J := Low(AKeys[I]) to High(AKeys[I]) do
      Result.AddButton(TtgKeyboardButton.Create(AKeys[I, J]))
  end;
end;

{ TtgKeyInline }
constructor TtgKeyInline.Create(const AText, AData: string);
begin
  inherited Create;
  FKey.AddPair('text', AText);
  FKey.AddPair('callback_data', AData);
end;

{ TtgInlineKb }

function TtgInlineKb.KeyboardAsJson: TJSONArray;
begin
  Result := TJSONArray.Create;
  for var I := 0 to FKeys.Count - 1 do
  begin
    var
    LJBtns := TJSONArray.Create;
    for var J := 0 to FKeys[I].Count - 1 do
    begin
      LJBtns.Add(FKeys[I].Items[J].FKey);
    end;
    Result.Add(LJBtns);
  end;
end;

constructor TtgInlineKb.Create(AKeys: TArray < TArray < TtgKeyInline >> );
begin
  FKeys := TObjectList < TObjectList < TtgKeyInline >>.Create();
  for var I := Low(AKeys) to High(AKeys) do
  begin
    FKeys.Add(TObjectList<TtgKeyInline>.Create());
    FKeys.Last.AddRange(AKeys[I]);
  end;
  FFields := TJSONObject.Create();
end;

destructor TtgInlineKb.Destroy;
begin
  FFields.Free;
  FKeys.Free;
  inherited Destroy;
end;

function TtgInlineKb.ToJson: string;
begin
  FFields.AddPair('inline_keyboard', KeyboardAsJson);
  Result := inherited ToJson;
end;

constructor TtgKeyboardButton.Create(const AText: string);
begin
  inherited Create;
  FKey.AddPair('text', AText);
end;

{ TtgReplyKb }

function TtgReplyKb.KeyboardAsJson: TJSONArray;
begin
  Result := TJSONArray.Create;
  for var I := 0 to FKeys.Count - 1 do
  begin
    var
    LJBtns := TJSONArray.Create;
    for var J := 0 to FKeys[I].Count - 1 do
    begin
      LJBtns.Add(FKeys[I].Items[J].FKey);
    end;
    Result.Add(LJBtns);
  end;
end;

function TtgReplyKb.OneTimeKeyboard(const AOneTimeKeyboard: Boolean): ItgReplyKb;
begin
  FFields.AddPair('one_time_keyboard', TJSONBool.Create(AOneTimeKeyboard));
  Result := Self;
end;

function TtgReplyKb.ResizeKeyboard(const AResizeKeyboard: Boolean): ItgReplyKb;
begin
  FFields.AddPair('resize_keyboard', TJSONBool.Create(AResizeKeyboard));
  Result := Self;
end;

function TtgReplyKb.Selective(const ASelective: Boolean): ItgReplyKb;
begin
  FFields.AddPair('selective', TJSONBool.Create(ASelective));
  Result := Self;
end;

function TtgReplyKb.InputFieldPlaceholder(const APlaceholder: string): ItgReplyKb;
begin
  FFields.AddPair('input_field_placeholder', TJSONString.Create(APlaceholder));
  Result := Self;
end;

function TtgReplyKb.IsPersistent(const AIsPersistent: Boolean): ItgReplyKb;
begin
  FFields.AddPair('is_persistent', TJSONBool.Create(AIsPersistent));
  Result := Self;
end;

function TtgReplyKb.ToJson: string;
begin
  if Assigned(FWrap) then
    inherited ReBuild;
  FFields.AddPair('keyboard', KeyboardAsJson);
  Result := inherited ToJson;
end;

function TtgKeyboardButton.RequestContact(const ARequestContact: Boolean): TtgKeyboardButton;
begin
  FKey.AddPair('request_contact', TJSONBool.Create(ARequestContact));
  Result := Self;
end;

{ TtgKeyboardCore }

procedure TtgKeyboardCore<TKey>.AddButton(ABtn: TKey);
begin
  if FKeys.Count = 0 then
    FKeys.Add(TObjectList<TKey>.Create);
  FKeys.Last.Add(ABtn);
end;

constructor TtgKeyboardCore<TKey>.Create(AKeys: TArray < TArray < TKey >> );
begin
  FKeys := TObjectList < TObjectList < TKey >>.Create();
  LoadBtn(AKeys);
  FFields := TJSONObject.Create();
end;

procedure TtgKeyboardCore<TKey>.AddRow;
begin
  if (FKeys.Count = 0) or (FKeys.Last.Count > 0) then
    FKeys.Add(TObjectList<TKey>.Create);
end;

destructor TtgKeyboardCore<TKey>.Destroy;
begin
  FKeys.Free;
  FFields.Free;
  inherited;
end;

procedure TtgKeyboardCore<TKey>.LoadBtn(AKeys: TArray < TArray < TKey >> );
begin
  for var I := Low(AKeys) to High(AKeys) do
  begin
    FKeys.Add(TObjectList<TKey>.Create());
    FKeys.Last.AddRange(AKeys[I]);
  end;
end;

procedure TtgKeyboardCore<TKey>.ReBuild;
var
  LAllKeys: TArray<TKey>;
begin
  for var I := 0 to FKeys.Count - 1 do
    LAllKeys := LAllKeys + FKeys[I].ToArray;
  FKeys.Clear;
  FKeys.Add(TObjectList<TKey>.Create);
  for var I := Low(LAllKeys) to High(LAllKeys) do
    if FKeys.Last.Count = 0 then
      FKeys.Last.Add(LAllKeys[I])
    else if FWrap(FKeys.Count - 1, FKeys.Last.Count - 1, LAllKeys[I]) then
    begin
      FKeys.Add(TObjectList<TKey>.Create);
      FKeys.Last.Add(LAllKeys[I]);
    end;
end;

function TtgKeyboardCore<TKey>.ToJson: string;
begin
  Result := FFields.ToJson;
end;

function TtgKeyboardCore<TKey>.Wrap(AWrap: TFunc<Integer, Integer, TKey, Boolean>): ITgKeyboardCore<TKey>;
begin
  FWrap := AWrap;
  Result := Self
end;

constructor TtgKeyAbstract.Create;
begin
  inherited Create;
  FKey := TJSONObject.Create();
end;

end.
