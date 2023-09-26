Return-Path: <bpf+bounces-10904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D3C7AF585
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 22:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C69892837F5
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 20:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671347C7A;
	Tue, 26 Sep 2023 20:47:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3943715D
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 20:47:38 +0000 (UTC)
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05883136
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 13:47:35 -0700 (PDT)
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-1dcfa4cd2b6so16689161fac.1
        for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 13:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695761254; x=1696366054;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/zDMVC/fYmKPYBhxu9c4/EG5uLEdTJncjl69CxbpaI=;
        b=t5cPtFBSB32a0CEjyCHGLWbWt9JZwKETtuBMSfQJ39I2AQMT8u36bXFQRMuxo9v6gK
         eMmRMc58rNdmPTD0Sp+2T8gTLVlibTc86wAZM62crbx304M0flnRnLnzipe56Cmlf1CS
         jfHb+bIK/GwwWalAzjrEjnls3Q8z+lW+Fbkkr2NJGCgO/8ofEP51tiJNFPEHjjMWfp9V
         0BiexAGZ3BVXdyKBvpP4Ty1DVi2RXfnCBZ3wh+L2N1gcNnOEnVJd0DrFl0uTgLfhI3/f
         8m8fM6bNZJOFxvdZZY7gx2AznJhewgyPZASm4KFmWXzjvhOFuGbGn64OuCWrNUOR+ucy
         IhxA==
X-Gm-Message-State: AOJu0YxN9VCILu01umFI8ap0yXVs72+twoyX1lr/gPQes/QBQ8FMl1Vc
	ybU5ePPCr1wb79uK4T0RkllK+tPivt7eNdQNeqPSQECiVdj0
X-Google-Smtp-Source: AGHT+IF5/b+N+5KGxuCTJnyIeBi3zIXcRokuHfKRpscL+qHJZH2/jepRo1bLPhfFTY1CnjK/K8w70tXdwtAnk32eJTe64zohFvmr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6871:6a87:b0:1c5:87d6:b779 with SMTP id
 zf7-20020a0568716a8700b001c587d6b779mr54027oab.8.1695761254376; Tue, 26 Sep
 2023 13:47:34 -0700 (PDT)
Date: Tue, 26 Sep 2023 13:47:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030ed510606492f24@google.com>
Subject: [syzbot] [bpf?] WARNING in bpf_mprog_attach
From: syzbot <syzbot+baa44e3dbbe48e05c1ad@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    bf6547d8715b Merge branches 'for-next/sve-remove-pseudo-re..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15e15266680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87bf2bd0cc8825ea
dashboard link: https://syzkaller.appspot.com/bug?extid=baa44e3dbbe48e05c1ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1429fe12680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135744cc680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce9077c94d96/disk-bf6547d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a846fe1c61d3/vmlinux-bf6547d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b4436f7e6852/Image-bf6547d8.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+baa44e3dbbe48e05c1ad@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6072 at include/linux/bpf_mprog.h:198 bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
WARNING: CPU: 1 PID: 6072 at include/linux/bpf_mprog.h:198 bpf_mprog_pos_before kernel/bpf/mprog.c:200 [inline]
WARNING: CPU: 1 PID: 6072 at include/linux/bpf_mprog.h:198 bpf_mprog_attach+0x584/0xb88 kernel/bpf/mprog.c:258
Modules linked in:
CPU: 1 PID: 6072 Comm: syz-executor183 Not tainted 6.6.0-rc3-syzkaller-gbf6547d8715b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
pc : bpf_mprog_pos_before kernel/bpf/mprog.c:200 [inline]
pc : bpf_mprog_attach+0x584/0xb88 kernel/bpf/mprog.c:258
lr : bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
lr : bpf_mprog_pos_before kernel/bpf/mprog.c:200 [inline]
lr : bpf_mprog_attach+0x584/0xb88 kernel/bpf/mprog.c:258
sp : ffff800096767920
x29: ffff800096767a00 x28: 0000000000000040 x27: 1fffe0001983e841
x26: 0000000000000000 x25: ffff0000cc1f4208 x24: 00000000ffffffde
x23: ffff8000967679a0 x22: ffff8000967679c0 x21: ffff0000cc1f4008
x20: ffff0000cc1f4628 x19: dfff800000000000 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008a576f00 x15: 0000000000000002
x14: 1ffff00012cecf34 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000d4921bc0 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000008 x4 : 0000000000000000 x3 : 0000000000000010
x2 : 0000000000000000 x1 : 0000000000000040 x0 : 000000000000003f
Call trace:
 bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
 bpf_mprog_pos_before kernel/bpf/mprog.c:200 [inline]
 bpf_mprog_attach+0x584/0xb88 kernel/bpf/mprog.c:258
 tcx_prog_attach+0x23c/0x6ac kernel/bpf/tcx.c:39
 bpf_prog_attach+0x19c/0x340 kernel/bpf/syscall.c:3848
 __sys_bpf+0x2e8/0x5dc kernel/bpf/syscall.c:5344
 __do_sys_bpf kernel/bpf/syscall.c:5439 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5437 [inline]
 __arm64_sys_bpf+0x80/0x98 kernel/bpf/syscall.c:5437
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 576
hardirqs last  enabled at (575): [<ffff800080034500>] local_daif_restore+0x1c/0x3c arch/arm64/include/asm/daifflags.h:75
hardirqs last disabled at (576): [<ffff80008a625394>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:436
softirqs last  enabled at (562): [<ffff8000805caa34>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (562): [<ffff8000805caa34>] bpf_prog_by_id+0x144/0x168 kernel/bpf/syscall.c:4083
softirqs last disabled at (560): [<ffff8000805ca92c>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (560): [<ffff8000805ca92c>] bpf_prog_by_id+0x3c/0x168 kernel/bpf/syscall.c:4077
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6072 at include/linux/bpf_mprog.h:198 bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
WARNING: CPU: 1 PID: 6072 at include/linux/bpf_mprog.h:198 bpf_mprog_insert+0x2bc/0x3f8 kernel/bpf/mprog.c:131
Modules linked in:
CPU: 1 PID: 6072 Comm: syz-executor183 Tainted: G        W          6.6.0-rc3-syzkaller-gbf6547d8715b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
pc : bpf_mprog_insert+0x2bc/0x3f8 kernel/bpf/mprog.c:131
lr : bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
lr : bpf_mprog_insert+0x2bc/0x3f8 kernel/bpf/mprog.c:131
sp : ffff8000967678c0
x29: ffff8000967678c0 x28: 0000000000000040 x27: 1fffe0001983e841
x26: dfff800000000000 x25: 0000000000000040 x24: 0000000000000008
x23: ffff0000cc1f4008 x22: 00000000ffffffff x21: ffff0000cc1f4208
x20: ffff8000967679c0 x19: ffff800096767ac0 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008a576f00 x15: 0000000000000002
x14: 1ffff00012cecf34 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000d4921bc0 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000008 x4 : 0000000000000008 x3 : 00000000ffffffff
x2 : ffff8000967679c0 x1 : 0000000000000040 x0 : 000000000000003f
Call trace:
 bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
 bpf_mprog_insert+0x2bc/0x3f8 kernel/bpf/mprog.c:131
 bpf_mprog_attach+0xa40/0xb88 kernel/bpf/mprog.c:288
 tcx_prog_attach+0x23c/0x6ac kernel/bpf/tcx.c:39
 bpf_prog_attach+0x19c/0x340 kernel/bpf/syscall.c:3848
 __sys_bpf+0x2e8/0x5dc kernel/bpf/syscall.c:5344
 __do_sys_bpf kernel/bpf/syscall.c:5439 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5437 [inline]
 __arm64_sys_bpf+0x80/0x98 kernel/bpf/syscall.c:5437
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 724
hardirqs last  enabled at (723): [<ffff80008a6253dc>] el1_dbg+0x6c/0x80 arch/arm64/kernel/entry-common.c:439
hardirqs last disabled at (724): [<ffff80008a625394>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:436
softirqs last  enabled at (594): [<ffff8000800218ec>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (594): [<ffff8000800218ec>] __do_softirq+0xac0/0xd54 kernel/softirq.c:582
softirqs last disabled at (579): [<ffff80008002aad4>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6072 at include/linux/bpf_mprog.h:198 bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
WARNING: CPU: 1 PID: 6072 at include/linux/bpf_mprog.h:198 bpf_mprog_entry_grow include/linux/bpf_mprog.h:277 [inline]
WARNING: CPU: 1 PID: 6072 at include/linux/bpf_mprog.h:198 bpf_mprog_insert+0x2d0/0x3f8 kernel/bpf/mprog.c:142
Modules linked in:
CPU: 1 PID: 6072 Comm: syz-executor183 Tainted: G        W          6.6.0-rc3-syzkaller-gbf6547d8715b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
pc : bpf_mprog_entry_grow include/linux/bpf_mprog.h:277 [inline]
pc : bpf_mprog_insert+0x2d0/0x3f8 kernel/bpf/mprog.c:142
lr : bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
lr : bpf_mprog_entry_grow include/linux/bpf_mprog.h:277 [inline]
lr : bpf_mprog_insert+0x2d0/0x3f8 kernel/bpf/mprog.c:142
sp : ffff8000967678c0
x29: ffff8000967678c0 x28: 1fffe0001983e882 x27: 1fffe0001983e841
x26: dfff800000000000 x25: 0000000000000040 x24: ffff0000cc1f4628
x23: ffff0000cc1f4410 x22: 0000000000000000 x21: ffff0000cc1f4210
x20: ffff8000967679c0 x19: ffff800096767ac0 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008a576ca0 x15: ffff80009503e000
x14: ffff80009509e000 x13: ffff80009503e000 x12: ffff80009509e000
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000d4921bc0 x7 : ffff800093fee000 x6 : ffff80009501e000
x5 : ffff0000cc1f4410 x4 : ffff0000cc1f4208 x3 : ffff0000cc1f4390
x2 : fffffffffffffff0 x1 : 0000000000000040 x0 : 000000000000003f
Call trace:
 bpf_mprog_total include/linux/bpf_mprog.h:198 [inline]
 bpf_mprog_entry_grow include/linux/bpf_mprog.h:277 [inline]
 bpf_mprog_insert+0x2d0/0x3f8 kernel/bpf/mprog.c:142
 bpf_mprog_attach+0xa40/0xb88 kernel/bpf/mprog.c:288
 tcx_prog_attach+0x23c/0x6ac kernel/bpf/tcx.c:39
 bpf_prog_attach+0x19c/0x340 kernel/bpf/syscall.c:3848
 __sys_bpf+0x2e8/0x5dc kernel/bpf/syscall.c:5344
 __do_sys_bpf kernel/bpf/syscall.c:5439 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5437 [inline]
 __arm64_sys_bpf+0x80/0x98 kernel/bpf/syscall.c:5437
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 746
hardirqs last  enabled at (745): [<ffff80008a627868>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (745): [<ffff80008a627868>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (746): [<ffff80008a625394>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:436
softirqs last  enabled at (740): [<ffff8000800218ec>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (740): [<ffff8000800218ec>] __do_softirq+0xac0/0xd54 kernel/softirq.c:582
softirqs last disabled at (727): [<ffff80008002aad4>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

