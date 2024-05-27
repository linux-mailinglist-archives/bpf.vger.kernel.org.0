Return-Path: <bpf+bounces-30633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337858CF93C
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 08:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571D31C20CDB
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 06:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C299F15AF1;
	Mon, 27 May 2024 06:36:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9180101DE
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791788; cv=none; b=L5ecrAqgFLMxmyqXjA8Et8ydH5rKzXN39Cf4nffrsBliRfaJ1n+a32nUcpF522pnLj1Uy21HmPouCSTEBEQxy74SvlAdFHaCcIZ+8QFUwr8ko3gZLSG3DbBZEbw1YfZ8t6cBnTdsg8Q5WIVgZr5xduXY1UyB9MapIdGIQ383Hrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791788; c=relaxed/simple;
	bh=xmP3VhOCd1AxLXN6BJ6CxuRnTmdIHaFhFfmv9IZmsqk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OGVO8Pw+bbA5c2PNCgJg/utTSPmMWQ8VMnGSL9TtlRr8VO+pPoQqxr1GdQDogBxM3+eiy0oSRNhDeioGyvaIQPkKu3yUcyz0bEZZLj5m9Kbi9Nb68WWOH3qemXSd69qk+RoOsvbqYAx3Fc0BaZ0rjMM/Xro0XQdYmVmsBgxYbAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7eaccb5a928so89268139f.3
        for <bpf@vger.kernel.org>; Sun, 26 May 2024 23:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716791786; x=1717396586;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+PKiPkBJYaEPjN/V2rVFav0UrCBiisVA2iYobVu1oU=;
        b=GWyVt016GfsTcKW+cFko+zjr91/+yhOMngSghyU/mRqBabGg3PcyTWk/pe8LdntfLh
         8HnlEgzo0kwUrKr+nRHSB/ex1qJ93N0LmZARBMBIk2jpscT0lwpoiEdm5F6Th7gPOJwg
         RdZDrZl6bjdybpAJcmgZZxUjqdvEHSkyhGk6LUTaFhEuRjDrBGwkc+wfNhn+nvQUCUY3
         cUI9WpZxAdnzggCS2Hv/E5mXYtB/bWkT8eATfxWg4mXRQWzho9BXFJnmtL2Yz4BiIcjm
         SD+1jspPrPXdzVQSE6wTuo8Jh+k8zCB0LX4bmCYNIReH8xf+IG5G2i/k2+JbfQly3/Tk
         Tdhg==
X-Forwarded-Encrypted: i=1; AJvYcCWhSzDe1l5RDFkm2UN48LXO91myI+7RjXVVGangB/vGisV4uJYcM3I2y4bc6s656/Tn3GIzTv0zNPIVGNqBfjWJt21D
X-Gm-Message-State: AOJu0YygHglDNgr2ozjujn4AECo64JD0JCCtBJHXESPZrpocOEKJH5Fr
	4GTY2iVgpYTHjnxyAIZVg/wMeFE6o3FnaEy+GL4ym79GYKYtPu3TI72FRNhJUcMMVOk8pNzTaeG
	B78rud+jgcxSz9+abPuoihY+ps5iZ3ayGIhJJheFGR1E4HN/TMc/hDig=
X-Google-Smtp-Source: AGHT+IFlCk4We9U1hMljv5jcIhJt2gDy+B+1W6leAYrzBpnLGJLUh0ZC/7SS5kyvM2peHimZV5yc/uuLOybLt6kNCVp4rdfLFZ/p
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:a883:0:b0:4b0:278e:96d8 with SMTP id
 8926c6da1cb9f-4b03f637e66mr200616173.1.1716791786114; Sun, 26 May 2024
 23:36:26 -0700 (PDT)
Date: Sun, 26 May 2024 23:36:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000909ea8061969bce5@google.com>
Subject: [syzbot] [bpf?] KASAN: slab-use-after-free Read in bpf_link_free (2)
From: syzbot <syzbot+1989ee16d94720836244@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6fbf71854e2d Merge tag 'perf-tools-fixes-for-v6.10-1-2024-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173e822c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62be2ac813b33670
dashboard link: https://syzkaller.appspot.com/bug?extid=1989ee16d94720836244
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eab66bf09e4e/disk-6fbf7185.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/232ac0545252/vmlinux-6fbf7185.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2820e679b0ee/bzImage-6fbf7185.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1989ee16d94720836244@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in bpf_link_free+0x234/0x2d0 kernel/bpf/syscall.c:3078
Read of size 8 at addr ffff888011469b10 by task syz-executor.1/6398

CPU: 0 PID: 6398 Comm: syz-executor.1 Not tainted 6.9.0-syzkaller-12400-g6fbf71854e2d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 bpf_link_free+0x234/0x2d0 kernel/bpf/syscall.c:3078
 bpf_link_put_direct kernel/bpf/syscall.c:3106 [inline]
 bpf_link_release+0x7b/0x90 kernel/bpf/syscall.c:3113
 __fput+0x408/0x8b0 fs/file_table.c:422
 task_work_run+0x251/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe75847cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe75916f0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fe7585ac120 RCX: 00007fe75847cee9
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000000000004
RBP: 00007fe7584c949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fe7585ac120 R15: 00007ffe4ae3abc8
 </TASK>

Allocated by task 6385:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace_noprof+0x19c/0x2c0 mm/slub.c:4152
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 bpf_raw_tp_link_attach+0x2a0/0x6e0 kernel/bpf/syscall.c:3858
 bpf_raw_tracepoint_open+0x1c2/0x240 kernel/bpf/syscall.c:3905
 __sys_bpf+0x3c0/0x810 kernel/bpf/syscall.c:5729
 __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6399:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2195 [inline]
 slab_free mm/slub.c:4436 [inline]
 kfree+0x149/0x360 mm/slub.c:4557
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0xaff/0x1830 kernel/rcu/tree.c:2809
 handle_softirqs+0x2c6/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3072 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3176
 bpf_link_free+0x1f8/0x2d0 kernel/bpf/syscall.c:3076
 bpf_link_put_direct kernel/bpf/syscall.c:3106 [inline]
 bpf_link_release+0x7b/0x90 kernel/bpf/syscall.c:3113
 __fput+0x408/0x8b0 fs/file_table.c:422
 task_work_run+0x251/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888011469b00
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 16 bytes inside of
 freed 128-byte region [ffff888011469b00, ffff888011469b80)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11469
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000000 ffff888015041a00 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080100010 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 2897, tgid 2897 (kworker/u8:8), ts 84640710621, free_ts 84523372123
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2e2d/0x2ee0 mm/page_alloc.c:3402
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4660
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2264
 allocate_slab+0x5a/0x2e0 mm/slub.c:2427
 new_slab mm/slub.c:2480 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3666
 __slab_alloc+0x58/0xa0 mm/slub.c:3756
 __slab_alloc_node mm/slub.c:3809 [inline]
 slab_alloc_node mm/slub.c:3988 [inline]
 kmalloc_trace_noprof+0x1d5/0x2c0 mm/slub.c:4147
 kmalloc_noprof include/linux/slab.h:660 [inline]
 __hw_addr_create net/core/dev_addr_lists.c:60 [inline]
 __hw_addr_add_ex+0x1a8/0x610 net/core/dev_addr_lists.c:118
 __dev_mc_add net/core/dev_addr_lists.c:867 [inline]
 dev_mc_add+0xa3/0x110 net/core/dev_addr_lists.c:885
 igmp6_group_added+0x1a4/0x710 net/ipv6/mcast.c:680
 __ipv6_dev_mc_inc+0x8b8/0xa90 net/ipv6/mcast.c:949
 addrconf_join_solict net/ipv6/addrconf.c:2240 [inline]
 addrconf_dad_begin net/ipv6/addrconf.c:4101 [inline]
 addrconf_dad_work+0x448/0x16f0 net/ipv6/addrconf.c:4226
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f2/0x390 kernel/kthread.c:389
page last free pid 5243 tgid 5242 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_folios+0xf23/0x19e0 mm/page_alloc.c:2614
 folios_put_refs+0x93a/0xa60 mm/swap.c:1024
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3354
 __mmput+0x115/0x3c0 kernel/fork.c:1346
 exit_mm+0x220/0x310 kernel/exit.c:565
 do_exit+0x9aa/0x27e0 kernel/exit.c:861
 do_group_exit+0x207/0x2c0 kernel/exit.c:1023
 get_signal+0x16a1/0x1740 kernel/signal.c:2909
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888011469a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
 ffff888011469a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888011469b00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888011469b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888011469c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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

