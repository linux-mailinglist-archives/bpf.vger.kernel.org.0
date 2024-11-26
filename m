Return-Path: <bpf+bounces-45603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D659D8F5D
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 01:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8B516ACD2
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 00:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E32A194A44;
	Tue, 26 Nov 2024 00:00:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D2C2ED
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579229; cv=none; b=D4KETCDssLiumUY0hl+2KcFz2EyP/zLfQKp3X8clQX1CMLMwCh3kih3LgEYvVvmlmUbREnwMMsSD410fzQ+tm2Ig6/lQcZcJMYfHix+buQn/pftIK1o8xVcBryjO6EWNCmNr7c74kIwbKwKkIJzFc/7iAua6eFwoymj6o31buZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579229; c=relaxed/simple;
	bh=4m1ssMz3/t+GieMLL0Q/VCdzvq2A5qK5Zm4q4ehLqcE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PtzGe2YLiBLxAMLRqM1to7kIKn9y1n3TxdylRDM7lKLyaBfvOsVsNLLo+MpO3TqHhovuUYPHcVfQPywLrok7tDtIexpQO9Zvv8q57iRN4dGlHOQ7sBzcsESuZ5e84NIhklW79tILyQoKY4I5r83wbE7hLdqipVvVfEhdUHvTg1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-84193bb7ed1so188054239f.1
        for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 16:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732579227; x=1733184027;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MXMmFPLNOHJFet4BKgZrdk1dVxmzIou58hNCe/DcTK8=;
        b=dxI9KP40jyhEn2nxNK020CTyim4X/oaWY8NY9WS0u0VnUThw+VYWeaE2vhrzP9G69/
         M+Ef5PWVCDGRAXfuM3Wg54DfueU9njN79cm5S9DTzCy1SmjelFaPQDgroIlnEGtO3VvD
         /PNfnZiHMRalb6jS1QDFNxpuPZuItWBVpxnoyKM76j6bGeVJBbEWuWKCMNc8qE7nmVCn
         QO2++Q/g388OCPRgr7joLWPUgZ5seO/eXE0Uw9CdIoR117JmmOgJPQ38xMTFVnNM8ygk
         62ImmqIqVYd7TB50nm8N09Bw9qfhoY3nv/oFA+ELrJpUjVyICV9P+TM/Jv4SDNlRKJ+R
         db7w==
X-Forwarded-Encrypted: i=1; AJvYcCUqk5fz24eX48GHr5MZS4BeBVpQzhjVtetdJ3ZNzDydxrHt5HEGsXrbt554g8iGeP1ecR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY8flE7er93gIABLmQTbNMFtnJlhfczsLVph2a8fP+NymJns1p
	65sxS12qQwcoSHjJOsTyrmERVqDrqeG50qAFMOfQzBfPHKiz3/lwwvX1mHoxfoqzjG0GoVk/Q/V
	EbDa3lb4fh+dFRHT2PC7fVyoC6hczZsXQgWWMGZaB5w6G6FNiAFQD4Sw=
X-Google-Smtp-Source: AGHT+IHCxAFW40TR2VledobhdZPBqzCrJmq5KcjhkSb/VpbG1riEHP/I8gRJ9iOe/N25lNo5T9C5J2wEZkwV0Re+eq92srT/1HXt
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d12:b0:3a7:70a4:6872 with SMTP id
 e9e14a558f8ab-3a79ad203ebmr136732745ab.9.1732579227104; Mon, 25 Nov 2024
 16:00:27 -0800 (PST)
Date: Mon, 25 Nov 2024 16:00:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67450f9b.050a0220.21d33d.0004.GAE@google.com>
Subject: [syzbot] [bpf?] KASAN: vmalloc-out-of-bounds Write in push_insn_history
From: syzbot <syzbot+5ca500b6e0bdb0d11dbc@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e13ee8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b193f152f0257905
dashboard link: https://syzkaller.appspot.com/bug?extid=5ca500b6e0bdb0d11dbc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e4af736be07e/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8b23128a7c9e/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ca500b6e0bdb0d11dbc@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in push_insn_history+0x615/0x690 kernel/bpf/verifier.c:3579
Write of size 4 at addr ffffc90002db9010 by task syz.0.4094/25926

CPU: 3 UID: 0 PID: 25926 Comm: syz.0.4094 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 push_insn_history+0x615/0x690 kernel/bpf/verifier.c:3579
 do_check kernel/bpf/verifier.c:18594 [inline]
 do_check_common+0xb78/0xd540 kernel/bpf/verifier.c:21848
 do_check_main kernel/bpf/verifier.c:21939 [inline]
 bpf_check+0x77c2/0xc9b0 kernel/bpf/verifier.c:22656
 bpf_prog_load+0xe3f/0x2670 kernel/bpf/syscall.c:2947
 __sys_bpf+0x5677/0x57a0 kernel/bpf/syscall.c:5790
 __do_sys_bpf kernel/bpf/syscall.c:5897 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5895 [inline]
 __ia32_sys_bpf+0x76/0xe0 kernel/bpf/syscall.c:5895
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf740e579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f50d555c EFLAGS: 00000296 ORIG_RAX: 0000000000000165
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00000000200017c0
RDX: 0000000000000048 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90002d99000, ffffc90002dbb000) created by:
 kvrealloc_noprof+0xfc/0x150 mm/util.c:755

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880741c9e88 pfn:0x741c9
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff8880741c9e88 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102cc2(GFP_HIGHUSER|__GFP_NOWARN), pid 25926, tgid 25924 (syz.0.4094), ts 1129383943138, free_ts 1129046992178
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
 __alloc_pages_slowpath mm/page_alloc.c:4286 [inline]
 __alloc_pages_noprof+0x6a6/0x25a0 mm/page_alloc.c:4764
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 vm_area_alloc_pages mm/vmalloc.c:3589 [inline]
 __vmalloc_area_node mm/vmalloc.c:3667 [inline]
 __vmalloc_node_range_noprof+0x724/0x1530 mm/vmalloc.c:3844
 __kvmalloc_node_noprof+0x14f/0x1a0 mm/util.c:680
 kvrealloc_noprof+0xfc/0x150 mm/util.c:755
 push_insn_history+0x2ac/0x690 kernel/bpf/verifier.c:3571
 do_check kernel/bpf/verifier.c:18594 [inline]
 do_check_common+0xb78/0xd540 kernel/bpf/verifier.c:21848
 do_check_main kernel/bpf/verifier.c:21939 [inline]
 bpf_check+0x77c2/0xc9b0 kernel/bpf/verifier.c:22656
 bpf_prog_load+0xe3f/0x2670 kernel/bpf/syscall.c:2947
 __sys_bpf+0x5677/0x57a0 kernel/bpf/syscall.c:5790
 __do_sys_bpf kernel/bpf/syscall.c:5897 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5895 [inline]
 __ia32_sys_bpf+0x76/0xe0 kernel/bpf/syscall.c:5895
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
page last free pid 29 tgid 29 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0x1080 mm/page_alloc.c:2657
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0x79d/0x14d0 kernel/rcu/tree.c:2823
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 run_ksoftirqd kernel/softirq.c:943 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:935
 smpboot_thread_fn+0x661/0xa30 kernel/smpboot.c:164
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffffc90002db8f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90002db8f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90002db9000: 00 00 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                         ^
 ffffc90002db9080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90002db9100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

