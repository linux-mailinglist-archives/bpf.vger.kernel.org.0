Return-Path: <bpf+bounces-56387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38321A96595
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 12:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E70A189DD23
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 10:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D4620E00C;
	Tue, 22 Apr 2025 10:12:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F9200BBC
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316750; cv=none; b=cOah9yIov+Ii6p5gb+csoxbxieWI6LyewQAwIMDoFY2aRKqHJnXO8ndicLaQkgEELEM0gEbGpsZumCZxdpVqUc97vuCyFUJybP4E7efrWE7DI2F7cTkfhy/iPKhiqFHncC8ObQwCFcyWtLXTgiWo0clrhx39posz/u2CgQiBQrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316750; c=relaxed/simple;
	bh=iuw8mzz4D8FzSVR6md29ftPqG/nClczLoSlv6YIjciM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uvHFv8FCcYrkK5AnzGovMutCyxzBmzTGwwDqzhKwzIWGFwVBqHFfAHpQD7gY5SGen8OeZ+CSzSGAn3hRVj2Wtk7z6MlxNn0kVkSmQ4418U2fDWOW5cPxXDOu3RrdBzY9HtO7JhZyiHgED2oMH430tOZ54rS3ADGbUzNRamznuAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d43541a706so47525915ab.1
        for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 03:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316747; x=1745921547;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YAH1eGiSqMrL1f9zZlMYWKFkdmMtSRfpvjTHspDKEI=;
        b=h016mxXU/luI/mBHp2KpzxtKUWU/Q/isJne6E5L2qSDAS03zsLGssdc0qA5nSCzdlc
         Y60dPQeUfXYPhpTXRJEwAihIjbhkRHjs0HHSjTakxfT4tg6mnqttKvFJmIYHGB/OiK9c
         1Ebl2GN78mVLMtdxC2aT0PMvMj9wTF6BKq46rHizo9eN7VMLZqfV2/8CXMRXBI/feDdK
         pN0LyyZ1cuRHZGc/6NxPW9SPnUjeKeJgUZLSJMQls5nro5wsm6zr80Y4yD2ma2Y7g8Vp
         FT+i56LkW50Qg4Gff8+vXdrpbNha3gPQJxrsD7y5oIP/aMlhTEnlOWRs2MNp4Yg8y+Ui
         R00g==
X-Forwarded-Encrypted: i=1; AJvYcCUF1PZY9vLuElpHUSVXN2PMhFjY9z7Jji9Va2a+CUw460zCShvPBvglUsGmZUwfi8Vh0ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXML8+Cul7wv20MN2rIsnl7OZHymXnaQX0d7GBhnBoIEK/wllJ
	hU28Tp31GIzdkfrL/LSGURd+DGX4Gd2ancOW8tc6Q0bOMqr5ErNOwd4I1NZxV2CBRtg1DDSsUrh
	TJT1TIE/kOm571fOTSsJo1zi02fQ+uI2XQKqYcbLphmuL332fFaiKAUM=
X-Google-Smtp-Source: AGHT+IEmMWNLajQ/yZ4q/Mpz1u1sc8u058gxDVsx1FnIBf0/iMnGdmA+jGVROjYyPJKr0OiMEUBFtElNvrrCvDxbLfWQG/KEXLSJ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c8:b0:3cf:bc71:94f5 with SMTP id
 e9e14a558f8ab-3d88ee51776mr142807415ab.22.1745316747558; Tue, 22 Apr 2025
 03:12:27 -0700 (PDT)
Date: Tue, 22 Apr 2025 03:12:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68076b8b.050a0220.380c13.0088.GAE@google.com>
Subject: [syzbot] [net?] [bpf?] KASAN: slab-use-after-free Read in
 sk_psock_verdict_data_ready (3)
From: syzbot <syzbot+c21c23281290bfafe8d5@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8582d9ab3efd libbpf: Verify section type in btf_find_elf_s..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13baba3f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b209dc5439043d2
dashboard link: https://syzkaller.appspot.com/bug?extid=c21c23281290bfafe8d5
compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ee77ac023e33/disk-8582d9ab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ebe52a30453e/vmlinux-8582d9ab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6868f9db2e2e/bzImage-8582d9ab.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c21c23281290bfafe8d5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in sk_psock_verdict_data_ready+0x6d/0x390 net/core/skmsg.c:1239
Read of size 8 at addr ffff888078595a20 by task syz.2.24/6005

CPU: 0 UID: 0 PID: 6005 Comm: syz.2.24 Not tainted 6.14.0-syzkaller-g8582d9ab3efd #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x16e/0x5b0 mm/kasan/report.c:521
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 sk_psock_verdict_data_ready+0x6d/0x390 net/core/skmsg.c:1239
 unix_stream_sendmsg+0x7a3/0x1000 net/unix/af_unix.c:2329
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:727
 ____sys_sendmsg+0x523/0x860 net/socket.c:2566
 ___sys_sendmsg net/socket.c:2620 [inline]
 __sys_sendmsg+0x271/0x360 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6d0d98e169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6d0e7fa038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f6d0dbb5fa0 RCX: 00007f6d0d98e169
RDX: 0000000000000003 RSI: 0000200000000980 RDI: 0000000000000007
RBP: 00007f6d0da10a68 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6d0dbb5fa0 R15: 00007ffcf19f37c8
 </TASK>

Allocated by task 6005:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4151 [inline]
 slab_alloc_node mm/slub.c:4200 [inline]
 kmem_cache_alloc_lru_noprof+0x1e5/0x390 mm/slub.c:4219
 sock_alloc_inode+0x28/0xc0 net/socket.c:309
 alloc_inode+0x69/0x1b0 fs/inode.c:346
 new_inode_pseudo include/linux/fs.h:3309 [inline]
 sock_alloc net/socket.c:622 [inline]
 __sock_create+0x127/0xa30 net/socket.c:1505
 sock_create net/socket.c:1599 [inline]
 __sys_socketpair+0x34f/0x720 net/socket.c:1750
 __do_sys_socketpair net/socket.c:1799 [inline]
 __se_sys_socketpair net/socket.c:1796 [inline]
 __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1796
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 23:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2389 [inline]
 slab_free mm/slub.c:4646 [inline]
 kmem_cache_free+0x197/0x410 mm/slub.c:4748
 rcu_do_batch kernel/rcu/tree.c:2568 [inline]
 rcu_core+0xaac/0x17a0 kernel/rcu/tree.c:2824
 handle_softirqs+0x2d6/0x9b0 kernel/softirq.c:579
 run_ksoftirqd+0xcf/0x130 kernel/softirq.c:968
 smpboot_thread_fn+0x576/0xaa0 kernel/smpboot.c:164
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbf/0xd0 mm/kasan/generic.c:548
 __call_rcu_common kernel/rcu/tree.c:3082 [inline]
 call_rcu+0x172/0xad0 kernel/rcu/tree.c:3202
 destroy_inode fs/inode.c:401 [inline]
 evict+0x837/0x9b0 fs/inode.c:834
 __dentry_kill+0x20d/0x630 fs/dcache.c:660
 dput+0x19f/0x2b0 fs/dcache.c:902
 __fput+0x60b/0x9f0 fs/file_table.c:473
 task_work_run+0x251/0x310 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x210 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888078595a00
 which belongs to the cache sock_inode_cache of size 1408
The buggy address is located 32 bytes inside of
 freed 1408-byte region [ffff888078595a00, ffff888078595f80)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x78590
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888030557601
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff8881422b0dc0 0000000000000000 0000000000000001
raw: 0000000000000000 0000000000150015 00000000f5000000 ffff888030557601
head: 00fff00000000040 ffff8881422b0dc0 0000000000000000 0000000000000001
head: 0000000000000000 0000000000150015 00000000f5000000 ffff888030557601
head: 00fff00000000003 ffffea0001e16401 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5838, tgid 5838 (syz-executor), ts 91567346475, free_ts 30811401561
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1717
 prep_new_page mm/page_alloc.c:1725 [inline]
 get_page_from_freelist+0x352b/0x36c0 mm/page_alloc.c:3652
 __alloc_frozen_pages_noprof+0x211/0x5b0 mm/page_alloc.c:4934
 alloc_pages_mpol+0x339/0x690 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2459 [inline]
 allocate_slab+0x8f/0x3a0 mm/slub.c:2623
 new_slab mm/slub.c:2676 [inline]
 ___slab_alloc+0xc3b/0x1500 mm/slub.c:3862
 __slab_alloc+0x58/0xa0 mm/slub.c:3952
 __slab_alloc_node mm/slub.c:4027 [inline]
 slab_alloc_node mm/slub.c:4188 [inline]
 kmem_cache_alloc_lru_noprof+0x274/0x390 mm/slub.c:4219
 sock_alloc_inode+0x28/0xc0 net/socket.c:309
 alloc_inode+0x69/0x1b0 fs/inode.c:346
 new_inode_pseudo include/linux/fs.h:3309 [inline]
 sock_alloc net/socket.c:622 [inline]
 __sock_create+0x127/0xa30 net/socket.c:1505
 sock_create net/socket.c:1599 [inline]
 __sys_socket_create net/socket.c:1636 [inline]
 __sys_socket+0x14d/0x3c0 net/socket.c:1683
 __do_sys_socket net/socket.c:1697 [inline]
 __se_sys_socket net/socket.c:1695 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1695
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0xde8/0x10a0 mm/page_alloc.c:2680
 __free_pages mm/page_alloc.c:5044 [inline]
 free_contig_range+0x154/0x430 mm/page_alloc.c:6900
 destroy_args+0x94/0x4b0 mm/debug_vm_pgtable.c:1017
 debug_vm_pgtable+0x555/0x590 mm/debug_vm_pgtable.c:1397
 do_one_initcall+0x24a/0x940 init/main.c:1257
 do_initcall_level+0x157/0x210 init/main.c:1319
 do_initcalls+0x71/0xd0 init/main.c:1335
 kernel_init_freeable+0x432/0x5d0 init/main.c:1567
 kernel_init+0x1d/0x2b0 init/main.c:1457
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888078595900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888078595980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888078595a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888078595a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888078595b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

