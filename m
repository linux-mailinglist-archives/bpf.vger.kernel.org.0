Return-Path: <bpf+bounces-64568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5765B144B5
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 01:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1A517FA81
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 23:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F81D2367DF;
	Mon, 28 Jul 2025 23:37:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3172264BE
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753745860; cv=none; b=UL6D7L4d9D7fJB+/v4mN5ULqwrsyj4g8jDWSe0HgSXevMVkPgesrzZnO2RexQN1iz3QLEQ5cQy5uhFMTazR/qNSJrJtE9OQffDeaHH0yWxCbkfAqdsjektECBxpad0/ZOtu6eOEKRf2/IkfFg8GrvqT4s/LHMBIp/Gm+ln//7yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753745860; c=relaxed/simple;
	bh=4Nsn2JzgNOLgwIa8CC3tkKHfNnnL6zgGVUfBBpwwTEc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pqIo62It6gPz9RdWB6Or2tcI2p/mfOmldkW57YGlWYqFh2yF6lF3YJAxiYOGk8FD2DLZ9dPQAyicjCSV+QV6dpjeaZvlpL0ym4a+V1Jvv3Pml4IGUYQqPCUGv3aEiSj8y/AHupMcZ5oo0nZHcCKyvRKu0FTDYn2erv4LNhss+PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-87c306a1b38so405322839f.1
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 16:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753745857; x=1754350657;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3ivzT5d25VTDkk/W17d4zKV+sXKZSW9JJ19Be8hmrY=;
        b=DcE2QMyVkdl7Gg81BvNqOSFdn9YFvL4kNF3djoePmOR3JN+xAmvIQrKEvVDLOn14hf
         avpFP1a2JmoNss8Fa+Y899cRV1BXQ79fDan1omZ0iZ6zS3SWkBZjkERW52XMiT8t9hUw
         IaOu1eCX2IgLPJvY1y55KiXZ8lQWlXlwQL8ulV7BnKHQT+hkJpbxmObemRekg23NJbBq
         67zwCwCxDzpCwnkx9m118I3oADFKjKFnIZC7bvz1L/E2amHFxS61kSF6QENl3SVPyKl1
         ydLuAv/UjGc9SIpQXfIpPw6zfQdwWNyZKFyhYKlzhG+UCHyluyIWPzv3JwWP1zJrNvbU
         2PiA==
X-Forwarded-Encrypted: i=1; AJvYcCUZq1KEc3wQQvdf5EDxrubabg7PlFsIKsQD28ZLfPgN5DLFP9RhWoBUDFPdJFe8j6EBb+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+nHXgnCNeUXsc8h8vYmmXv3Yq7dwDg9ekprWDD/NmR9d4SCCs
	5DQ56fkYzInQrqz8TCDf8Bx6ZoTzdT6FlaoFY2xJCCauBxYRS+YufMMAeotq5DKTjdbnOCO+FFX
	epG741rkQYsxQRW5B7s3Gz19Oy3JErjuhzF83joAYwlpWHm/25QQ7ciwXu6I=
X-Google-Smtp-Source: AGHT+IGbbIqiWaNiESj6i2+xr5J432n7+5X8JupkVIUv059I8zQaFd3d7ssRdsbY/4GvmSovV1KmNpMih9+5SdxtFmjJaox9ae0q
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c9:b0:3e2:8e44:8240 with SMTP id
 e9e14a558f8ab-3e3c52e3e54mr198337165ab.11.1753745857670; Mon, 28 Jul 2025
 16:37:37 -0700 (PDT)
Date: Mon, 28 Jul 2025 16:37:37 -0700
In-Reply-To: <6887e3c8.a00a0220.b12ec.00ad.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688809c1.a00a0220.b12ec.00b7.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Write in __bpf_get_stackid
From: syzbot <syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5b4c54ac49af bpf: Fix various typos in verifier.c comments
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17441782580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=934611ae034ab218
dashboard link: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f294a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14349034580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5a5cfac28d08/disk-5b4c54ac.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bb5b9f9f1b33/vmlinux-5b4c54ac.xz
kernel image: https://storage.googleapis.com/syzbot-assets/14b928da2760/bzImage-5b4c54ac.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __bpf_get_stackid+0x677/0xcf0 kernel/bpf/stackmap.c:265
Write of size 8 at addr ffff8880439aa258 by task syz-executor265/6114

CPU: 1 UID: 0 PID: 6114 Comm: syz-executor265 Not tainted 6.16.0-rc6-syzkaller-g5b4c54ac49af #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <IRQ>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 __bpf_get_stackid+0x677/0xcf0 kernel/bpf/stackmap.c:265
 ____bpf_get_stackid_raw_tp kernel/trace/bpf_trace.c:1810 [inline]
 bpf_get_stackid_raw_tp+0x196/0x210 kernel/trace/bpf_trace.c:1799
 bpf_prog_b724608cae728045+0x27/0x2f
 bpf_dispatcher_nop_func include/linux/bpf.h:1322 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2257 [inline]
 bpf_trace_run2+0x284/0x4b0 kernel/trace/bpf_trace.c:2298
 __do_trace_kfree include/trace/events/kmem.h:94 [inline]
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x3a0/0x440 mm/slub.c:4829
 slab_free_after_rcu_debug+0x60/0x2a0 mm/slub.c:4680
 rcu_do_batch kernel/rcu/tree.c:2576 [inline]
 rcu_core+0xca8/0x1710 kernel/rcu/tree.c:2832
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:xas_load+0xd9/0x5b0 lib/xarray.c:244
Code: 42 0f b6 04 28 84 c0 0f 85 3a 04 00 00 49 8d 5e fe 48 8b 44 24 08 0f b6 28 48 89 d8 48 c1 e8 03 48 89 44 24 20 42 0f b6 04 28 <84> c0 0f 85 34 04 00 00 44 0f b6 23 44 0f b6 fd 44 89 ff 44 89 e6
RSP: 0000:ffffc9000459f898 EFLAGS: 00000a02
RAX: 0000000000000000 RBX: ffff888025438840 RCX: ffff88807c050000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000002
RBP: 0000000000000000 R08: ffff88807c050000 R09: 0000000000000002
R10: 0000000000000003 R11: 0000000000000000 R12: ffffc9000459fb32
R13: dffffc0000000000 R14: ffff888025438842 R15: 0000000000000002
 xas_find+0x157/0x990 lib/xarray.c:1406
 next_uptodate_folio+0x32/0x5d0 mm/filemap.c:3562
 filemap_map_pages+0x21f/0x1740 mm/filemap.c:3714
 do_fault_around mm/memory.c:5548 [inline]
 do_read_fault mm/memory.c:5581 [inline]
 do_fault mm/memory.c:5724 [inline]
 do_pte_missing mm/memory.c:4251 [inline]
 handle_pte_fault mm/memory.c:6069 [inline]
 __handle_mm_fault+0x3687/0x5620 mm/memory.c:6212
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6381
 do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f3d52e29438
Code: Unable to access opcode bytes at 0x7f3d52e2940e.
RSP: 002b:00007fff46c399c8 EFLAGS: 00010206
RAX: 00007f3d52e59ad8 RBX: 0000000000000000 RCX: 0000000000000004
RDX: 00007f3d52e5ad00 RSI: 0000000000000000 RDI: 00007f3d52e59ad8
RBP: 00007f3d52e58118 R08: 00007fff46c39a3c R09: 00007fff46c39a3c
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3d52e5ace8
R13: 0000000000000000 R14: 00007f3d52e5ad00 R15: 00007f3d52db0290
 </TASK>

Allocated by task 6114:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4328 [inline]
 __kmalloc_node_noprof+0x276/0x4e0 mm/slub.c:4334
 kmalloc_node_noprof include/linux/slab.h:932 [inline]
 __bpf_map_area_alloc kernel/bpf/syscall.c:391 [inline]
 bpf_map_area_alloc+0x64/0x180 kernel/bpf/syscall.c:404
 prealloc_elems_and_freelist+0x86/0x1d0 kernel/bpf/stackmap.c:51
 stack_map_alloc+0x33f/0x4c0 kernel/bpf/stackmap.c:114
 map_create+0xaa0/0x1310 kernel/bpf/syscall.c:1477
 __sys_bpf+0x60f/0x870 kernel/bpf/syscall.c:6004
 __do_sys_bpf kernel/bpf/syscall.c:6132 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6130 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6130
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880439aa000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 24 bytes to the right of
 allocated 576-byte region [ffff8880439aa000, ffff8880439aa240)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x439a8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a441dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a441dc0 0000000000000000 dead000000000001
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea00010e6a01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5514, tgid 5514 (dhcpcd), ts 48384102667, free_ts 48383277611
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab+0x8a/0x3b0 mm/slub.c:2619
 new_slab mm/slub.c:2673 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3859
 __slab_alloc mm/slub.c:3949 [inline]
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x305/0x4f0 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 load_elf_phdrs fs/binfmt_elf.c:525 [inline]
 load_elf_binary+0x2cd/0x2790 fs/binfmt_elf.c:854
 search_binary_handler fs/exec.c:1670 [inline]
 exec_binprm fs/exec.c:1702 [inline]
 bprm_execve+0x999/0x1450 fs/exec.c:1754
 do_execveat_common+0x510/0x6a0 fs/exec.c:1860
 do_execve fs/exec.c:1934 [inline]
 __do_sys_execve fs/exec.c:2010 [inline]
 __se_sys_execve fs/exec.c:2005 [inline]
 __x64_sys_execve+0x94/0xb0 fs/exec.c:2005
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5514 tgid 5514 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0xc71/0xe70 mm/page_alloc.c:2706
 discard_slab mm/slub.c:2717 [inline]
 __put_partials+0x161/0x1c0 mm/slub.c:3186
 put_cpu_partial+0x17c/0x250 mm/slub.c:3261
 __slab_free+0x2f7/0x400 mm/slub.c:4513
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x224/0x4f0 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 tomoyo_add_entry security/tomoyo/common.c:2132 [inline]
 tomoyo_supervisor+0xbd5/0x1480 security/tomoyo/common.c:2204
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x149/0x1e0 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0x15cf/0x1aa0 security/tomoyo/domain.c:888
 tomoyo_bprm_check_security+0x11c/0x180 security/tomoyo/tomoyo.c:102
 security_bprm_check+0x89/0x270 security/security.c:1302
 search_binary_handler fs/exec.c:1660 [inline]
 exec_binprm fs/exec.c:1702 [inline]
 bprm_execve+0x8ee/0x1450 fs/exec.c:1754
 do_execveat_common+0x510/0x6a0 fs/exec.c:1860
 do_execve fs/exec.c:1934 [inline]
 __do_sys_execve fs/exec.c:2010 [inline]
 __se_sys_execve fs/exec.c:2005 [inline]
 __x64_sys_execve+0x94/0xb0 fs/exec.c:2005

Memory state around the buggy address:
 ffff8880439aa100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880439aa180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880439aa200: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                                    ^
 ffff8880439aa280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880439aa300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax
   5:	84 c0                	test   %al,%al
   7:	0f 85 3a 04 00 00    	jne    0x447
   d:	49 8d 5e fe          	lea    -0x2(%r14),%rbx
  11:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  16:	0f b6 28             	movzbl (%rax),%ebp
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
  25:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax
* 2a:	84 c0                	test   %al,%al <-- trapping instruction
  2c:	0f 85 34 04 00 00    	jne    0x466
  32:	44 0f b6 23          	movzbl (%rbx),%r12d
  36:	44 0f b6 fd          	movzbl %bpl,%r15d
  3a:	44 89 ff             	mov    %r15d,%edi
  3d:	44 89 e6             	mov    %r12d,%esi


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

