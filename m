Return-Path: <bpf+bounces-45559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 940649D7A35
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 03:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF223B21AE9
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394DCEAF1;
	Mon, 25 Nov 2024 02:50:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4294834545
	for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732503022; cv=none; b=a3sKekbZNq6qwmNVO3XBYpLRc1A9vdNFftfRhYZimev6v63JDlB04gI1msN7KzxT0FAfM1/U95clHyEU6mbJTXSuw/qArZV/4wg6TsVew9z2hpy/55/T6HULDsf7w1h7o9Q8JLA4Q02AzpYQRm1r1D6SefmvXRQr1cNfBExCZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732503022; c=relaxed/simple;
	bh=LKsKScGP/jYhObXHr3bHTA276e58QH/9Xl/ouFDD4tI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nJQaQYmDzL6GhS7kT/GlFLJXL1YfyZtEVGIiJ7Hx1vVqyfXL71o9TnCIRDVtdgHQ6/mvqtY8DnajDRlBfFwanCy68NU34uRaG2cKn8bozZmbIfQ4jabLobUdYOKVb1kRdJZ4wLzSgEiRobA30KK31yawVHz99WWcW/1j5FI6X4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a77a2d9601so48449775ab.3
        for <bpf@vger.kernel.org>; Sun, 24 Nov 2024 18:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732503020; x=1733107820;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTMFbq32d7GUN70szs6Yow8qrKh2EhjvonWQd+1+QfU=;
        b=OKBEOztGJWq55D+VAM5Dqo5Q9dXL66k8jOX6FKskOcQPR3/j0jUyySdR0gD+daoVYy
         DhsVQLKsfjDg2vIh6pMaKnAbtYYG65JHEhQo8olEApVLlxJHQPXefh8y+bP1MuUsj/gE
         hEWv2L8rx8/PWPJ74SA1xAkPm2pLtW9zj4DardPRUp1VSXHce2Ush7Yjj9QVRJ6cqLtp
         xkmz+WT6jDp/wVkvOe4dsyVqBgMfuw1bqwdOFduzOD4zfGVWBzy36+itG15pQu2fb3nu
         rgM7tpbUFe/CLu6lq1WaA3j/ZdEPAWTCXRN4gSNqNlfqjBRO8UyOg8QmkG8a9EIHGspH
         tKIg==
X-Forwarded-Encrypted: i=1; AJvYcCWd4SFu3hgCp9NKzrDdO1Vbm5J0dBmcZ8MFDNqe49Dmvo+TKfyHGpMqy6bSbTLwvd2LZoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHUcckurMgo706Odkjg3MQNU9GXhzGZejA4x+WNbCG7BDiLJX
	HgUkJgM3btY9t4Of+JARdCfz5HRowxYsjj7YikTZ67+OpWFHtAWyKnZjaFjt4qaE7HInICfXJA8
	Ete9MaMSElKR8/VKo04fYLfuDnajxMdUu+tDIeO320ePL0zkwhyTZ/iI=
X-Google-Smtp-Source: AGHT+IE/+d4o/UjR7cg4oZ9kJUqrY1+5UsFK4ovnuh2cAKY5c8TtCaL/s7brYsb9up9s1UvXQHj4/kscT+IjSCWszf/2n0IGmM0x
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c264:0:b0:3a7:3e04:5920 with SMTP id
 e9e14a558f8ab-3a79af6d213mr91278635ab.17.1732503020549; Sun, 24 Nov 2024
 18:50:20 -0800 (PST)
Date: Sun, 24 Nov 2024 18:50:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6743e5ec.050a0220.1cc393.0056.GAE@google.com>
Subject: [syzbot] [bpf?] KASAN: vmalloc-out-of-bounds Write in vrealloc_noprof
From: syzbot <syzbot+7d9959e6503e8ffc8558@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ac24e26aa08f Add linux-next specific files for 20241120
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14d91b78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45719eec4c74e6ba
dashboard link: https://syzkaller.appspot.com/bug?extid=7d9959e6503e8ffc8558
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124d8ec0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1425a75f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9c6bcf3605c7/disk-ac24e26a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4ce96eb398a9/vmlinux-ac24e26a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a22aac22c90/bzImage-ac24e26a.xz

The issue was bisected to:

commit 96a30e469ca1d2b8cc7811b40911f8614b558241
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Fri Nov 15 00:13:03 2024 +0000

    bpf: use common instruction history across all states

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102bd930580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=122bd930580000
console output: https://syzkaller.appspot.com/x/log.txt?x=142bd930580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7d9959e6503e8ffc8558@syzkaller.appspotmail.com
Fixes: 96a30e469ca1 ("bpf: use common instruction history across all states")

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in vrealloc_noprof+0x340/0x3a0 mm/vmalloc.c:4095
Write of size 2097120 at addr ffffc90004c00020 by task syz-executor132/5834

CPU: 1 UID: 0 PID: 5834 Comm: syz-executor132 Not tainted 6.12.0-next-20241120-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memset+0x23/0x50 mm/kasan/shadow.c:84
 vrealloc_noprof+0x340/0x3a0 mm/vmalloc.c:4095
 push_insn_history+0x16c/0x6a0 kernel/bpf/verifier.c:3571
 check_mem_access+0xf30/0x2240 kernel/bpf/verifier.c:7267
 do_check+0x7d97/0xfcd0 kernel/bpf/verifier.c:18703
 do_check_common+0x1564/0x2010 kernel/bpf/verifier.c:21848
 do_check_main kernel/bpf/verifier.c:21939 [inline]
 bpf_check+0x19380/0x1f1b0 kernel/bpf/verifier.c:22656
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2947
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5790
 __do_sys_bpf kernel/bpf/syscall.c:5897 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5895 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5895
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae10fcf269
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdf2bc3148 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fae10fcf269
RDX: 0000000000000090 RSI: 0000000020000840 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90004800000, ffffc90004e01000) created by:
 kvrealloc_noprof+0xc7/0x120 mm/util.c:747

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6c600
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102cc2(GFP_HIGHUSER|__GFP_NOWARN), pid 5834, tgid 5834 (syz-executor132), ts 114573563417, free_ts 25588986996
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3725/0x3870 mm/page_alloc.c:3510
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4787
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 vm_area_alloc_pages mm/vmalloc.c:3589 [inline]
 __vmalloc_area_node mm/vmalloc.c:3667 [inline]
 __vmalloc_node_range_noprof+0x9c9/0x1380 mm/vmalloc.c:3844
 __kvmalloc_node_noprof+0x142/0x190 mm/util.c:672
 kvrealloc_noprof+0xc7/0x120 mm/util.c:747
 push_insn_history+0x16c/0x6a0 kernel/bpf/verifier.c:3571
 check_mem_access+0xf30/0x2240 kernel/bpf/verifier.c:7267
 do_check+0x7d97/0xfcd0 kernel/bpf/verifier.c:18703
 do_check_common+0x1564/0x2010 kernel/bpf/verifier.c:21848
 do_check_main kernel/bpf/verifier.c:21939 [inline]
 bpf_check+0x19380/0x1f1b0 kernel/bpf/verifier.c:22656
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2947
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5790
 __do_sys_bpf kernel/bpf/syscall.c:5897 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5895 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5895
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2693
 free_contig_range+0x152/0x550 mm/page_alloc.c:6666
 destroy_args+0x92/0x910 mm/debug_vm_pgtable.c:1017
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
 do_one_initcall+0x248/0x880 init/main.c:1266
 do_initcall_level+0x157/0x210 init/main.c:1328
 do_initcalls+0x3f/0x80 init/main.c:1344
 kernel_init_freeable+0x435/0x5d0 init/main.c:1577
 kernel_init+0x1d/0x2b0 init/main.c:1466
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffffc90004bfff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90004bfff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90004c00000: 00 00 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                               ^
 ffffc90004c00080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90004c00100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

