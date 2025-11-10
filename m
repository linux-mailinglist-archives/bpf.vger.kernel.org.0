Return-Path: <bpf+bounces-74094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C60C489F4
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 19:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FC73AA449
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 18:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F046C31D374;
	Mon, 10 Nov 2025 18:41:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51012D8781
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800095; cv=none; b=kZxaqzUxG8HxtyXRtZIBiM08Y8bKw7/bvDSWBjyqlrOSZAsjCGgPs06Rx76sOgVg+bYFCOVCefBM5FX4F/jAVrJTfyqHGsiQTO3ylqPzpIV2qIA7rxQ7ylSxdE6OLbEPU8odv15Y7W4a50098aFtgPesz/bFFqPBZabsKu+GJyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800095; c=relaxed/simple;
	bh=KO0+j0cE9ef88+tJ/d2NXnbkTkpvc7WUvY6jk/RljNc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=De5yr3adyrykANrTlUqiCcbKY4Sex4GLXOZx6sRVI5sY4L0jxTuaI3vbKuD+DlxV7hiSZFxiWPYERJuRMsUP9DLN2uOKmjrysuxhDXYr9PgbIzlTTNiWsZNlmRRC2bpbnfnXgi87Isyfwj1iY8vR6q0uHGfP4PWNMDoAgfKbiIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-43322fcfae7so38302575ab.1
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 10:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762800093; x=1763404893;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NnhZydG1G8cdKeiKdQOH984jKKHAIjsseBdIzrMizt0=;
        b=QXzputWOeD748ypUCg4cWwNbBTBQD5wbdUwOu18ELWVqDMAoeqL9zcBgwbQGiLvZEU
         OhOSSqNpjHrs9ooQJZ1y0wlX/99P9YSnkslN7dNgdmzXCCZFticB6jepL7eIMrtAhh6n
         Qp+jXAoY5YEGBmshGKJYqlwbr0v7WO2jB/2xSNnIcYr0EWihyWDsCTT0rtxlW/y6elJY
         RgeE6jjhHoDWgeVMDb0RnPwlxf2H6e7uR15hot87hNc+OA4ca2yFV/1eidHtjVs+3smz
         +S3jtddeO++RkGvWu01aBH1NZ49KOsL20j0KSt6Dx+MxIBEkVYMppkgOcHqIZFTHRAjh
         lJDw==
X-Forwarded-Encrypted: i=1; AJvYcCWlhx5uTtdJzdOFkRbALYqPOPyurCwg5aOd1OlATo6knAfXik2KaLXLS0egr60GVFTTK3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUDyOwxGvy6BagKCGwHkL1n4eYpyvGXczeI5Sk6NJLZZ8FVMYw
	wjTC9Ou3RNUnUoA/6+pkimP6cOvYYfk8VSatAvGByyeA+G2KFVF1LZ9y7fS7R8zctaceXuDiPjP
	0ACfue/0bs1SDvybj/tR+kQJA6taZADiPDXtbFHkDkl7b4izgT0/OYcp8EjE=
X-Google-Smtp-Source: AGHT+IFvNMUe2TutKQdDFRtb6oLNmOL0jP1NF5KzunaeVnyeQH6WKK0CzRpW0Y0bFMWAGLtxdrclmTEm9Pnq52GJUHo4FXWUD2cK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a82:b0:433:7673:1d with SMTP id
 e9e14a558f8ab-43376730369mr97025235ab.31.1762800092966; Mon, 10 Nov 2025
 10:41:32 -0800 (PST)
Date: Mon, 10 Nov 2025 10:41:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691231dc.a70a0220.22f260.0101.GAE@google.com>
Subject: [syzbot] [bpf?] KASAN: stack-out-of-bounds Write in __bpf_get_stack
From: syzbot <syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	contact@arnaud-lcm.com, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f8c67d8550ee bpf: Use kmalloc_nolock() in range tree
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=121a50b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=d1b7fa1092def3628bd7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12270412580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128bd084580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d9e95bfbe4ee/disk-f8c67d85.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0766b6dd0e91/vmlinux-f8c67d85.xz
kernel image: https://storage.googleapis.com/syzbot-assets/79089f9e9e93/bzImage-f8c67d85.xz

The issue was bisected to:

commit e17d62fedd10ae56e2426858bd0757da544dbc73
Author: Arnaud Lecomte <contact@arnaud-lcm.com>
Date:   Sat Oct 25 19:28:58 2025 +0000

    bpf: Refactor stack map trace depth calculation into helper function

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1632d0b4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1532d0b4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1132d0b4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")

==================================================================
BUG: KASAN: stack-out-of-bounds in __bpf_get_stack+0x5a3/0xaa0 kernel/bpf/stackmap.c:493
Write of size 168 at addr ffffc900030e73a8 by task syz.1.44/6108

CPU: 0 UID: 0 PID: 6108 Comm: syz.1.44 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 __bpf_get_stack+0x5a3/0xaa0 kernel/bpf/stackmap.c:493
 ____bpf_get_stack kernel/bpf/stackmap.c:517 [inline]
 bpf_get_stack+0x33/0x50 kernel/bpf/stackmap.c:514
 ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1653 [inline]
 bpf_get_stack_raw_tp+0x1a9/0x220 kernel/trace/bpf_trace.c:1643
 bpf_prog_4b3f8e3d902f6f0d+0x41/0x49
 bpf_dispatcher_nop_func include/linux/bpf.h:1364 [inline]
 __bpf_prog_run include/linux/filter.h:721 [inline]
 bpf_prog_run include/linux/filter.h:728 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
 bpf_trace_run2+0x284/0x4b0 kernel/trace/bpf_trace.c:2116
 __traceiter_kfree+0x2e/0x50 include/trace/events/kmem.h:97
 __do_trace_kfree include/trace/events/kmem.h:97 [inline]
 trace_kfree include/trace/events/kmem.h:97 [inline]
 kfree+0x62f/0x6d0 mm/slub.c:6824
 compute_scc+0x9a6/0xa20 kernel/bpf/verifier.c:25021
 bpf_check+0x5df2/0x1c210 kernel/bpf/verifier.c:25162
 bpf_prog_load+0x13ba/0x1a10 kernel/bpf/syscall.c:3095
 __sys_bpf+0x507/0x860 kernel/bpf/syscall.c:6171
 __do_sys_bpf kernel/bpf/syscall.c:6281 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6279 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6279
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc4d8b8f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd2851bb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fc4d8de5fa0 RCX: 00007fc4d8b8f6c9
RDX: 0000000000000094 RSI: 00002000000000c0 RDI: 0000000000000005
RBP: 00007fc4d8c11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc4d8de5fa0 R14: 00007fc4d8de5fa0 R15: 0000000000000003
 </TASK>

The buggy address belongs to stack of task syz.1.44/6108
 and is located at offset 296 in frame:
 __bpf_get_stack+0x0/0xaa0 include/linux/mmap_lock.h:-1

This frame has 1 object:
 [32, 36) 'rctx.i'

The buggy address belongs to a 8-page vmalloc region starting at 0xffffc900030e0000 allocated at copy_process+0x54b/0x3c00 kernel/fork.c:2012
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x572fb
memcg:ffff88803037aa02
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ffff88803037aa02
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_ZERO|__GFP_NOWARN), pid 1340, tgid 1340 (kworker/u8:6), ts 107851542040, free_ts 101175357499
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_frozen_pages_noprof mm/mempolicy.c:2487 [inline]
 alloc_pages_noprof+0xa9/0x190 mm/mempolicy.c:2507
 vm_area_alloc_pages mm/vmalloc.c:3647 [inline]
 __vmalloc_area_node mm/vmalloc.c:3724 [inline]
 __vmalloc_node_range_noprof+0x96c/0x12d0 mm/vmalloc.c:3897
 __vmalloc_node_noprof+0xc2/0x110 mm/vmalloc.c:3960
 alloc_thread_stack_node kernel/fork.c:311 [inline]
 dup_task_struct+0x3d4/0x830 kernel/fork.c:881
 copy_process+0x54b/0x3c00 kernel/fork.c:2012
 kernel_clone+0x21e/0x840 kernel/fork.c:2609
 user_mode_thread+0xdd/0x140 kernel/fork.c:2685
 call_usermodehelper_exec_sync kernel/umh.c:132 [inline]
 call_usermodehelper_exec_work+0x9c/0x230 kernel/umh.c:163
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
page last free pid 5918 tgid 5918 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2906
 vfree+0x25a/0x400 mm/vmalloc.c:3440
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:535
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x2300 kernel/exit.c:966
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x72/0x130 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc900030e7300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900030e7380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc900030e7400: f1 f1 f1 f1 00 00 f2 f2 00 00 f3 f3 00 00 00 00
                   ^
 ffffc900030e7480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900030e7500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

