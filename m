Return-Path: <bpf+bounces-42373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA62C9A3759
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 09:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D32C1F223CA
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 07:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC8D189F41;
	Fri, 18 Oct 2024 07:37:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB0E17C7C2
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237050; cv=none; b=WoWz1QPXrqzrI+HNg/C9WOdevASY23UcXLygdcFFfVqOCMcUDh/b0awEETBCLBkbgC3QLQpAey3ZdK4kt2COBYN3r4sAWZVrPBttrpHVbbGdkBtCGpYTTuab8J6OEws2cZZEyMseOst8dy8n+Vr+Y6LlnwfC/w93tYDZS3PuWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237050; c=relaxed/simple;
	bh=3j32HDsoXxcNnfMxlhAz+OPZcnUlVBMR8ZevjD4mCy0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lO0aWzBv347ruFW7wrcCdbGoqMNU+Rhyx0tc3X7DlObuZNU5uUW7zMQVpdRE7VVYtLISVZyh1J4oU7BXJWdbb2VHrtuFGVvSobiPw4q/uoGXyC9ET2RvGMTrPE6v13LrNLDfGI/rJ+yeP9j+s4gokOKdHd2Lfu4qXgJ8I+nellI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso18733525ab.0
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 00:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729237048; x=1729841848;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PceIiyZTW4DaHDkzJQNil/nz6nGZZ3KEslMKSIiwl3c=;
        b=n+oH9afe+HXY0zOxFmTlmf+xv8ucMW+TD3XnDD7A/b9Un3j8FgTizLU6wxKk6tyvQr
         GzISvjVzICWwV7mjGGuKxjpf2RLQm2wuVBVZ9AF0eIMKX3aofQdwHRpAlxXSriUYLQtW
         uoPintxYHQ8wzv5BWzGKuK/QzLGJO7JHzt/MRJIh8BbnTaWVw8icYA13CuSchLtnlCJs
         v2dxXsC43a7tPV2mcO7DNWz6njxmOfpVBbBGwYo2Iu0cNbGBG9TQdnbnHb6JKLMEjcPa
         dFDE5u1I/yMFyqYWNy6CVQy1X0zw24NW4wkpUAGRUvuaqqxonP7j3Dg/5YUHgIlAPn44
         fqIA==
X-Forwarded-Encrypted: i=1; AJvYcCWaKKxOVXJbweZ5qKHukWubeHiOKaqBv/qYB/bRju6dEf23wETJYKdrw6O6uN2SAx6I2ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo/tNSbYizjqB0v7CQLypm6a0yTIpZ/mUeWg+jk7EgbJ3SrlTv
	EsC28mdbF/3QwbcuVcY41baK6Zlgsrjw6oxz1nWZVnaMMti9FLKJwGtq5aAM1vhcgPhVmGnTKYc
	mojgqG972VL5mXPKBLFBS1ZqqEV597JYnkvMdlX9qiszjsTj1H0iLz8E=
X-Google-Smtp-Source: AGHT+IFQO01hq61sLP2nhUaFpL/LYiVoNqV2CfPCR7g/qxrX9KLvjXdOr8uyseCIEmcRMdJe64k49pIWTEPgSVLDVxMIl68U+l7H
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8e:b0:39f:5efe:ae73 with SMTP id
 e9e14a558f8ab-3a3f40500a4mr16847475ab.5.1729237047997; Fri, 18 Oct 2024
 00:37:27 -0700 (PDT)
Date: Fri, 18 Oct 2024 00:37:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67121037.050a0220.10f4f4.000f.GAE@google.com>
Subject: [syzbot] [trace?] [bpf?] KASAN: slab-use-after-free Read in
 bpf_trace_run2 (2)
From: syzbot <syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    15e7d45e786a Add linux-next specific files for 20241016
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11b01830580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c36416f1c54640c0
dashboard link: https://syzkaller.appspot.com/bug?extid=b390c8062d8387b6272a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153ef887980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf2ad43c81cc/disk-15e7d45e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c85347a66a1c/vmlinux-15e7d45e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/648cf8e59c13/bzImage-15e7d45e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __bpf_trace_run kernel/trace/bpf_trace.c:2304 [inline]
BUG: KASAN: slab-use-after-free in bpf_trace_run2+0xfa/0x540 kernel/trace/bpf_trace.c:2359
Read of size 8 at addr ffff88805faaeb18 by task syz-executor/5664

CPU: 0 UID: 0 PID: 5664 Comm: syz-executor Not tainted 6.12.0-rc3-next-20241016-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __bpf_trace_run kernel/trace/bpf_trace.c:2304 [inline]
 bpf_trace_run2+0xfa/0x540 kernel/trace/bpf_trace.c:2359
 __bpf_trace_sys_enter+0x38/0x60 include/trace/events/syscalls.h:18
 __traceiter_sys_enter+0x2b/0x50 include/trace/events/syscalls.h:18
 trace_sys_enter+0xd9/0x150 include/trace/events/syscalls.h:18
 syscall_trace_enter+0xf8/0x150 kernel/entry/common.c:61
 syscall_enter_from_user_mode_work include/linux/entry-common.h:168 [inline]
 syscall_enter_from_user_mode include/linux/entry-common.h:198 [inline]
 do_syscall_64+0xcc/0x230 arch/x86/entry/common.c:79
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f83bb719959
Code: 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 90 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 c7 c0 0f 00 00 00 0f 05 <0f> 1f 80 00 00 00 00 48 81 ec 48 01 00 00 49 89 d0 64 48 8b 04 25
RSP: 002b:00007ffe2c16e340 EFLAGS: 00000202 ORIG_RAX: 000000000000000f
RAX: ffffffffffffffda RBX: 0000000000001623 RCX: 00007f83bb719959
RDX: 00007ffe2c16e340 RSI: 00007ffe2c16e470 RDI: 0000000000000011
RBP: 00007ffe2c16e8ec R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe2c16e970
R13: 00007ffe2c16e978 R14: 0000000000000009 R15: 0000000000000000
 </TASK>

Allocated by task 5681:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4304
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 bpf_raw_tp_link_attach+0x2a0/0x6e0 kernel/bpf/syscall.c:3829
 bpf_raw_tracepoint_open+0x177/0x1f0 kernel/bpf/syscall.c:3876
 __sys_bpf+0x3c0/0x810 kernel/bpf/syscall.c:5691
 __do_sys_bpf kernel/bpf/syscall.c:5756 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5754 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5754
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 24:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2329 [inline]
 slab_free mm/slub.c:4588 [inline]
 kfree+0x1a0/0x460 mm/slub.c:4736
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:921
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 __call_rcu_common kernel/rcu/tree.c:3086 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
 bpf_link_put_direct kernel/bpf/syscall.c:3045 [inline]
 bpf_link_release+0x78/0x90 kernel/bpf/syscall.c:3052
 __fput+0x23c/0xa50 fs/file_table.c:434
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 get_signal+0x15e8/0x1740 kernel/signal.c:2690
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88805faaeb00
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 24 bytes inside of
 freed 128-byte region [ffff88805faaeb00, ffff88805faaeb80)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5faae
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41a00 ffffea0000bc2e40 dead000000000002
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5361, tgid 5361 (syz-executor), ts 814297773699, free_ts 814275036984
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3123/0x3270 mm/page_alloc.c:3493
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4769
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2399
 allocate_slab+0x5a/0x2f0 mm/slub.c:2565
 new_slab mm/slub.c:2618 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3805
 __slab_alloc+0x58/0xa0 mm/slub.c:3895
 __slab_alloc_node mm/slub.c:3970 [inline]
 slab_alloc_node mm/slub.c:4131 [inline]
 __do_kmalloc_node mm/slub.c:4272 [inline]
 __kmalloc_node_track_caller_noprof+0x2e9/0x4c0 mm/slub.c:4292
 kmemdup_noprof+0x2a/0x60 mm/util.c:135
 rds_tcp_init_net+0x66/0x320 net/rds/tcp.c:557
 ops_init+0x31e/0x590 net/core/net_namespace.c:139
 setup_net+0x287/0x9e0 net/core/net_namespace.c:363
 copy_net_ns+0x33f/0x570 net/core/net_namespace.c:501
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
page last free pid 9 tgid 9 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2674
 vfree+0x186/0x2e0 mm/vmalloc.c:3377
 delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3298
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88805faaea00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88805faaea80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88805faaeb00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88805faaeb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88805faaec00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

