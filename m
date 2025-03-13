Return-Path: <bpf+bounces-53969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5402A5FCC9
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 17:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C59D16A01C
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 16:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C5E269D08;
	Thu, 13 Mar 2025 16:59:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CE2686BD
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885173; cv=none; b=Uwty96ONk0+LQ4fCrJnQAuUkYFvMGRufpMhMqcQzGYsq1n8VlHVNZkqIy0N6hODlRQRvFvHIDvD54JXg7p0ZMWFZnt+ZQqvkwBrWKDLB79Vg/eak2WrDqrCsIJI0+/lNPDFYhBKZnVkL1q+m5L1/kPQ3V80BVkZK3Gst4jl6mCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885173; c=relaxed/simple;
	bh=r78kbKxQagOfA4fTjXUz8rQD0c6w/m7aqX4C3ZCFu1Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=d8myhPSe2oa2sF2ymYyn4JBpzcvXorm4CuL5jwYZPZ/bHEP1LPv1YCNvQi5Yb4Lc4uxg6vKTDjgO83Ngnq8TSsdwaqI4HqbnQ3AdTu6kn/joPWSmgorU9j5oj4AfWR1B+1rR8Yiryfon2ieXXU56tFvgN6qELZYtrvoLWoQBR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d2a63dc62aso12626935ab.2
        for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 09:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885170; x=1742489970;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdpBlpt1qHoogcDEBbY7Tv30XG+ng+gd1D5ipu5ours=;
        b=dQaEGh92Ith+Q8PpV5u7SzvT7mPkU6kiQKbGdNmrlPTZoUvXjbpFaY+3rLlNdi9rQ0
         91BWUjkmZwnjlZnFOdhZCJ+jmJw/reGdRM5xAKbpF2SfKwhyoXFn1GZIRlcCG7QtDthb
         u+cW8IqBIirmb7jctrUQNnlqYAfydfp/rr/TXIGzKQP2Gd9osOoYsGlLVg1OCCpT0dyo
         Y46LLyoPpMaCaHTTNPVjV3P41XXyqwjUhJsupFPPw8pxOjsZpeOGVrX+oDV9JuhyrvTS
         RvjyfxfEhfRiXVBIEIwtY4nZ5y8i8CrMaUxwsy0ylLjMl68iNpsWmtRuSikatUMH78nf
         PttA==
X-Forwarded-Encrypted: i=1; AJvYcCWvIYp/dC6O5+DQYhJ+X3u1tMDEbNlakwZB6BwfDi5Ykeb8Cqua1EnHPToo4bTokYrGrhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQSBVQdtgdZqtj3L3JZR3g7AAgP5oMF1HCvMzCEVWjUcW1u2Jp
	MfrJ2nnfeev6KE11dRbY+zspg+C3uvlbRPTxrpaeqz9PsdjgqkfMFNh1AizCrLmTYvKC/R3in3W
	gTZDzD9DXI19TAcBHHbIx7aXOvr97TFXOoxDbvzZvowyp7+xlx/aeGsE=
X-Google-Smtp-Source: AGHT+IEczvvqGmjagvGQMtEa8Pq8M87g8xXwDIdXCeR2blw2m2+e3dFRH9JVZaM1p69oDP9VprNq9WWirbaRHuT0ORQausSa5xKg
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cb:b0:3cf:c7d3:e4b with SMTP id
 e9e14a558f8ab-3d4817af930mr5683665ab.21.1741885170615; Thu, 13 Mar 2025
 09:59:30 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:59:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d30ef2.050a0220.14e108.0039.GAE@google.com>
Subject: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in atomic_ptr_type_ok
From: syzbot <syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, iii@linux.ibm.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yepeilin@google.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f28214603dc6 Merge branch 'selftests-bpf-move-test_lwt_seg..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15f84664580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16450ba8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f5fa54580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b6b450916744/disk-f2821460.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f67764ad4712/vmlinux-f2821460.xz
kernel image: https://storage.googleapis.com/syzbot-assets/42aedcc506e8/bzImage-f2821460.xz

The issue was bisected to:

commit e24bbad29a8de70bb33c1cabc85bb40e6707572a
Author: Peilin Ye <yepeilin@google.com>
Date:   Tue Mar 4 01:06:13 2025 +0000

    bpf: Introduce load-acquire and store-release instructions

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154f5074580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=174f5074580000
console output: https://syzkaller.appspot.com/x/log.txt?x=134f5074580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
Fixes: e24bbad29a8d ("bpf: Introduce load-acquire and store-release instructions")

==================================================================
BUG: KASAN: slab-out-of-bounds in is_ctx_reg kernel/bpf/verifier.c:6185 [inline]
BUG: KASAN: slab-out-of-bounds in atomic_ptr_type_ok+0x3d7/0x550 kernel/bpf/verifier.c:6223
Read of size 4 at addr ffff888141b0d690 by task syz-executor143/5842

CPU: 1 UID: 0 PID: 5842 Comm: syz-executor143 Not tainted 6.14.0-rc3-syzkaller-gf28214603dc6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x16e/0x5b0 mm/kasan/report.c:521
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 is_ctx_reg kernel/bpf/verifier.c:6185 [inline]
 atomic_ptr_type_ok+0x3d7/0x550 kernel/bpf/verifier.c:6223
 check_atomic_store kernel/bpf/verifier.c:7804 [inline]
 check_atomic kernel/bpf/verifier.c:7841 [inline]
 do_check+0x89dd/0xedd0 kernel/bpf/verifier.c:19334
 do_check_common+0x1678/0x2080 kernel/bpf/verifier.c:22600
 do_check_main kernel/bpf/verifier.c:22691 [inline]
 bpf_check+0x165c8/0x1cca0 kernel/bpf/verifier.c:23821
 bpf_prog_load+0x1664/0x20e0 kernel/bpf/syscall.c:2967
 __sys_bpf+0x4ea/0x820 kernel/bpf/syscall.c:5811
 __do_sys_bpf kernel/bpf/syscall.c:5918 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5916 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5916
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa3ac86bab9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe50fff5f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa3ac86bab9
RDX: 0000000000000094 RSI: 00004000000009c0 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5842:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4325
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 do_check_common+0x1ec/0x2080 kernel/bpf/verifier.c:22499
 do_check_main kernel/bpf/verifier.c:22691 [inline]
 bpf_check+0x165c8/0x1cca0 kernel/bpf/verifier.c:23821
 bpf_prog_load+0x1664/0x20e0 kernel/bpf/syscall.c:2967
 __sys_bpf+0x4ea/0x820 kernel/bpf/syscall.c:5811
 __do_sys_bpf kernel/bpf/syscall.c:5918 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5916 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5916
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888141b0d000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 312 bytes to the right of
 allocated 1368-byte region [ffff888141b0d000, ffff888141b0d558)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x141b08
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000040 ffff88801b042000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 057ff00000000040 ffff88801b042000 dead000000000100 dead000000000122
head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 057ff00000000003 ffffea000506c201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 8909973200, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1585
 prep_new_page mm/page_alloc.c:1593 [inline]
 get_page_from_freelist+0x3a8c/0x3c20 mm/page_alloc.c:3538
 __alloc_frozen_pages_noprof+0x264/0x580 mm/page_alloc.c:4805
 alloc_pages_mpol+0x311/0x660 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab+0x8f/0x3a0 mm/slub.c:2587
 new_slab mm/slub.c:2640 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3826
 __slab_alloc+0x58/0xa0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 __kmalloc_cache_noprof+0x27b/0x390 mm/slub.c:4320
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 virtio_pci_probe+0x54/0x340 drivers/virtio/virtio_pci_common.c:689
 local_pci_probe drivers/pci/pci-driver.c:324 [inline]
 pci_call_probe drivers/pci/pci-driver.c:392 [inline]
 __pci_device_probe drivers/pci/pci-driver.c:417 [inline]
 pci_device_probe+0x6c5/0xa10 drivers/pci/pci-driver.c:451
 really_probe+0x2b9/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
 bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:370
 bus_add_driver+0x346/0x670 drivers/base/bus.c:678
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888141b0d580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888141b0d600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888141b0d680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                         ^
 ffff888141b0d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888141b0d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

