.class public final Lcom/android/internal/app/ShutdownThread;
.super Ljava/lang/Thread;
.source "ShutdownThread.java"


# static fields
.field private static final MAX_BROADCAST_TIME:I = 0x2710

.field private static final MAX_NUM_PHONE_STATE_READS:I = 0x10

.field private static final MAX_SHUTDOWN_WAIT_TIME:I = 0x4e20

.field private static final PHONE_STATE_POLL_SLEEP_MSEC:I = 0x1f4

.field private static final SHUTDOWN_VIBRATE_MS:I = 0x1f4

.field private static final TAG:Ljava/lang/String; = "ShutdownThread"

.field private static mReboot:Z

.field public static mRebootType:I

.field private static mRebootReason:Ljava/lang/String;

.field private static final sInstance:Lcom/android/internal/app/ShutdownThread;

.field private static sIsStarted:Z

.field private static sIsStartedGuard:Ljava/lang/Object;

.field private static sSystemReady:Z

.field private static final sSystemReadySync:Ljava/lang/Object;


# instance fields
.field private mActionDone:Z

.field private final mActionDoneSync:Ljava/lang/Object;

.field private mContext:Landroid/content/Context;

.field private mHandler:Landroid/os/Handler;

.field private mPhoneStateListener:Landroid/telephony/PhoneStateListener;

.field private mPowerManager:Landroid/os/PowerManager;

.field private mRadioOffSync:Ljava/lang/Object;

.field private mTelephonyManager:Landroid/telephony/TelephonyManager;

.field private mWakeLock:Landroid/os/PowerManager$WakeLock;


# direct methods
.method static constructor <clinit>()V
    .registers 2

    .prologue
    const/4 v1, 0x0

    .line 64
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/android/internal/app/ShutdownThread;->sIsStartedGuard:Ljava/lang/Object;

    .line 65
    sput-boolean v1, Lcom/android/internal/app/ShutdownThread;->sIsStarted:Z

    .line 71
    new-instance v0, Lcom/android/internal/app/ShutdownThread;

    invoke-direct {v0}, Lcom/android/internal/app/ShutdownThread;-><init>()V

    sput-object v0, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    .line 75
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/android/internal/app/ShutdownThread;->sSystemReadySync:Ljava/lang/Object;

    .line 76
    sput-boolean v1, Lcom/android/internal/app/ShutdownThread;->sSystemReady:Z

    return-void
.end method

.method private constructor <init>()V
    .registers 3

    .prologue
    const/4 v1, 0x0

    .line 95
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 80
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/internal/app/ShutdownThread;->mActionDoneSync:Ljava/lang/Object;

    .line 89
    iput-object v1, p0, Lcom/android/internal/app/ShutdownThread;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    .line 90
    iput-object v1, p0, Lcom/android/internal/app/ShutdownThread;->mPhoneStateListener:Landroid/telephony/PhoneStateListener;

    .line 91
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/internal/app/ShutdownThread;->mRadioOffSync:Ljava/lang/Object;

    .line 96
    return-void
.end method

.method static synthetic access$000(Landroid/content/Context;)V
    .registers 1
    .parameter "x0"

    .prologue
    .line 51
    invoke-static {p0}, Lcom/android/internal/app/ShutdownThread;->beginShutdownSequence(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic access$100(Lcom/android/internal/app/ShutdownThread;)Ljava/lang/Object;
    .registers 2
    .parameter "x0"

    .prologue
    .line 51
    iget-object v0, p0, Lcom/android/internal/app/ShutdownThread;->mRadioOffSync:Ljava/lang/Object;

    return-object v0
.end method

.method private static beginShutdownSequence(Landroid/content/Context;)V
    .registers 8
    .parameter "context"

    .prologue
    const/4 v6, 0x0

    const/4 v4, 0x1

    .line 157
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sIsStartedGuard:Ljava/lang/Object;

    monitor-enter v2

    .line 159
    :try_start_5
    sget-boolean v3, Lcom/android/internal/app/ShutdownThread;->sIsStarted:Z

    if-nez v3, :cond_97

    .line 160
    const/4 v3, 0x1

    sput-boolean v3, Lcom/android/internal/app/ShutdownThread;->sIsStarted:Z

    .line 165
    monitor-exit v2
    :try_end_d
    .catchall {:try_start_5 .. :try_end_d} :catchall_99

    .line 168
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    invoke-direct {v2, p0}, Lcom/android/internal/app/ShutdownThread;->prepare(Landroid/content/Context;)V

    ###################################################
    ## Change title string of powerdown/reboot confirmation dialog box
    ## v1 : is klobbered
    ## v2 : holds the string id for the title (as in original)
    ## Code reordered slightly so that we can safely waylay v1

    sget v1, Lcom/android/internal/app/ShutdownThread;->mRebootType:I

    const/4 v2, 0x1

    if-eq v1, v2, :set_title_reboot

    const/4 v2, 0x2

    if-eq v1, v2, :set_title_recovery

    .line 173
    .local v1, pd:Landroid/app/ProgressDialog;
    const v2, 0x1040115

    goto :set_title_done

:set_title_reboot

    const v2, 0x10403c5

    goto :set_title_done

:set_title_recovery

    const v2, 0x10403c4

:set_title_done

    ###################################################

    .line 172
    new-instance v1, Landroid/app/ProgressDialog;

    invoke-direct {v1, p0}, Landroid/app/ProgressDialog;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0, v2}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/ProgressDialog;->setTitle(Ljava/lang/CharSequence;)V

    .line 174
    const v2, 0x1040116

    invoke-virtual {p0, v2}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/ProgressDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 175
    invoke-virtual {v1, v4}, Landroid/app/ProgressDialog;->setIndeterminate(Z)V

    .line 176
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/app/ProgressDialog;->setCancelable(Z)V

    .line 177
    invoke-virtual {v1}, Landroid/app/ProgressDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    const/16 v3, 0x7d9

    invoke-virtual {v2, v3}, Landroid/view/Window;->setType(I)V

    .line 178
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const v3, 0x10d0001

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v2

    if-nez v2, :cond_50

    .line 180
    invoke-virtual {v1}, Landroid/app/ProgressDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    const/4 v3, 0x4

    invoke-virtual {v2, v3}, Landroid/view/Window;->addFlags(I)V

    .line 183
    :cond_50
    invoke-virtual {v1}, Landroid/app/ProgressDialog;->show()V

    .line 186
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    iput-object p0, v2, Lcom/android/internal/app/ShutdownThread;->mContext:Landroid/content/Context;

    .line 187
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    const-string v3, "power"

    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Landroid/os/PowerManager;

    iput-object p0, v2, Lcom/android/internal/app/ShutdownThread;->mPowerManager:Landroid/os/PowerManager;

    .line 188
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    iput-object v6, v2, Lcom/android/internal/app/ShutdownThread;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    .line 189
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    iget-object v2, v2, Lcom/android/internal/app/ShutdownThread;->mPowerManager:Landroid/os/PowerManager;

    invoke-virtual {v2}, Landroid/os/PowerManager;->isScreenOn()Z

    move-result v2

    if-eqz v2, :cond_88

    .line 191
    :try_start_71
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    sget-object v3, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    iget-object v3, v3, Lcom/android/internal/app/ShutdownThread;->mPowerManager:Landroid/os/PowerManager;

    const/16 v4, 0x1a

    const-string v5, "Shutdown"

    invoke-virtual {v3, v4, v5}, Landroid/os/PowerManager;->newWakeLock(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/app/ShutdownThread;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    .line 193
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    iget-object v2, v2, Lcom/android/internal/app/ShutdownThread;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v2}, Landroid/os/PowerManager$WakeLock;->acquire()V
    :try_end_88
    .catch Ljava/lang/SecurityException; {:try_start_71 .. :try_end_88} :catch_9c

    .line 199
    :cond_88
    :goto_88
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    new-instance v3, Lcom/android/internal/app/ShutdownThread$2;

    invoke-direct {v3}, Lcom/android/internal/app/ShutdownThread$2;-><init>()V

    iput-object v3, v2, Lcom/android/internal/app/ShutdownThread;->mHandler:Landroid/os/Handler;

    .line 201
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    invoke-virtual {v2}, Lcom/android/internal/app/ShutdownThread;->start()V

    .line 202
    .end local v1           #pd:Landroid/app/ProgressDialog;
    :goto_96
    return-void

    .line 162
    .restart local p0
    :cond_97
    :try_start_97
    monitor-exit v2

    goto :goto_96

    .line 165
    :catchall_99
    move-exception v3

    monitor-exit v2
    :try_end_9b
    .catchall {:try_start_97 .. :try_end_9b} :catchall_99

    throw v3

    .line 194
    .end local p0
    .restart local v1       #pd:Landroid/app/ProgressDialog;
    :catch_9c
    move-exception v2

    move-object v0, v2

    .line 195
    .local v0, e:Ljava/lang/SecurityException;
    const-string v2, "ShutdownThread"

    const-string v3, "No permission to acquire wake lock"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 196
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    iput-object v6, v2, Lcom/android/internal/app/ShutdownThread;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    goto :goto_88
.end method

.method private prepare(Landroid/content/Context;)V
    .registers 5
    .parameter "context"

    .prologue
    .line 214
    const-string v0, "phone"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    iput-object v0, p0, Lcom/android/internal/app/ShutdownThread;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    .line 215
    new-instance v0, Lcom/android/internal/app/ShutdownThread$3;

    invoke-direct {v0, p0}, Lcom/android/internal/app/ShutdownThread$3;-><init>(Lcom/android/internal/app/ShutdownThread;)V

    iput-object v0, p0, Lcom/android/internal/app/ShutdownThread;->mPhoneStateListener:Landroid/telephony/PhoneStateListener;

    .line 226
    iget-object v0, p0, Lcom/android/internal/app/ShutdownThread;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    iget-object v1, p0, Lcom/android/internal/app/ShutdownThread;->mPhoneStateListener:Landroid/telephony/PhoneStateListener;

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/telephony/TelephonyManager;->listen(Landroid/telephony/PhoneStateListener;I)V

    .line 227
    return-void
.end method

.method public static reboot(Landroid/content/Context;Ljava/lang/String;Z)V
    .registers 4
    .parameter "context"
    .parameter "reason"
    .parameter "confirm"

    .prologue
    .line 151
    const/4 v0, 0x1

    sput-boolean v0, Lcom/android/internal/app/ShutdownThread;->mReboot:Z

    .line 152
    sput-object p1, Lcom/android/internal/app/ShutdownThread;->mRebootReason:Ljava/lang/String;

    .line 153
    invoke-static {p0, p2}, Lcom/android/internal/app/ShutdownThread;->shutdown(Landroid/content/Context;Z)V

    .line 154
    return-void
.end method

.method public static shutdown(Landroid/content/Context;Z)V
    .registers 6
    .parameter "context"
    .parameter "confirm"

    .prologue
    const-string v3, "ShutdownThread"

    .line 109
    sget-object v1, Lcom/android/internal/app/ShutdownThread;->sIsStartedGuard:Ljava/lang/Object;

    monitor-enter v1

    .line 110
    :try_start_5
    sget-boolean v2, Lcom/android/internal/app/ShutdownThread;->sIsStarted:Z

    if-eqz v2, :cond_12

    .line 111
    const-string v2, "ShutdownThread"

    const-string v3, "Request to shutdown already running, returning."

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 112
    monitor-exit v1

    .line 139
    :goto_11
    return-void

    .line 114
    :cond_12
    monitor-exit v1
    :try_end_13
    .catchall {:try_start_5 .. :try_end_13} :catchall_70

    .line 116
    const-string v1, "ShutdownThread"

    const-string v1, "Notifying thread to start radio shutdown"

    invoke-static {v3, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 118
    if-eqz p1, :cond_73

    ###################################################
    ## Change title string of powerdown/reboot confirmation dialog box
    ## v1 : is klobbered
    ## v2 : holds the string id for the title (as in original)
    ## Code reordered slightly so that we can safely waylay v1

    sget v1, Lcom/android/internal/app/ShutdownThread;->mRebootType:I

    const/4 v2, 0x1

    if-eq v1, v2, :set_title_reboot_confirm

    const/4 v2, 0x2

    if-eq v1, v2, :set_title_recovery_confirm

    const v2, 0x1040115

    goto :set_title_done_confirm

:set_title_reboot_confirm

    const v2, 0x10403c5

    goto :set_title_done_confirm

:set_title_recovery_confirm

    const v2, 0x10403c4

:set_title_done_confirm

    ###################################################

    .line 119
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const v2, 0x1080027

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setIcon(I)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const v2, 0x1040117

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const v2, 0x1040013

    new-instance v3, Lcom/android/internal/app/ShutdownThread$1;

    invoke-direct {v3, p0}, Lcom/android/internal/app/ShutdownThread$1;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const v2, 0x1040009

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    .line 130
    .local v0, dialog:Landroid/app/AlertDialog;
    invoke-virtual {v0}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    const/16 v2, 0x7d9

    invoke-virtual {v1, v2}, Landroid/view/Window;->setType(I)V

    .line 131
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x10d0001

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v1

    if-nez v1, :cond_6c

    .line 133
    invoke-virtual {v0}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Landroid/view/Window;->addFlags(I)V

    .line 135
    :cond_6c
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    goto :goto_11

    .line 114
    .end local v0           #dialog:Landroid/app/AlertDialog;
    :catchall_70
    move-exception v2

    :try_start_71
    monitor-exit v1
    :try_end_72
    .catchall {:try_start_71 .. :try_end_72} :catchall_70

    throw v2

    .line 137
    :cond_73
    invoke-static {p0}, Lcom/android/internal/app/ShutdownThread;->beginShutdownSequence(Landroid/content/Context;)V

    goto :goto_11
.end method

.method public static systemReady()V
    .registers 2

    .prologue
    .line 426
    sget-object v0, Lcom/android/internal/app/ShutdownThread;->sSystemReadySync:Ljava/lang/Object;

    monitor-enter v0

    .line 427
    const/4 v1, 0x1

    :try_start_4
    sput-boolean v1, Lcom/android/internal/app/ShutdownThread;->sSystemReady:Z

    .line 428
    monitor-exit v0

    .line 429
    return-void

    .line 428
    :catchall_8
    move-exception v1

    monitor-exit v0
    :try_end_a
    .catchall {:try_start_4 .. :try_end_a} :catchall_8

    throw v1
.end method


# virtual methods
.method actionDone()V
    .registers 3

    .prologue
    .line 205
    iget-object v0, p0, Lcom/android/internal/app/ShutdownThread;->mActionDoneSync:Ljava/lang/Object;

    monitor-enter v0

    .line 206
    const/4 v1, 0x1

    :try_start_4
    iput-boolean v1, p0, Lcom/android/internal/app/ShutdownThread;->mActionDone:Z

    .line 207
    iget-object v1, p0, Lcom/android/internal/app/ShutdownThread;->mActionDoneSync:Ljava/lang/Object;

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 208
    monitor-exit v0

    .line 209
    return-void

    .line 208
    :catchall_d
    move-exception v1

    monitor-exit v0
    :try_end_f
    .catchall {:try_start_4 .. :try_end_f} :catchall_d

    throw v1
.end method

# Method to setup trigger for boot into Open Recovery
.method private static boot_to_or()V
    .registers 3

:boot_to_or_01

    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    const-string v1, "/system/xbin/boot_to_or"

    invoke-virtual {v0, v1}, Ljava/lang/Runtime;->exec(Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Process;->waitFor()I

:boot_to_or_02
    .catchall {:boot_to_or_01 .. :boot_to_or_02} :boot_to_or_03

    return-void

:boot_to_or_03
    move-exception v2

    return-void

.end method

.method public run()V
    .registers 30

    .prologue
    .line 241
    sget-object v28, Lcom/android/internal/app/ShutdownThread;->sSystemReadySync:Ljava/lang/Object;

    monitor-enter v28

    .line 243
    :try_start_3
    sget-boolean v3, Lcom/android/internal/app/ShutdownThread;->sSystemReady:Z

    if-eqz v3, :cond_160

    .line 245
    new-instance v6, Lcom/android/internal/app/ShutdownThread$4;

    move-object v0, v6

    move-object/from16 v1, p0

    invoke-direct {v0, v1}, Lcom/android/internal/app/ShutdownThread$4;-><init>(Lcom/android/internal/app/ShutdownThread;)V

    .line 252
    .local v6, br:Landroid/content/BroadcastReceiver;
    const-string v3, "ShutdownThread"

    const-string v4, "Sending shutdown broadcast..."

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 255
    const/4 v3, 0x0

    move v0, v3

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/internal/app/ShutdownThread;->mActionDone:Z

    .line 256
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mContext:Landroid/content/Context;

    move-object v3, v0

    new-instance v4, Landroid/content/Intent;

    const-string v5, "android.intent.action.ACTION_SHUTDOWN"

    invoke-direct {v4, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const/4 v5, 0x0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mHandler:Landroid/os/Handler;

    move-object v7, v0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-virtual/range {v3 .. v10}, Landroid/content/Context;->sendOrderedBroadcast(Landroid/content/Intent;Ljava/lang/String;Landroid/content/BroadcastReceiver;Landroid/os/Handler;ILjava/lang/String;Landroid/os/Bundle;)V

    .line 259
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    const-wide/16 v5, 0x2710

    add-long v19, v3, v5

    .line 260
    .local v19, endTime:J
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mActionDoneSync:Ljava/lang/Object;

    move-object v3, v0

    monitor-enter v3
    :try_end_42
    .catchall {:try_start_3 .. :try_end_42} :catchall_17c

    .line 261
    :goto_42
    :try_start_42
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/app/ShutdownThread;->mActionDone:Z

    move v4, v0

    if-nez v4, :cond_5c

    .line 262
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    sub-long v14, v19, v4

    .line 263
    .local v14, delay:J
    const-wide/16 v4, 0x0

    cmp-long v4, v14, v4

    if-gtz v4, :cond_16c

    .line 264
    const-string v4, "ShutdownThread"

    const-string v5, "Shutdown broadcast timed out"

    invoke-static {v4, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 272
    .end local v14           #delay:J
    :cond_5c
    monitor-exit v3
    :try_end_5d
    .catchall {:try_start_42 .. :try_end_5d} :catchall_179

    .line 274
    :try_start_5d
    const-string v3, "ShutdownThread"

    const-string v4, "Shutting down activity manager..."

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 276
    const-string v3, "activity"

    invoke-static {v3}, Landroid/os/ServiceManager;->checkService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v3

    invoke-static {v3}, Landroid/app/ActivityManagerNative;->asInterface(Landroid/os/IBinder;)Landroid/app/IActivityManager;
    :try_end_6d
    .catchall {:try_start_5d .. :try_end_6d} :catchall_17c

    move-result-object v11

    .line 278
    .local v11, am:Landroid/app/IActivityManager;
    if-eqz v11, :cond_75

    .line 280
    const/16 v3, 0x2710

    :try_start_72
    invoke-interface {v11, v3}, Landroid/app/IActivityManager;->shutdown(I)Z
    :try_end_75
    .catchall {:try_start_72 .. :try_end_75} :catchall_17c
    .catch Landroid/os/RemoteException; {:try_start_72 .. :try_end_75} :catch_23b

    .line 285
    :cond_75
    :goto_75
    :try_start_75
    const-string v3, "phone"

    invoke-static {v3}, Landroid/os/ServiceManager;->checkService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/ITelephony$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ITelephony;

    move-result-object v25

    .line 287
    .local v25, phone:Lcom/android/internal/telephony/ITelephony;
    const-string v3, "bluetooth"

    invoke-static {v3}, Landroid/os/ServiceManager;->checkService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v3

    invoke-static {v3}, Landroid/bluetooth/IBluetooth$Stub;->asInterface(Landroid/os/IBinder;)Landroid/bluetooth/IBluetooth;

    move-result-object v12

    .line 291
    .local v12, bluetooth:Landroid/bluetooth/IBluetooth;
    const-string v3, "mount"

    invoke-static {v3}, Landroid/os/ServiceManager;->checkService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v3

    invoke-static {v3}, Landroid/os/storage/IMountService$Stub;->asInterface(Landroid/os/IBinder;)Landroid/os/storage/IMountService;
    :try_end_92
    .catchall {:try_start_75 .. :try_end_92} :catchall_17c

    move-result-object v23

    .line 296
    .local v23, mount:Landroid/os/storage/IMountService;
    if-eqz v12, :cond_9d

    :try_start_95
    invoke-interface {v12}, Landroid/bluetooth/IBluetooth;->getBluetoothState()I

    move-result v3

    const/16 v4, 0xa

    if-ne v3, v4, :cond_17f

    :cond_9d
    const/4 v3, 0x1

    move v13, v3

    .line 298
    .local v13, bluetoothOff:Z
    :goto_9f
    if-nez v13, :cond_ac

    .line 299
    const-string v3, "ShutdownThread"

    const-string v4, "Disabling Bluetooth..."

    invoke-static {v3, v4}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 300
    const/4 v3, 0x0

    invoke-interface {v12, v3}, Landroid/bluetooth/IBluetooth;->disable(Z)Z
    :try_end_ac
    .catchall {:try_start_95 .. :try_end_ac} :catchall_17c
    .catch Landroid/os/RemoteException; {:try_start_95 .. :try_end_ac} :catch_183

    .line 308
    :cond_ac
    :goto_ac
    if-eqz v25, :cond_b4

    :try_start_ae
    invoke-interface/range {v25 .. v25}, Lcom/android/internal/telephony/ITelephony;->isRadioOn()Z

    move-result v3

    if-nez v3, :cond_194

    :cond_b4
    const/4 v3, 0x1

    move/from16 v26, v3

    .line 309
    .local v26, radioOff:Z
    :goto_b7
    if-nez v26, :cond_c7

    .line 310
    const-string v3, "ShutdownThread"

    const-string v4, "Turning off radio..."

    invoke-static {v3, v4}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 311
    const/4 v3, 0x0

    move-object/from16 v0, v25

    move v1, v3

    invoke-interface {v0, v1}, Lcom/android/internal/telephony/ITelephony;->setRadio(Z)Z
    :try_end_c7
    .catchall {:try_start_ae .. :try_end_c7} :catchall_17c
    .catch Landroid/os/RemoteException; {:try_start_ae .. :try_end_c7} :catch_199

    .line 318
    :cond_c7
    :goto_c7
    :try_start_c7
    const-string v3, "ShutdownThread"

    const-string v4, "Waiting for Bluetooth and Radio..."

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_ce
    .catchall {:try_start_c7 .. :try_end_ce} :catchall_17c

    .line 321
    const/16 v22, 0x0

    .local v22, i:I
    :goto_d0
    const/16 v3, 0x10

    move/from16 v0, v22

    move v1, v3

    if-ge v0, v1, :cond_f9

    .line 322
    if-nez v13, :cond_e3

    .line 324
    :try_start_d9
    invoke-interface {v12}, Landroid/bluetooth/IBluetooth;->getBluetoothState()I
    :try_end_dc
    .catchall {:try_start_d9 .. :try_end_dc} :catchall_17c
    .catch Landroid/os/RemoteException; {:try_start_d9 .. :try_end_dc} :catch_1af

    move-result v3

    const/16 v4, 0xa

    if-ne v3, v4, :cond_1ab

    const/4 v3, 0x1

    move v13, v3

    .line 331
    :cond_e3
    :goto_e3
    if-nez v26, :cond_ee

    .line 333
    :try_start_e5
    invoke-interface/range {v25 .. v25}, Lcom/android/internal/telephony/ITelephony;->isRadioOn()Z
    :try_end_e8
    .catchall {:try_start_e5 .. :try_end_e8} :catchall_17c
    .catch Landroid/os/RemoteException; {:try_start_e5 .. :try_end_e8} :catch_1c3

    move-result v3

    if-nez v3, :cond_1be

    const/4 v3, 0x1

    move/from16 v26, v3

    .line 339
    :cond_ee
    :goto_ee
    if-eqz v26, :cond_1d3

    if-eqz v13, :cond_1d3

    .line 340
    :try_start_f2
    const-string v3, "ShutdownThread"

    const-string v4, "Radio and Bluetooth shutdown complete."

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 356
    :cond_f9
    new-instance v24, Lcom/android/internal/app/ShutdownThread$5;

    move-object/from16 v0, v24

    move-object/from16 v1, p0

    invoke-direct {v0, v1}, Lcom/android/internal/app/ShutdownThread$5;-><init>(Lcom/android/internal/app/ShutdownThread;)V

    .line 363
    .local v24, observer:Landroid/os/storage/IMountShutdownObserver;
    const-string v3, "ShutdownThread"

    const-string v4, "Shutting down MountService"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 365
    const/4 v3, 0x0

    move v0, v3

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/internal/app/ShutdownThread;->mActionDone:Z

    .line 366
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    const-wide/16 v5, 0x4e20

    add-long v17, v3, v5

    .line 367
    .local v17, endShutTime:J
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mActionDoneSync:Ljava/lang/Object;

    move-object v3, v0

    monitor-enter v3
    :try_end_11d
    .catchall {:try_start_f2 .. :try_end_11d} :catchall_17c

    .line 369
    if-eqz v23, :cond_1eb

    .line 370
    :try_start_11f
    invoke-interface/range {v23 .. v24}, Landroid/os/storage/IMountService;->shutdown(Landroid/os/storage/IMountShutdownObserver;)V
    :try_end_122
    .catchall {:try_start_11f .. :try_end_122} :catchall_204
    .catch Ljava/lang/Exception; {:try_start_11f .. :try_end_122} :catch_1f4

    .line 377
    :goto_122
    :try_start_122
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/app/ShutdownThread;->mActionDone:Z

    move v4, v0

    if-nez v4, :cond_13c

    .line 378
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    sub-long v14, v17, v4

    .line 379
    .restart local v14       #delay:J
    const-wide/16 v4, 0x0

    cmp-long v4, v14, v4

    if-gtz v4, :cond_207

    .line 380
    const-string v4, "ShutdownThread"

    const-string v5, "Shutdown wait timed out"

    invoke-static {v4, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 388
    .end local v14           #delay:J
    :cond_13c
    monitor-exit v3
    :try_end_13d
    .catchall {:try_start_122 .. :try_end_13d} :catchall_204

    .line 390
    :try_start_13d
    sget-boolean v3, Lcom/android/internal/app/ShutdownThread;->mReboot:Z

    if-eqz v3, :cond_224

    .line 391
    const-string v3, "ShutdownThread"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Rebooting, reason: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Lcom/android/internal/app/ShutdownThread;->mRebootReason:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_15b
    .catchall {:try_start_13d .. :try_end_15b} :catchall_17c

    .line 393
    :try_start_15b
    sget-object v3, Lcom/android/internal/app/ShutdownThread;->mRebootReason:Ljava/lang/String;

    invoke-static {v3}, Landroid/os/Power;->reboot(Ljava/lang/String;)V
    :try_end_160
    .catchall {:try_start_15b .. :try_end_160} :catchall_17c
    .catch Ljava/lang/Exception; {:try_start_15b .. :try_end_160} :catch_214

    .line 411
    .end local v6           #br:Landroid/content/BroadcastReceiver;
    .end local v11           #am:Landroid/app/IActivityManager;
    .end local v12           #bluetooth:Landroid/bluetooth/IBluetooth;
    .end local v13           #bluetoothOff:Z
    .end local v17           #endShutTime:J
    .end local v19           #endTime:J
    .end local v22           #i:I
    .end local v23           #mount:Landroid/os/storage/IMountService;
    .end local v24           #observer:Landroid/os/storage/IMountShutdownObserver;
    .end local v25           #phone:Lcom/android/internal/telephony/ITelephony;
    .end local v26           #radioOff:Z
    :cond_160
    :goto_160
    :try_start_160
    monitor-exit v28
    :try_end_161
    .catchall {:try_start_160 .. :try_end_161} :catchall_17c

    .line 416
    const-string v3, "ShutdownThread"

    const-string v4, "Performing low-level shutdown..."

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget v1, Lcom/android/internal/app/ShutdownThread;->mRebootType:I

    const/4 v2, 0x1

    if-eq v1, v2, :reboot

    const/4 v2, 0x2

    if-eq v1, v2, :reboot_recovery

    .line 417
    invoke-static {}, Landroid/os/Power;->shutdown()V

    .line 418
    return-void

:reboot

    const-string v4, "now"

    invoke-static {v4}, Landroid/os/Power;->reboot(Ljava/lang/String;)V

    return-void

:reboot_recovery

    invoke-static {}, Lcom/android/internal/app/ShutdownThread;->boot_to_or()V

    const-string v4, "openrecovery"

    invoke-static {v4}, Landroid/os/Power;->reboot(Ljava/lang/String;)V

    return-void

    move-result v0

    return-void

    .line 268
    .restart local v6       #br:Landroid/content/BroadcastReceiver;
    .restart local v14       #delay:J
    .restart local v19       #endTime:J
    :cond_16c
    :try_start_16c
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mActionDoneSync:Ljava/lang/Object;

    move-object v4, v0

    invoke-virtual {v4, v14, v15}, Ljava/lang/Object;->wait(J)V
    :try_end_174
    .catchall {:try_start_16c .. :try_end_174} :catchall_179
    .catch Ljava/lang/InterruptedException; {:try_start_16c .. :try_end_174} :catch_176

    goto/16 :goto_42

    .line 269
    :catch_176
    move-exception v4

    goto/16 :goto_42

    .line 272
    .end local v14           #delay:J
    :catchall_179
    move-exception v4

    :try_start_17a
    monitor-exit v3
    :try_end_17b
    .catchall {:try_start_17a .. :try_end_17b} :catchall_179

    :try_start_17b
    throw v4

    .line 411
    .end local v6           #br:Landroid/content/BroadcastReceiver;
    .end local v19           #endTime:J
    :catchall_17c
    move-exception v3

    monitor-exit v28
    :try_end_17e
    .catchall {:try_start_17b .. :try_end_17e} :catchall_17c

    throw v3

    .line 296
    .restart local v6       #br:Landroid/content/BroadcastReceiver;
    .restart local v11       #am:Landroid/app/IActivityManager;
    .restart local v12       #bluetooth:Landroid/bluetooth/IBluetooth;
    .restart local v19       #endTime:J
    .restart local v23       #mount:Landroid/os/storage/IMountService;
    .restart local v25       #phone:Lcom/android/internal/telephony/ITelephony;
    :cond_17f
    const/4 v3, 0x0

    move v13, v3

    goto/16 :goto_9f

    .line 302
    :catch_183
    move-exception v3

    move-object/from16 v21, v3

    .line 303
    .local v21, ex:Landroid/os/RemoteException;
    :try_start_186
    const-string v3, "ShutdownThread"

    const-string v4, "RemoteException during bluetooth shutdown"

    move-object v0, v3

    move-object v1, v4

    move-object/from16 v2, v21

    invoke-static {v0, v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 304
    const/4 v13, 0x1

    .restart local v13       #bluetoothOff:Z
    goto/16 :goto_ac

    .line 308
    .end local v21           #ex:Landroid/os/RemoteException;
    :cond_194
    const/4 v3, 0x0

    move/from16 v26, v3

    goto/16 :goto_b7

    .line 313
    :catch_199
    move-exception v3

    move-object/from16 v21, v3

    .line 314
    .restart local v21       #ex:Landroid/os/RemoteException;
    const-string v3, "ShutdownThread"

    const-string v4, "RemoteException during radio shutdown"

    move-object v0, v3

    move-object v1, v4

    move-object/from16 v2, v21

    invoke-static {v0, v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 315
    const/16 v26, 0x1

    .restart local v26       #radioOff:Z
    goto/16 :goto_c7

    .line 324
    .end local v21           #ex:Landroid/os/RemoteException;
    .restart local v22       #i:I
    :cond_1ab
    const/4 v3, 0x0

    move v13, v3

    goto/16 :goto_e3

    .line 326
    :catch_1af
    move-exception v21

    .line 327
    .restart local v21       #ex:Landroid/os/RemoteException;
    const-string v3, "ShutdownThread"

    const-string v4, "RemoteException during bluetooth shutdown"

    move-object v0, v3

    move-object v1, v4

    move-object/from16 v2, v21

    invoke-static {v0, v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 328
    const/4 v13, 0x1

    goto/16 :goto_e3

    .line 333
    .end local v21           #ex:Landroid/os/RemoteException;
    :cond_1be
    const/4 v3, 0x0

    move/from16 v26, v3

    goto/16 :goto_ee

    .line 334
    :catch_1c3
    move-exception v21

    .line 335
    .restart local v21       #ex:Landroid/os/RemoteException;
    const-string v3, "ShutdownThread"

    const-string v4, "RemoteException during radio shutdown"

    move-object v0, v3

    move-object v1, v4

    move-object/from16 v2, v21

    invoke-static {v0, v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 336
    const/16 v26, 0x1

    goto/16 :goto_ee

    .line 345
    .end local v21           #ex:Landroid/os/RemoteException;
    :cond_1d3
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mRadioOffSync:Ljava/lang/Object;

    move-object v3, v0

    monitor-enter v3
    :try_end_1d9
    .catchall {:try_start_186 .. :try_end_1d9} :catchall_17c

    .line 347
    :try_start_1d9
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mRadioOffSync:Ljava/lang/Object;

    move-object v4, v0

    const-wide/16 v5, 0x1f4

    invoke-virtual {v4, v5, v6}, Ljava/lang/Object;->wait(J)V
    :try_end_1e3
    .catchall {:try_start_1d9 .. :try_end_1e3} :catchall_1e8
    .catch Ljava/lang/InterruptedException; {:try_start_1d9 .. :try_end_1e3} :catch_23e

    .line 350
    :goto_1e3
    :try_start_1e3
    monitor-exit v3

    .line 321
    add-int/lit8 v22, v22, 0x1

    goto/16 :goto_d0

    .line 350
    :catchall_1e8
    move-exception v4

    monitor-exit v3
    :try_end_1ea
    .catchall {:try_start_1e3 .. :try_end_1ea} :catchall_1e8

    :try_start_1ea
    throw v4
    :try_end_1eb
    .catchall {:try_start_1ea .. :try_end_1eb} :catchall_17c

    .line 372
    .restart local v17       #endShutTime:J
    .restart local v24       #observer:Landroid/os/storage/IMountShutdownObserver;
    :cond_1eb
    :try_start_1eb
    const-string v4, "ShutdownThread"

    const-string v5, "MountService unavailable for shutdown"

    invoke-static {v4, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1f2
    .catchall {:try_start_1eb .. :try_end_1f2} :catchall_204
    .catch Ljava/lang/Exception; {:try_start_1eb .. :try_end_1f2} :catch_1f4

    goto/16 :goto_122

    .line 374
    :catch_1f4
    move-exception v4

    move-object/from16 v16, v4

    .line 375
    .local v16, e:Ljava/lang/Exception;
    :try_start_1f7
    const-string v4, "ShutdownThread"

    const-string v5, "Exception during MountService shutdown"

    move-object v0, v4

    move-object v1, v5

    move-object/from16 v2, v16

    invoke-static {v0, v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_122

    .line 388
    .end local v16           #e:Ljava/lang/Exception;
    :catchall_204
    move-exception v4

    monitor-exit v3
    :try_end_206
    .catchall {:try_start_1f7 .. :try_end_206} :catchall_204

    :try_start_206
    throw v4
    :try_end_207
    .catchall {:try_start_206 .. :try_end_207} :catchall_17c

    .line 384
    .restart local v14       #delay:J
    :cond_207
    :try_start_207
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mActionDoneSync:Ljava/lang/Object;

    move-object v4, v0

    invoke-virtual {v4, v14, v15}, Ljava/lang/Object;->wait(J)V
    :try_end_20f
    .catchall {:try_start_207 .. :try_end_20f} :catchall_204
    .catch Ljava/lang/InterruptedException; {:try_start_207 .. :try_end_20f} :catch_211

    goto/16 :goto_122

    .line 385
    :catch_211
    move-exception v4

    goto/16 :goto_122

    .line 394
    .end local v14           #delay:J
    :catch_214
    move-exception v3

    move-object/from16 v16, v3

    .line 395
    .restart local v16       #e:Ljava/lang/Exception;
    :try_start_217
    const-string v3, "ShutdownThread"

    const-string v4, "Reboot failed, will attempt shutdown instead"

    move-object v0, v3

    move-object v1, v4

    move-object/from16 v2, v16

    invoke-static {v0, v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_160

    .line 399
    .end local v16           #e:Ljava/lang/Exception;
    :cond_224
    new-instance v27, Landroid/os/Vibrator;

    invoke-direct/range {v27 .. v27}, Landroid/os/Vibrator;-><init>()V

    .line 400
    .local v27, vibrator:Landroid/os/Vibrator;
    const-wide/16 v3, 0x1f4

    move-object/from16 v0, v27

    move-wide v1, v3

    invoke-virtual {v0, v1, v2}, Landroid/os/Vibrator;->vibrate(J)V
    :try_end_231
    .catchall {:try_start_217 .. :try_end_231} :catchall_17c

    .line 403
    const-wide/16 v3, 0x1f4

    :try_start_233
    invoke-static {v3, v4}, Ljava/lang/Thread;->sleep(J)V
    :try_end_236
    .catchall {:try_start_233 .. :try_end_236} :catchall_17c
    .catch Ljava/lang/InterruptedException; {:try_start_233 .. :try_end_236} :catch_238

    goto/16 :goto_160

    .line 404
    :catch_238
    move-exception v3

    goto/16 :goto_160

    .line 281
    .end local v12           #bluetooth:Landroid/bluetooth/IBluetooth;
    .end local v13           #bluetoothOff:Z
    .end local v17           #endShutTime:J
    .end local v22           #i:I
    .end local v23           #mount:Landroid/os/storage/IMountService;
    .end local v24           #observer:Landroid/os/storage/IMountShutdownObserver;
    .end local v25           #phone:Lcom/android/internal/telephony/ITelephony;
    .end local v26           #radioOff:Z
    .end local v27           #vibrator:Landroid/os/Vibrator;
    :catch_23b
    move-exception v3

    goto/16 :goto_75

    .line 348
    .restart local v12       #bluetooth:Landroid/bluetooth/IBluetooth;
    .restart local v13       #bluetoothOff:Z
    .restart local v22       #i:I
    .restart local v23       #mount:Landroid/os/storage/IMountService;
    .restart local v25       #phone:Lcom/android/internal/telephony/ITelephony;
    .restart local v26       #radioOff:Z
    :catch_23e
    move-exception v4

    goto :goto_1e3
.end method
