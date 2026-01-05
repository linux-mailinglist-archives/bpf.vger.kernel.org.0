Return-Path: <bpf+bounces-77834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81950CF4299
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 15:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00069300D281
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 14:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D4E346772;
	Mon,  5 Jan 2026 14:11:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8413345CD9
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622281; cv=none; b=d7DPVDXx50+89B9QJJLV+hdKJX5/tBSh6Qo/a/cURP6BUSyf/bV31O+TbaAKbbPGsL1fSiFpJP3ts3ltAGnga8YRYn5woOtFTMpakyloDHrf0+uYf8nIqGLUuYfIVCbMJu8DBKaPeiSsgtdGs/n2/Fb7QsEPCyuAbtnzFPLaTRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622281; c=relaxed/simple;
	bh=SxNlGhoDBkaZv0Iy0fCk8gTsb4Hnd6ztmd4CRnc3a+M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aFGVtLpNpGU+jzsjCv1XQEyz/o81g5jcxhayuOx8ws71W9Bs0d+/lrm0iqR+7995ob4XKS2wOo/b9M4dq7qYJWB97DiyXQiKAbAPktwHKtIMxpMBMCIg1Ohi1U9Icju2ivOfYWhrEGrdTjKftMfT1XloAk8OzX2r3TCiBrGpDRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7c70546acd9so34207139a34.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 06:11:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767622279; x=1768227079;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtMWxxPLCuk2eWMEbDquYa0hrVzkkp2fBA7Y9QCp76s=;
        b=KCzq0aH2Q5L5gXF+l5G3FhNiY1IrkF2gaSCRU5c4aFdlFHzvyuYxpychrA67g+TiVy
         hVXW04hO2hv5p1FJaAPeBk3mjpbhrbA/WZYL+rI3OPdG5P0SXPpAYG4p4TiIE2r/0PnD
         06FfQgnmPTAdI6BTjm06O8rDmrc6C8nlBfa3wX89/VA81mTFe9Fupg6YW6heW81mT9fM
         UVDQiNoBplyiB4xtUPL+zFy4qFv286yr3myOgVzEfh7J9HM8l8T5wEl+MpWPOyWMuaz9
         5fDjQJybUxZUVoMzo4SXUsMnZcuXMIBktDMgg84eW5oLaNDn2rMlXJ0pTaUXgNMiZhjr
         Ubhg==
X-Forwarded-Encrypted: i=1; AJvYcCUKeKIAC77pLhZOQipwJAE3qkaRAt1ea3eIGDzzWTCAmSAlWmGJ1v81kXYfJbzxRCy1tys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ufvRsUYj02squI5QRKEXGpJU1YGoLlrxPciDjjim2lcwbif4
	v1cpY9MKYpKYKIGEbK+WipuGuekkeMLwbC9aKwHRWqIjstByVA6rGT5pfNduoJFGAmnpaLS6PtC
	Zn3/Ea+4o5CmLntxD7LvsVqag5fSCno1tCnm6ukq0PW1jaiyhdy1zzox9uSM=
X-Google-Smtp-Source: AGHT+IEtUuAscl8sS2KwjQTHkBr++AMhsAQH1zdhVQ+qs1Np9ixn7kBeTOEbFr2sI8lujPW+hVCE2quCBT31w6fXtRyamdvkHjwd
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2224:b0:65b:33ec:1bd4 with SMTP id
 006d021491bc7-65d0eb2e62amr21568883eaf.43.1767622278740; Mon, 05 Jan 2026
 06:11:18 -0800 (PST)
Date: Mon, 05 Jan 2026 06:11:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695bc686.050a0220.1c677c.032f.GAE@google.com>
Subject: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in strnchr
From: syzbot <syzbot+2c29addf92581b410079@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    22cc16c04b78 riscv, bpf: Fix incorrect usage of BPF_TRAMP_..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1391f792580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=2c29addf92581b410079
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c82e22580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16de569a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/43a53493cb5f/disk-22cc16c0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9726fb9e1980/vmlinux-22cc16c0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efd2bc050ab6/bzImage-22cc16c0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c29addf92581b410079@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in strnchr+0x5e/0x80 lib/string.c:405
Read of size 1 at addr ffff888029e093b0 by task ksoftirqd/1/23

CPU: 1 UID: 0 PID: 23 Comm: ksoftirqd/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 strnchr+0x5e/0x80 lib/string.c:405
 bpf_bprintf_prepare+0x167/0x13d0 kernel/bpf/helpers.c:829
 ____bpf_snprintf kernel/bpf/helpers.c:1065 [inline]
 bpf_snprintf+0xd3/0x1b0 kernel/bpf/helpers.c:1049
 bpf_prog_c2925c0a7ac12d80+0x58/0x60
 bpf_dispatcher_nop_func include/linux/bpf.h:1378 [inline]
 __bpf_prog_run include/linux/filter.h:723 [inline]
 bpf_prog_run include/linux/filter.h:730 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
 bpf_trace_run1+0x27f/0x4c0 kernel/trace/bpf_trace.c:2115
 __bpf_trace_rcu_utilization+0xa1/0xf0 include/trace/events/rcu.h:27
 __do_trace_rcu_utilization include/trace/events/rcu.h:27 [inline]
 trace_rcu_utilization+0x191/0x1c0 include/trace/events/rcu.h:27
 rcu_core+0x13fe/0x1870 kernel/rcu/tree.c:2865
 handle_softirqs+0x27d/0x850 kernel/softirq.c:622
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Allocated by task 6022:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:414
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __do_kmalloc_node mm/slub.c:5657 [inline]
 __kmalloc_node_noprof+0x57a/0x820 mm/slub.c:5663
 kmalloc_node_noprof include/linux/slab.h:987 [inline]
 __bpf_map_area_alloc kernel/bpf/syscall.c:395 [inline]
 bpf_map_area_alloc+0x64/0x180 kernel/bpf/syscall.c:408
 insn_array_alloc+0x52/0x140 kernel/bpf/bpf_insn_array.c:49
 map_create+0xafd/0x16a0 kernel/bpf/syscall.c:1514
 __sys_bpf+0x5f0/0x860 kernel/bpf/syscall.c:6146
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888029e09000
 which belongs to the cache kmalloc-cg-1k of size 1024
The buggy address is located 0 bytes to the right of
 allocated 944-byte region [ffff888029e09000, ffff888029e093b0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29e08
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888072141701
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813ffb0280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000000f5000000 ffff888072141701
head: 00fff00000000040 ffff88813ffb0280 dead000000000100 dead000000000122
head: 0000000000000000 0000000080100010 00000000f5000000 ffff888072141701
head: 00fff00000000003 ffffea0000a78201 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5709, tgid 5709 (dhcpcd-run-hook), ts 83835394493, free_ts 83796353079
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1846
 prep_new_page mm/page_alloc.c:1854 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3b0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xf2b/0x1960 mm/slub.c:4656
 __slab_alloc+0x65/0x100 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 __do_kmalloc_node mm/slub.c:5656 [inline]
 __kmalloc_noprof+0x47d/0x800 mm/slub.c:5669
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kmalloc_array_noprof include/linux/slab.h:1003 [inline]
 alloc_pipe_info+0x1fd/0x4d0 fs/pipe.c:817
 get_pipe_inode fs/pipe.c:896 [inline]
 create_pipe_files+0x8a/0x7e0 fs/pipe.c:928
 __do_pipe_flags+0x46/0x1f0 fs/pipe.c:990
 do_pipe2+0x9c/0x170 fs/pipe.c:1038
 __do_sys_pipe2 fs/pipe.c:1056 [inline]
 __se_sys_pipe2 fs/pipe.c:1054 [inline]
 __x64_sys_pipe2+0x5a/0x70 fs/pipe.c:1054
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5712 tgid 5712 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc8/0xd30 mm/page_alloc.c:2943
 __slab_free+0x21b/0x2a0 mm/slub.c:6004
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:349
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_noprof+0x37d/0x710 mm/slub.c:5270
 vm_area_alloc+0x24/0x140 mm/vma_init.c:32
 __mmap_new_vma mm/vma.c:2469 [inline]
 __mmap_region mm/vma.c:2708 [inline]
 mmap_region+0xdea/0x1d10 mm/vma.c:2786
 do_mmap+0xc45/0x10d0 mm/mmap.c:558
 vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:581
 ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:604
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888029e09280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888029e09300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888029e09380: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
                                     ^
 ffff888029e09400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888029e09480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

