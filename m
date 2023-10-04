Return-Path: <bpf+bounces-11411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FBE7B983B
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 00:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2879E282001
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 22:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A802628E;
	Wed,  4 Oct 2023 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BFF10780
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 22:39:12 +0000 (UTC)
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F4C1B1
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 15:38:51 -0700 (PDT)
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-1dd691b1037so434235fac.3
        for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 15:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696459131; x=1697063931;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RoUHWZqBgk2pNpDdFNHkbX4RlWGSvne5VSjvJ2m0a0Y=;
        b=QCwr/eLHH1f1mD8dYz1MVocorbppSISDv1BLRa3V0i0JsUofz9v93Rrpwi57OFutKD
         GWFYzDZCCB5wcXN+JEdWAcGMASgOV81de6HVjJ1TZ+Qb6OB5M1PMdK7oRu1/19modE2U
         8ElKYxPx8RYkyBFfY/V8dFcIXYtU5Di9st9i3FECWHg9u8pMIWCjRHwqi6PMsbKIE0bF
         iYlk93sZe3a/vxKRjU5Ut8f35LkpWqdUbo2sCkjVCubt3kvMrf1OBJZmVcUcuwT40750
         nEWp1Hm21sYYHQL7DpA5ak43VrCXc6uY061OVw3LM48+F0JqHwc7oqk9wfJI+AlEW+1V
         Po2Q==
X-Gm-Message-State: AOJu0YyLk2cWSN9EwloUKmYxEX6FwmaZSmooSKELfv00OZa1P5+ghlFD
	5kFV/211YxBLvvfcXVQmD0ujU2PjGkZgG+oNu4WB7xKONAtj
X-Google-Smtp-Source: AGHT+IHZY/6QhxXn312XoQMfsJYvxs/hrbPyjxbUMlieErVSfU9Ud6OH9dLxHTI9WCOYfblUUhXY5JgSOMGAlGbRogbE6AH1N/rD
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6871:6a83:b0:1d6:4da3:ae2d with SMTP id
 zf3-20020a0568716a8300b001d64da3ae2dmr1353623oab.7.1696459131059; Wed, 04 Oct
 2023 15:38:51 -0700 (PDT)
Date: Wed, 04 Oct 2023 15:38:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e20df20606ebab4f@google.com>
Subject: [syzbot] [bpf?] [net?] WARNING: zero-size vmalloc in xskq_create
From: syzbot <syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, jonathan.lemon@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com, 
	magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    cbf3a2cb156a Merge tag 'nfs-for-6.6-3' of git://git.linux-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1706797c680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b4e3baedc34d5e0
dashboard link: https://syzkaller.appspot.com/bug?extid=b132693e925cbbd89e26
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-cbf3a2cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a4d0b2b619dd/vmlinux-cbf3a2cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3a3810831d66/zImage-cbf3a2cb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6300 at mm/vmalloc.c:3247 __vmalloc_node_range+0x448/0x54c mm/vmalloc.c:3247
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 1 PID: 6300 Comm: syz-executor.1 Not tainted 6.6.0-rc4-syzkaller #0
Hardware name: ARM-Versatile Express
Backtrace: 
[<8181d9c0>] (dump_backtrace) from [<8181dabc>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:256)
 r7:00000000 r6:82622a04 r5:60000093 r4:81fb565c
[<8181daa4>] (show_stack) from [<8183adac>] (__dump_stack lib/dump_stack.c:88 [inline])
[<8181daa4>] (show_stack) from [<8183adac>] (dump_stack_lvl+0x48/0x54 lib/dump_stack.c:106)
[<8183ad64>] (dump_stack_lvl) from [<8183add0>] (dump_stack+0x18/0x1c lib/dump_stack.c:113)
 r5:00000000 r4:82854d14
[<8183adb8>] (dump_stack) from [<8181e564>] (panic+0x120/0x374 kernel/panic.c:340)
[<8181e444>] (panic) from [<80242e4c>] (check_panic_on_warn kernel/panic.c:236 [inline])
[<8181e444>] (panic) from [<80242e4c>] (print_tainted+0x0/0xa0 kernel/panic.c:231)
 r3:8260c484 r2:00000001 r1:81f9e164 r0:81fa5d18
 r7:8048685c
[<80242dd8>] (check_panic_on_warn) from [<80243040>] (__warn+0x7c/0x180 kernel/panic.c:673)
[<80242fc4>] (__warn) from [<802432bc>] (warn_slowpath_fmt+0x178/0x1f4 kernel/panic.c:698)
 r8:00000009 r7:81fcbdd8 r6:eaec9df4 r5:84520000 r4:00000000
[<80243148>] (warn_slowpath_fmt) from [<8048685c>] (__vmalloc_node_range+0x448/0x54c mm/vmalloc.c:3247)
 r10:00000126 r9:84520000 r8:ffffffff r7:ff800000 r6:00000dc0 r5:00000000
 r4:00000000
[<80486414>] (__vmalloc_node_range) from [<80486a38>] (vmalloc_user+0x6c/0x74 mm/vmalloc.c:3474)
 r10:00000126 r9:84520000 r8:8bcb4640 r7:00000000 r6:00000000 r5:89ddc040
 r4:00000000
[<804869cc>] (vmalloc_user) from [<817cc7c8>] (xskq_create+0x74/0xc0 net/xdp/xsk_queue.c:39)
[<817cc754>] (xskq_create) from [<817caddc>] (xsk_init_queue net/xdp/xsk.c:952 [inline])
[<817cc754>] (xskq_create) from [<817caddc>] (xsk_setsockopt+0x1d0/0x2c8 net/xdp/xsk.c:1286)
 r7:8bcb46b0 r6:8bcb4400 r5:00000000 r4:00000002
[<817cac10>] (xsk_setsockopt) from [<8134280c>] (__sys_setsockopt+0xd8/0x1c8 net/socket.c:2308)
 r8:80200288 r7:00000126 r6:20000280 r5:89886f00 r4:817cac0c
[<81342734>] (__sys_setsockopt) from [<81342918>] (__do_sys_setsockopt net/socket.c:2319 [inline])
[<81342734>] (__sys_setsockopt) from [<81342918>] (sys_setsockopt+0x1c/0x24 net/socket.c:2316)
 r6:0014c2c8 r5:00000000 r4:00000020
[<813428fc>] (sys_setsockopt) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xeaec9fa8 to 0xeaec9ff0)
9fa0:                   00000020 00000000 00000003 0000011b 00000002 20000280
9fc0: 00000020 00000000 0014c2c8 00000126 7ea3332e 7ea3332f 003d0f00 76b4c0fc
9fe0: 76b4bf08 76b4bef8 00016688 000509e0
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

