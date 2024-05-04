Return-Path: <bpf+bounces-28569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A51068BBA7E
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 12:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C953282E31
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 10:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EAB1802E;
	Sat,  4 May 2024 10:21:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E2A11C83
	for <bpf@vger.kernel.org>; Sat,  4 May 2024 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714818085; cv=none; b=Omz8MlSNmyX+fDx4AxdHX33AN2p96i2ywmEunYo5iUilUT3eSYm1FSf7SwK/q2lJzMAoB3MJGCCVP0xiwkM8Mh1JWMsbQqqDUotA/fcK2QskqZ9+WNbM5l/3buvrJcyP4bW5GOFn27aZYZKJZTlQpFNpN2SDfFioAUpr9sX5AkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714818085; c=relaxed/simple;
	bh=cBA8x8fOwo00ICBO/mY2Xz9sJ+/8GFPnrUE4hgLj2PA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=plMRNKU8fi5bJzz5acgD6Da+VHZ0citXiPUkBqgh5bFiMlI4ptQjrsyiRT04cZxcDiKMVpkf7A9Hjcorlh0IFvx4mjPang3wrH+AFqDvPA0mQUaqBjrVtDEh5ugsAGaSghy0NvhVeSNwRvD+Yov48t7Dl0DAQAFicsjp6COQgMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dee81b7e97so51470439f.3
        for <bpf@vger.kernel.org>; Sat, 04 May 2024 03:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714818082; x=1715422882;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aM8nxrdqTrmhaDBzQpTqKBGgBDB2k8pSRetXT9GNHFA=;
        b=iLHWgznBVnR691ej7sSOt9x4eogzstL2kTdyo8Dbs98zmSz6khmneyUjwFKPRl2Ngn
         n340YDJpfoKoqbo6+9Soqh8C5QYVPGIlUCK1BjJB+LMxvW6mDj3AzJ2oMvH2k4fv+kUK
         OZUq3DtgWpzBuxjYbAwhfGQJFkrdpNzojzfLNPvEOLk8iZ9SIse1oDnPtGxjprTtgwG9
         kvL3djpwJXPZMRTLp2I8ddqDIStwW+JOJ2bAD7KgM2DtAUN5OzO4JPxeEezBP5Yy9ru8
         9ttEieJ/AvsWtU3M3MIFFQSBFQRrDaX47KUaaYC8CGj7Xfg/dzQ5kaODnt1vb72YnXRW
         RB2g==
X-Forwarded-Encrypted: i=1; AJvYcCUjKanf50noImQQ+nOWz1M7x7KWpokceuoPrTmmGdmwdRZpukklAnzQsImZQkwgw0EEVKBvkEY82bALZdH5ML6RUOjd
X-Gm-Message-State: AOJu0YwaJtpaDHh6AnONwuH1iZtlwk1nGOE5dQLk/dHIVXnS1c3zM/Gr
	pXMzG6QBv23Ci/u78Yc/NHJD3cjFpv+13f8P6+QoBgxghB2TzeYa3MN86+18EArYAvxUBH8KUjx
	PmnFWy3HUbl01+XKlbJU2R9hn8dUPWW6OexfyZMvhLo2c6Qe6LPa7Zj0=
X-Google-Smtp-Source: AGHT+IF3ruQHv9nM+a2/JmuYgwc/Xc4fXzFeReeG9K6uoc39hS7Ii9gleqlXbFBo9fS4apMFtIpuPQGgncaKMOmM8jwQbzEGI0MJ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4387:b0:487:591e:6df3 with SMTP id
 bo7-20020a056638438700b00487591e6df3mr172683jab.2.1714818082672; Sat, 04 May
 2024 03:21:22 -0700 (PDT)
Date: Sat, 04 May 2024 03:21:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac237d06179e3237@google.com>
Subject: [syzbot] [bpf?] KASAN: slab-use-after-free Read in htab_map_alloc (2)
From: syzbot <syzbot+061f58eec3bde7ee8ffa@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2506f6229bd0 Merge branch 'net-dsa-adjust_link-removal'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11ac64ef180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15dda165e1d20cf1
dashboard link: https://syzkaller.appspot.com/bug?extid=061f58eec3bde7ee8ffa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fc61e6a6e169/disk-2506f622.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ed6cc1ccbe5/vmlinux-2506f622.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c6ea42464245/bzImage-2506f622.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+061f58eec3bde7ee8ffa@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in lockdep_register_key+0x253/0x3f0 kernel/locking/lockdep.c:1225
Read of size 8 at addr ffff88805fe2c298 by task syz-executor.1/5906

CPU: 1 PID: 5906 Comm: syz-executor.1 Not tainted 6.9.0-rc5-syzkaller-01473-g2506f6229bd0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 lockdep_register_key+0x253/0x3f0 kernel/locking/lockdep.c:1225
 htab_map_alloc+0x9b/0xe60 kernel/bpf/hashtab.c:506
 map_create+0x90c/0x1200 kernel/bpf/syscall.c:1333
 __sys_bpf+0x6d1/0x810 kernel/bpf/syscall.c:5659
 __do_sys_bpf kernel/bpf/syscall.c:5784 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5782 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5782
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7781e7dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7782c720c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f7781fabf80 RCX: 00007f7781e7dea9
RDX: 0000000000000048 RSI: 0000000020000140 RDI: 0100000000000000
RBP: 00007f7781eca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f7781fabf80 R15: 00007ffe14057dd8
 </TASK>

Allocated by task 5593:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc_node_track_caller+0x24e/0x4e0 mm/slub.c:3986
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:597
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:666
 alloc_skb include/linux/skbuff.h:1308 [inline]
 alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6455
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2794
 sock_alloc_send_skb include/net/sock.h:1766 [inline]
 llc_ui_sendmsg+0x48d/0xf80 net/llc/af_llc.c:971
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 sock_sendmsg+0x134/0x200 net/socket.c:768
 splice_to_socket+0xa13/0x10b0 fs/splice.c:889
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11e/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x58e/0xc90 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x28c/0x3e0 fs/splice.c:1233
 do_sendfile+0x56d/0xdc0 fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5593:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x153/0x3a0 mm/slub.c:4390
 skb_kfree_head net/core/skbuff.c:1033 [inline]
 skb_free_head net/core/skbuff.c:1045 [inline]
 skb_release_data+0x676/0x880 net/core/skbuff.c:1072
 skb_release_all net/core/skbuff.c:1137 [inline]
 __kfree_skb net/core/skbuff.c:1151 [inline]
 kfree_skb_reason+0x1a3/0x3b0 net/core/skbuff.c:1187
 llc_ui_sendmsg+0xb03/0xf80 net/llc/af_llc.c:1000
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 sock_sendmsg+0x134/0x200 net/socket.c:768
 splice_to_socket+0xa13/0x10b0 fs/splice.c:889
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11e/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x58e/0xc90 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x28c/0x3e0 fs/splice.c:1233
 do_sendfile+0x56d/0xdc0 fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88805fe2c000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 664 bytes inside of
 freed 2048-byte region [ffff88805fe2c000, ffff88805fe2c800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5fe28
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888015042000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
head: 00fff80000000840 ffff888015042000 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
head: 00fff80000000003 ffffea00017f8a01 dead000000000122 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5095, tgid 21395662 (syz-executor.0), ts 5095, free_ts 13812911031
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmalloc_trace+0x269/0x360 mm/slub.c:3992
 kmalloc include/linux/slab.h:628 [inline]
 rtnl_newlink+0xf2/0x20a0 net/core/rtnetlink.c:3723
 rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6594
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x986/0xab0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6572
 destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1036
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1416
 do_one_initcall+0x248/0x880 init/main.c:1245
 do_initcall_level+0x157/0x210 init/main.c:1307
 do_initcalls+0x3f/0x80 init/main.c:1323
 kernel_init_freeable+0x435/0x5d0 init/main.c:1555
 kernel_init+0x1d/0x2b0 init/main.c:1444
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88805fe2c180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805fe2c200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88805fe2c280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88805fe2c300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805fe2c380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

