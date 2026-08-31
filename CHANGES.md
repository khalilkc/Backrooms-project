# سجل التغييرات الشامل — Backrooms by Andinest Games

توثيق كامل لجميع التعديلات المنفذة على المشروع، مرتبة زمنيًا حسب المهمة.

**جدول المحتويات:**
1. [إزالة نظام Online / Multiplayer بالكامل](#1-إزالة-نظام-online--multiplayer-بالكامل)
2. [تحويل C# إلى GDScript + إزالة الأكل والشرب والتعب + إزالة الهاتف](#2-تحويل-c-إلى-gdscript--إزالة-الأكل-والشرب-والتعب--إزالة-الهاتف)
3. [خلفية فيديو للقائمة الرئيسية بملاءمة كل الشاشات](#3-خلفية-فيديو-للقائمة-الرئيسية-بملاءمة-كل-الشاشات)
4. [إصلاح ملف نموذج I4.0 التالف](#4-إصلاح-ملف-نموذج-i40-التالف)
5. [ضباب حجمي لـ Level 0 و Level 4 + إزالة PlayerSkin](#5-ضباب-حجمي-لـ-level-0-و-level-4--إزالة-playerskin)
6. [نظام حركة اللاعب الاحترافي (Found Footage)](#6-نظام-حركة-اللاعب-الاحترافي-found-footage)
7. [إصلاح تدهور الأداء التدريجي في توليد العالم](#7-إصلاح-تدهور-الأداء-التدريجي-في-توليد-العالم)
8. [تحسينات أداء إضافية + إصلاح انهيار Level 4](#8-تحسينات-أداء-إضافية--إصلاح-انهيار-level-4)
9. [SSR + SSAO + SSIL للمستويين 0 و4 وتقوية ضباب Level 0](#9-ssr--ssao--ssil-للمستويين-0-و4-وتقوية-ضباب-level-0)
10. [أنيميشن واقعي لباب TheHub بزاوية 95 درجة](#10-أنيميشن-واقعي-لباب-thehub-بزاوية-95-درجة)
11. [SceneLoader موحّد لكل انتقالات المشاهد](#11-sceneloader-موحّد-لكل-انتقالات-المشاهد)
12. [قائمة رئيسية جديدة بالكود + حذف multiplayer](#12-قائمة-رئيسية-جديدة-بالكود--حذف-multiplayer)
13. [قائمة إيقاف مؤقت موحّدة](#13-قائمة-إيقاف-مؤقت-موحّدة)
14. [شبكة ملاحة (NavigationMesh) لتوليد العالم](#14-شبكة-ملاحة-navigationmesh-لتوليد-العالم)
15. [أشعة ضوء حجمية لـ Level 4 + إزالة git نهائيًا](#15-أشعة-ضوء-حجمية-لـ-level-4--إزالة-git-نهائيًا)
16. [استبدال نظام أشعة الإخفاء بالفوليومتريك فوج الأصلي](#16-استبدال-نظام-أشعة-الإخفاء-بالفوليومتريك-فوج-الأصلي)
17. [إصلاح اختفاء السماء + انعكاسات الأرضية + far=40](#17-إصلاح-اختفاء-السماء--انعكاسات-الأرضية--far40)
18. [تلاشي حافة far بشكل ضبابي + VoxelGI لظل متشتت](#18-تلاشي-حافة-far-بشكل-ضبابي--voxelgi-لظل-مشتت)
19. [ظلال منكسرة وواقعية بدون VoxelGI (SSAO + SSIL + SDFGI)](#19-ظلال-منكسرة-وواقعية-بدون-voxelgi-ssao--ssil--sdfgi)
20. [إزالة SDFGI الثقيل + شيدر GI خفيف لمحاكاة ملء الظلال](#20-إزالة-sdfgi-الثقيل--شيدر-gi-خفيف-لمحاكاة-ملء-الظلال)
21. [تخفيف GIFake + تقوية أشعة vol fog + إرجاع ضبابية far](#21-تخفيف-gifake--تقوية-أشعة-vol-fog--إرجاع-ضبابية-far)
22. [موازنة الإضاءة البيضاء الزائدة + ضباب DEPTH مضمون قبل far](#22-موازنة-الإضاءة-البيضاء-الزائدة--ضباب-depth-مضمون-قبل-far)
23. [ظلال شمس متفتتة وواقعية (خريطة ظل أعلى كثافة + شرائح قريبة + تلامس)](#23-ظلال-شمس-متفتتة-وواقعية-خريطة-ظل-أعلى-كثافة--شرائح-قريبة--تلامس)
24. [استعادة الأداء مع ظلال واقعية خفيفة (8192 → 4096 + PCF13 + مدى 42)](#24-استعادة-الأداء-مع-ظلال-واقعية-خفيفة-8192--4096--pcf13--مدى-42)
25. [إضاءة Omni واقعية خفيفة (تفعيل الظلال) — Level 4 وLevel 0](#25-إضاءة-omni-واقعية-خفيفة-تفعيل-الظلال--level-4-وlevel-0)
26. [إصلاح "لماذا لا تشتغل تعديلاتي على البيئة" — ضباب Level 0 صفر + ضباب Level 4 بكثافة مرئية](#26-إصلاح-لماذا-لا-تشتغل-تعديلاتي-على-البيئة--ضباب-level-0-صفر--ضباب-level-4-بكثافة-مرئية)
27. [إعادة التسمية إلى Backrooms by Andinest Games + إزالة كاملة لشخصية I4.0](#27-إعادة-التسمية-إلى-backrooms-by-andinest-games--إزالة-كاملة-لشخصية-i40)

---

## 1) إزالة نظام Online / Multiplayer بالكامل

**التاريخ:** 24 أغسطس 2026
**الوصف:** إزالة كاملة لنظام اللعب الجماعي (Multiplayer) والاتصال الشبكي المرتبط به، مع الحفاظ على سلوك اللعبة الأحادية (Singleplayer) دون أي تأثير.

### ملفات محذوفة بالكامل

| الملف / المسار | الوصف |
|---|---|
| `Scripts/Multiplayer/MultiplayerConnection.gd` | عميل WebSocket (`WebSocketPeer`) كان يتصل بخادم `main.tao71.org:65287` لمزامنة اللاعبين والمصادقة. |
| `Scripts/Multiplayer/MultiplayerConnection.gd.uid` | معرّف المورد الخاص بالسكربت المحذوف. |
| `Scripts/Multiplayer/MultiplayerCharacter.gd` | تمثيل اللاعب البعيد داخل العالم (NameTag، وضع الزحف، أصوات بعيدة). |
| `Scripts/Multiplayer/MultiplayerCharacter.gd.uid` | معرّف المورد الخاص بالسكربت المحذوف. |
| `Scripts/Multiplayer/Server/` (كامل المجلد) | الخادم الجانبي بلغة Python: `main.py`, `classes.py`, `config.py`, `globals.py`, `config.json`, `info.json`, `requirements.txt`. |
| `Prefabs/MultiplayerSkin.tscn` | مشهد جلد اللاعب البعيد المستخدم في `SpawnedMultiplayerPlayers`. |

> **ملاحظة معمارية:** ملف `Scripts/I4.0/Conn.cs` لم يُحذف في هذه المرحلة لأنه لا علاقة له بالـ Multiplayer؛ حُوِّل لاحقًا في القسم 2.

### تعديلات السكربتات

#### `Scripts/Globals.gd`
- حُذف القسم `MULTIPLAYER` بالكامل: `Multiplayer_Host` (`"main.tao71.org"`), `Multiplayer_Port` (`65287`), `Multiplayer_UpdateTime` (`0`).
- حُذف القسم `ACCOUNT` بالكامل (تسجيل دخول خادم اللعب الجماعي): `User_Username`, `User_Password`.
- حُذف المتغير `Sound_Players: Dictionary[String, Dictionary]`.
- حُذفت الدالة `static func ParseSound(ID)` — كانت تُستخدم حصرًا في مزامنة أصوات الصافرة (`set_sounds`) وصارت كودًا ميتًا.
- أُبقي على `enum SoundID` و`CreateSoundPlayers()` لخدمة صافرة اللاعب المحلية.

#### `Scripts/WorldGen/WorldGen.gd`
- حُذف المتغير `MULTIPLAYER_PLAYER_SKIN`, والمتغير `MUL: MultiplayerConnection`, وقاموس `SpawnedMultiplayerPlayers`.
- حُذفت الخاصية `@export var Multiplayer: bool = true`.
- حُذفت دالة `UpdateMultiplayer()` بالكامل.
- في `_ready()`: حُذفت كتلة إنشاء `MultiplayerConnection` وربطها بالمشغل، وفرع الاتصال بالخادم (`AutoConnect` / `IsAuthorized` / `Login` / `GetLevelsData`)؛ أصبح المنطق: بذرة عشوائية إن لم تكن مضبوطة ثم توليد مباشر.
- حُذف مؤقّت `multiplayerTimer`.
- **تحسين أداء:** حُذفت `_process(_Delta)` بالكامل — كانت تُنفَّذ كل إطار وتستدعي مزامنة اللاعبين.

#### `Scripts/Character/CharacterMovement.gd`
- حُذف المتغير `MUL: MultiplayerConnection` ومصفوفة `MultiplayerSounds` ودالة `UpdateMultiplayer()`.
- تبسيط التوقيعات: `PlaySound(Type, Sound, ID)` ← `PlaySound(Type, Sound)` و `StopSound(Type, ID)` ← `StopSound(Type)`.

#### `Scripts/WorldGen/Levels/TheHub_Door.gd`
- في `Init()`: حُذف الشرط `&& Level not in MultiplayerConnection.VisitedLevels` — القائمة كانت تُملأ فقط عبر خادم Multiplayer وتبقى فارغة دائمًا offline؛ الإزالة تحافظ على نفس سلوك offline الفعلي (الباب يحتاج مفتاح المستوى).

#### `Scripts/ConfigManager.gd`
- من `GUI_Elements` حُذفت المفاتيح المهجورة: `Multiplayer_Host`, `Multiplayer_Port`, `Multiplayer_UpdateTime`, `User_Username`, `User_Password`, `Sound_Player_Voice`, `Sound_Player_SFX`.
- حُذفت عناصر واجهة "أصوات اللاعبين المخصصة" كلها (التصديرات، الثوابت، `__new_sound_players_element__()`، وكتل البناء داخل `Load()` و`Save()`).

### تعديلات المشاهد

#### `Scenes/MainMenu.tscn`
- حُذف تبويب `TAB_MULTIPLAYER` بشجرته الكاملة (Host/Port، اسم المستخدم، كلمة المرور، Sync time).
- حُذفت من `TAB_SOUND` ثلاثة أقسام: `Player voice volume`, `Player SFX volume`, `Players volumes`.
- تنظيف `node_paths` لعقدة ConfigManager، وحذف اتصال `__new_sound_players_element__`.
- تحديث تلميح زر `Play` بإزالة تحذير حساب Multiplayer، وتحديث `_tab_index` لـ `TAB_I40` من 5 إلى 4.
- التبويبات النهائية: `TAB_GRAPHICS`, `TAB_SOUND`, `TAB_CONTROLS`, `TAB_GAME`, `TAB_I40`.

#### `Scenes/Level 0.tscn` و `Scenes/Level TheHub.tscn`
- حُذف السطر `Multiplayer = false` من عقدة WorldGenerator.

### الموارد والإعدادات

- **`default_bus_layout.tres`:** حُذف باصّا الصوت `GlobalPlayerVoice` و`GlobalPlayerSFX` (لم يكن أي مشغّل موجَّهًا إليهما).
- **`Locales/Locales.csv`:** حُذفت صفوف `TAB_MULTIPLAYER`, `LBL_MULTIPLAYER_SERVER`, `TT_LBL_MULTIPLAYER_SERVER`, `LBL_USERNAME`, `TT_LBL_USERNAME`, `LBL_PASSWORD`, `TT_LBL_PASSWORD`, `LBL_MULTIPLAYER_SYNC`, `TT_LBL_MULTIPLAYER_SYNC`, وصفوف أصوات اللاعبين (`LBL_VOL_PLAYER_*`, `LBL_VOL_CUSTOMPLAYER_*`)، وحُدِّث `TT_BTN_PLAY`. ملفات `.translation` تُعاد تلقائيًا عند فتح المحرر.
- **`.godot/global_script_class_cache.cfg`:** أُزيل مدخلا الفئتين `MultiplayerCharacter` و`MultiplayerConnection`.

### التوثيق
- **`README.md`:** حُذف تنبيه الخادم الرسمي من صندوق IMPORTANT، وحُذف بند `[X] Multiplayer` وبنوده الفرعية من خارطة الطريق.

---

## 2) تحويل C# إلى GDScript + إزالة الأكل والشرب والتعب + إزالة الهاتف

**التاريخ:** 24 أغسطس 2026
**الوصف:** تحويل آخر ملف C# في المشروع إلى GDScript أصلي (إزالة اعتماد .NET نهائيًا)، وإزالة كاملة لنظام الإحصائيات الحيوية (الماء/الطعام/اللياقة/التعب) مع الإبقاء على الصحة، وإزالة كاملة لنظام الهاتف بكل واجهاته وأصوله وإعداداته.

### الملفات المحذوفة

| الملف / المسار | الوصف |
|---|---|
| `Scripts/I4.0/Conn.cs` | آخر ملف C# — كان يدير إعدادات I4.0 ويغلّف مكتبة `TAO71.I4_0`. |
| `Scripts/I4.0/Conn.cs.uid` | معرّف المورد. |
| `Scripts/Character/Phone.gd` (+ `.uid`) | سكربت الهاتف: التطبيقات وكاميرا الصور. |
| `Scripts/Character/Phone_I4.0.gd` (+ `.uid`) | تطبيق محادثة I4.0 داخل الهاتف (كان غير مكتمل). |
| `Themes/Phone.tres` | ثيم واجهة الهاتف. |
| `Themes/Icons/send.webp` (+ `.import`) | أيقونة زر الإرسال. |
| `Textures/FileNoPreview.webp` (+ `.import`) | صورة بديلة كانت تُستخدم حصريًا في `Phone_I4.0.gd`. |
| `BackroomsWithI4.0.csproj` / `.csproj.old` / `.sln` | ملفات مشروع .NET. |
| `.gitmodules` | تعريف الوحدة الفرعية `vendor/I4.0`. |
| `vendor/I4.0/` | الوحدة الفرعية الفارغة لمكتبة `TAO71.I4_0`. |

> نظام شخصية I4.0 الذكية (`Scripts/I4.0/I4CharController.gd` و`Prefabs/I4.0.tscn`) لم يُمسّ إطلاقًا.

### التحويل: `Scripts/I4.0/Conn.gd` (جديد)

تحويل أصلي كامل لـ `Conn.cs` باستخدام `WebSocketPeer` المدمج بدل `System.Net.WebSockets` ومكتبة `TAO71.I4_0`:

- **`class_name Conn extends Node`** — مسجّل عالميًا كما كان الصنف C#.
- **إدارة الإعدادات:** نفس مسار `[$GAME_CONFIG_DIR]/I4.0_config.json` ونفس مفاتيح وقيم `ClientConfiguration` الافتراضية (`Encryption_PrivateKeyPassword = "changeme"`, `Encryption_Threads = 1`, `Encryption_RSASize = 4096`, `Encryption_Hash = "sha512"`, `Service_DefaultAPIKey = "nokey"`, `PingInterval = 20.0`)، مع إنشاء تلقائي ودمج القيم المحفوظة.
- **طبقة النقل:** تأطير مطابق للأصل — مقاطع بحجم `TRANSFER_RATE = 8192 * 1024` ومؤشر نهاية `"--END--"`، اتصال `wss://` / `ws://` بالمنفذ الافتراضي `8060`، مصافحة `get_public_key` بعد كل اتصال، إغلاق مهذب برسالة `"close"`، ومهلة استقبال 30 ثانية (تحسين لم يكن في الأصل لمنع التعليق).
- **طبقة الخدمات:** `Request` تبني مغلف `{model_name, service, key, prompt:{conversation, parameters}, user_parameters}` داخل `{hash, public_key, version, content}` بـ `VERSION = 220000`؛ `GetAvailableModels` تجمع `models` وتُبلغ عن `errors`؛ `ConnectToServer(Models)` منقول سطرًا بسطر (مرور `I4_Servers`، فصل `host:port`، محاولة TLS ثم اتصال عادي).
- حُذفت خاصية `ErrorContainer` غير المستخدمة والدالة `_Process` الفارغة.

> **قيود موثقة:** تشفير RSA-4096 الهجين للمكتبة الأصلية لا يمكن استنساخه بواجهات Godot الأساسية (لا تكشف RSA خام)، فيُرسَل `content` صريحًا مع بقاء بنية المغلف جاهزة لأي طبقة تشفير مستقبلية — دون تأثير حالي لأن هذه الدوال لم تكن مستدعاة.

### إزالة الأكل والشرب والتعب

#### `Scripts/Character/CharacterMovement.gd`
- حُذف: `Water` + `WaterDecreaseMultiplier`, `Food` + `FoodDecreaseMultiplier`, `Stamina` + التصديرات (`StaminaRecover`, `TiredStaminaRecover`, `WalkStaminaLoss`, `RunStaminaLoss`, `JumpStaminaLoss`), الثابت `TiredSpeed`, الحالة `Tired`, وتصديرات الواجهة `WaterGUI/FoodGUI/StaminaGUI` مع فئة GUI.
- في `_process`: حذف تحديث الأعمدة والاستنزاف والأضرار ومنطق التعب.
- في `_physics_process`: الجري متاح دائمًا (فرعا جري/مشي فقط)، وحذف كل حسابات اللياقة.
- **ما بقي عمدًا:** `Health/Die()` (الموت بالسقوط يعتمد عليها عبر `WorldGen.PlayerDieFalling`) ونظام الجنون `Sanity`.

#### `Prefabs/Player.tscn`
- حُذفت أشجار `GUI/Stats` و`GUI` و`CameraGUI`، وأصبحت `node_paths` على الجذر `("Head")` فقط، وحُدِّث `load_steps` من 15 إلى 5، والعقدة `I4Conn` تشير الآن إلى `Conn.gd`.

#### المشاهد
- `Scenes/Level TheHub.tscn`: حُذفا `WaterDecreaseMultiplier = 0.15` و`FoodDecreaseMultiplier = 0.1`.
- `Scenes/Level TheVoid.tscn`: حُذفت التجاوزات الست (`WaterDecreaseMultiplier`, `FoodDecreaseMultiplier`, `StaminaRecover`, `TiredStaminaRecover`, `WalkStaminaLoss`, `RunStaminaLoss`).

### إزالة نظام الهاتف (تكملة)

- **`Scenes/MainMenu.tscn`:** حذف قسمَي "Camera quality level" و"Camera compression level" بخياراتهما وتلميحيهما، وحذف مفتاحي NodePath من قاموس ConfigManager.
- **`Scripts/Globals.gd`:** حذف `CameraQualityLevel` و`CameraSaveCompressionLevel` (المستهلك الوحيد كان `Phone.gd`).
- **`Scripts/ConfigManager.gd`:** حذف المفتاحين من `GUI_Elements`.
- **`Locales/Locales.csv`:** حذف صفوف الكاميرا (14 صفًا: `LBL_CAMQUALITY`, `CAMQUALITY_*` ×7, `LBL_CAMCOMPRESSION`, `CAMCOMPRESSION_*` ×5) وصفوف الهاتف (9 صفوف: `PLACEHOLDER_PROMPT`, `BTN_SEND`, `BTN_ATTACH_FLS`, `BTN_TAKE_PICTURE`, `BTN_DEL_CONV`, `TOOL_SEARCH_TXT`, `TOOL_SEARCH_IMG`, `TT_BTN_I4.0_UTILITIES`, `MSG_ATTACH_FILES_ERROR`).
- **`project.godot`:** حذف قسم `[dotnet]` بالكامل.
- **`.godot/global_script_class_cache.cfg`:** حذف مدخلَي `Phone` و`Phone_I40` وإضافة `Conn`.
- **`README.md`:** حذف بند `- [ ] Phone` من خارطة الطريق.

### نتائج الأداء
- `_physics_process` للاعب فقد 6 عمليات حسابية لكل إطار، و`_process` فقد 3 تحديثات واجهة + منطق التعب.
- لا .NET نهائيًا: لا `csproj` ولا `sln` ولا `[dotnet]` ولا وحدة فرعية خارجية.

---

## 3) خلفية فيديو للقائمة الرئيسية بملاءمة كل الشاشات

**التاريخ:** 24 أغسطس 2026
**الوصف:** تفعيل فيديو خلفية القائمة الرئيسية مع ملاءمة تلقائية لكل أحجام ونِسَب الشاشات دون تشويه.

### الوضع قبل التغيير
- عقدة الفيديو `Background` (`VideoStreamPlayer`) كانت موجودة في `Scenes/MainMenu.tscn` وتشير إلى `res://Video/MainMenu.ogv` لكنها مخفية (`visible = false`).
- العرض كان "تمديدًا أعمى" عبر `expand = true` مع مراسي ملء الشاشة — فيتشوه الفيديو على الشاشات غير 16:9.

### الملفات الجديدة

| الملف | الوصف |
|---|---|
| `Scripts/VideoBackground.gd` | سكربت ملاءمة فيديو بنمط **Cover** (قابل لإعادة الاستخدام على أي `VideoStreamPlayer`). |

### آلية العمل
1. قراءة نسبة أبعاد الفيديو الحقيقية من `get_video_texture()` عند أول توفر، ثم تعطيل `_process` ذاتيًا — صفر تكلفة متكررة بعد أول إطارات.
2. عند كل تغيير لحجم النافذة (إشارة `size_changed`): إذا كانت الشاشة أعرض نسبيًا → ثبات العرض على عرضها وحساب الارتفاع من النسبة؛ وإلا → ثبات الارتفاع وحساب العرض.
3. توسيط العقدة `(screenSize - targetSize) / 2` والقصّ الطبيعي للزيادة — سلوك `background-size: cover`.
4. حواط آمنة: تجاهل نسيج غير مهيأ (≤ 1px) وحماية من القسمة على صفر.

### تعديلات المشهد
- **`Scenes/MainMenu.tscn`:** تفعيل عقدة `Background`، ربط `Scripts/VideoBackground.gd` عليها، وإضافة `[ext_resource type="Script" ... id="5_vbgd"]`؛ الخصائص: `autoplay = true`, `expand = true`, `loop = true` (التكرار مدعوم في Godot 4.3+ والمشروع يستهدف 4.7).

| حالة الشاشة | السلوك |
|---|---|
| 16:9 | مطابقة شبه تامة |
| 21:9 / 32:9 | امتلاء كامل مع قصّ يسار/يمين هامشي |
| 4:3 / 16:10 | امتلاء كامل مع قصّ أعلى/أسفل |
| تغيير حجم حي | إعادة ملاءمة فورية |

> صيغة `.ogv` هي الوحيدة المدعومة أصليًا للفيديو في Godot 4، والملف (~2.5MB) مستورد بشكل صحيح.

---

## 4) إصلاح ملف نموذج I4.0 التالف

**التاريخ:** 24 أغسطس 2026
**الوصف:** استبدال ملف `.vrm` تالف بالنموذج الحقيقي.

### المشكلة
```
ERROR: glTF: Error parsing .gltf JSON data: Expected 'true', 'false', or 'null', got 'version' at line: 0
Import VRM: res://Meshes/I4.0/I4.0-1.vrm
```

### السبب الجذري
الملف `Meshes/I4.0/I4.0-1.vrm` لم يكن نموذجًا بل **مؤشر Git LFS** نصيًا بحجم 134 بايت:

```
version https://git-lfs.github.com/spec/v1
oid sha256:cdd71677837b1e16991506872426be9a44bcd28e3d2d4bbc369aea95f6117fd4
size 630703000
```

المستودع الأصلي يخزّن الملفات الكبيرة عبر Git LFS، وتنزيله كـ ZIP من GitHub لا يتضمن محتوى LFS بل مؤشراته. حاول مستورد VRM تحليل المؤشر كـ JSON ففشل عند كلمة `version` — وهو مصدر نص الخطأ حرفيًا.

### الإصلاح
1. تحديد المستودع الأصلي: [`TAO71-Games/BackroomsWithI4.0-Godot`](https://github.com/TAO71-Games/BackroomsWithI4.0-Godot).
2. التحقق من توفر النسخة الحقيقية عبر خادم LFS (`media.githubusercontent.com`) — الحجم المعلَن طابق المؤشر تمامًا.
3. تنزيل الملف (~601MB) عبر منزّل خلفي يدعم الاستئناف بنطاقات HTTP Range مع إعادة محاولة تلقائية.
4. التحقق من السلامة قبل الاستبدال: التوقيع `glTF` ✓، إصدار GLB = 2 ✓، الحجم = 630,703,000 بايت ✓.

| | قبل | بعد |
|---|---|---|
| الحجم | 134 بايت (نص) | 630,703,000 بايت |
| المحتوى | مؤشر Git LFS | نموذج VRM صالح (glTF 2.0 Binary) |

سيكتشف المحرر الملف ويعيد استيراده تلقائيًا عبر إضافة VRM فيختفي الخطأ ويظهر نموذج I4.0 المستخدم في `Scenes/Level 867.tscn` عبر `Prefabs/I4.0.tscn`.

> **وقاية:** أي ملف كبير مستقبلًا من هذا المستودع يجب أن يُنزَّل عبر `git clone` + `git lfs pull` وليس ZIP — وللكشف عن أي ملف مشابه افحص أول بايتاته: النماذج الصالحة تبدأ بـ `glTF`.

---

## 5) ضباب حجمي لـ Level 0 و Level 4 + إزالة PlayerSkin

**التاريخ:** 24 أغسطس 2026
**الوصف:** إضافة ضباب حجمي (Volumetric Fog) بسيط ومتناسق مع أجواء المستويين 0 و4 فقط، وإزالة نموذج اللاعب المرئي بالكامل (لعبة منظور أول).

### الضباب الحجمي

#### `Scenes/Level 0.tscn` (إضافة)
أجواء المستوى صفراء رطبة بإضاءة فلورسنت — ضباب دافئ مغبر يلتقط هالات المصابيح:
- `volumetric_fog_enabled = true`
- `volumetric_fog_density = 0.015` (خفيف)
- `volumetric_fog_albedo = Color(0.72, 0.65, 0.38, 1)` (أصفر ترابي دافئ)
- `volumetric_fog_anisotropy = 0.3` (تشتت أمامي ناعم نحو الإضاءة)
- `volumetric_fog_gi_inject = 0.6`

#### `Scenes/Level 4.tscn` (ضبط)
كان الضباب الحجمي مفعّلًا بكثافة مبالغة (0.02) وبأبيض افتراضي — خُفّف ولُوِّن ليناسب المكاتب المهجورة والسماء الملبدة:
- الكثافة: `0.02` ← `0.012`
- `volumetric_fog_albedo = Color(0.6, 0.64, 0.7, 1)` (رمادي مزرق بارد يطابق لون الضباب العميق الموجود)
- `volumetric_fog_anisotropy = 0.25` (أشعة شمس ناعمة عبر النوافذ مع DirectionalLight3D)
- `volumetric_fog_gi_inject`: `0.75` ← `0.5`
- بقي `detail_spread = 0.9` كما هو.

> باقي المستويات لم تُمسّ؛ خصائص volumetric موجودة في TheHub/TheVoid لكنها معطّلة أصلًا (`volumetric_fog_enabled` غير مضبوط).

### إزالة PlayerSkin ونموذج اللاعب

| الملف المحذوف | الوصف |
|---|---|
| `Prefabs/PlayerSkin.tscn` | مشهد جلد اللاعب الذي كان يعرض النموذج. |
| `Meshes/PlayerSkin/` (كامل المجلد) | `Hazmat_guy.glb` (~6.8MB) + ثلاث خامات JPG + ملفات الاستيراد. |

- **`Scripts/Character/CharacterMovement.gd`:** حذف المتغير `INIT_SCALE_SKIN` وقراءته من `$PlayerSkin` في `_ready()`، وتبسيط منطق الزحف ليعدّل `PlayerCollider` فقط (النصف العلوي للكبسولة) دون أي تعديل على جلد مرئي.
- **`Prefabs/Player.tscn`:** حذف عقدة `PlayerSkin` والمورد الخارجي الخاص بها؛ `load_steps` من 5 إلى 4.
- **`Scenes/MainMenu.tscn`:** حذف سطر الشكر عن نموذج "Hazmat guy" من شاشة Credits (النموذج لم يعد مستخدمًا).
- الزحف يعمل كما كان وظيفيًا: خفض ارتفاع كبسولة التصادم لنصفها.

---

## 6) نظام حركة اللاعب الاحترافي (Found Footage)

**التاريخ:** 24 أغسطس 2026
**الوصف:** إعادة بناء كاملة لتحكم اللاعب: منظور أول واقعي بأسلوب كاميرا found-footage (اهتزاز، انسياب، ميلان، تنفّس، ارتطام هبوط). أُضيف في البداية Blur عمقي للكاميرا ثم أُزيل بالكامل بطلب المستخدم في اليوم نفسه.

### إزالة ESC (إظهار الماوس)
- حُذفت معالجة `toggle_mouse` والمتغير `MouseCaptured` بالكامل من `CharacterMovement.gd`.
- الماوس الآن ملتقط دائمًا (`MOUSE_MODE_CAPTURED`) طوال اللعب؛ التفاعل والتصفيق يعملان دون شرط.
- الإجراء نفسه ما يزال معرفًا في `project.godot` (غير مستخدم) — يمكن حذفه لاحقًا.

### إعادة هيكلة المشهد `Prefabs/Player.tscn`
- عقدة جديدة **`Head` (Node3D)** بارتفاع العين 1.75م، وتحتها `Camera3D` (إزاحة -0.25م كما كانت).
- الفصل: الانحراف الأفقي (yaw) على جسم اللاعب، والرأس يحمل pitch + الاهتزاز + الميلان — فلا يتأثر اتجاه التصويب بالـ bob.

### نظام النظر (Look Feel)
- تجميع مدخلات الماوس في هدف ثم تنعيمها بدالة أسية مستقلة عن الإطارات (`LookSmoothing = 24`) — تأخر خفيف يبيع إحساس الكاميرا المحمولة.
- ميلان الرول المركّب: ميل نحو اتجاه الحركة الجانبية (`StrafeRollDegrees = 1.9`) + ميلان من خطأ الانحراف أثناء اللف السريع (`YawErrorRollDegrees`) + رول من دورة الخطو — مقيد ±5°.

### الحركة الواقعية
- سرعات: مشي 2.7 / ركض 5.4 / زحف 1.4 م/ث، تسارع أرضي `11` وهوائي `2.4` (منحنى أسّي سلس).
- قفزة: Coyote Time‏ (0.12ث) + Jump Buffer‏ (0.15ث) — قفز متسامح واحترافي.
- زحف بانتقال ناعم: كبسولة تنكمش بنسبة 0.55 مع إعادة تمركز صحيحة (إصلاح خلل قديم كان يغرس الكبسولة في الأرض)، والعين تنخفض إلى 1.02م؛ **يُمنع الوقوف إذا كان السقف منخفضًا** (استعلام `intersect_shape`).
- جاذبية متدرجة كما كانت (`FallTime`) للحفاظ على سلوك سقوط العالم المفتوح.

### Found-Footage Camera
- **Head Bob:** نمط رقم-8 (جانبي sin + عمودي بتردد مضاعف)، تردده 7.6 يرتفع ×1.32 عند الركض، وسعته تتدرج مشي/ركض وتنخفض ×0.55 زحفًا، مع وزن يدخل ويخرج بسلاسة (صفر في الهواء).
- **تنفّس:** موجة بطيئة (1.15Hz) على pitch وارتفاع العين تظهر فقط عند السكون.
- **ارتطام الهبوط:** نابض مخمد على موضع الكاميرا يتناسب مع سرعة السقوط (`LandDipDistance=0.17`) + ركلة pitch أمامية + نبضة FOV — كلها تتناسب مع قوة الاصطدام.
- **FOV ديناميكي:** 78 أساسي +7 عند الركض بانتقال ناعم.
- كل القيم أعلاه `@export` قابلة للضبط من Inspector ضمن فئات مرتبة.

### Blur الكاميرا (مُزيل)
- أُضيف في البداية نظام Depth of Field عبر `CameraAttributesPractical`، ثم **أُزيل بالكامل** بطلب المستخدم: التصديرات، المتغير `__attrs` و`__blurSpike`، كتلة الإنشاء في `_ready()`، والتحديث في `_process()`.
- لم يتبقَّ أي أثر له في السكربت.

---

## 7) إصلاح تدهور الأداء التدريجي في توليد العالم

**التاريخ:** 24 أغسطس 2026
**الوصف:** إصلاح انخفاض FPS كلما استكشف اللاعب أكثر في Level 0 — كان سببه تراكم الشانكات المحمّلة دون إزاحة فعلية، مع تكاليف متكررة أخرى في `Scripts/WorldGen/WorldGen.gd`.

### السبب الجذري: عدم توازن التحميل/الإزاحة
- **التحميل** يضيف مربعًا بمدى ±`ViewDistance/2` شانكًا (±7 عند ViewDistance=15).
- **الإزاحة** كانت تشترط مسافة إقليدية ثلاثية الأبعاد > ViewDistance كاملة (15) شاملة محور Y.
- النتيجة: أي شانك يبقى داخل قرص نصف قطره 15 حول اللاعب لا يُحذف أبدًا — فكلما تجول اللاعب تراكمت منطقة ضخمة خلفه من الأضواء والمجسمات والتصادمات ظلّت تُحسب في كل إطار → FPS ينخفض تدريجيًا ويرتبط بمسار الاستكشاف.

### الإصلاحات في `UpdateChunks()`
1. **إزاحة متماثلة مربعة:** حذف أي شانك يتجاوز `extent + 1` على أي محور أفقي (hysteresis شانك واحد لمنع اهتزاز التحميل على الحدود)، و`|dy| > 2` للطوابق. العدد المحمّل الآن ثابت ≈ 17×17×3 بدلًا من النمو مع الاستكشاف.
2. **كاش صور الأرضيات:** قاموس جديد `LoadedImages` يحفظ `Image` المفكوك بجانب كل `Texture2D` — كان `get_image()` يفك ضغط النسيج من جديد في كل تكة توليد (كل ثانيتين) ×3 طوابق.
3. **تنظيف الكاش:** صور الطوابق البعيدة تُمحى مع خرائطها.
4. **سقف `PlayerSpawns`:** 512 مدخلًا كحد أقصى بدل نمو غير محدود مع كل شانك ظهور.

### ملاحظة ضبط
- `ViewDistance = 15` في Globals يعني ~675 شانكًا محمّلًا دائمًا (15×15×3 طوابق) — إن رغبت بأداء أعلى يمكن خفضه إلى 10–12 من config بدون أي تغيير كودي.

---

## 8) تحسينات أداء إضافية + إصلاح انهيار Level 4

**التاريخ:** 24 أغسطس 2026
**الوصف:** بعد القسم 7 بقي الأداء ضعيفًا، وأظهر Level 4 خطأ وصول لخاصية غير موجودة.

### إصلاح الخطأ (`Invalid access to 'IsPlayerSpawn' on Node3D`)
- السطر الخاص بجمع نقاط الظهور كان **خارج حارس** `if ("Init" in chunk && "SetSeed" in chunk):` بسبب مسافة بادئة ناقصة — فكان يُنفَّذ على كل الشانكات بما فيها `L4T1Chunk` الذي لا يحمل أي سكربت.
- عاد إلى داخل الحارس؛ الشانكات غير المبرمَجة تُتخطى بأمان الآن.

### تحسين الأضواء (`WorldGen_Chunk.gd`)
- صيغة `distance_fade_begin` كانت مربوطة بـ ViewDistance وتصل سقف 75م → آلاف OmniLights نشطة في آن واحد (~4 أضواء × مئات الشانكات × الطوابق).
- الصيغة الجديدة مستقلة عن ViewDistance: بدء التلاشي عند `lightFadeScale × 3` ≈ **25م** وانطفاء كامل عند ~33م — الضباب يقطع الرؤية عند 40م أصلًا فالفارق البصري معدوم، والوفر في Forward+ ضخم.

### خفض ViewDistance الافتراضي
- `Globals.ViewDistance`: ‏15 ← **12** (من مربع 31×31×3 ≈ 867 شانكًا إلى 25×25×3 ≈ 507).
- مع مدى الرؤية بالضباب (40م = 4 شانكات) لا فرق بصريًا؛ ما يزال قابلًا للتجاوز من `config.json`.

---

## 9) SSR + SSAO + SSIL للمستويين 0 و4 وتقوية ضباب Level 0

**التاريخ:** 24 أغسطس 2026
**الوصف:** تفعيل المؤثرات الشاشية الثلاثة في `Scenes/Level 0.tscn` و`Scenes/Level 4.tscn` بإعدادات خفيفة واحترافية، وإعادة تفعيل الضباب الحجمي في Level 0 بكثافة أعلى مع تعويض التكلفة على مستوى المشروع.

### الإعدادات المشتركة (خفيفة + واقعية)
- **SSR** (انعكاسات): `ssr_max_steps = 48` بدل 64 الافتراضي و`fade_out = 1.5` — انعكاسات قريبة سريعة الخبوت، أرخص بـ ~25%.
- **SSAO** (إظلام تلامسي): نصف قطر 0.8 وحِدّة 2.5 (L0) / 2.0 (L4) — ظلال تلامس عميقة عند الزوايا والأرجل.
- **SSIL** (إضاءة غير مباشرة): شدة 0.8 (L0) / 0.7 (L4) — نزيف لوني خفيف واقعي دون تلويث.
- جودة المعالجة LOW (=1) كانت مضبوطة مسبقًا في `project.godot` لكليهما.

### تقوية الضباب الحجمي في Level 0
- أُعيد `volumetric_fog_enabled = true` (كان موقفًا مؤقتًا).
- الكثافة: `0.015` ← **`0.04`** — ضباب أصفر كثيف يلتقط أعمدة ضوء الفلورسنت.
- `anisotropy = 0.45` لتوجيه التشتت نحو المصابيح (أشعة أوضح).
- ألوان albedo/emission التي ضبطتها سابقًا بقيت كما هي.

### تعويض الأداء في `project.godot`
- `volumetric_fog/volume_size = 48` و`volume_depth = 48` (بدل 64) — عمل الفسحة أقل بنحو النصف، فيبقى صافي كلفة الضباب الأقوى محدودًا.
- ملاحظة: ضباب Level 4 ما يزال معطلًا كما أوقفته — سطر واحد يعيده إن رغبت (`volumetric_fog_enabled = true`).

---

## 10) أنيميشن واقعي لباب TheHub بزاوية 95 درجة

**التاريخ:** 25 أغسطس 2026
**الملفات:** `Scripts/WorldGen/Levels/TheHub_Door.gd`
**الوصف:** استبدال الالتفاف اللحظي للباب بأنيميشن كامل من الكود عبر Tween، مع إزالة `_process` و`_ready` نهائيًا.

### الحركة
- **الفتح:** دوران `95°` (كان 90°) خلال `1.1 ثانية` بمنحنى `TRANS_CUBIC / EASE_OUT` — دفعة سريعة في البداية ثم تباطؤ واقعي عند نهاية المدى.
- **الإغلاق:** عودة لـ `0°` خلال `0.9 ثانية` بـ `EASE_IN_OUT` — تسارع ثم تباطؤ في الإطباق.
- المحور هو عقدة `Door` الداخلية المثبتة عند حافة الباب أصلًا (مفصلة حقيقية)، فالقرص والاصطدام والنص يدورون معًا.
- كل القيم قابلة للضبط من Inspector: `OpenAngleDegrees` (10–170)، `OpenDuration`، `CloseDuration`.

### تنظيف
- حذف `_process` الذي كان يعمل كل إطار (ومعه `await process_frame` المتكرر قبل تهيئة الشانك) — لا استهلاك CPU الآن بين التفاعلات.
- حالة `IsAnimating` تمنع التفاعل أثناء الحركة (لا انعكاس مفاجئ في منتصف الأرجحة).
- حذف `INIT_ROTATION` والتعليق `TODO` وسطر `print`.

---

## 11) SceneLoader موحّد لكل انتقالات المشاهد

**التاريخ:** 25 أغسطس 2026
**الملفات:** `Scripts/SceneLoader.gd` (جديد)، `project.godot`، `Scripts/MainMenu.gd`، `Scripts/Character/CharacterMovement.gd`، `Scripts/Globals.gd` — **حُذف:** `Scenes/LevelLoader.tscn` و`Scripts/WorldGen/LoadLevel.gd`
**الوصف:** نظام تحميل شاشات كامل (CanvasLayer) أصبح الـ autoload الرسمي الوحيد للانتقال بين المشاهد.

### المزايا
- تحميل في Thread مع شريط تقدم حقيقي، 3 محاولات إعادة ثم fallback متزامن عند الفشل.
- شاشة تحميل أجواء رعب: تعتيم تدريجي (fade)، vignette أحمر داكن بـ shader، عنوان يرتجف عشوائيًا، spinner، نصائح Backrooms فردية، حد أدنى للعرض 0.5 ثانية.
- `restart_current_scene()` جاهزة لإعادة تشغيل المستوى بنفس الشاشة.
- إشارات: `loading_started / loading_finished / loading_failed`.

### التكييف للمشروع
- حذف استدعاءات `GraphicsSettings` و`Net` غير الموجودة (كانت ستكسر الترجمة).
- استبدال نصائح اللعب الجماعي بنصائح فردية تناسب اللعبة.
- إصلاح: الـ spinner كان يعمل 60 إطار/ثانية حتى وهو مخفي (يُوقف الآن عبر `visibility_changed`)؛ التقاط موضع العنوان الأساسي بعد اكتمال layout (كان سيقفز لأعلى الزاوية أول مرة).

### التوصيل
- مسجّل autoload باسم `SceneLoader` في `project.godot`.
- `MainMenu.StartGame()` ← `SceneLoader.goto_scene(...)`.
- `CharacterMovement.ChangeLevel()` ← `SceneLoader.goto_scene(Level.resource_path)` مباشرة.
- حذف `Globals.LevelToLoad` ومسار LevelLoader.tscn بالكامل — لا انتقال مشاهد خارج النظام الجديد.

### إصلاح: الشاشة الرمادية بعد التحميل (25 أغسطس 2026)
- **العَرَض:** دخول أي مستوى عبر اللودر يظهر شاشة رمادية فارغة.
- **التشخيص** (عبر تشغيل headless مع بروب آلي): مُحمِّل Godot المتوازي (`load_threaded_request` بأي إعداد، وحتى `ResourceLoader.load` من خيط يدوي) يُفشل تحليل سلاسل الموارد العميقة في هذا المشروع بخطأ Parse Error فارغ يتسلسل من `.tres` القواميد حتى مشهد المستوى — بسبب PackedByteArray الضخمة المضمنة في الميشات. التحميل المتزامن على الخيط الرئيسي يعمل دائمًا.
- **الحل:** تحميل متزامن على الخيط الرئيسي يتم **خلف ستارة الـ fade المعتمة** فلا يظهر تجمد الاطار على اللاعب؛ ثم امتلاء الشريط وفتح الستارة.
- **تحصين:** بناء واجهة اللودر في `_init` بدل `_ready` — لا يمكن فشل أي استدعاء مبكر.
- **تحقق آلي:** بروب headless أكد: اكتمال التحميل، current_scene صحيح، كاميرا اللاعب نشطة، 15 شانكًا، صفر أخطاء.

### إصلاح إضافيان (25 أغسطس 2026)
1. **شريط التحميل ظاهر دائمًا بـ 0%:** سطر `hide()` فُقد أثناء إعادة كتابة `_init` — أُعيد إلى `_init` و`_ready` معًا؛ الواجهة مخفية إلا أثناء التحميل الفعلي.
2. **رمادي دائم عند الدخول من باب مرحلة** (بينما القائمة ← الهاب تعمل): بروب محاكى مسار الباب أثبت أن العالم يُولَّد كاملًا (225 شانكًا) لكن `P2_CAMERA=null`. السبب: إطفاء كاميرا المشهد القديم أولًا يجعل كاميرا المشهد الجديد لا تدّعي النشاط تلقائيًا (Godot لا يعيد التعيين ما دامت كاميرا أخرى مسجلة في الـ Viewport حتى لو غير نشطة)، ثم يُحرَّر المشهد القديم فيبقى العرض بلا كاميرا = لون الخلفية الرمادي. الحل: حذف منطق الإطفاء واستبداله بـ `__activate_camera__()` التي تفعّل أول `Camera3D` داخل المشهد الجديد صراحةً بعد التبديل (لا تؤثر على مشاهد 2D بلا كاميرا).
- **تحقق نهائي:** `P2_CAMERA=Camera3D` نشطة + 225 شانكًا + اللاعب داخله، عبر مسار الهاب ← Level 0 المحاكى للباب.

---

## 12) قائمة رئيسية جديدة بالكود + حذف multiplayer

**التاريخ:** 26 أغسطس 2026
**الملفات:** `Scripts/MainMenu.gd`، `Scripts/UI/MenuOverlay.gd` (جديد)، `Scripts/UI/CreditsPanel.gd` (جديد)، `Scenes/MainMenu.tscn` — **حُذفت:** `Scripts/ConfigManager.gd`، `Scripts/SetLabelValue.gd`، `Scripts/VideoBackground.gd`
**الوصف:** استبدال القائمة الرئيسية القديمة بنظام مبني بالكود بالكامل، مع حذف كل آثار الـ multiplayer.

### القائمة الرئيسية (`MainMenu.gd`)
- فيديو الخلفية + vignette + grain shaders + تعريض 35%.
- أزرار: **PLAY** (يحمّل الهاب عبر SceneLoader)، **SETTINGS** (معطل حاليًا، زر رمادي واضح)، **CREDITS**، **EXIT**.
- انترو أنيميشن للأزرار + نبض "BACKROOMS" + تنفس vignette.
- كل بناء الواجهة بالكود — `MainMenu.tscn` = العقدة الجذرية فقط.

### MenuOverlay (`Scripts/UI/MenuOverlay.gd`)
- بنية مشتركة للـ overlays: خلفية داكنة + حاوية محتوى + زر BACK + `back_requested` signal.
- يدعم ESC للعودة + ظلال زر احترافية + عنوان صفحة.

### Credits (`Scripts/UI/CreditsPanel.gd`)
- امتداد MenuOverlay، نصوص اللعبة مع فاصل وشكر للعب.

### المحذوف
- `ConfigManager.gd`، `SetLabelValue.gd`، `VideoBackground.gd` — معزولة عن القائمة القديمة بالكامل (لا مراجع في أي ملف).
- `MultiplayerPanel.gd` — لم يكن موجودًا مسبقًا (لم يُحذف شيء إضافي).
- `multiplayer.multiplayer_peer` cleanup في القائمة القديم، زر MULTIPLAYER، Net.play_solo، GlobalSelf، Nickname logic — كلها حُذفت.
- تعليقات السكربتات الجديدة حُذفت بالكامل (قاعدة Clean Code).

### التحقق
- بروب headless: القائمة ← فتح Credits ← إغلاق ← الضغط على PLAY → `current_scene=TheHub` مع `Camera3D` نشطة وصفر أخطاء.

### تنظيفات مصاحبة
- حُذف `JumpTimer` (Timer node) واستُبدل بعدّادات زمنية خفيفة.
- `Running` و`CurrentSpeed` و`CurrentDirection` محفوظة بنفس الأسماء لأي استخدام خارجي.
- لا أصوات خطوات بعد (لا أصول صوتية في المشروع) — نقطة ربط مستقبلية عند عبور دورة الـ bob.

---

## 13) قائمة إيقاف مؤقت موحّدة

**التاريخ:** 26 أغسطس 2026
**الملفات:** `Scripts/PauseMenu.gd` (جديد)، `Scenes/PauseMenu.tscn` (جديد)، `Scenes/Level 0.tscn`، `Scenes/Level 4.tscn`، `Scenes/Level TheHub.tscn`، `Scripts/SceneLoader.gd`، `Scripts/MainMenu.gd`
**الوصف:** قائمة إيقاف مؤقت مبنية بالكود بنفس أسلوب القائمة الرئيسية، مضافة إلى المستويات 0 و4 والهاب.

### القائمة (`PauseMenu.gd`)
- أزرار: **RESUME**، **RESTART** (إعادة تشغيل المستوى عبر `SceneLoader`)، **SETTINGS** (معطّل)، **MAIN MENU**، **QUIT**.
- `process_mode = ALWAYS` مع `ESC` للتبديل — تعمل حتى أثناء الإيقاف.
- الطبقة `layer = 10` فوق شاشة التحميل والواجهات.
- تعتيم الخلفية + انيميشن فتح/إغلاق، والماوس يظهر تلقائيًا عند الفتح ويُلتقط عند الاستئناف (يُعاد ضبطه في `MainMenu._ready`).

### الإصلاحات أثناء التنفيذ
- تعارض أنواع: الحاوية كانت `Control` بدل `VBoxContainer` — أُصلح.
- مرجع `uid` غير صالح لدالة `PauseMenu.gd` — حُذف (يُحل عبر المسار).
- إعادة التشغيل: التحميل الفوري لمحتوى `goto_scene` (كان معلّقًا عند 0% أو 100%) — استُبدل بمسار شاشة التحميل الكامل `goto_scene(current_scene.scene_file_path)` الذي أُعيدت كتابته (راجع القسم 11).

### التحقق
- بروب headless أكد: القائمة تفتح وتغلق، حالة الإيقاف تذهب/تعود، RESTART يقود عبر اللودر، MAIN MENU يقوم بتحميل MainMenu بنجاح.

---

## 14) شبكة ملاحة (NavigationMesh) لتوليد العالم

**التاريخ:** 26 أغسطس 2026
**الملفات:** `Scripts/WorldGen/WorldGen.gd`
**الوصف:** توليد `NavigationRegion3D` محمّل ديناميكيًا خلف كل جيل شانكات — بُنية جاهزة لأي عدو يتحرك لاحقًا (بدون أعداء بعد).

### الآلية
- عقدة `NavigationRegion3D` تُنشأ وتُضاف تحت العقدة `World`، تُعاد إعادة توليد شبكتها عبر `RebuildNavigationMesh()` بعد كل `UpdateChunks()`.
- بناء شبكة يدوي: `set_vertices()` + `add_polygon()` على `NavigationMesh` مباشرة (لا `add_vertices` — واجهة Godot 4 يجب أن تضبط القمم والبوليجونات معًا).
- الجدران تُعالج كعوائق: `_is_wall_active()` تفحص وجود العقدة و`wall.visible` (الجدران المعطّلة تُخفي نفسها في `WorldGen_RandomObject`).
- المعاملات: `wall_margin = 0.6`، `agent_radius = 0.4`، `agent_height = 1.8`، `max_climb = 0.3`، `cell_size = 0.25`، `cell_height = 0.2`.
- البناء مؤجّل بـ `call_deferred("RebuildNavigationMesh")` مع حارس قمم فارغة — يعالج انهيار مخزن مؤقت GPU ("Condition '!buffer.driver_id' is true") الذي ظهر عند البناء مباشرة بعد `UpdateChunks`.

### التحقق
- بروب headless: `TEST_NAV=true`, 121 شانكًا / 121 بوليجونًا / 484 قمة، وصفر أخطاء.

---

## 15) أشعة ضوء حجمية لـ Level 4 + إزالة git نهائيًا

**التاريخ:** 30 أغسطس 2026
**الملفات:** `Scripts/LightRays/LightRays.gd` (جديد)، `Scripts/LightRays/LightRays.gdshader` (جديد)، `Scenes/Level 4.tscn` — **حُذف:** مجلد `.git/`
**الوصف:** تأثير أشعة ضوء حجمية (Volumetric Light Rays) بأسلوب Radial Blur Occlusion على Level 4، وفصل تام عن git.

### هيكل المشهد الجديد في `Level 4.tscn`
```
Level 4
├── LightRaysUI (CanvasLayer, layer 5)
│   ├── ColorRect_LightRays (ColorRect + ShaderMaterial + LightRays.gd)
│   └── RaysViewportContainer (SubViewportContainer, visibility_layer = 0)
│       └── RaysViewport (SubViewport: own_world_3d=false, transparent_bg=true, clear ALWAYS, update ALWAYS)
│           ├── WorldEnvironment (background_mode = 0 — بلا سماء)
│           └── Camera3D_Viewport (Camera3D: current=true)
└── Player/Head/Camera3D
	└── RemoteTransform3D (use_global_coordinates=true) ← RaysViewport/Camera3D_Viewport
```

### آلية العمل
- كاميرا الإخفاء (`Camera3D_Viewport`) تتبع كاميرا اللاعب عبر `RemoteTransform3D` وتُصيّر العالم من نفس الزاوية دون سماء (الخلفية شفافة) → تُغذي نسيج الـ `SubViewport` بقناع إخفاء (1) حيث الأجسام و(0) حيث الخلفية.
- `SubViewport.own_world_3d = false` يشارك عالم المستوى (فيصوّر الشانكات والأعمدة) بينما البيئة المحلية تنظّف السماء.
- الشيدر (`LightRays.gdshader`) بأسلوب Radial Blur: 200 عينة على طول الشّعاع بين الفراغ والضوء، تُجمّع الإخفاء المتراكم مع تلاشي حسب زاوية النظر، `render_mode unshaded, blend_add` ليُضاف التوهج على الشاشة.
- السكربت (`LightRays.gd`): يضبط `light_source_pos` من إسقاط نقطة نسبية لاتجاه `DirectionalLight3D`، و`light_source_dir` و`camera_dir` كل إطار، ويعيّن نسيج `light_color` من لون الضوء الفعلي، وينشئ `ViewportTexture` للـ SubViewport عبر الكود، ويوازن حجم الـ SubViewport مع الشاشة.
- عقدة الاختبار مغلقة بالكامل (لا تُرسم ولا تُسمع) لكنها تبقى تُصيّر (`update_mode = ALWAYS`).

### قواعد
- في السكربت والشيدر صفر تعليقات (Clean Code).
- المادة `resource_local_to_scene = true` لتجنّب مشاركة الأضرار.

### التحقق
- بروب headless: تحميل Level 4 بلا أخطاء، `ColorRect_LightRays` + مادة شيدر، `SubViewport` شفاف، `Camera3D_Viewport` نشطة، `RemoteTransform3D` موصول بالمسار الصحيح — كلها `=true`.

### إزالة git
- حُذف مجلد `.git/` بالكامل (`Remove-Item -Recurse -Force`) — المشروع لم يعد مرتبطًا بأي مستودع ولا تتبّع للملفات.

> **تعديل لاحق (القسم 16):** نظام أشعة الإخفاء في القسم 15 استُبدل بالكامل بالفوليومتريك فوج الأصلي لضعف التأثير وثقله — انظر القسم 16.

---

## 16) استبدال نظام أشعة الإخفاء بالفوليومتريك فوج الأصلي

**التاريخ:** 30 أغسطس 2026
**الملفات:** `Scenes/Level 4.tscn` — **حُذف:** `Scripts/LightRays/LightRays.gd`، `Scripts/LightRays/LightRays.gdshader` + كامل شجرة `LightRaysUI` من المشهد
**الوصف:** استبدال نظام أشعة الضوء المخصص (SubViewport + شيدر 200 عينة/بكسل) بأشعة الشمس الحجمية الأصلية في Godot (Volumetric Fog) — نتيجة أوضح، وخفيفة على الأجهزة.

### المشاكل المكتشفة في النظام السابق
1. **الثقل:** كاميرا الإخفاء تُصيّر world المستوى كاملًا مرة ثانية كل إطار (مئات الشانكات) + شيدر الـ 200 عينة لكل بكسل عند الدقة الكاملة.
2. **التأثير الضعيف:** عقدة `RemoteTransform3D` (التي تجعل كاميرا الإخفاء تتبع كاميرا اللاعب) غابت من المشهد — الكاميرا بقيت ثابتة عند الموقع الابتدائي لذا قناع الإخفاء لم يطابق الرؤية.
3. الفوليومتريك فوج كان **معطّلًا** رغم أن المشروع مُجهّز له أصلًا: `volumetric_fog/volume_size=48` في `project.godot`، وكل أضواء الشانكات تحمل `light_volumetric_fog_energy = 2.0–4.0`.

### الحل الجديد (أشعة شمس حجمية أصلية)
#### `Scenes/Level 4.tscn` — Environment:
```ini
volumetric_fog_enabled = true
volumetric_fog_density = 0.05
volumetric_fog_albedo = Color(0.6, 0.64, 0.7, 1)   # رمادي مزرق مطابق لأجواء المستوى
volumetric_fog_anisotropy = 0.35                    # تشتت أمامي نحو الشمس = أشعة أوضح
volumetric_fog_gi_inject = 0.5
volumetric_fog_length = 150.0                       # تمدد الأشعة حتى الأفق
```
#### `DirectionalLight3D` (الشمس — اتجاهها صحيح أصلًا: تنزل للأمام للأسفل):
```ini
light_energy = 1.4                 # تقوية الشمس
light_volumetric_fog_energy = 3.0  # طاقة الضباب الحجمي للشمس — مصدر الأشعة الواضح
```

### لماذا هو أفضل
- **واقعي:** المحرك يحسب تبعثر الضوء داخل حجم 3D فعلي — أشعة تظهر عبر الفجوات/النوافذ والفراغات وليس وهجًا سطحيًا مرسومًا فوق الشاشة.
- **خفيف:** فسحة `48³` (مضبوطة مسبقًا في المشروع) لا تُعاد تصيير العالم؛ لا كاميرا ثانية، ولا شيدر ثقيل لكل بكسل — إزالة النظام القديم تعني 200 عينة أقل لكل بكسل وتمريرة تصيير أقل.
- **جاهز أصلًا:** قائمة الديَبَغ تعرض الحالة، وأضواء الشانكات كانت ماعدّة لـ `light_volumetric_fog_energy` منذ التصميم الأصلي.
- **الانعكاسات:** `SSR` مفعّل مسبقًا (48 خطوة) فيعمل مع أشعة الشمس على الأسطح.

### التحقق
- بروب headless: `LightRaysUI` غير موجودة، `volumetric_fog_enabled=true`، الكثافة 0.05، `anisotropy=0.35`، `length=150`، `light_energy=1.4`، `light_volumetric_fog_energy=3.0` — كلها متطابقة بلا أخطاء تحميل.

### ضبط مفتوح (من Inspector)
| المفتاح | الأثر |
|---|---|
| `light_volumetric_fog_energy` | قوة الأشعة (زيدها → أشعة أوضح) |
| `volumetric_fog_density` | كثافة الحجم (زيادة → ضباب أعمق وأشعة أظهر) |
| `volumetric_fog_anisotropy` | درجة تركز التشتت نحو الشمس |
| `volumetric_fog_length` | مدى امتداد الأشعة |

---

## 17) إصلاح اختفاء السماء + انعكاسات الأرضية + far=40

**التاريخ:** 30 أغسطس 2026
**الملفات:** `Scenes/Level 4.tscn`، `Prefabs/Player.tscn`، `Chunks/L4T2Chunk.tscn`، `Chunks/L4T3Chunk.tscn`، `Textures/Fabric039/Fabric039_GlossyFloor.tres` (جديد)
**الوصف:** ثلاثة إصلاحات بطلب المستخدم: إعادة إظهار السماء، إضافة انعكاسات للأرضية في Level 4، وجعل مسافة قصّ الكاميرا 40م مع تلاشٍ سلِس بالضباب.

### إصلاح اختفاء السماء (السبب الجذري)
- تفعيل الفوليومتريك فوج في القسم 16 جعل السماء تختفي لأن القيمة الافتراضية لـ `volumetric_fog_sky_affect` في Godot 4.7 هي **1.0** (الضباب الحجمي يُرسم فوق السماء بالكامل) — لا 0 كما قد تُوحي الوثائق. تحقق بروب headless أكد ذلك.
- **الحل:** `volumetric_fog_sky_affect = 0.0` → الفوليومتريك يمسّ الأجسام فقط ولا يغطي السماء، فأشعة الشمس تبقى على الضباب والسماء تظهر.
- إضافة `fog_sky_affect = 0.0` أيضًا: الضباب العميق (2D) لا يغسل السماء بعد الآن؛ الأفق والسماء تُرى بوضوح بينما الأجسام القريبة ما تزال تغرق تدريجيًا بالضباب.

### انعكاسات الأرضية (Level 4)
- **اكتشاف:** `SSR` كان **معطلًا** رغم وجود إعداداته (`ssr_max_steps`) — النصفّات الإعدادية موجودة دون `ssr_enabled = true`. فعّلته في `Scenes/Level 4.tscn`.
- مادة الأرضية المشتركة `Fabric039_4K-JPG.tres` يُستخدمها أيضًا إطار النوافذ في `Prefabs/Lvl4Windows.tscn` فتجنّبت تعديلها، وأنشأت مادة جديدة منفصلة **`Textures/Fabric039/Fabric039_GlossyFloor.tres`**: `roughness = 0.1` (بدل النسيج الخشن)، مع الاحتفاظ بالنسيج الملون وخرائط Normal وAO.
- طبّقت المادة على عقدة `Floor` في `L4T2Chunk` و`L4T3Chunk` فقط (L4T1Chunk فارغ أصلًا) — أرضية لامعة عاكسة (أرض مكتب مبلّلة) تُظهر انعكاسات المصابيح والجدران والنوافذ عبر SSR دون المساس بأي مادة أخرى.

### كاميرا اللاعب far=40 + تلاشٍ سلِس
- `Prefabs/Player.tscn` ← `Camera3D.far`: 70 ← **40**.
- بدل القصّ الصلب عند حدود البُعد، الضباب العميق الكثيف (`fog_density = 1.0` حتى `fog_depth_end = 50`) يخفي الأجسام تدريجيًا قبل الوصول إلى 40م فيختفي أي «شكل سطحي» للحافة البعيدة — وسلوك مصاحب أسرع (عرض شانكات أقل).
- ملاحظة: التغيير على اللاعب المشترك يؤثر على كل المستويات؛ في المستويات الضبابية لا فرق بصري، وإن احتاج TheVoid مدى أطول يمكن تجاوز `far` عبر سكربت حسب `LevelName`.

### التحقق
- بروب headless: `ssr_enabled=true`، `fog_sky_affect=0`، `volumetric_fog_sky_affect=0`، `far=40`، وأرضية T2/T3 بطبقة `roughness=0.1` مع نسيج ملون — كلها متطابقة بلا أخطاء.

---

## 18) تلاشي حافة far بشكل ضبابي + VoxelGI لظل متشتت

**التاريخ:** 30 أغسطس 2026
**الملفات:** `Scenes/Level 4.tscn`، `Scripts/WorldGen/VoxelGIBaker.gd` (جديد)
**الوصف:** معالجة شكوى «حدود far تظهر سطحية» عبر جعل النهاية تذوب بالضباب منسجمة مع السماء، وتنفيذ اقتراح المستخدم بتفعيل VoxelGI لظل منتشر غير متشتت.

### إخفاء حافة far بشكل ضبابي
- **السبب:** رغم أن الضباب شبه الكامل عند 40م، كان يتبقى ~1% من الهندسة غير مُضبّبة تقطع على خلفية السماء الساطعة، فيظهر خط سطحي رفيع عند حد `far`.
- **الحل:**
  - `fog_density`: 1.0 ← **1.4** → تغطية ضبابية شبه كاملة (≈100%) قبل الـ 40م بمسافة مريحة، فلا يوجد جسم مرئي يلامس حدود القص.
  - `fog_sky_affect`: 0.0 ← **0.35** → الأفق يُطلى جزئيًا بلون الضباب فيندمج «جدار الضباب» مع السماء خلفه، فالانتقال تلاشٍ طبيعي (ضباب جوي) بدل خط قطع؛ والسماء العلوية تبقى بمنظرها البانورامي واضحًا.

### VoxelGI — ظل متشتت (اقتراح المستخدم)
- أضفت عقدة **`VoxelGI`** كطفل للاعب في Level 4 فقط، بحجم `Vector3(40, 16, 40)` (منطقة 40م حول اللاعب) — **المنطقة تتبع اللاعب** بدل التثبيت عند الأصل، لأن عالم 300×300.
- VoxelGI في Godot 4.7 له خاصيتان فقط مهمتان: `size` وطريقة `bake()` (لا يوجد resolution/bake_mode — الدقة الافتراضية 128³ كافية).
- سكربت جديد `Scripts/WorldGen/VoxelGIBaker.gd` (extends VoxelGI): يُعيد الـ bake تلقائيًا كل **2.5 ثانية** إذا تحركت الكاميرا **4م** فأكثر (مع أول 3 عمليات bake إجبارية فور الإقلاع) — فيتحدّث الـ GI مع تولد الشانكات الجديدة أثناء السير دون هزات متكررة.
- أمان headless: يجتاز السكربت الـ bake تمامًا عند التشغيل headless (لا GPU).
- النتيجة: ضوء غير مباشر يُحسب من جميع الإضاءات في المنطقة، يملأ الظلال بشظايا منعكسة فيتشتت الظلام الصلب ويصبح الظل ناعمًا ومنتشرًا — مع أشعة الشمس الفوليومتريك يظهر عمق وحجم أيقوني.

### التحقق
- بروب headless: `fog_density=1.4`، `fog_sky_affect=0.35`، عقدة `Player/VoxelGI` موجودة بالحجم (40,16,40) والسكربت محمّل و`bake()` متاح — بلا أخطاء.

### ملاحظات
- أداء: الـ bake كل 2.5ث عند الحركة كلفة خفيفة؛ إن لاحظت هزّة مؤقتة عند دورات الـ bake يمكن رفع `bake_interval` من السكربت (متغير `bake_interval` export على العقدة في المحرر).
- المنطقة 40م ≈ مدى الرؤية، فأي ظل خارجها يبقى حادًا إلى أن يصل اللاعب — طبيعي.

---

## 19) ظلال منكسرة وواقعية بدون VoxelGI (SSAO + SSIL + SDFGI)

**التاريخ:** 30 أغسطس 2026
**الملفات:** `Scenes/Level 4.tscn`، `project.godot`
**الوصف:** بعد أن أزال المستخدم عقدة VoxelGI، طلب استبدال الظلال السطحية بظلال منكسرة وواقعية — نُفّذ بدون VoxelGI عبر ثلاث طبقات تكمل بعضها في `Scenes/Level 4.tscn` (Environment + الشمس) وفلترة ظلال أعلى في المشروع.

### ما الذي تغير (Level 4)
- **`ssao_enabled = true` + ضبط (`ssao_radius = 1.2`، `ssao_intensity = 2.2`، `ssao_power = 2.0`، `ssao_detail = 0.6`)** — SSAO يخطّ الظلال عند الزوايا والحواف المتلامسة (contact shadows) فتتكسر الظلال عند الانحناءات بدل سطح واحد أملس.
- **`ssil_enabled = true` + ضبط (`ssil_radius = 6.0`، `ssil_intensity = 1.1`)** — SSIL يحسب الضوء غير المباشر الفوري (Screen-Space Indirect Lighting) فيغمر جوانب الظل بانعكاسات ناعمة فتنكسر هشاشة الظل الصلب.
- **`sdfgi_enabled = true` + `sdfgi_use_occlusion = true`** — SDFGI هو بديل الـ GI الديناميكي الرسمي المناسب للمساحات الكبيرة (يمتد حتى ~205م بدل منطقة VoxelGI الصغيرة)، يتحدث مباشرة مع تولد الشانكات بلا إدارة bake، بجودة منخفضة مسبقة في المشروع (`probe_ray_count=0`) للحفاظ على الأداء، ويملأ الظلال بضوء السماء والانعكاسات الملوّنة.
  - `sdfgi_energy = 1.05` و`sdfgi_bounce_feedback = 0.55` لسطوع انعكاس متوازن.
  - يتغذى منه `volumetric_fog_gi_inject = 0.5` فتصبح أشعة الشمس الفوليومتريك ملوّنة بضوء GI.
- **`shadow_blur = 2.0` على ضوء الشمس** (PCF17 بدل PCF13 الافتراضي) → حواف ظلال أنعم؛ والشمس مبقاة `shadow_opacity = 0.8` حتى لا يكون غاء الظل كاملاً (يمر ضوء).

### المشروع كله
- `rendering/lights_and_shadows/directional_shadow/soft_shadow_filter_quality = 3` (PCF17) — جودة فلترة ظل الشمس فوق default=2، فيستفيد منها كل المستويات.

### التحقق
- بروب headless: `ssao_enabled=true`، `ssil_enabled=true`، `sdfgi_enabled=true`+`use_occlusion=true`، `shadow_blur=2`، `soft_shadow_filter_quality=3`، وعدم وجود أي عقدة VoxelGI — متطابقة بلا أخطاء.

### ملاحظات
- الأداء مسبقًا مضبوط: `ssao/quality=1` و`ssil/quality=1` و`sdfgi probe_ray_count=0` في `project.godot` — أي التفعيل بدقة منخفضة رخيصة.
- إن بدت الظلال معتمة أكثر من اللازم يمكن خفض `ssao_intensity` أو `sdfgi_energy` من الـ Environment في المحرر.

---

## 20) إزالة SDFGI الثقيل + شيدر GI خفيف لمحاكاة ملء الظلال

**التاريخ:** 30 أغسطس 2026
**الملفات:** `Scenes/Level 4.tscn`، `Scripts/PostFX/GIFake.gdshader` (جديد)
**الوصف:** SDFGI تسبّب هبوطًا بالفريمات حتى 2 فقط، فأُزيل نهائيًا؛ وعُوّض مظهره (ملء الظلام بضوء محيطي ملوّن) بشيدر كامل الشاشة خفيف + تعديلات إضاءة رخيصة، مع أداء أعلى بكثير.

### إزالة SDFGI
- حُذفت أسطر `sdfgi_enabled` / `sdfgi_use_occlusion` / `sdfgi_energy` / `sdfgi_bounce_feedback` من `Environment_yk364`، وعُطّل تمامًا (`sdfgi_enabled=false`).
- إعدادات المشروع `global_illumination/sdfgi/*` بقيت (لا تُؤثر على ميزة معطّلة) لتسهيل إعادة التفعيل لاحقًا.

### بديل خفيف — شيدر GIFake (ملء الظل بالضوء المحيطي)
- ملف جديد **`Scripts/PostFX/GIFake.gdshader`** (canvas_item) على ColorRect كامل الشاشة داخل **CanvasLayer جديد `FX_Ambient`** (طبقة 0) في Level 4 — طبقة تحت PauseMenu (طبقة 10) فلا يمسّ القائمة، `mouse_filter=ignore` فلا يبتلع الإدخال.
- **كيف يعمل:** يعيّن إضاءة كل بكسل؛ في المناطق المظلمة (الظلال/الجوانب المظلمة) يرفعها نحو لون محيطي مزرق `ambient_tint` بمقدار يتناسب مع الظلمة (سلس smoothstep) → يحاكي انعكاس السماء الذي كان يفعله SDFGI، بينما المناطق الساطعة (النوافذ، أشعة الشمس، السماء) تبقى دون تغيير لا يغسلها.
- يضيف **فينيت خفيف** (طمس حواف الشاشة) لتأثير سينمائي عميق.
- الكلفة: تمرير Quad واحد بنسختين نسيج — أخف بكثير من GI حقيقي.

### التعديلات المصاحبة لتعويض GI والإضاءة الخفيفة
- `ambient_light_energy = 1.8` (بدل 1.0) → الضوء المحيطي من السماء يملأ الظلال بدل سحقها للأسود.
- `shadow_opacity = 0.6` (بدل 0.8) على الشمس → الظلال أفتح وأكثر نعومة، يمرّ ضوء.
- `volumetric_fog_ambient_inject = 1.0` (بدل `gi_inject=0.5` غير المجدي بلا GI) → الغلاف الجوي الفوليومتريك يتوهّج بضوء محيطي فيتوهّج الضباب البعيد بدل التعتيم.
- `adjustment_saturation = 1.1` و`adjustment_contrast = 1.04` — تشبّع خفيف يحاكي نبضات ألوان الانعكاس التي يضيفها GI، مع عمق.
- **تم الإبقاء** (رخيصة وبقيت مظهرًا منكسرًا): SSAO (حواف متلامسة)، SSIL (بونس فوري ناعم)، `shadow_blur=2` PCF17، الفوليومتريك فوج الحجم 48 (مضبوط مسبقًا في المشروع)، والـ SSR للأرضية العاكسة.

### التحقق
- بروب headless: `sdfgi_enabled=false`، `ambient_light_energy=1.8`، `volumetric_fog_ambient_inject=1.0`، `adjustment_saturation=1.1`، `shadow_opacity=0.6`، وعقدة FX موجودة بطبقة 0 وShaderMaterial محمّل والشيدر مسارًا سليمًا — بلا أخطاء.
- فريمات اللاعب/Kill لم تعد تُطبع لأن اللعبة تعمل بمعدل طبيعي (لا انكسار).

### ملاحظات
- كل قيم الشيدر متغيّرات uniform قابلة للضبط من المحرر على Node `FX_Ambient/ColorRect_Ambient` → ShaderMaterial: `ambient_strength` (قوة ملء الظل)، `dark_cutoff` (أي سطوع يُعتبر ظلًا)، `vignette_strength`.
- إن رأيت الفينيت مزعجًا ارفع `vignette_strength=0` من المحرر.

---

## 21) تخفيف GIFake + تقوية أشعة vol fog + إرجاع ضبابية far

**التاريخ:** 30 أغسطس 2026
**الملفات:** `Scenes/Level 4.tscn`، `Scripts/PostFX/GIFake.gdshader`
**الوصف:** ثلاثة إصلاحات بطلب المستخدم: (1) GIFake كان قويًا لدرجة طمس الفوليومتريك فوج وآثاره، (2) تقوية انكسار الضوء وظهور أشعة الشمس، (3) ضبابية far اختفت — أعيدها.

### 1) تخفيف GIFake (لم يعد يبلع الـ vol fog)
- الشيدر صار يلمس **الظلام الداكن فقط**: `dark_cutoff`: 0.45 ← **0.3** → البكسلات الرمادية (كضباب التدرج البعيد والأشعة) لا تُرفع بالمرة وتظل بلونها.
- قوة الملء: `ambient_strength`: 0.6 ← **0.22** → أقل من ثلث السابق.
- الفينيت: `vignette_strength`: 0.2 ← **0.08** (يلمح فقط).
- طبّقت القيم على المادة في المشهد (`shader_parameter/...`) وعلى افتراضات الشيدر معًا — فالنتيجة غير مغسولة ويظهر الفوليومتريك بوضوح.

### 2) تقوية انكسار الضوء وأشعة الشمس
- `light_volumetric_fog_energy` على الشمس: 3.0 ← **5.0** — طاقة الضوء المنكسر في الغلاف الفوليومتريك.
- `volumetric_fog_anisotropy`: 0.35 ← **0.65** — تشتت أمامي أقوى → أشعة شمس محددة وحادة عبر الضباب.
- `volumetric_fog_density`: أُضيف **0.06** (أسمك قليلًا) + `volumetric_fog_albedo` أفتح: `Color(0.65, 0.68, 0.74)` → انكسار أكثر سطوعًا في الهواء.
- مع GIFake الأضعف تظهر الأشعة كاملة دون طمس.

### 3) إرجاع ضبابية far
- السبب الرئيسي: GIFake القوي كان يرفع سطوع بكسلات الضباب البعيد فيمحو التدرج ويُظهر حدًّا سطحيًا. بتخفيفه عاد التدرج.
- إضافة: `fog_depth_curve`: 0.7579 ← **0.9** → الضباب «يدخل متأخرًا ويشتد بشدة» — المسافة القريبة صافية والبعيدة (قبل far=40) تُغطّى ضبابيًا بشكل واضح وسلِس.
- أبقيت `fog_density = 1.4` و`fog_sky_affect = 0.35` (سماء واضحة + اندماج أفق).

### التحقق
- بروب headless: `fog_depth_curve=0.9`، `volumetric_fog_density=0.06`، `volumetric_fog_anisotropy=0.65`، `light_volumetric_fog_energy=5.0`، `GIFake` قوته 0.22 وعتبته 0.3 وفينيت 0.08، و`sdfgi_enabled=false` — كلها متطابقة بلا أخطاء.

### ملاحظات
- أسطر SDFGI (`sdfgi_use_occlusion`/`sdfgi_energy`/`sdfgi_bounce_feedback`) و`volumetric_fog_gi_inject` بقيت في المشهد لكنها **معطّلة/خاملة** (لا `sdfgi_enabled` ولا أي GI) — لا أثر بصري لها.
- لضبط أقوى/أخف للأشعة من المحرر: `light_volumetric_fog_energy` أو `volumetric_fog_anisotropy` على WorldEnvironment.

---

## 22) موازنة الإضاءة البيضاء الزائدة + ضباب DEPTH مضمون قبل far

**التاريخ:** 30 أغسطس 2026
**الملفات:** `Scenes/Level 4.tscn`
**الوصف:** بطلب المستخدم: (1) الإضاءة أقوى وأبيض أكثر من اللازم — خُفّضت، (2) ضباب far لا يشتغل — أصله بتحويل الضباب إلى نمط DEPTH بمدى محسوم يغطي قبل far=40 حتمًا. كما رُصد أن المستخدم عطّل GIFake (`visible=false`) فعُزي السبب الفعلي للبياض للفوليومتريك والambient.

### 1) خفض البياض الزائد
- `volumetric_fog`:
  - `density`: 0.06 ← **0.05**، `albedo`: (0.65,0.68,0.74) ← **(0.55,0.58,0.64)** (أغمق وأبرز) — ضباب أقل بياضًا.
  - `ambient_inject`: 1.0 ← **0.5** (نصف وهج الأبيض الداخلي).
  - `anisotropy`: 0.65 ← **0.5** (تشتت أمامي موجود يبقي الأشعة محددة لكن أنعم).
- الشمس `light_volumetric_fog_energy`: 5.0 ← **3.0** — أبرز عنصر للبياض.
- `ambient_light_energy`: 1.8 ← **1.4** — سطوع عام أقل.
- `glow_intensity`: 1.78 ← **1.5** — انفجار bloom أقل.

### 2) ضباب far يعمل حتمًا (نمط DEPTH)
- `fog_mode`: 1 (Exponential) ← **0 (DEPTH)** — نمط العمق يصل إلى تغطية كاملة عند `fog_depth_end` بمواصفات Godot الرسمية.
- `fog_depth_begin = 8.0` (القرب صافٍ تمامًا)، `fog_depth_end = 38.0` (**قبل far=40**) → أي جسم يمر إلى 38م يُغطّى ضبابًا كاملًا ولا يصل لجدار far أساسًا.
- `fog_density = 1.5` لضمان ملء الكامل داخل الباند فيمنع أي صورة ظلية للقص.
- `fog_sky_affect = 0.35` محفوظة (سماء واضحة + أفق مندمج).

### التحقق
- بروب headless: `fog_mode=0`، `fog_depth_begin=8`، `fog_depth_end=38`، `fog_density=1.5`، `volumetric_fog_density=0.05`/`anisotropy=0.5`/`ambient_inject=0.5`، `light_volumetric_fog_energy=3`، `ambient_light_energy=1.4`، `glow_intensity=1.5` — كلها مطابقة بلا أخطاء.

### ملاحظات
- GIFake (`FX_Ambient`) ما زال `visible=false` عندك — عند إعادة تفعيله يستخدم قيّمته المخففة (strength 0.22/cutoff 0.3) ولا يبيّض.
- ضبط دقيق إضافي متاح من المحرر على WorldEnvironment، وبقيم أفتراضي في `Scripts/PostFX/GIFake.gdshader`.

---

## 23) ظلال شمس متفتتة وواقعية (خريطة ظل أعلى كثافة + شرائح قريبة + تلامس)

**التاريخ:** 30 أغسطس 2026
**الملفات:** `Scenes/Level 4.tscn`، `project.godot`
**الوصف:** الظل الشمسي كان مسطحًا «سرطحيًا» بلا تفاصيل. السبب: خريطة التظليل 4096 ممتدة على مدى 100م (كثافة بكسل قليلة) → التفاصيل الدقيقة (قضبان النوافذ، الخشخشة بين الصناديق) تذوب. رُفعت الكثافة ورُكّزت على المنطقة المرئية وجُلّي التلامس.

### خريطة الظل — كثافة وتفاصيل (الأساس)
- `project.godot` ← `rendering/lights_and_shadows/directional_shadow/size`: 4096 ← **8192** — أربعة أضعاف البكسلات → الظلال تبدو «متفتتة» بتفاصيل دقيقة بدل كتلة واحدة ناعمة.
- `directional_shadow_max_distance`: 100 ← **48** على الضوء — المدى أصبح = منطقة الرؤية (40م + هامش)، فتتوزع الـ texels بكثافة مضاعفة على ما نراه فعليًا.
- شرائح PSSM أُعيد توزيعها لتركيز التفاصيل قرب اللاعب: `split_1` 0.1←**0.06**، `split_2` 0.2←**0.15**، `split_3` 0.5←**0.4** → القرب (~3م-7م) يحصل على شريحة شبه مخصصة = حواف قطع دقيقة عند الملامسة.

### تلامس وواقعية
- `shadow_normal_bias`: 2.0 ← **1.5** — انحياز أقل فيلّظل يلتصق بالجدران/الأرض بدل انفصال «ظل عائم سطحي»؛ يظهر انكسار عند الزوايا. (SSAO يغطي أي حب شبكة محتمل).
- `directional_shadow_blend_splits = true` — مزج سلِس بين الشرائح فلا يظهر «حزام ملحوظ» عند المسافات بينها.
- `shadow_opacity`: 0.6 ← **0.65** — حضور أقوى قليلًا كي تُقرأ التفاصيل المتفتتة دون ثُقل.
- `project.godot` ← `rendering/environment/ssao/quality`: 1 ← **2** — تظليل تلامس أدق يُفصّل التجاويف والشرخ بين الأجسام (كلفة خفيفة).

### النتيجة المتوقعة
- ظل النوافذ على الأرض يتفتت إلى أشرطة ضوئية-داكنة عبر قضبان الإطار، وظلال الصناديق تنكسِر عند فراغاتها وحوافها بدل قمة واحدة، مع حواف PCF17 ناعمة وambient 1.4 تملأ داخلها.

### التحقق
- بروب headless: `size=8192`، `ssao quality=2`، `shadow_opacity=0.65`، `normal_bias=1.5`، `max_distance=48`، `splits=0.06/0.15/0.4`، `blend=true` — كلها مطابقة بلا أخطاء.

### ملاحظات
- كلفة 8192 على PSSM: تمرير Raster واحد لكل مُلقٍ — مقبول على Desktop d3d12؛ إن لاحظت هبوطًا أقل خبّض إلى `size=4096` لأن التوزيع والشرائح كفاية.
- تعديلات الشرائح أعلاه خاصّ بـ Level 4 (على عقدة الضوء)؛ باقي المستويات بافتراضي Godot.

---

## 24) استعادة الأداء مع ظلال واقعية خفيفة (8192 → 4096 + PCF13 + مدى 42)

**التاريخ:** 30 أغسطس 2026
**الملفات:** `Scenes/Level 4.tscn`، `project.godot`
**الوصف:** إعدادات القسم 23 (خريطة 8192 + PCF17 + SSAO متوسط) جرّت الأداء إلى 8 فريم. أُعيدت الموازنة نحو خفة الجهاز مع الإبقاء على واقعية الظلال المتفتتة التي تعتمد على **توزيع المدى والشرائح القريبة** لا على حجم الخريطة المبالغ.

### خفض الجودة / المدى (الأداء)
- `project.godot`:
  - `directional_shadow/size`: 8192 ← **4096** — ربع البكسلات السابقة (المعالج الأثقل).
  - `soft_shadow_filter_quality`: 3 (PCF17) ← **2 (PCF13)** — نعومة محترمة بكلفة أقل.
  - `ssao/quality`: 2 ← **1** — تظليل تلامس خفيف كما كان قبل القسم 23.
- على ضوء الشمس (Level 4):
  - `shadow_blur`: 2 ← **1** (PCF13 معالجة شاملة).
  - `directional_shadow_max_distance`: 48 ← **42** — أقل قليلًا من مدى الرؤية (40م + هامش صغير) فالتفاصيل ما تزال مركزة.

### ما بقي حفاظًا على الواقعية (بلا كلفة تقريبًا)
- **الشرائح القريبة** `split_1/2/3 = 0.06/0.15/0.4` — توزيع التكسلات صفقة مجانية تعطي التفاصيل قرب اللاعب.
- `normal_bias=1.5` (تلامس)، `blend_splits=true` (لا حزام)، `shadow_opacity=0.65`، و`4096` تغطي 42م فالتفاصيل (قضبان نوافذ، فراغات) تبقى مرئية.

### النتيجة
- الظلال ما تزال متفتتة وقريبة من القسم 23 بصريًا، لكن بكلفة تقريبًا ربع سابقة → استعادة المعدل الطبيعي للفريمات.

### التحقق
- بروب headless: `shadow_blur=1`، `max_distance=42`، `size=4096`، `soft_shadow_filter_quality=2`، `ssao quality=1` — كلها مطابقة بلا أخطاء.

### ملاحظات
- إن رُزّ بقاء فريمات منخفضة بعد هذا، الخناق التالي هو **الفوليومتريك فوج** (volume 48): خبّض `environment/volumetric_fog/volume_size` و`volume_depth` إلى 32 في project.godot (تُقلّ الأشعة قليلًا لكنها تبقى) — أخبرني قبل فعلها.

---

## 25) إضاءة Omni واقعية خفيفة (تفعيل الظلال) — Level 4 وLevel 0

**التاريخ:** 30 أغسطس 2026
**الملفات:** `Chunks/L4T2Chunk.tscn`، `Chunks/L4T3Chunk.tscn`، `Chunks/L0T1Chunk.tscn`
**الوصف:** أضواء Omni في لفل 4 ولفل 0 كانت بلا ظلال أصلًا (`shadow_enabled` غير مفعلة) فبدت بقع إضاءة مسطحة لا تحتجب بالجدران والأثاث — غير واقعية. عُولجت بتفعيل الظلال الناعمة بنفس الكم والمدى (خفيفة أداءً عبر atlas مشتركة والتقاط مناطق النجوم فقط).

### التغيير
- لكل OmniLight3D (في L4T2 ×4، L4T3 ×4، L0T1 ×1):
  - **`shadow_enabled = true`** — الأضواء الآن تحتجب بالجدران والأثاث: تدرجات صحيحة، وظل تحت حافة الأثاث، وصحراء ضوئية خلف الحاجز. عند لفل 4 يتظلل الفوليومتريك فوج تحت الأضواء أيضًا (`light_volumetric_fog_energy`).
  - **`shadow_normal_bias = 1.5`** — ظل يلامس السطح بدل انفصال «ظل عائم» شائع مع omni الافتراضي (2.0).
  - **`shadow_opacity = 0.9`** — ظل ناعم بشفافية خفيفة (أنبوب ضوئي لا يعطي أسودًا صافيًا) كواقع.
- جودة فلترة الظلال الموقعية `positional_shadow/soft_shadow_filter_quality` **2 (PCF13)**، والمشهد مسبقًا `atlas_quadrant_3_subdiv=3` — حافة ناعمة بلا تكلفة عالية.

### خفة الأداء
- لا أسطوانات إضافية في المشهد؛ نفس عدد الأضواء، والتظليل يشترك في **shadow atlas** ويُتقّى الأضواء غير الظاهرة (تقطيع تلقائي).
- إن ظهرت ظلال منخفضة التفاصيل يمكن رفع `rendering/lights_and_shadows/shadow_atlas/size` من 2048 إلى 3072 (خطوة وسطى) — لم أفعلها حفاظًا على خفة الأداء.

### التحقق
- بروب headless: L4T2 4 أضArray وL4T3 4 وL0T1 1، كلها `shadow_enabled=true` مع `normal_bias=1.5`، وجودة PCF13 — بلا أخطاء.

### ملاحظات
- لم تُلمس الطاقة/المدى/اللون (بياض لفل 4، أصفر لفل 0) — بقيت هوية كل لفل.

---

## 26) إصلاح "لماذا لا تشتغل تعديلاتي على البيئة" — ضباب Level 0 صفر + ضباب Level 4 بكثافة مرئية

**التاريخ:** 30 أغسطس 2026
**الملفات:** `Scenes/Level 0.tscn`، `Scenes/Level 4.tscn`
**الوصف:** المستخدم لاحظ أن تعديلاته اليدوية على ملكيات البيئة (الضباب) لا تُحدث أثرًا بصريًا: أضاف ضبابًا لـ Level 4 فلم يظهر، وأزاله من Level 0 فبقي ظاهرًا. التشخيص كشف 3 أسباب متراكبة عولج بعضها بالمشهد نفسه.

### التشخيص الجذري (سبب "لا تشتغل")
- **`fog_enabled` و`volumetric_fog_enabled` افتراضهما `false` في Godot 4.7** (تحقق headless: `Environment.new().fog_enabled == false`). المحرر يكتفي بحذف الخاصية যখনها بالافتراضي، فلا يوجد أي سطر تفعيل في الملف → الضباب في Level 0 كان **معطّلًا أصلًا**، وتعديل `fog_density`/`fog_light_color` بلا أثر لأن لا مُفعّل يحملها. ما كان يراه المستخدم "ضبابًا" هو العتمة السوداء للخلفية (background_energy=0 بدون إضاءة محيطة)، لا ضباب البيئة.
- **Level 4 عكس ذلك:** `fog_mode=1` (DEPTH) و`fog_density` **غير مستخدمة في وضع DEPTH**؛ التدرّج من `fog_depth_begin=8` إلى `fog_depth_end=38` — فالمستخدم يرفع الكثافة فلا يتغير شيء لأنها متجاهَلة، مع 8 أمتار صافية أمام الكاميرا تبدو "بلا ضباب".
- **كاش المشاهد:** `SceneLoader.goto_scene` يحمّل بـ `ResourceLoader.CACHE_MODE_REUSE` (سطر 185)، فالمشهد المحمّل سابقًا يبقى بالنسخة المخزّنة حتى **Project → Reload** — سبب شهير لاختفاء تعديل "مُحفظ".

### التغيير
- **Level 0 (إزالة كاملة للضباب):** كُتبت صراحةً `fog_enabled = false` و`volumetric_fog_enabled = false` في البيئة، و`fog_density = 0.0` — الضباب 2D والحجمي **خاملان تمامًا** ولن يعودا حتى مع تعديل الكثافة لاحقًا. تبقى العتمة من الإضاءة فقط (انعدام ambient).
- **Level 4 (ضباب بكثافة مرئية):** `fog_mode = 1(DEPTH) → 0(Exponential)` وحُذفت `fog_depth_begin/end` (لا معنى لها في الوضع الأسي) وضُبطت `fog_density = 0.06` — من الآن **كل تغيير للكثافة ينعكس فورًا** ويمكن للمستخدم ضبطه يدويًا في المحرر.

### التحقق
- بروب headless: `TEST_L0_FOG_ENABLED=false VOL=false DENS=0.0`، و`TEST_L4_FOG_MODE=0 DENS=0.06 EN=true` — بلا أخطاء.

### ملاحظات
- الضباب الحجمي في Level 4 بقي مُفعّلًا كأشعة الشمس، لكن الكثافة الأسيّة الجديدة هي المسيطرة الأقرب للكاميرا.

---

## 27) إعادة التسمية إلى Backrooms by Andinest Games + إزالة كاملة لشخصية I4.0

**التاريخ:** 31 أغسطس 2026
**الملفات:** `project.godot`، `README.md`، `CHANGES.md`، `Scripts/Globals.gd`، `Prefabs/Player.tscn`، `Scenes/Level 867.tscn`، وحذف: `Prefabs/I4.0.tscn`، `Scripts/I4.0/`، `Meshes/I4.0/`، `addons/vrm/`
**الوصف:** إعادة تسمية المشروع بالكامل إلى "Backrooms by Andinest Games" وإزالة كل أثر للشخصية الذكية المدمجة I4.0 (نموذج VRM، المتحكّم، سكربت الاتصال بخادم I4.0، وإضافة VRM) من اللعبة.

### إعادة التسمية
- `project.godot`: `config/name="BackroomsWithI4.0"` → `"Backrooms by Andinest Games"`.
- `README.md`: العنوان والوصف أعيدت كتابتهما بدون ذكر I4.0، وحُذف سطر الشخصية من خارطة الطريق.
- `Scripts/Globals.gd`: مسار مجلد بيانات اللعبة `BackroomsWithI4.0` → `Backrooms by Andinest Games`.

### إزالة كاملة لشخصية I4.0
- **حُذفت الملفات:** `Prefabs/I4.0.tscn` (المشهد الكامل)، `Scripts/I4.0/` (سكربتا `Conn.gd` لمجموعة الاتصال و`I4CharController.gd` لمتحكّم الوجه/الجسم)، `Meshes/I4.0/I4.0-1.vrm` (النموذج)، و`addons/vrm/` (إضافة استيراد VRM التي لم تعد مستخدمة بعد حذف النموذج الوحيد من نوع VRM).
- **`Prefabs/Player.tscn`:** أُزيلت عقدة `Scripts/I4Conn` (سكربت `Conn.gd`) التي كانت تتصل بخوادم Tao71 — اللاعب لم يعد يحاول الاتصال بأي خادم عند التشغيل.
- **`Scenes/Level 867.tscn`:** أُزيلت عقدة `I4_0` ومُصدرها، ونُقّح وصف العقدة ليذكر "VRM models" فقط.
- **`Scripts/Globals.gd`:** أُزيلت متغيرات `I4_Servers` و`I4_Chatbots` (قوائم خوادم ونماذج I4.0).
- **`project.godot`:** أُزيلت إضافة `res://addons/vrm/plugin.cfg` من قائمة الإضافات المفعّلة.

### التحقق
- فحص مرجعي شامل على كل ملفات `gd/tscn/godot`: لا بقايا لـ `I4.0`/`I4_0`/`I4CharController`/`I4_Servers`/`addons/vrm` — نظيف تمامًا.
- بروب headless: كل المشاهد والقطع (L4T2/L4T3/L0T1/LHT1/Player/Level 4/Level 0/Level 867) تُحمّل بلا أخطاء؛ Level 867 أبناؤه `["README", "MeshInstance3D", "DirectionalLight3D", "Player"]` بدون `I4_0`.

### ملاحظات
- تفعيل إضافة VRM كان ضروريًا سابقًا لاستيراد `I4.0-1.vrm`؛ بلا أي ملف `.vrm` متبقٍ لم تعد الإضافة مطلوبة.



### توثيق تاريخي
- الإشارات التاريخية لـ I4.0 داخل نصوص الأقسام القديمة (١–٤) تُركت كنزعة أثرية لأنها توثّق النظام الذي كان موجودًا وحُذف لاحقًا، ولا تُظهر المشروع كمحتوى **Backrooms by Andinest Games**.
