Return-Path: <bpf+bounces-5168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7237580C0
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 17:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D441C20D24
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611D4100CC;
	Tue, 18 Jul 2023 15:21:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004BCD52A
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 15:21:25 +0000 (UTC)
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6F81BEE
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 08:21:13 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3a36b52afcfso8923807b6e.3
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 08:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689693672; x=1692285672;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BQLzZuOKgxc7pnTyY+iPW8cpnqfY4naIu5QRKA+3w8=;
        b=XQ0Tx7+AuJtJVQKqipv65NS+OC81T39bge0ESaquesn3SL9LV42Rbujg45IR5kqj+V
         4O34605N5ut/Oxsi84iRuVL6sDkQC7hW/giedLgo61kHOCJEt3+TLn28Dilf6d6ZKE+J
         oNmhJi2OtSeyemUTJmRQl5fxM1Kfy4txXJ2yQUR0PKFgjQ9qxH83RxqdGHAxtFvtulws
         qqXkwTz0DJl4l+lN3wb8M8kKJabLPpCpTWpgEpituGk/4fH42gaiOIoXhBhSrfy2XSyp
         0jSd1n32SUTcouPe8hF8Zr9ujZCj6FQPS6u/0ulzjAjvhR4zUw5u1tzqfxf+e3la8PxB
         Whqg==
X-Gm-Message-State: ABy/qLagLAddqb2LfYo+t9i7+BBCzPK0jgc43FHUCBihYBgEo/QQPZ25
	xCvstY+OmGeEcNT3tXN3QHwl1gGlCNJYBCejSXbaXgYE0LwKo1FlgA==
X-Google-Smtp-Source: APBJJlEfjK3FXEL7fQ+5oIcKO3iTa80LT1Vgu9ngz8XiIgCF416cmHuYa9Eu5mVFZgpV/ePUiEYl+7KafKYY1pEAPUPTNIgzugu9
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:191a:b0:3a1:f368:6b1 with SMTP id
 bf26-20020a056808191a00b003a1f36806b1mr24352780oib.3.1689693672781; Tue, 18
 Jul 2023 08:21:12 -0700 (PDT)
Date: Tue, 18 Jul 2023 08:21:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000253d6b0600c4778a@google.com>
Subject: [syzbot] [modules?] WARNING in do_page_fault
From: syzbot <syzbot+78c0d2c0b793eabb450d@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, chris@chrisdown.name, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, llvm@lists.linux.dev, mcgrof@kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, syzkaller-bugs@googlegroups.com, 
	trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    3a8a670eeeaa Merge tag 'net-next-6.5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ef3444a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce7f4ca96cdf82c7
dashboard link: https://syzkaller.appspot.com/bug?extid=78c0d2c0b793eabb450d
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15be1d1ca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1615b4e2a80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-3a8a670e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a940531a9b86/vmlinux-3a8a670e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f3cbae5be61/Image-3a8a670e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78c0d2c0b793eabb450d@syzkaller.appspotmail.com

------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Not tainted 6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000840 x12: 00000000000002c0
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : ffff00007f9cecc8 x4 : 0000000000000000 x3 : ffff7ffffd60e000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 00000000000008af x12: 00000000000002e5
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 000000000000091e x12: 000000000000030a
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 000000000000098d x12: 000000000000032f
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 00000000000009fc x12: 0000000000000354
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000a6b x12: 0000000000000379
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000ada x12: 000000000000039e
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000b49 x12: 00000000000003c3
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000bb8 x12: 00000000000003e8
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000c27 x12: 000000000000040d
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
__do_kernel_fault: 207930 callbacks suppressed
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000c99 x12: 0000000000000433
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000d08 x12: 0000000000000458
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000d77 x12: 000000000000047d
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000de6 x12: 00000000000004a2
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000e55 x12: 00000000000004c7
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000ec4 x12: 00000000000004ec
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000f33 x12: 0000000000000511
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000fa2 x12: 0000000000000536
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000001011 x12: 000000000000055b
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000001080 x12: 0000000000000580
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
__do_kernel_fault: 192717 callbacks suppressed
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 00000000000010f2 x12: 00000000000005a6
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000001161 x12: 00000000000005cb
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 00000000000011d0 x12: 00000000000005f0
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 000000000000123f x12: 0000000000000615
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 00000000000012ae x12: 000000000000063a
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 000000000000131d x12: 000000000000065f
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2ba40
x29: ffff800082b2ba40 x28: f4ff000004d18000 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f4ff0000062f10c0
x23: 0000000020400009 x22: 0000000000000025 x21: 00000000fffffff7
x20: ffff800082b2bb60 x19: 0000000097c18005 x18: 00000000fffffffb
x17: 3030207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 000000000000138c x12: 0000000000000684
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff000004d18000
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_page_fault+0xac/0x4b0 arch/arm64/mm/fault.c:733
 do_translation_fault+0xac/0xb8 arch/arm64/mm/fault.c:744
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 00000000fffffff7
WARNING: CPU: 1 PID: 3082 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 1 PID: 3082 Comm: syz-executor151 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware 

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

