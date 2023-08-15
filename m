Return-Path: <bpf+bounces-7813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F7877CE8B
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 16:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455AA1C209F4
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6A114260;
	Tue, 15 Aug 2023 14:54:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5E7134CB;
	Tue, 15 Aug 2023 14:54:33 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF60AE6B;
	Tue, 15 Aug 2023 07:54:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe11652b64so8563208e87.0;
        Tue, 15 Aug 2023 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692111270; x=1692716070;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HsopOZpXGZAWMdG51SC5QwAXSIKILOPEXFnyb5gJ+Ao=;
        b=IzpGSG5o78/I+4UzFwlDda1oGBNknY7PZr5Fmc0/ks97gbn0G9WuruNPKFlvCk0xkC
         EnnYERcDfWoffTOU9axpr4E0efnQQxof5gR/meYmi0DrZSX+9U/6BYkh2uv72zQ0o2Wt
         LOT4LPz94odAOUyf1m4fBo6UZnOyCj7sY7pM+RVWVYmdoVgGPMTb8PeghaJmwI6imoJy
         Vx7X5V3MSSZ2lu1Lu89C5xVmXOMZTiLjRrTSn6UdgAozp7Bhs1RJ/y3dJmn/dvuzKwe9
         B8eI+R9kTcVG1ODWcvz+10TNFl9SXLR0FdkDRm51sOCwurFAAjAymt6w+6akHqiA8W7P
         nItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692111270; x=1692716070;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsopOZpXGZAWMdG51SC5QwAXSIKILOPEXFnyb5gJ+Ao=;
        b=YvZejj7Bst42Epq5gCoqIRTQZoV/7DPMf0g36eLvI9drEFY2eNAG91eFnK3DDgJpkU
         pBZ6cA/fMoV4KexF4nuoVJtDiublan1+6T7cVsywRjehAuOTj+XdgAygSdrMGHEMSV3Z
         cgmDzkUgY75rRDBuBYcDC3g7oclYP+83srZi3O/BdQQAdQw2MEhAN3cEHoJXImRqASrS
         NrbWlox8zL3/o+AQn4P2Ydgcg5iFmabVW4uuXAq3YL75hj4+ppBNX1VnlvvFPwN+yGpU
         iqDHSbjWQr31sddvJKaSrHtJBITLVPmgp5K+5XdfH4CFy4T/s9U3F0GxldhOIL3rR0sl
         w2Jg==
X-Gm-Message-State: AOJu0Yxcbt7ser0j+v6KY5GoIdr4gZT7svXgJvNgHxHbycm1KsHe+2TT
	KDhsLIk4QY5UNPld0rmQZ5bEqT0vxw5AQUJCcNs=
X-Google-Smtp-Source: AGHT+IF27O9oIImZ5UunCuOuRNrMTZ+1yTe0bH1MhaNvT0wWaFSYrW9NylJ2SaMXyFkecoIsTeE5e6CO4UrkSufqAYs=
X-Received: by 2002:ac2:41c1:0:b0:4f9:570c:7b28 with SMTP id
 d1-20020ac241c1000000b004f9570c7b28mr6994956lfi.32.1692111269676; Tue, 15 Aug
 2023 07:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yikebaer Aizezi <yikebaer61@gmail.com>
Date: Tue, 15 Aug 2023 22:54:18 +0800
Message-ID: <CALcu4rY8ekyOyxXJwuwthM268YEN9oUvhHd+TnhSHUohGLYz7w@mail.gmail.com>
Subject: WARNING in __tun_detach
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

When using Healer to fuzz the Latest Linux-6.5-rc6,  the following crash
was triggered.

HEAD commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421 (tag: v6.5-rc6=EF=BC=
=89
git tree: upstream

console output:
https://drive.google.com/file/d/1gdz7U-3qEkqcMdTym5UURmFPkzKUgvJQ/view?usp=
=3Ddrive_link
kernel config:https://drive.google.com/file/d/1DO9JM2wVO3ADkB7SweHN9q2mACe0=
T8lA/view?usp=3Ddrive_link
C reproducer:https://drive.google.com/file/d/1JBLx8X_egdvNSAkBVm81Wbtq6bLYl=
QE_/view?usp=3Ddrive_link
Syzlang reproducer:
https://drive.google.com/file/d/1BbmMzlF3u148wNT12wcrNNZoiFATz8Yb/view?usp=
=3Ddrive_link


If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>


------------[ cut here ]------------
WARNING: CPU: 1 PID: 10367 at net/core/dev.c:10876
unregister_netdevice_many_notify+0x13eb/0x18a0 net/core/dev.c:10876
Modules linked in:
CPU: 1 PID: 10367 Comm: syz-executor Not tainted 6.5.0-rc6 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:unregister_netdevice_many_notify+0x13eb/0x18a0 net/core/dev.c:108=
76
Code: b4 1a 00 00 48 c7 c6 00 89 f7 8a 48 c7 c7 40 89 f7 8a c6 05 3f
4c 56 06 01 e8 71 b9 9e f9 0f 0b e9 49 f7 ff ff e8 55 b5 d6 f9 <0f> 0b
e9 20 f7 ff ff e8 49 b5 d6 f9 0f 0b e9 5f f7 ff ff e8 6d 81
RSP: 0018:ffffc90004eaf870 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000007d98201 RCX: 0000000000000000
RDX: ffff888017f3bc00 RSI: ffffffff87a9b59b RDI: 0000000000000001
RBP: ffff88810aa60080 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000008e001 R12: 0000000000000000
R13: ffff88810aa60080 R14: ffff8881078cc000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888135c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f79076d138 CR3: 000000010c171000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 00000000000088e3 DR6: 00000000ffff0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 unregister_netdevice_many net/core/dev.c:10906 [inline]
 unregister_netdevice_queue+0x2e1/0x3c0 net/core/dev.c:10786
 unregister_netdevice include/linux/netdevice.h:3112 [inline]
 __tun_detach+0x10d1/0x1400 drivers/net/tun.c:684
 tun_detach drivers/net/tun.c:700 [inline]
 tun_chr_close+0xc4/0x240 drivers/net/tun.c:3491
 __fput+0x406/0xac0 fs/file_table.c:384
 task_work_run+0x164/0x250 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa8c/0x2990 kernel/exit.c:874
 do_group_exit+0xd0/0x2a0 kernel/exit.c:1024
 get_signal+0x25c3/0x25f0 kernel/signal.c:2881
 arch_do_signal_or_restart+0x75/0x5b0 arch/x86/kernel/signal.c:308
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:297
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbdbc69442d
Code: Unable to access opcode bytes at 0x7fbdbc694403.
RSP: 002b:00007fbdbd8fe0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fbdbc7cc0a8 RCX: 00007fbdbc69442d
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fbdbc7cc0a8
RBP: 00007fbdbc7cc0a0 R08: 00007fbdbd8fe640 R09: 00007fbdbd8fe640
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbdbc7cc0ac
R13: 000000000000000b R14: 00007fbdbc653240 R15: 00007fbdbd8de000
 </TASK>

Modules linked in:
CPU: 1 PID: 10367 Comm: syz-executor Not tainted 6.5.0-rc6 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:unregister_netdevice_many_notify+0x13eb/0x18a0 net/core/dev.c:108=
76
Code: b4 1a 00 00 48 c7 c6 00 89 f7 8a 48 c7 c7 40 89 f7 8a c6 05 3f
4c 56 06 01 e8 71 b9 9e f9 0f 0b e9 49 f7 ff ff e8 55 b5 d6 f9 <0f> 0b
e9 20 f7 ff ff e8 49 b5 d6 f9 0f 0b e9 5f f7 ff ff e8 6d 81
RSP: 0018:ffffc90004eaf870 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000007d98201 RCX: 0000000000000000
RDX: ffff888017f3bc00 RSI: ffffffff87a9b59b RDI: 0000000000000001
RBP: ffff88810aa60080 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000008e001 R12: 0000000000000000
R13: ffff88810aa60080 R14: ffff8881078cc000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888135c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f79076d138 CR3: 000000010c171000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 00000000000088e3 DR6: 00000000ffff0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 unregister_netdevice_many net/core/dev.c:10906 [inline]
 unregister_netdevice_queue+0x2e1/0x3c0 net/core/dev.c:10786
 unregister_netdevice include/linux/netdevice.h:3112 [inline]
 __tun_detach+0x10d1/0x1400 drivers/net/tun.c:684
 tun_detach drivers/net/tun.c:700 [inline]
 tun_chr_close+0xc4/0x240 drivers/net/tun.c:3491
 __fput+0x406/0xac0 fs/file_table.c:384
 task_work_run+0x164/0x250 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa8c/0x2990 kernel/exit.c:874
 do_group_exit+0xd0/0x2a0 kernel/exit.c:1024
 get_signal+0x25c3/0x25f0 kernel/signal.c:2881
 arch_do_signal_or_restart+0x75/0x5b0 arch/x86/kernel/signal.c:308
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:297
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbdbc69442d
Code: Unable to access opcode bytes at 0x7fbdbc694403.
RSP: 002b:00007fbdbd8fe0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fbdbc7cc0a8 RCX: 00007fbdbc69442d
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fbdbc7cc0a8
RBP: 00007fbdbc7cc0a0 R08: 00007fbdbd8fe640 R09: 00007fbdbd8fe640
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbdbc7cc0ac
R13: 000000000000000b R14: 00007fbdbc653240 R15: 00007fbdbd8de000
 </TASK>
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 1 PID: 10367 Comm: syz-executor Not tainted 6.5.0-rc6 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd5/0x150 lib/dump_stack.c:106
 panic+0x67e/0x730 kernel/panic.c:340
 check_panic_on_warn+0xad/0xb0 kernel/panic.c:236
 __warn+0xee/0x390 kernel/panic.c:673
 __report_bug lib/bug.c:199 [inline]
 report_bug+0x2d9/0x500 lib/bug.c:219
 handle_bug+0x3c/0x70 arch/x86/kernel/traps.c:326
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:347
 asm_exc_invalid_op+0x16/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:unregister_netdevice_many_notify+0x13eb/0x18a0 net/core/dev.c:108=
76
Code: b4 1a 00 00 48 c7 c6 00 89 f7 8a 48 c7 c7 40 89 f7 8a c6 05 3f
4c 56 06 01 e8 71 b9 9e f9 0f 0b e9 49 f7 ff ff e8 55 b5 d6 f9 <0f> 0b
e9 20 f7 ff ff e8 49 b5 d6 f9 0f 0b e9 5f f7 ff ff e8 6d 81
RSP: 0018:ffffc90004eaf870 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000007d98201 RCX: 0000000000000000
RDX: ffff888017f3bc00 RSI: ffffffff87a9b59b RDI: 0000000000000001
RBP: ffff88810aa60080 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000008e001 R12: 0000000000000000
R13: ffff88810aa60080 R14: ffff8881078cc000 R15: dffffc0000000000
 unregister_netdevice_many net/core/dev.c:10906 [inline]
 unregister_netdevice_queue+0x2e1/0x3c0 net/core/dev.c:10786
 unregister_netdevice include/linux/netdevice.h:3112 [inline]
 __tun_detach+0x10d1/0x1400 drivers/net/tun.c:684
 tun_detach drivers/net/tun.c:700 [inline]
 tun_chr_close+0xc4/0x240 drivers/net/tun.c:3491
 __fput+0x406/0xac0 fs/file_table.c:384
 task_work_run+0x164/0x250 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa8c/0x2990 kernel/exit.c:874
 do_group_exit+0xd0/0x2a0 kernel/exit.c:1024
 get_signal+0x25c3/0x25f0 kernel/signal.c:2881
 arch_do_signal_or_restart+0x75/0x5b0 arch/x86/kernel/signal.c:308
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:297
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbdbc69442d
Code: Unable to access opcode bytes at 0x7fbdbc694403.
RSP: 002b:00007fbdbd8fe0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fbdbc7cc0a8 RCX: 00007fbdbc69442d
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fbdbc7cc0a8
RBP: 00007fbdbc7cc0a0 R08: 00007fbdbd8fe640 R09: 00007fbdbd8fe640
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbdbc7cc0ac
R13: 000000000000000b R14: 00007fbdbc653240 R15: 00007fbdbd8de000
 </TASK>
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..

