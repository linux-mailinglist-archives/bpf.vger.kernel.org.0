Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4A949DF97
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 11:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbiA0KmT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 05:42:19 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:37866 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiA0KmS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 05:42:18 -0500
Received: by mail-il1-f199.google.com with SMTP id 20-20020a056e020cb400b002b93016fbccso1881358ilg.4
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 02:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Hrx9AeFuVg1nzeaIQo9oHlV16SrR5kF+a+aIiKA98VI=;
        b=LpZxWNsH465y3Bo4wsG5ozzkLCOKgqy5QaZ4yxHDsQcgyGgGOdjm3sBOW4cuVDABFc
         vPozbuOgSfWnU43DwsUDwoF0IG7xPm86zRR3pvEqu+PjE9dPH3w3zx3WPx+Dyq1JuvLO
         bMcMhnfdFdb8XS90TFrbNWJrQ3vR8OhIoua0WX14RNSD/zphHUxScW6jUeaHDfbySRRT
         AyYplo0LdEC/8jE2tNEJCrQfwFQLCrRjFgLl9ywmTCMJhVpzG9/7WhZZ2AfdHx5e19xb
         ypoT2kzqRIpoJAr1/whyRhT9AON8eGP+b8ZHu9fNfzr9s6vCeEpI1qWthBeB+5nysgKA
         JBPw==
X-Gm-Message-State: AOAM533uWTedCcb0D4zl6s9FJ5eKYe0umuk/y0to5Wu+fc1L3QhVwv/E
        rL/AGY+DPtTouuentxkH2MPWolE2Ls2l6SnYEa7z4TH1lytd
X-Google-Smtp-Source: ABdhPJyZj5HO5nzoOaAXYWOh/SuIzp/QmKNw3aegzE6/gDtJFG2f5Yf7qxEmNy7HvBbeLIerF4LGpopuCJHBvapp0ES9A+zSEfqQ
MIME-Version: 1.0
X-Received: by 2002:a6b:da11:: with SMTP id x17mr1611995iob.170.1643280137675;
 Thu, 27 Jan 2022 02:42:17 -0800 (PST)
Date:   Thu, 27 Jan 2022 02:42:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df66a505d68df8d1@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Write in bpf_prog_test_run_xdp
From:   syzbot <syzbot+6d70ca7438345077c549@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c446fdacb10d bpf: fix register_btf_kfunc_id_set for !CONFI..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=118a9404700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fed7021824b74f81
dashboard link: https://syzkaller.appspot.com/bug?extid=6d70ca7438345077c549
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d70ca7438345077c549@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __skb_frag_set_page include/linux/skbuff.h:3242 [inline]
BUG: KASAN: slab-out-of-bounds in bpf_prog_test_run_xdp+0x10ac/0x1150 net/bpf/test_run.c:972
Write of size 8 at addr ffff888048c75000 by task syz-executor.5/23405

CPU: 1 PID: 23405 Comm: syz-executor.5 Not tainted 5.16.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x336 mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 __skb_frag_set_page include/linux/skbuff.h:3242 [inline]
 bpf_prog_test_run_xdp+0x10ac/0x1150 net/bpf/test_run.c:972
 bpf_prog_test_run kernel/bpf/syscall.c:3356 [inline]
 __sys_bpf+0x1858/0x59a0 kernel/bpf/syscall.c:4658
 __do_sys_bpf kernel/bpf/syscall.c:4744 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:4742 [inline]
 __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:4742
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4ea30dd059
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4ea1a52168 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f4ea31eff60 RCX: 00007f4ea30dd059
RDX: 0000000000000048 RSI: 0000000020000000 RDI: 000000000000000a
RBP: 00007f4ea313708d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc8367c5af R14: 00007f4ea1a52300 R15: 0000000000022000
 </TASK>

Allocated by task 23405:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc mm/kasan/common.c:516 [inline]
 ____kasan_kmalloc mm/kasan/common.c:475 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
 kmalloc include/linux/slab.h:586 [inline]
 kzalloc include/linux/slab.h:715 [inline]
 bpf_test_init.isra.0+0x9f/0x150 net/bpf/test_run.c:411
 bpf_prog_test_run_xdp+0x2f8/0x1150 net/bpf/test_run.c:941
 bpf_prog_test_run kernel/bpf/syscall.c:3356 [inline]
 __sys_bpf+0x1858/0x59a0 kernel/bpf/syscall.c:4658
 __do_sys_bpf kernel/bpf/syscall.c:4744 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:4742 [inline]
 __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:4742
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff888048c74000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 0 bytes to the right of
 4096-byte region [ffff888048c74000, ffff888048c75000)
The buggy address belongs to the page:
page:ffffea0001231c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x48c70
head:ffffea0001231c00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888010c42140
raw: 0000000000000000 0000000080040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 1137, ts 352220884506, free_ts 345202653097
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4165
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5389
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2271
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab mm/slub.c:1944 [inline]
 new_slab+0x28a/0x3b0 mm/slub.c:2004
 ___slab_alloc+0x87c/0xe90 mm/slub.c:3018
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3105
 slab_alloc_node mm/slub.c:3196 [inline]
 __kmalloc_node_track_caller+0x2cb/0x360 mm/slub.c:4957
 kmalloc_reserve net/core/skbuff.c:354 [inline]
 __alloc_skb+0xde/0x340 net/core/skbuff.c:426
 alloc_skb include/linux/skbuff.h:1159 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:745 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:802 [inline]
 nsim_dev_trap_report_work+0x29a/0xbc0 drivers/net/netdevsim/dev.c:843
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1352 [inline]
 free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3325 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3404
 qlink_free mm/kasan/quarantine.c:157 [inline]
 qlist_free_all+0x6d/0x160 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:260 [inline]
 slab_post_alloc_hook mm/slab.h:732 [inline]
 slab_alloc_node mm/slub.c:3230 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 kmem_cache_alloc+0x202/0x3a0 mm/slub.c:3243
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:138
 getname_flags include/linux/audit.h:323 [inline]
 getname+0x8e/0xd0 fs/namei.c:217
 do_sys_openat2+0xf5/0x4d0 fs/open.c:1208
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff888048c74f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888048c74f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888048c75000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff888048c75080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888048c75100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
