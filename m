Return-Path: <bpf+bounces-3868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5D0745A7C
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 12:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D367280D60
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 10:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFD1525B;
	Mon,  3 Jul 2023 10:43:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33654431
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 10:43:04 +0000 (UTC)
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E396AC4
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 03:42:58 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1b896011e00so13728795ad.3
        for <bpf@vger.kernel.org>; Mon, 03 Jul 2023 03:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688380978; x=1690972978;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hTTuLmZnGpvEn8HYNxZkLSLDrqh7PUM5SevNCYkDSs=;
        b=jy9y+VeNYn1sGNumwZMFP3o7YcLoTvib8wFk6vUBn5Tocev+gIueub73UP7U6zqZ+R
         9u3ufmsIDWXy8Q3cvYEFGBPu3TR3MYVMOMotaRKMWthHj7+HE+whjC3L+qhfqsXmOdfk
         eYYGJNjONEKuE5GRBt2MSw+Rk50MJguhETETRcJJVn4HNHHTMTilXZXl/VvuKv22ueGO
         a/r4HvSqcT1DO4V20Vm7GgcG3olhmg2RDVI2tZahdLjAgyTNxTAUWnumAqVzHPMN7bKv
         NjcA35vgdY1QO98ZYbYiPq8hBTi4/dOKsJ4ewTKQUhEFgx5Go+sRwBrIU23HusvedDET
         vS0w==
X-Gm-Message-State: ABy/qLbM9zjAFraDRbw+3AALPLYD8R6XIHmvVyZKwhKHlZk0zk4EX4lU
	FV845HbDZVKOcBI0nqNRe1/p4sjWZm8ribuLyC27q133pnQ7kb1FEw==
X-Google-Smtp-Source: APBJJlFNf0574orWPRyEjT20tj8wIh4w7qYtJOJcwIdo+/8lxNRYLtKzgHnaX6UN/64l9LW+qURvnupFshxYIIJJ+pN3QFkQPlD8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:8642:b0:1b8:9eca:d6a7 with SMTP id
 y2-20020a170902864200b001b89ecad6a7mr544505plt.7.1688380978400; Mon, 03 Jul
 2023 03:42:58 -0700 (PDT)
Date: Mon, 03 Jul 2023 03:42:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076961f05ff92d4e0@google.com>
Subject: [syzbot] [modules?] WARNING in init_module_from_file
From: syzbot <syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, chris@chrisdown.name, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, llvm@lists.linux.dev, mcgrof@kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, syzkaller-bugs@googlegroups.com, 
	trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    3a8a670eeeaa Merge tag 'net-next-6.5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b009e7280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce7f4ca96cdf82c7
dashboard link: https://syzkaller.appspot.com/bug?extid=9c2bdc9d24e4a7abe741
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1465b04f280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127c9dfb280000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-3a8a670e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a940531a9b86/vmlinux-3a8a670e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f3cbae5be61/Image-3a8a670e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com

------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Not tainted 6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 000000000000083a x12: 00000000000002be
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : ffff00007f9b8cc8 x4 : 0000000000000000 x3 : ffff7ffffd5f8000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 00000000000008a6 x12: 00000000000002e2
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000912 x12: 0000000000000306
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 000000000000097e x12: 000000000000032a
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 00000000000009ea x12: 000000000000034e
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000a56 x12: 0000000000000372
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000ac2 x12: 0000000000000396
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000b2e x12: 00000000000003ba
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000b9a x12: 00000000000003de
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000c06 x12: 0000000000000402
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
__do_kernel_fault: 233598 callbacks suppressed
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000c75 x12: 0000000000000427
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : ffff00007f9b8cc8 x4 : 0000000000000000 x3 : ffff7ffffd5f8000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000ce1 x12: 000000000000044b
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000d4d x12: 000000000000046f
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000db9 x12: 0000000000000493
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000e25 x12: 00000000000004b7
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000e91 x12: 00000000000004db
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000efd x12: 00000000000004ff
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000f69 x12: 0000000000000523
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000fd5 x12: 0000000000000547
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000001041 x12: 000000000000056b
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
__do_kernel_fault: 219598 callbacks suppressed
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 00000000000010b0 x12: 0000000000000590
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : ffff00007f9b8cc8 x4 : 0000000000000000 x3 : ffff7ffffd5f8000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 000000000000111c x12: 00000000000005b4
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000001188 x12: 00000000000005d8
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 00000000000011f4 x12: 00000000000005fc
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000001260 x12: 0000000000000620
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 00000000000012cc x12: 0000000000000644
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000001338 x12: 0000000000000668
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
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
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel

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

