Return-Path: <bpf+bounces-38873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1688B96BC7C
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 14:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3E51F22771
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 12:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328551D9330;
	Wed,  4 Sep 2024 12:35:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4F1CF7AE
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453323; cv=none; b=qdo77rAUI+MEuOeFL+3yP8nETrUa3ESjzobeX2Bp20hx/sz35w+4qI1vbQ7KvhleFJOnDkXamI9RbRkncC34DjAooE3Se3e44OBIqoTlAV7ttz68m74Bs2OYNEgQ6s9tqe6KNOoWmAvHtZqs7ClvziQF4Eg9E1neKsZBu+OmVwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453323; c=relaxed/simple;
	bh=t+gnULiEUiPPKts+uEzedNwutohl3nSJyDw2ulcoEKk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SssJoiIuZ6OVBDMKut5YlpUAk1K66DfK56mjJbeNW+QEXp5SIaBIB3fAak2ZguzxXbhcDM/5FKFFM7OnitfLucsVA00XZSJ/avTy/nc+3gMnufODZj4yf9JhI4fPIfd9r/ErDUh55DOC1P6WZiyJRzngeFe9N9bp7iPE8EOzoBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a5e277079so297164639f.1
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2024 05:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725453321; x=1726058121;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkfHEc9lmJJvVteLzBNeYlL/M/84Jk3aTacariufTS4=;
        b=VXcbMXSXU5KpcOrkOi3jhJeBErGa/Z2xa/DdwcacvqaD9ZIMszlN1Q/VJz7qur8N9P
         XlaqfGHcIyZ9u0d+kOM+HAxriF5MtObu+mTNenxQU9JbXT++KHeKhBKFTgUyALhkUBv7
         +2ILhFAgyYpHxDXcgP0ak1q7DQZccNCElgztUxLPUL5Ibs3/grsGTdKN8yttLacV/v1m
         WSak0p2JxQNZf0nK5mSW4ffgwFTROyoofvBa3AYHnxkVJN/hKbP//mBXrYPV5t6epmy4
         fXO7zl7pxaR3rwzyZ9qBEpc/rdzrW6dyrBKr5SvZs+st25JBsVoD7d2o23UHlOHh3R4y
         6zOA==
X-Forwarded-Encrypted: i=1; AJvYcCX5rCjzRiTkwkVHe7PiB28Aj8AOpxeK9pvdjE9izCmeJwQhZdXhXBh9LR5CPWOozEnUC7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDFigJtTnleAoqcRInLGAx7IzHhqSx2/umLqvu6WwfdU1sZP3
	DUDXd2k4EF3SNBW9SsPWcEhHK1bTtxfD6aPuck/IvDnicFsvraKn4ETbHVZPz+w6nGtaRTTHQ3k
	bzpg8t7h7hTZaWoaOT1t2JvHm6la6iM/p/ETU9U6nO2/ekP1vzKFf14I=
X-Google-Smtp-Source: AGHT+IHkvRx81+C03kHPhjTY8vxvtpp3lcHS4TYaT7Depvw6RQodJ9lgjjJDyjI/sm71l6vPbEXlPxNJFzmvJmnVO+t1/EiAVHup
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9820:b0:4c0:9a05:44c4 with SMTP id
 8926c6da1cb9f-4d017c4697bmr1131411173.0.1725453321412; Wed, 04 Sep 2024
 05:35:21 -0700 (PDT)
Date: Wed, 04 Sep 2024 05:35:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004cb8a506214a6876@google.com>
Subject: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in sk_filter_trim_cap
From: syzbot <syzbot+b4bc25bfaad44df51f05@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    33f339a1ba54 bpf, net: Fix a potential race in do_sock_get..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13f046fb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=b4bc25bfaad44df51f05
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05db6c7e2db6/disk-33f339a1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/236ebb3d5e01/vmlinux-33f339a1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/97dd5f4e883e/bzImage-33f339a1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4bc25bfaad44df51f05@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in sk_filter_trim_cap+0x270/0xa80 net/core/filter.c:155
Read of size 8 at addr ffff888062a0a178 by task syz.3.1323/10208

CPU: 0 UID: 0 PID: 10208 Comm: syz.3.1323 Not tainted 6.11.0-rc5-syzkaller-00191-g33f339a1ba54 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 sk_filter_trim_cap+0x270/0xa80 net/core/filter.c:155
 sk_filter include/linux/filter.h:1052 [inline]
 sock_queue_rcv_skb_reason+0x28/0xf0 net/core/sock.c:521
 sock_queue_rcv_skb include/net/sock.h:2376 [inline]
 mgmt_cmd_status+0x28d/0x4d0 net/bluetooth/mgmt_util.c:156
 cmd_status_rsp net/bluetooth/mgmt.c:1450 [inline]
 cmd_complete_rsp+0xe7/0x150 net/bluetooth/mgmt.c:1465
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x187/0x420 net/bluetooth/mgmt.c:9469
 hci_dev_close_sync+0x665/0x11a0 net/bluetooth/hci_sync.c:5191
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4ef0d7cef9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4ef1b48038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4ef0f35f80 RCX: 00007f4ef0d7cef9
RDX: 0000000000000000 RSI: 00000000400448ca RDI: 0000000000000005
RBP: 00007f4ef0def01e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4ef0f35f80 R15: 00007ffef1e33f48
 </TASK>

Allocated by task 6202:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4158 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 sk_prot_alloc+0xe0/0x210 net/core/sock.c:2096
 sk_alloc+0x38/0x370 net/core/sock.c:2149
 bt_sock_alloc+0x3c/0x340 net/bluetooth/af_bluetooth.c:148
 hci_sock_create+0xa1/0x190 net/bluetooth/hci_sock.c:2202
 bt_sock_create+0x161/0x230 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x490/0x920 net/socket.c:1571
 sock_create net/socket.c:1622 [inline]
 __sys_socket_create net/socket.c:1659 [inline]
 __sys_socket+0x150/0x3c0 net/socket.c:1706
 __do_sys_socket net/socket.c:1720 [inline]
 __se_sys_socket net/socket.c:1718 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1718
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 10210:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x149/0x360 mm/slub.c:4594
 sk_prot_free net/core/sock.c:2132 [inline]
 __sk_destruct+0x479/0x5f0 net/core/sock.c:2224
 sock_put include/net/sock.h:1884 [inline]
 mgmt_pending_free net/bluetooth/mgmt_util.c:307 [inline]
 mgmt_pending_remove+0x13e/0x1a0 net/bluetooth/mgmt_util.c:315
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 mgmt_index_removed+0xe6/0x340 net/bluetooth/mgmt.c:9402
 hci_sock_bind+0xcce/0x1150 net/bluetooth/hci_sock.c:1307
 __sys_bind_socket net/socket.c:1833 [inline]
 __sys_bind+0x23d/0x2f0 net/socket.c:1857
 __do_sys_bind net/socket.c:1865 [inline]
 __se_sys_bind net/socket.c:1863 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1863
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888062a0a000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 376 bytes inside of
 freed 2048-byte region [ffff888062a0a000, ffff888062a0a800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x62a08
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801ac42000 ffffea0000a95600 dead000000000002
raw: 0000000000000000 0000000000080008 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff88801ac42000 ffffea0000a95600 dead000000000002
head: 0000000000000000 0000000000080008 00000001fdffffff 0000000000000000
head: 00fff00000000003 ffffea00018a8201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5235, tgid 5235 (syz-executor), ts 58768438859, free_ts 15148990809
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2321
 allocate_slab+0x5a/0x2f0 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_node_track_caller_noprof+0x281/0x440 mm/slub.c:4177
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:605
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1320 [inline]
 nlmsg_new include/net/netlink.h:1015 [inline]
 inet6_ifinfo_notify+0x72/0x120 net/ipv6/addrconf.c:6162
 addrconf_notify+0xc6b/0x1020 net/ipv6/addrconf.c:3763
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 __dev_notify_flags+0x207/0x400
 dev_change_flags+0xf0/0x1a0 net/core/dev.c:8915
 do_setlink+0xcd0/0x41f0 net/core/rtnetlink.c:2900
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6660
 destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1017
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
 do_one_initcall+0x248/0x880 init/main.c:1267
 do_initcall_level+0x157/0x210 init/main.c:1329
 do_initcalls+0x3f/0x80 init/main.c:1345
 kernel_init_freeable+0x435/0x5d0 init/main.c:1578
 kernel_init+0x1d/0x2b0 init/main.c:1467
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888062a0a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888062a0a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888062a0a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff888062a0a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888062a0a200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

