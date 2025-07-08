Return-Path: <bpf+bounces-62683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4320BAFCC6A
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 15:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01881BC409F
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDF82DF3FD;
	Tue,  8 Jul 2025 13:46:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1262DEA9A
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982385; cv=none; b=uVaq5hGXuDIo7Dkcp31aYQ8zyWkI3cxl7P900djE2pNM0Au5KIi6FnM522VH/83Xm/+ZgePbjimfuxz4va1BqQoqzk0XrvN+UhX9bXLjcpupnM624em++jHHcZ/GPs8piI0qr6HEh+7bAvsd5q/SJslrSX1+LpqF5tm4aEsRJIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982385; c=relaxed/simple;
	bh=Egn0yyZanoTQkdTqKl4E0EFbnChdxFFGwjZpDJd9vWE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qfsEtUdcqWjfV0jTaUFvAHG8zsGyW2pa9SXK4rlBjx8uhyJg8Gn6OjYezED3ueq2zIIpn6J9z9EoBsM3XTiN5fLSIlqjGgoYWtLpwApFdLegKg3OOz5FamsMEKfhcer3WIdrYbQNSGD2tupvz3ZJZpul9Fd6EE4ymy405xQTlrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddbec809acso48666885ab.2
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 06:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982383; x=1752587183;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Bm8WKGtXdif4sm7GnOLMTGBsf7+3XnGX3Jw1+NDLKA=;
        b=AP5YxNrAfkamcs3GlcrlKJFIAlJG3on5qGVuc7UsBJxj0byBuPC6QLFKJ5Xji36Qm6
         OZ5IXNgbOwmCQzsNKI0J27pZBV4KaZN2eO5USkn8XS2Vv+lEDLCA85AS6j+ObRUjHVTw
         Kz0iZWlET1Hd+yP0FFzgQsNPTNrU0mI0+FgmV1Ny4tPyUSPyX/Gc5qD6No+eCPRMhavT
         lDvQBvRVIDxPEzqi/Sni8vS7ibLP1Scy+C1CcqgYxKbGMxUQEz5jNatwcZ5N6TCyaCTd
         bTnnw70aaFTNdCTUDn/Z3wYKaKxHrNiTnZPvLgMGQuFPsM2WZ0BZvLObBC8NaPn2zahU
         M0bA==
X-Forwarded-Encrypted: i=1; AJvYcCWeEp5ePdbh/N07+HF7uXb+71NsEsJUuJejfAJ5o0AmltFLA+wuzkJMzQD8mn9hJnh2B40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpFnET0DiNbovmAnRTfOx68cL5qdOK2aNtbKPeK+8ZzO3c9jQl
	KCZ7PSJ4zQQp/pLJThCMdB52nDdhtuh3hN4aXW1TJsRGiOqKCVByRZbN8QNiryfJVUqEHobAiSU
	+NrGzTtnmn++HniyRPjFfiKQoEL1M1HANzW6UWCx/Npxm2qJj2q8DMRSe8Og=
X-Google-Smtp-Source: AGHT+IFGy6aEB/3/1ODGia5u9qOeamUSsIw8NLVjcczEZSSyoCM+FY1tl08PSQGOcucA1H5MGLZjjSVvbyviNpn0GTyKygqsbYlQ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170e:b0:3dc:7fa4:834 with SMTP id
 e9e14a558f8ab-3e153a89436mr37251585ab.15.1751982382898; Tue, 08 Jul 2025
 06:46:22 -0700 (PDT)
Date: Tue, 08 Jul 2025 06:46:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686d212e.050a0220.1ffab7.000c.GAE@google.com>
Subject: [syzbot] [bpf?] KASAN: invalid-free in drain_mem_cache
From: syzbot <syzbot+6fe5045b85546171744e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    17bbde2e1716 Merge tag 'net-6.16-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13924582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6ddf055b5c86f8
dashboard link: https://syzkaller.appspot.com/bug?extid=6fe5045b85546171744e
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0fb40d3b9565/disk-17bbde2e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae187eb465df/vmlinux-17bbde2e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/108daf226325/bzImage-17bbde2e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6fe5045b85546171744e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: invalid-free in free_one kernel/bpf/memalloc.c:260 [inline]
BUG: KASAN: invalid-free in free_all kernel/bpf/memalloc.c:269 [inline]
BUG: KASAN: invalid-free in drain_mem_cache+0x1d8/0x480 kernel/bpf/memalloc.c:640
Free of addr ffff888044850001 by task kworker/u8:2/36

CPU: 0 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted 6.16.0-rc4-syzkaller-00108-g17bbde2e1716 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: events_unbound bpf_map_free_deferred
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report_invalid_free+0xea/0x110 mm/kasan/report.c:596
 kasan_kfree_large include/linux/kasan.h:241 [inline]
 free_large_kmalloc+0x8c/0x200 mm/slub.c:4762
 free_one kernel/bpf/memalloc.c:260 [inline]
 free_all kernel/bpf/memalloc.c:269 [inline]
 drain_mem_cache+0x1d8/0x480 kernel/bpf/memalloc.c:640
 bpf_mem_alloc_destroy+0x13d/0x4d0 kernel/bpf/memalloc.c:754
 trie_free+0x132/0x150 kernel/bpf/lpm_trie.c:652
 bpf_map_free kernel/bpf/syscall.c:862 [inline]
 bpf_map_free_deferred+0xed/0x110 kernel/bpf/syscall.c:888
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x44850
head: order:4 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888027533f82
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f8(unknown)
raw: 00fff00000000040 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001f8000000 ffff888027533f82
head: 00fff00000000040 0000000000000000 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000001f8000000 ffff888027533f82
head: 00fff00000000004 ffffea0001121401 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000010
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 4, migratetype Unmovable, gfp_mask 0x442dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO|__GFP_NOWARN|__GFP_COMP), pid 6731, tgid 6727 (syz.1.287), ts 371750372606, free_ts 371388829185
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21d5/0x22b0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 __alloc_pages_noprof+0xa/0x30 mm/page_alloc.c:4993
 __alloc_pages_node_noprof include/linux/gfp.h:284 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:311 [inline]
 ___kmalloc_large_node+0x85/0x210 mm/slub.c:4272
 __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:4300
 __do_kmalloc_node mm/slub.c:4316 [inline]
 __kmalloc_node_noprof+0x366/0x4e0 mm/slub.c:4334
 alloc_bulk+0x33b/0x530 kernel/bpf/memalloc.c:246
 prefill_mem_cache kernel/bpf/memalloc.c:499 [inline]
 bpf_mem_alloc_init+0x45c/0xc60 kernel/bpf/memalloc.c:546
 trie_alloc+0x220/0x340 kernel/bpf/lpm_trie.c:603
 map_create+0x903/0x1150 kernel/bpf/syscall.c:1477
 __sys_bpf+0x67e/0x860 kernel/bpf/syscall.c:5818
 __do_sys_bpf kernel/bpf/syscall.c:5943 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5941 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5941
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5952 tgid 5952 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0xc65/0xe60 mm/page_alloc.c:2706
 kasan_depopulate_vmalloc_pte+0x74/0xa0 mm/kasan/shadow.c:472
 apply_to_pte_range mm/memory.c:3032 [inline]
 apply_to_pmd_range mm/memory.c:3076 [inline]
 apply_to_pud_range mm/memory.c:3112 [inline]
 apply_to_p4d_range mm/memory.c:3148 [inline]
 __apply_to_page_range+0xb8f/0x1380 mm/memory.c:3184
 kasan_release_vmalloc+0xa2/0xd0 mm/kasan/shadow.c:593
 kasan_release_vmalloc_node mm/vmalloc.c:2241 [inline]
 purge_vmap_node+0x214/0x8f0 mm/vmalloc.c:2258
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88804484ff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88804484ff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888044850000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                   ^
 ffff888044850080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888044850100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

