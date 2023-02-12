unit TelegaPi.Types;

interface

type
  ItgUser = interface
    ['{33BF51DB-F10F-4408-9E64-82E56AB870FE}']
    function GetCanJoinGroups: Boolean;
    function GetCanReadAllGroupMessages: Boolean;
    function GetFirstName: string;
    function GetId: Int64;
    function GetIsBot: Boolean;
    function GetSupportsInlineQueries: Boolean;
    function GetUsername: string;
    // public
    property CanJoinGroups: Boolean read GetCanJoinGroups;
    property CanReadAllGroupMessages: Boolean read GetCanReadAllGroupMessages;
    property FirstName: string read GetFirstName;
    property Id: Int64 read GetId;
    property IsBot: Boolean read GetIsBot;
    property SupportsInlineQueries: Boolean read GetSupportsInlineQueries;
    property Username: string read GetUsername;
  end;

  ItgUpdate = interface
    ['{66946DBE-B901-4080-8D31-FDB08BD5DA9A}']
    function GetUpdateId: Int64;
    // public
    property UpdateId: Int64 read GetUpdateId;
  end;

implementation

end.
