unit test.iCloud;

interface
uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TiCloudTests = class(TObject) 
  public
    [Test]
    procedure InvalidURLRaisesConnectionError;
  end;

implementation


{ TiCloudTests }

procedure TiCloudTests.InvalidURLRaisesConnectionError;
begin
  assert.Fail('not yet implemented');
end;

initialization
  TDUnitX.RegisterTestFixture(TiCloudTests);
end.
