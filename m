Return-Path: <bpf+bounces-64563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B2CB1439A
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 22:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528C9189E7CC
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 20:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1E9226541;
	Mon, 28 Jul 2025 20:55:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ECC219A8A
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753736139; cv=none; b=DuGlK9m/+vfxGuhBejcMJPOS72UF0/vff17GxWqTo2obBqriuQTkcl+yXZJkiv3aKJUqc+W7uF6/CU43kfp3Xa1iAMNBAhx3WW8SuBjavDK7B/MO/TewWoVDyNvkHuC8Jb95z8eVaS3RgRx6+bZoJ8bDME3EtSVdcD6vBeBv6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753736139; c=relaxed/simple;
	bh=Wno5wYng66b0GZFZK0W2c9/pLUYd+5PuwygKaCtMjiU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i6+pHItG92O0vd/A8a+5PeRpxY5kkbylpWOrAMED4V6KbFzJnFk9DMjhI05mlgDWAWfFjejUIuZeFzWayEi8i9/dvmtvvi+7jcF+lvxA4qOImw4KFpnV4f9jJMIscu359dUB5a5sZup1Ux2T1DGjiuyzk2Yj6BrpjLni/EIGrgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-87c056ae7c0so1027561539f.2
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 13:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753736137; x=1754340937;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Unvfr/7pPCFzVkxr0K5Aeq/kXRUMaEsDKE5erHjIrwk=;
        b=UJBKpPFTs2UTOAU39LSWDrdzke4IEfHGGUJ8NIsFfbAKXNgmx6uO4NhqfuafhMlTF5
         vqbVhzYBfNvKl5f8871L0/S5C9RMUyu7SiDzQDCYpgWnjuoV0+5IlnpPAOPdKEDg7XZe
         JsHOFrDwoQYZalZ1r+bmQmp0jj39pQbHctDaOekjHNL7+BHK91O8DlwQ/j53lj8R8CFz
         8KG/DmjEyBsa+iFY4lAB26G7Qvm8rdDmMSLHIWM5Ff/25e9+0o9nB3fWD3QjjHVyoOqi
         04aGYs+s7NE9bv8IKV3eD628SUqE7XXQk98lz1zYQZTZ0tHfJPHWND6rQFtp+Lm10w2l
         Cbuw==
X-Forwarded-Encrypted: i=1; AJvYcCUVoFBonF7K84HwOEnMF+SmTSLdnfdRtcGOU01sVEBOg4qHwr5AlO+tzGM+70Mi/nQ23OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfFF49AH03JQkQgGyxVbTq072Rtc8y9uKww6Jw4+vfOQNmS4rZ
	pE64tC4msNCy/SvAWWEymGchcOf2vjVD2iYzAgCqdUPgidDDPtXd1xqkHhUW+D3ECYEId2b10x9
	+w4HmW6MGfknqTsN3TaJuXRLVAKWzWSzGV5jHCh7iOE9UDwnoE3pK4zXR/bc=
X-Google-Smtp-Source: AGHT+IGz/LWHaUhIPxsiWoExQzh/HH2+PbEpPOukxwFcLv6VO34WGUU7Hc6wHFeTfpT2swoSmO+lm42wLG3FSt9W2ZcxrYoY7Ptx
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cb:b0:3dd:e7d6:18bb with SMTP id
 e9e14a558f8ab-3e3c52c6410mr204998425ab.17.1753736136990; Mon, 28 Jul 2025
 13:55:36 -0700 (PDT)
Date: Mon, 28 Jul 2025 13:55:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6887e3c8.a00a0220.b12ec.00ad.GAE@google.com>
Subject: [syzbot] [bpf?] KASAN: slab-out-of-bounds Write in __bpf_get_stackid
From: syzbot <syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5345e64760d3 bpf: Simplify bounds refinement from s32
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1052e782580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=934611ae034ab218
dashboard link: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/533f77de596b/disk-5345e647.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/771fbeaf8fb5/vmlinux-5345e647.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6bb4eec6d31b/bzImage-5345e647.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com

hrtimer: interrupt took 66349 ns
==================================================================
BUG: KASAN: slab-out-of-bounds in __bpf_get_stackid+0x677/0xcf0 kernel/bpf/stackmap.c:265
Write of size 8 at addr ffff888143fd0a58 by task syz.1.2/5975

CPU: 1 UID: 0 PID: 5975 Comm: syz.1.2 Not tainted 6.16.0-rc6-syzkaller-g5345e64760d3 #0 PREEMPT(full) 
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
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x9f/0x2c0 mm/kasan/generic.c:189
Code: 00 fc ff df 4d 8d 34 19 4d 89 f4 4d 29 dc 49 83 fc 10 7f 29 4d 85 e4 0f 84 41 01 00 00 4c 89 cb 48 f7 d3 4c 01 fb 41 80 3b 00 <0f> 85 de 01 00 00 49 ff c3 48 ff c3 75 ee e9 21 01 00 00 44 89 dd
RSP: 0018:ffffc900044dee68 EFLAGS: 00000246
RAX: 0000000000000001 RBX: ffffffffffffffff RCX: ffffffff8215d67f
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffea0000c7f634
RBP: 0000000000000000 R08: ffffea0000c7f637 R09: 1ffffd400018fec6
R10: dffffc0000000000 R11: fffff9400018fec6 R12: 0000000000000001
R13: 0000000000000000 R14: fffff9400018fec7 R15: 1ffffd400018fec6
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 page_ref_count include/linux/page_ref.h:67 [inline]
 set_page_refcounted+0x4f/0x160 mm/internal.h:491
 __alloc_pages_noprof mm/page_alloc.c:4995 [inline]
 alloc_pages_bulk_noprof+0x570/0x710 mm/page_alloc.c:4913
 ___alloc_pages_bulk mm/kasan/shadow.c:344 [inline]
 __kasan_populate_vmalloc mm/kasan/shadow.c:368 [inline]
 kasan_populate_vmalloc+0xba/0x1a0 mm/kasan/shadow.c:417
 alloc_vmap_area+0xd51/0x1490 mm/vmalloc.c:2092
 __get_vm_area_node+0x1f8/0x300 mm/vmalloc.c:3187
 __vmalloc_node_range_noprof+0x301/0x12f0 mm/vmalloc.c:3853
 __vmalloc_node_noprof mm/vmalloc.c:3956 [inline]
 vmalloc_noprof+0xb2/0xf0 mm/vmalloc.c:3989
 bpf_prog_calc_tag+0xb9/0x620 kernel/bpf/core.c:307
 resolve_pseudo_ldimm64+0xbc/0xc50 kernel/bpf/verifier.c:20479
 bpf_check+0x1c58/0x1d2e0 kernel/bpf/verifier.c:24614
 bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2972
 __sys_bpf+0x528/0x870 kernel/bpf/syscall.c:6022
 __do_sys_bpf kernel/bpf/syscall.c:6132 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6130 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6130
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1cabb8e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1cac9f6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f1cabdb5fa0 RCX: 00007f1cabb8e9a9
RDX: 0000000000000094 RSI: 0000200000000640 RDI: 0000000000000005
RBP: 00007f1cabc10d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f1cabdb5fa0 R15: 00007ffee0b40348
 </TASK>

Allocated by task 5979:
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

The buggy address belongs to the object at ffff888143fd0800
 which belongs to the cache kmalloc-cg-1k of size 1024
The buggy address is located 24 bytes to the right of
 allocated 576-byte region [ffff888143fd0800, ffff888143fd0a40)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x143fd0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88814cb20d01
flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000040 ffff88801a44b280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000000f5000000 ffff88814cb20d01
head: 057ff00000000040 ffff88801a44b280 dead000000000122 0000000000000000
head: 0000000000000000 0000000080100010 00000000f5000000 ffff88814cb20d01
head: 057ff00000000003 ffffea00050ff401 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 5854, tgid 5854 (syz-executor), ts 88680071975, free_ts 62656261060
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_slab_page mm/slub.c:2453 [inline]
 allocate_slab+0x65/0x3b0 mm/slub.c:2619
 new_slab mm/slub.c:2673 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3859
 __slab_alloc mm/slub.c:3949 [inline]
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __kmalloc_cache_node_noprof+0x29a/0x3d0 mm/slub.c:4367
 kmalloc_node_noprof include/linux/slab.h:928 [inline]
 alloc_mem_cgroup_per_node_info mm/memcontrol.c:3665 [inline]
 mem_cgroup_alloc mm/memcontrol.c:3747 [inline]
 mem_cgroup_css_alloc+0x4b2/0x1f20 mm/memcontrol.c:3789
 css_create kernel/cgroup/cgroup.c:5669 [inline]
 cgroup_apply_control_enable+0x3d1/0xa80 kernel/cgroup/cgroup.c:3289
 cgroup_mkdir+0xc40/0xe60 kernel/cgroup/cgroup.c:5893
 kernfs_iop_mkdir+0x211/0x350 fs/kernfs/dir.c:1268
 vfs_mkdir+0x306/0x510 fs/namei.c:4375
 do_mkdirat+0x247/0x590 fs/namei.c:4408
 __do_sys_mkdirat fs/namei.c:4425 [inline]
 __se_sys_mkdirat fs/namei.c:4423 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4423
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5696 tgid 5696 stack trace:
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
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4204
 ptlock_alloc+0x20/0x70 mm/memory.c:7174
 ptlock_init include/linux/mm.h:2939 [inline]
 pagetable_pte_ctor include/linux/mm.h:2988 [inline]
 __pte_alloc_one_noprof include/asm-generic/pgalloc.h:78 [inline]
 pte_alloc_one+0x7d/0x170 arch/x86/mm/pgtable.c:18
 do_fault_around mm/memory.c:5542 [inline]
 do_read_fault mm/memory.c:5581 [inline]
 do_fault mm/memory.c:5724 [inline]
 do_pte_missing mm/memory.c:4251 [inline]
 handle_pte_fault mm/memory.c:6069 [inline]
 __handle_mm_fault+0x294d/0x5620 mm/memory.c:6212
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6381
 do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

Memory state around the buggy address:
 ffff888143fd0900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888143fd0980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888143fd0a00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                                    ^
 ffff888143fd0a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888143fd0b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	df 4d 8d             	fisttps -0x73(%rbp)
   3:	34 19                	xor    $0x19,%al
   5:	4d 89 f4             	mov    %r14,%r12
   8:	4d 29 dc             	sub    %r11,%r12
   b:	49 83 fc 10          	cmp    $0x10,%r12
   f:	7f 29                	jg     0x3a
  11:	4d 85 e4             	test   %r12,%r12
  14:	0f 84 41 01 00 00    	je     0x15b
  1a:	4c 89 cb             	mov    %r9,%rbx
  1d:	48 f7 d3             	not    %rbx
  20:	4c 01 fb             	add    %r15,%rbx
  23:	41 80 3b 00          	cmpb   $0x0,(%r11)
* 27:	0f 85 de 01 00 00    	jne    0x20b <-- trapping instruction
  2d:	49 ff c3             	inc    %r11
  30:	48 ff c3             	inc    %rbx
  33:	75 ee                	jne    0x23
  35:	e9 21 01 00 00       	jmp    0x15b
  3a:	44 89 dd             	mov    %r11d,%ebp


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

