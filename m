Return-Path: <bpf+bounces-44754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1629C7590
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 16:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89271F25F6F
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0004713B791;
	Wed, 13 Nov 2024 15:05:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E61369A8
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510325; cv=none; b=tNGxowFbkveKWVCyxliW42ihMUlIxIMqawQ/kQExyF1asHaK0by68JksvirXxxwQfY4jRaFMACb/CitrkpmgcOjF2+vQKwyTdvjToOWs/ojXJTuG9jHw9l3WhxNteAg/2QA9cdkwK+VQwGb1Cc0LEkv6uFigEDSfyEbRprF4y6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510325; c=relaxed/simple;
	bh=Qzb3SWYKN5kATyrvzc/giVlT23Wo4lYTj5Z0PrALw+M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LD7YT22ZxkNVyY6s5NNaTEWRseey3lHbvNeObXBPzmXAvNcrXwWyY7uwGtmw9WXuhM7Dlhd6wNyorVLgIP8dyFO3PsT8B0Nq+U8ljWwmfaUGx2AI3cm/y/hf+RH7wEdNbrFZT2ggWNDQzlorkMxtfCPvkq1zhHVf/96zxlf3O2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83ae0af926dso748501939f.2
        for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 07:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731510323; x=1732115123;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Js2tCNoHj99UZbl15cY2mUZXw4l/roodQ0DjM9uGmiY=;
        b=XERNE9jQp9vvlaZzWkNGY3PhAZdRSvaiCcWQmDcrwAGa6MT4Mhd1OXketMKIWNA9B6
         SmfSPu2lXlVDLTEKmngXtBGqehxBbQZ62ecjAUUXjVdPT+KyHA0rRzhVvFLyBv9hL/bI
         aEL6PQQn3YSWEuB2wPlFW02a5+UJ6RdgA3GeVQzgntxAc4V3E6KBwbj69S7ykJvtpUYJ
         I3X52eYaXNgZnFc9vNyRNfPrwTcgL83gXmRjfGhbudeCc9rBqxGyEMEUBg57wWGXtTlo
         /CHmCj5yi9UuQNXYj1LBoFxKwp9865PHUJySpl9LFovkfeorKuucx53XAVZXpw/V8NMC
         tJ8g==
X-Forwarded-Encrypted: i=1; AJvYcCV5BoQUf8mA+Pbppfwg8RT1ob4PvRbjj/wCOODAn7Go1raHSQSUzt5MJEJ0QEX04vV1LLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ynkUOZduieWC8/tQcNpVoQ5uBfsOELzFPJooqWDL/ARuB145
	cdMZKGn9vcVzimIN32zYtRNOkghEw+YNCheCT3wW/g6KQYmRGU34QbT4FYkdkwPpbHWFszT6oP4
	tCbHFFbKdlWWeaQi/URDBUjnxmKF5jq21WrSddZLvc/snQ64GF5164nM=
X-Google-Smtp-Source: AGHT+IERF9C5WIE83rp9obP4lMyBNE0WYs9a1Ck9M5zPa5hSQMEY65QzFGJn21AgGj9jA/YgK+xVplkj68B4tCmdzOlqyt8IpWE4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1384:b0:3a7:1a2a:85c3 with SMTP id
 e9e14a558f8ab-3a71a2a863fmr15848105ab.22.1731510323076; Wed, 13 Nov 2024
 07:05:23 -0800 (PST)
Date: Wed, 13 Nov 2024 07:05:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6734c033.050a0220.2a2fcc.0015.GAE@google.com>
Subject: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in
 sk_psock_verdict_data_ready (2)
From: syzbot <syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4861333b4217 bonding: add ESP offload features when slaves..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=122e6ea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea5200d154f868aa
dashboard link: https://syzkaller.appspot.com/bug?extid=dd90a702f518e0eac072
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4263c9834cd5/disk-4861333b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14c4f9ec4615/vmlinux-4861333b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6cc8fe1b802d/bzImage-4861333b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in sk_psock_verdict_data_ready+0x6d/0x390 net/core/skmsg.c:1221
Read of size 8 at addr ffff88807595c220 by task syz.8.2987/16517

CPU: 1 UID: 0 PID: 16517 Comm: syz.8.2987 Not tainted 6.12.0-rc6-syzkaller-01230-g4861333b4217 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 sk_psock_verdict_data_ready+0x6d/0x390 net/core/skmsg.c:1221
 unix_stream_sendmsg+0x7d5/0xf80 net/unix/af_unix.c:2345
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2609
 ___sys_sendmsg net/socket.c:2663 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2692
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc8c817e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc8c9018038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc8c8335f80 RCX: 00007fc8c817e719
RDX: 0000000000000000 RSI: 0000000020000500 RDI: 0000000000000004
RBP: 00007fc8c81f139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc8c8335f80 R15: 00007ffeb3aa3828
 </TASK>

Allocated by task 16517:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_lru_noprof+0x139/0x2b0 mm/slub.c:4153
 sock_alloc_inode+0x28/0xc0 net/socket.c:307
 alloc_inode+0x65/0x1a0 fs/inode.c:265
 sock_alloc net/socket.c:633 [inline]
 __sock_create+0x127/0xa30 net/socket.c:1540
 sock_create net/socket.c:1634 [inline]
 __sys_socketpair+0x2ca/0x720 net/socket.c:1781
 __do_sys_socketpair net/socket.c:1834 [inline]
 __se_sys_socketpair net/socket.c:1831 [inline]
 __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1831
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 16:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kmem_cache_free+0x1a2/0x420 mm/slub.c:4681
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3086 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
 destroy_inode fs/inode.c:320 [inline]
 evict+0x83c/0x9b0 fs/inode.c:756
 __dentry_kill+0x20d/0x630 fs/dcache.c:615
 dput+0x19f/0x2b0 fs/dcache.c:857
 __fput+0x5d2/0x880 fs/file_table.c:439
 __do_sys_close fs/open.c:1567 [inline]
 __se_sys_close fs/open.c:1552 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1552
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807595c200
 which belongs to the cache sock_inode_cache of size 1408
The buggy address is located 32 bytes inside of
 freed 1408-byte region [ffff88807595c200, ffff88807595c780)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x75958
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802edbb601
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801eac6c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080150015 00000001f5000000 ffff88802edbb601
head: 00fff00000000040 ffff88801eac6c80 0000000000000000 dead000000000001
head: 0000000000000000 0000000080150015 00000001f5000000 ffff88802edbb601
head: 00fff00000000003 ffffea0001d65601 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE), pid 5853, tgid 5853 (syz-executor), ts 63362518844, free_ts 14776689664
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_lru_noprof+0x1c5/0x2b0 mm/slub.c:4153
 sock_alloc_inode+0x28/0xc0 net/socket.c:307
 alloc_inode+0x65/0x1a0 fs/inode.c:265
 sock_alloc net/socket.c:633 [inline]
 __sock_create+0x127/0xa30 net/socket.c:1540
 sock_create net/socket.c:1634 [inline]
 __sys_socket_create net/socket.c:1671 [inline]
 __sys_socket+0x150/0x3c0 net/socket.c:1718
 __do_sys_socket net/socket.c:1732 [inline]
 __se_sys_socket net/socket.c:1730 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1730
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 free_contig_range+0x152/0x550 mm/page_alloc.c:6748
 destroy_args+0x92/0x910 mm/debug_vm_pgtable.c:1017
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
 do_one_initcall+0x248/0x880 init/main.c:1269
 do_initcall_level+0x157/0x210 init/main.c:1331
 do_initcalls+0x3f/0x80 init/main.c:1347
 kernel_init_freeable+0x435/0x5d0 init/main.c:1580
 kernel_init+0x1d/0x2b0 init/main.c:1469
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88807595c100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807595c180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807595c200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88807595c280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807595c300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

