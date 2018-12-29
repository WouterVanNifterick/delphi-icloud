unit WvN.iCloud;

interface

uses
  System.SysUtils,
  REST.Client,
  REST.Types,
  System.Hash;

type
  /// <summary>
  /// See: https://github.com/mindcollapse/iCloud-API/blob/master/iCloud.py
  /// </summary>
  TICloud = class
  private
    FClientBuildNumber: string;
    FClientId: string;
    FInstance: string;
    FChecksum: string;
  public
    Login: string;
    Password: string;
    HttpClient: REST.Client.TRESTRequest;
    constructor Create(aLogin, aPassword: string);
    function GetContactList: string;
    function Authenticate: string;
  end;

  TURLS = record
  const
    version                 = 'https=//www.icloud.com/system/version.json';
    validate                = 'https=//setup.icloud.com/setup/ws/1/validate?clientBuildNumber={0}&clientId={1}';
    Authenticate: string    = 'https=//setup.icloud.com/setup/ws/1/login?clientBuildNumber=%s&clientId=%s';
    logout_no_services      = 'https=//setup.icloud.com/setup/ws/1/logout';
    get_contacts_list       = '{0}/co/startup?clientBuildNumber={1}&clientId={2}&clientVersion=2.1&dsid={3}&id={4}&locale=en_US&order=last%2Cfirst';
    refresh_web_auth        = '{0}/refreshWebAuth?clientBuildNumber={1}&clientId={2}&dsid={3}&id={4}';
    get_notes_list          = '{0}/no/startup?clientBuildNumber={1}&clientId={2}&dsid={3}&id={4}';
    get_active_reminders    = '{0}/rd/startup?clientVersion=4.0&dsid={1}&id={2}&lang=en-us&usertz=US%2FPacific';
    get_completed_reminders = '{0}/rd/completed?clientVersion=4.0&dsid={1}&id={2}&lang=en-us&usertz=US%2FPacific';
    fmi                     = 'None';
    fmi_init                = '{0}/fmipservice/client/web/initClient?dsid={1}&id={2}';
    fmi_refresh             = '{0}/fmipservice/client/web/refreshClient?dsid={1}&id={2}';
    get_calendar_events     = '{0}/ca/events?clientBuildNumber={1}&clientID={2}&clientVersion=4.0&dsid={3}&endDate={4}&id={5}&lang=en-us&requestID=1&startDate={6}&usertz=US%2FPacific';
  end;

implementation

{ TICloud }

function TICloud.Authenticate: string;
begin
  var AuthURL := format(TURLS.Authenticate, [FClientBuildNumber, FClientId]);
  FChecksum := THashSHA1.GetHashString(Login + FInstance).ToUpper;

  var req := TRESTRequest.Create(nil);
  req.AddParameter('Origin','https://www.icloud.com',TRestRequestParameterKind.pkHTTPHEADER);
  req.AddParameter('Referer','https://www.icloud.com',TRestRequestParameterKind.pkHTTPHEADER);
  req.Execute;
end;

constructor TICloud.Create(aLogin, aPassword: string);
begin
  Login := aLogin;
  Password := aPassword;
  FClientBuildNumber := '1P24';
  FClientId := '';
end;

function TICloud.GetContactList: string;
begin

end;

end.
