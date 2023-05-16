unit Native;

interface
uses Windows;

procedure loadNative;

type
  NTStatus = cardinal;
  PUnicodeString = ^TUnicodeString;
  TUnicodeString = record
    Length: Word;
    MaximumLength: Word;
    Buffer: PWideChar;
  end;
  PObjectAttributes = ^TObjectAttributes;
  TObjectAttributes = packed record
    Length: Cardinal;
    RootDirectory: THandle;
    ObjectName: PUnicodeString;
    Attributes: Cardinal;
    SecurityDescriptor: Pointer;
    SecurityQualityOfService: Pointer;
  end;
  OBJECT_ATTRIBUTES = TObjectAttributes;
  POBJECT_ATTRIBUTES = ^OBJECT_ATTRIBUTES;
  PLARGE_INTEGER = ^_LARGE_INTEGER;
  PVOID = pointer;
  USHORT = WORD;
  UCHAR = byte;
  PWSTR = PWideChar;
  Handle = DWORD;
  ULONG_PTR = Cardinal;
  ppointer = ^Pointer;
  _IO_STATUS_BLOCK = record
    //union {
    Status: NTSTATUS;
    //    PVOID Pointer;
     //}
    Information: ULONG_PTR;
  end;
  IO_STATUS_BLOCK = _IO_STATUS_BLOCK;
  PIO_STATUS_BLOCK = ^IO_STATUS_BLOCK;
  TIoStatusBlock = IO_STATUS_BLOCK;
  PIoStatusBlock = ^TIoStatusBlock;

  pPROCESS_BASIC_INFORAMTION = ^PROCESS_BASIC_INFORAMTION;
  PROCESS_BASIC_INFORAMTION = record
    ExitStatus: DWORD;
    PEBBaseAddress: Pointer;
    AffinityMask: DWORD;
    BasePriority: DWORD;
    UniqueProcessId: DWORD;
    InheritedFormUniqueProcessId: DWORD;
  end;

type
  UInt64 = Int64;
  ULONG64 = UInt64;
  PULONG64 = ^ULONG64;
  DWORD64 = UInt64;
  PDWORD64 = ^DWORD64;
  PUINT64 = ^UINT64;


  PROCESS_BASIC_INFORMATION64 = record
    ExitStatus: Cardinal;
    Pad1: Cardinal;
    PebBaseAddress: UInt64;
    AffinityMask: UInt64;
    BasePriority: Cardinal;
    Pad2: Cardinal;
    UniqueProcessId: UInt64;
    InheritedFromUniqueProcessId: UInt64;
  end;
  TProcessBasicInformation64 = PROCESS_BASIC_INFORMATION64;
  PProcessBasicInformation64 = ^TProcessBasicInformation64;

  PROCESSINFOCLASS = (
    ProcessBasicInformation,
    ProcessQuotaLimits,
    ProcessIoCounters,
    ProcessVmCounters,
    ProcessTimes,
    ProcessBasePriority,
    ProcessRaisePriority,
    ProcessDebugPort,
    ProcessExceptionPort,
    ProcessAccessToken,
    ProcessLdtInformation,
    ProcessLdtSize,
    ProcessDefaultHardErrorMode,
    ProcessIoPortHandlers, // Note: this is kernel mode only
    ProcessPooledUsageAndLimits,
    ProcessWorkingSetWatch,
    ProcessUserModeIOPL,
    ProcessEnableAlignmentFaultFixup,
    ProcessPriorityClass,
    ProcessWx86Information,
    ProcessHandleCount,
    ProcessAffinityMask,
    ProcessPriorityBoost,
    ProcessDeviceMap,
    ProcessSessionInformation,
    ProcessForegroundInformation,
    ProcessWow64Information, // = 26
    ProcessImageFileName, // added after W2K
    ProcessLUIDDeviceMapsEnabled,
    ProcessBreakOnTermination, // used by RtlSetProcessIsCritical()
    ProcessDebugObjectHandle,
    ProcessDebugFlags,
    ProcessHandleTracing,
    MaxProcessInfoClass);
  PROCESS_INFORMATION_CLASS = PROCESSINFOCLASS;
  TProcessInfoClass = PROCESSINFOCLASS;

  PIO_APC_ROUTINE = procedure(ApcContext: PVOID; IoStatusBlock: PIO_STATUS_BLOCK; Reserved: ULONG); stdcall;

  pKNORMAL_ROUTINE = procedure(NormalContext, SystemArgument1, SystemArgument2: PVOID); stdcall;

const
  STATUS_SUCCESS = NTStatus($00000000);
  STATUS_ACCESS_DENIED = NTStatus($C0000022);
  STATUS_INFO_LENGTH_MISMATCH = NTStatus($C0000004);

const SystemProcessesAndThreadsInformation = 5;

type

  PClientID = ^TClientID;
  TClientID = packed record

    UniqueProcess: cardinal;
    UniqueThread: cardinal;
  end;

  PVM_COUNTERS = ^VM_COUNTERS;
  VM_COUNTERS = record
    PeakVirtualSize,
      VirtualSize,
      PageFaultCount,
      PeakWorkingSetSize,
      WorkingSetSize,
      QuotaPeakPagedPoolUsage,
      QuotaPagedPoolUsage,
      QuotaPeakNonPagedPoolUsage,
      QuotaNonPagedPoolUsage,
      PagefileUsage,
      PeakPagefileUsage: dword;
  end;

  PIO_COUNTERS = ^IO_COUNTERS;
  IO_COUNTERS = record

    ReadOperationCount,
      WriteOperationCount,
      OtherOperationCount,
      ReadTransferCount,
      WriteTransferCount,
      OtherTransferCount: LARGE_INTEGER;
  end;

  PSYSTEM_THREADS = ^SYSTEM_THREADS;
  SYSTEM_THREADS = record
    KernelTime,
      UserTime,
      CreateTime: LARGE_INTEGER;
    WaitTime: dword;
    StartAddress: pointer;
    ClientId: TClientId;
    Priority,
      BasePriority,
      ContextSwitchCount: dword;
    State: dword;
    WaitReason: dword;
  end;

  PSYSTEM_PROCESSES = ^SYSTEM_PROCESSES;
  SYSTEM_PROCESSES = record
    NextEntryDelta,
      ThreadCount: dword;
    Reserved1: array[0..5] of dword;
    CreateTime,
      UserTime,
      KernelTime: LARGE_INTEGER;
    ProcessName: TUnicodeString;
    BasePriority: dword;
    ProcessId,
      InheritedFromProcessId,
      HandleCount: dword;
    Reserved2: array[0..1] of dword;
    VmCounters: VM_COUNTERS;
    IoCounters: IO_COUNTERS; // Windows 2000 only

    Threads: array[0..0] of SYSTEM_THREADS;
  end;



  PCardinal = ^cardinal;

  PUNICODE_STRING = ^UNICODE_STRING;
  UNICODE_STRING = packed record
    Length: Word;
    MaximumLength: Word;
    Buffer: PWideChar;
  end;


  KEY_VALUE_PARTIAL_INFORMATION = packed record
    TitleIndex: ULONG;
    Type_: ULONG;
    DataLength: ULONG;
    Data: array[0..0] of UCHAR;
  end;
  PKEY_VALUE_PARTIAL_INFORMATION = ^KEY_VALUE_PARTIAL_INFORMATION;

  _KEY_VALUE_INFORMATION_CLASS = (
    KeyValueBasicInformation,
    KeyValueFullInformation,
    KeyValuePartialInformation,
    KeyValueFullInformationAlign64,
    KeyValuePartialInformationAlign64);
  KEY_VALUE_INFORMATION_CLASS = _KEY_VALUE_INFORMATION_CLASS;
  TKeyValueInformationClass = KEY_VALUE_INFORMATION_CLASS;
type
  _SECTION_BASIC_INFORMATION = record // Information Class 0
    BaseAddress: PVOID;
    Attributes: ULONG;
    Size: LARGE_INTEGER;
  end;

  OBJECT_INFORMATION_CLASS = (ObjectBasicInformation, ObjectNameInformation, ObjectTypeInformation, ObjectAllTypesInformation, ObjectHandleInformation);


function RtlCreateUserThread(ProcessHandle: HANDLE; SecurityDescriptor: PSECURITY_DESCRIPTOR; CreateSuspended: BOOLEAN; StackZeroBits: ULONG; StackReserved: PULONG; StackCommit: PULONG; StartAddress: PVOID; StartParameter: PVOID; ThreadHandle: PHANDLE; ClientID: PCLIENTID): THandle; stdcall; external 'ntdll.dll' name 'RtlCreateUserThread';

function ZwQuerySection(
  SectionHandle: HANDLE;
  SectionInformationClass: DWORD;
  SectionInformation: PVOID;
  SectionInformationLength: ULONG;
  ResultLength: PULONG
  ): NTSTATUS; stdcall; external 'ntdll.dll' name 'ZwQuerySection';

function ZwQueryObject(ObjectHandle: cardinal; ObjectInformationClass: OBJECT_INFORMATION_CLASS; ObjectInformation: pointer; Length: ULONG; ResultLength: PDWORD): THandle; stdcall; external 'ntdll.dll' name 'ZwQueryObject';

function ZwQueryInformationProcess(hProcess: THandle;
  InformationClass: DWORD; Buffer: pPROCESS_BASIC_INFORAMTION;
  BufferLength: DWORD; ReturnLength: PDWORD): Cardinal; stdcall; external 'ntdll.dll';

function ZwUnmapViewOfSection(ProcessHandle: dword; BaseAddress: pointer): NTStatus; stdcall; external 'ntdll.dll' name 'ZwUnmapViewOfSection';
function ZwMapViewOfSection(SectionHandle: dword;
  ProcessHandle: dword;
  BaseAddress: PPointer;
  ZeroBits,
  CommitSize: dword;
  SectionOffset: PInt64;
  ViewSize: pdword;
  InheritDisposition: dword;
  AllocationType, Protect: dword): NTStatus;
stdcall; external 'ntdll.dll' name 'ZwMapViewOfSection';
function ZwCreateSection(SectionHandle: PHANDLE; DesiredAccess: ACCESS_MASK; ObjectAttributes: POBJECT_ATTRIBUTES;
  MaximumSize: PLARGE_INTEGER; SectionPageProtection: ULONG; AllocationAttributes: ULONG; FileHandle: THandle
  ): NTSTATUS; stdcall; external 'ntdll.dll' name 'ZwCreateSection';
function NtSetValueKey(
  KeyHandle: HANDLE;
  ValueName: PUNICODE_STRING;
  TitleIndex: ULONG;
  Type_: ULONG;
  Data: PVOID;
  DataSize: ULONG
  ): NTSTATUS; stdcall; external 'ntdll.dll';
function NtDeleteValueKey(
  KeyHandle: HANDLE;
  ValueName: PUNICODE_STRING
  ): NTSTATUS; stdcall; external 'ntdll.dll';
function NtQueryValueKey(
  KeyHandle: HANDLE;
  ValueName: PUNICODE_STRING;
  KeyValueInformationClass: KEY_VALUE_INFORMATION_CLASS;
  KeyValueInformation: PVOID;
  KeyValueInformationLength: ULONG;
  ResultLength: PULONG
  ): NTSTATUS; stdcall; external 'ntdll.dll';

function NtDeleteKey(KeyHandle: THandle): NTSTATUS; stdcall; external 'ntdll.dll';
function ZwWriteVirtualMemory(ProcessHandle: HANDLE; BaseAddress: PVOID; Buffer: PVOID; BufferLength: ULONG; ReturnLength: PULONG): NTSTATUS; stdcall; external 'ntdll.dll';

var
  NtWow64QueryInformationProcess64: function(ProcessHandle: THANDLE;
    ProcessInformationClass: PROCESSINFOCLASS;
    ProcessInformation: Pointer;
    ProcessInformationLength: ULONG;
    ReturnLength: PUInt64
    ): NTSTATUS; stdcall;

  NtWow64ReadVirtualMemory64: function(ProcessHandle: THANDLE;
    BaseAddress: UInt64;
    Buffer: Pointer;
    BufferLength: UInt64;
    ReturnLength: PUInt64
    ): NTSTATUS; stdcall;

  NtWow64WriteVirtualMemory64: function(ProcessHandle: THANDLE;
    BaseAddress: UInt64;
    Buffer: Pointer;
    BufferLength: UInt64;
    ReturnLength: PUInt64
    ): NTSTATUS; stdcall;

  NtFreeVirtualMemory: function(ProcessHandle: THANDLE;
    BaseAddress: pointer;
    Length: pdword;
    FreeType: ULONG): NTSTATUS; stdcall;




  Wow64DisableWow64FsRedirection: function(OldValue: pointer): boolean; stdcall;
  Wow64RevertWow64FsRedirection: function(OldValue: pointer): boolean; stdcall;

implementation


procedure loadNative;
var
  hntdll, hPSAPI, hkernel32, hps, hPdh: dword;
  proc_name: string;
var pid: DWORD;
  lpdwResult: dword;
  buff: array[0..256] of WideChar;
  s: widestring;
  xpEr, vistaEr: Integer;
begin
  hntdll := LoadLibraryA(PChar('ntdll.dll'));
  hkernel32 := LoadLibraryA(PChar('kernel32.dll'));
  hPSAPI := LoadLibraryA(PChar('PSAPI.dll'));
  hPdh := LoadLibraryA(PChar('pdh.dll'));

  if hntdll <> 0 then begin
    NtWow64QueryInformationProcess64 := GetProcAddress(hntdll, PChar('NtWow64QueryInformationProcess64'));
    NtWow64ReadVirtualMemory64 := GetProcAddress(hntdll, PChar('NtWow64ReadVirtualMemory64'));
    NtWow64WriteVirtualMemory64 := GetProcAddress(hntdll, PChar('NtWow64WriteVirtualMemory64'));
    NtFreeVirtualMemory := GetProcAddress(hntdll, PChar('NtFreeVirtualMemory'));
  end;

end;


end.
