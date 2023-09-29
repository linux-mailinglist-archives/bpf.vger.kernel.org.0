Return-Path: <bpf+bounces-11123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818847B3A2F
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 20:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DCC2F283509
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BC441E49;
	Fri, 29 Sep 2023 18:43:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6828F70
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 18:43:38 +0000 (UTC)
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682F31A5
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 11:43:36 -0700 (PDT)
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6c6204b2defso7682560a34.0
        for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 11:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696013015; x=1696617815;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+IO+qGNr7Q1OqQXnJ0K+7tfthwm5cgkTCtl9T9+EG4=;
        b=fuZ0Gk7fDjkLcJWTyXRQrKp2kNIHIzSQMssU6umGIiqROMkw4EC6Xk+d5yCcFMyjRR
         cFAX5s15/uxsyuKGNJqht6YnA0szBWD8dRRupw0E1MxdQ0ToffJWJPACM7duskG5C+Sp
         CiNGgxNHqX3JiO/FlJLJy34hzfr1dBjHSHI5gh7MBBpNsoRXLMzgksq7r9GoshLrSpox
         X7PCJNAF4JQib5cOExxasjS6WGLTucCdrBC641JEcSxm0RO+YlOz4CroqAgaeJTEAg8s
         sK/NcrIPn3mI9OFZQoZt+c/lQDzdtKZmHkK9lnaQoeZPiE6QO6VYpBjxelq1v74GY20G
         STww==
X-Gm-Message-State: AOJu0YxNHyJyW5PkLwHXnE2vXKVxzRFTUbcdak216HyAYiJHTnLLSX0Z
	qOdZmZyCbCpyajemE8EapNf9KqJp0QMv9x097g6mZT1QEza4
X-Google-Smtp-Source: AGHT+IENU0Eyy7n9Fg2Q2n3JU9R3ZD/YvUXLjCV6xn3xAMAHjdfWFK9opv3w6z49kI+7cBA8nU4X/8Ox0FT5QEd8DT0mhIrULCpS
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1e82:b0:6bc:b75c:f32f with SMTP id
 n2-20020a0568301e8200b006bcb75cf32fmr1585441otr.2.1696013015689; Fri, 29 Sep
 2023 11:43:35 -0700 (PDT)
Date: Fri, 29 Sep 2023 11:43:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055b35a060683cd56@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in tls_encrypt_done
From: syzbot <syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com>
To: borisp@nvidia.com, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    6465e260f487 Linux 6.6-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114f1f96680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d7d7928f78936aa
dashboard link: https://syzkaller.appspot.com/bug?extid=29c22ea2d6b2c5fd2eae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c6888e680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174c3996680000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-6465e260.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3560b94cfbc8/vmlinux-6465e260.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a098d6f44df3/bzImage-6465e260.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in debug_spin_unlock kernel/locking/spinlock_debug.c:99 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_unlock+0x1f7/0x230 kernel/locking/spinlock_debug.c:140
Read of size 4 at addr ffff88801f5a7d3c by task kworker/2:1/36

CPU: 2 PID: 36 Comm: kworker/2:1 Not tainted 6.6.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: pencrypt_serial padata_serial_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 debug_spin_unlock kernel/locking/spinlock_debug.c:99 [inline]
 do_raw_spin_unlock+0x1f7/0x230 kernel/locking/spinlock_debug.c:140
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:166 [inline]
 _raw_spin_unlock_bh+0x1e/0x30 kernel/locking/spinlock.c:210
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 tls_encrypt_done+0x281/0x560 net/tls/tls_sw.c:488
 padata_serial_worker+0x246/0x490 kernel/padata.c:378
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 19233:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa3/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 tls_set_sw_offload+0x12e0/0x1700 net/tls/tls_sw.c:2606
 do_tls_setsockopt_conf net/tls/tls_main.c:667 [inline]
 do_tls_setsockopt net/tls/tls_main.c:772 [inline]
 tls_setsockopt+0x108c/0x1340 net/tls/tls_main.c:800
 __sys_setsockopt+0x2cd/0x5b0 net/socket.c:2308
 __do_sys_setsockopt net/socket.c:2319 [inline]
 __se_sys_setsockopt net/socket.c:2316 [inline]
 __x64_sys_setsockopt+0xbd/0x150 net/socket.c:2316
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 19233:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x138/0x190 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 __cache_free mm/slab.c:3370 [inline]
 __do_kmem_cache_free mm/slab.c:3557 [inline]
 __kmem_cache_free+0xcc/0x2d0 mm/slab.c:3564
 tls_sk_proto_close+0x4c3/0xb00 net/tls/tls_main.c:390
 inet_release+0x132/0x270 net/ipv4/af_inet.c:433
 inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:484
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1402
 __fput+0x3f7/0xa70 fs/file_table.c:384
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa92/0x2a20 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x78/0x80 mm/kasan/generic.c:492
 kvfree_call_rcu+0x70/0xbe0 kernel/rcu/tree.c:3372
 tls_ctx_free net/tls/tls_main.c:333 [inline]
 tls_ctx_free+0x69/0x90 net/tls/tls_main.c:323
 tls_sk_proto_close+0x46b/0xb00 net/tls/tls_main.c:398
 inet_release+0x132/0x270 net/ipv4/af_inet.c:433
 inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:484
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1402
 __fput+0x3f7/0xa70 fs/file_table.c:384
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa92/0x2a20 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x78/0x80 mm/kasan/generic.c:492
 kvfree_call_rcu+0x70/0xbe0 kernel/rcu/tree.c:3372
 tls_ctx_free net/tls/tls_main.c:333 [inline]
 tls_ctx_free+0x69/0x90 net/tls/tls_main.c:323
 tls_sk_proto_close+0x46b/0xb00 net/tls/tls_main.c:398
 inet_release+0x132/0x270 net/ipv4/af_inet.c:433
 inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:484
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1402
 __fput+0x3f7/0xa70 fs/file_table.c:384
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa92/0x2a20 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801f5a7c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 316 bytes inside of
 freed 512-byte region [ffff88801f5a7c00, ffff88801f5a7e00)

The buggy address belongs to the physical page:
page:ffffea00007d69c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1f5a7
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0x4()
raw: 00fff00000000800 ffff888012c40600 ffffea000076b490 ffffea00006bae50
raw: 0000000000000000 ffff88801f5a7000 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x242020(__GFP_HIGH|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 6562, tgid 6562 (syz-executor469), ts 291264206650, free_ts 291263177339
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 kmem_getpages mm/slab.c:1356 [inline]
 cache_grow_begin+0x99/0x3a0 mm/slab.c:2550
 cache_alloc_refill+0x294/0x3a0 mm/slab.c:2923
 ____cache_alloc mm/slab.c:2999 [inline]
 ____cache_alloc mm/slab.c:2982 [inline]
 __do_cache_alloc mm/slab.c:3182 [inline]
 slab_alloc_node mm/slab.c:3230 [inline]
 __kmem_cache_alloc_node+0x3c5/0x470 mm/slab.c:3521
 kmalloc_trace+0x25/0xe0 mm/slab_common.c:1114
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 tls_ctx_create+0x45/0x140 net/tls/tls_main.c:808
 tls_init net/tls/tls_main.c:951 [inline]
 tls_init+0x11e/0xbc0 net/tls/tls_main.c:928
 __tcp_set_ulp net/ipv4/tcp_ulp.c:146 [inline]
 tcp_set_ulp+0x31f/0x7e0 net/ipv4/tcp_ulp.c:167
 do_tcp_setsockopt+0x5cb/0x2830 net/ipv4/tcp.c:3429
 tcp_setsockopt+0xd4/0x100 net/ipv4/tcp.c:3679
 __sys_setsockopt+0x2cd/0x5b0 net/socket.c:2308
 __do_sys_setsockopt net/socket.c:2319 [inline]
 __se_sys_setsockopt net/socket.c:2316 [inline]
 __x64_sys_setsockopt+0xbd/0x150 net/socket.c:2316
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 __folio_put_small mm/swap.c:106 [inline]
 __folio_put+0xc3/0x110 mm/swap.c:129
 folio_put include/linux/mm.h:1475 [inline]
 put_page include/linux/mm.h:1544 [inline]
 free_page_and_swap_cache+0x25a/0x2d0 mm/swap_state.c:303
 __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:154 [inline]
 tlb_remove_table_rcu+0x89/0xe0 mm/mmu_gather.c:209
 rcu_do_batch kernel/rcu/tree.c:2139 [inline]
 rcu_core+0x805/0x1bb0 kernel/rcu/tree.c:2403
 __do_softirq+0x218/0x965 kernel/softirq.c:553

Memory state around the buggy address:
 ffff88801f5a7c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801f5a7c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801f5a7d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88801f5a7d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801f5a7e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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

