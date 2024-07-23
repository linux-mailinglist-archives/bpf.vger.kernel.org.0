Return-Path: <bpf+bounces-35431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA2B93A88F
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 23:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB031C22806
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 21:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192DC145A1A;
	Tue, 23 Jul 2024 21:10:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D4C143C5B
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721769028; cv=none; b=XlVK4pXWF3xvw1mCTWQ6VOKfJQvGZSeoCo7PtrmnSFc+ssfzGwOAMcwPb5W+RVzexl/QqNWxlSuaiI2SrUv0t2rcHxT5RYa6l5gf99/U6pmk6rNODiA1uigqHh5KfzUMfX5wkTvsFJ0pEX2h5UNfW6QVCrNvHwZQEhaDBr6oKw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721769028; c=relaxed/simple;
	bh=1uuBevEFlb1Qjw0yjLNrYioqx3PJI0Ka6S27LBl1NoE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NYRhGex0OSu06DF/8XPJgbuvjkO6DeKtYVh2bda7ugYuY9fweUpkxtSThet4KS8mOl/Hn6KfZygMVG7jnQwvvCQUXzLjbG9Z4+wXM/9g6kKyTbxZiLTiNkPwho/1nFOhpUawDmlrPMylnpgxvh1/CIdhKpFV5QTo+2abbAnt43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39a17513a7eso5128185ab.1
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 14:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721769026; x=1722373826;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ob6QkeWrPJRGWmCCA3yd7IryHXaVPhd7BKwi6ydERuw=;
        b=fDfDwlmhGxGxcO5lwlxYV/fPkO7VLXBnDhh86pkSREYv20Zo6IttSh0hp+CKO5/4F6
         OLplcdPTtSiRQx2CTn/zxSXC80DCcpyD7snw/gduidZFXpIg3NjSXC7Z59dofAp/77jA
         cN8XRIgbJUq7h4nPxdX+v4f76CyejmCrmNITmVwodxUyXbs8oHKN4MmskWofJwP5pOZr
         Br16D0iSN+0GyYPb2ySQAbLB4tXjBg3Cw+mAVyXMOQ79nfQubYQJMFYPNf8Yl/RK86S8
         +XhbQpv/pjGxUMaL/U6l/WYJ3Jr3VOMV66KZNm8GdcZhoeJHoC4sYTcWH5ZbGN9+AfcV
         Xh8g==
X-Forwarded-Encrypted: i=1; AJvYcCXVV9D4TDP+V454fd+I5ALDDZOXVxe6DxkPk7lsDRecxikWEYt41YZ/fPYFk+QOLcVRjrRyQVDxEehRrYPO2WYmvIkm
X-Gm-Message-State: AOJu0Yw+3hIpGeLYQ1sQF2EGcYo4JkTtzDucHkPVzCR3UmMRU7Q45MLQ
	ylBBx+LbADiVWtz5BPGYy2gXj8mT0CvTxby56RHFXLZW71lb/k45NKA5gi9UkQ1UdKoXO8g64VM
	0dni1NRo3mT1W4Ub2gDafW8NUulFSBOGq05DM6em1TnI/EZJ6/oekbzo=
X-Google-Smtp-Source: AGHT+IG2x2y923Rwf8dwevBLTzWh7kz0Bi9UufTaKrczgwKPPzHZn9HfPXacPrIOQLpOleXTkcFThnTSN1dXUcbLat6wYaEHrTtB
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b47:b0:39a:14c9:3f80 with SMTP id
 e9e14a558f8ab-39a194e53efmr157485ab.5.1721769026141; Tue, 23 Jul 2024
 14:10:26 -0700 (PDT)
Date: Tue, 23 Jul 2024 14:10:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003054f4061df097f5@google.com>
Subject: [syzbot] [bpf?] [net?] general protection fault in bq_flush_to_queue
From: syzbot <syzbot+3c2b6d5d4bec3b904933@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    28bbe4ea686a Merge tag 'i2c-for-6.11-rc1-second-batch' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ab4e19980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d240b438cabdc8e
dashboard link: https://syzkaller.appspot.com/bug?extid=3c2b6d5d4bec3b904933
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a6bb49754efa/disk-28bbe4ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/68010035620f/vmlinux-28bbe4ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/739b01ffb241/bzImage-28bbe4ea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c2b6d5d4bec3b904933@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 9319 Comm: syz.4.1011 Not tainted 6.10.0-syzkaller-12084-g28bbe4ea686a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:bq_flush_to_queue+0x44/0x610 kernel/bpf/cpumap.c:675
Code: df e8 40 d8 d6 ff 49 8d 5e 50 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 f6 e8 3a 00 48 8b 2b 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 1d 05 00 00 44 8b 65 00 4d 8d 6e 58 4c
RSP: 0018:ffffc90000a18a80 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880789a4290 RCX: ffff88801ab78000
RDX: 0000000000000100 RSI: 0000000000000010 RDI: ffff8880789a4240
RBP: 0000000000000000 R08: ffffffff896117da R09: 1ffffffff1f5cf4d
R10: dffffc0000000000 R11: fffffbfff1f5cf4e R12: 0000000000000001
R13: ffffc9000d1af820 R14: ffff8880789a4240 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f20312356b8 CR3: 0000000079b12000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __cpu_map_flush+0x5d/0xd0 kernel/bpf/cpumap.c:767
 xdp_do_check_flushed+0x136/0x240 net/core/filter.c:4304
 __napi_poll+0xe4/0x490 net/core/dev.c:6774
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 common_interrupt+0xaa/0xd0 arch/x86/kernel/irq.c:278
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:rcu_preempt_read_enter kernel/rcu/tree_plugin.h:389 [inline]
RIP: 0010:__rcu_read_lock+0x30/0xb0 kernel/rcu/tree_plugin.h:412
Code: 57 41 56 53 49 be 00 00 00 00 00 fc ff df 65 4c 8b 3c 25 00 d7 03 00 49 81 c7 44 04 00 00 4c 89 fb 48 c1 eb 03 42 0f b6 04 33 <84> c0 75 35 41 8b 2f ff c5 42 0f b6 04 33 84 c0 75 3e 41 89 2f 42
RSP: 0018:ffffc9000d1af6b0 EFLAGS: 00000a07
RAX: 0000000000000000 RBX: 1ffff1100356f088 RCX: ffffffff81701eba
RDX: dffffc0000000000 RSI: ffffffff8bcad5a0 RDI: ffff88801f942780
RBP: ffff88813fffa000 R08: ffffffff92fcd837 R09: 1ffffffff25f9b06
R10: dffffc0000000000 R11: fffffbfff25f9b07 R12: 1ffff11002bddf93
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88801ab78444
 rcu_read_lock include/linux/rcupdate.h:836 [inline]
 percpu_ref_put_many include/linux/percpu-refcount.h:330 [inline]
 percpu_ref_put+0x12/0x180 include/linux/percpu-refcount.h:351
 obj_cgroup_put include/linux/memcontrol.h:802 [inline]
 __memcg_slab_free_hook+0xa7/0x310 mm/memcontrol.c:3050
 memcg_slab_free_hook mm/slub.c:2186 [inline]
 slab_free mm/slub.c:4470 [inline]
 kmem_cache_free+0x1cf/0x350 mm/slub.c:4548
 vma_lock_free kernel/fork.c:457 [inline]
 __vm_area_free+0xe0/0x110 kernel/fork.c:513
 remove_vma mm/mmap.c:187 [inline]
 exit_mmap+0x645/0xc80 mm/mmap.c:3406
 __mmput+0x115/0x380 kernel/fork.c:1345
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x27f0 kernel/exit.c:869
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 get_signal+0x1695/0x1730 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd3c9775f19
Code: Unable to access opcode bytes at 0x7fd3c9775eef.
RSP: 002b:00007fd3ca6110f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fd3c9905f68 RCX: 00007fd3c9775f19
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fd3c9905f68
RBP: 00007fd3c9905f60 R08: 00007fd3ca6116c0 R09: 00007fd3ca6116c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd3c9905f6c
R13: 000000000000000b R14: 00007ffc73d12a30 R15: 00007ffc73d12b18
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bq_flush_to_queue+0x44/0x610 kernel/bpf/cpumap.c:675
Code: df e8 40 d8 d6 ff 49 8d 5e 50 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 f6 e8 3a 00 48 8b 2b 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 1d 05 00 00 44 8b 65 00 4d 8d 6e 58 4c
RSP: 0018:ffffc90000a18a80 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880789a4290 RCX: ffff88801ab78000
RDX: 0000000000000100 RSI: 0000000000000010 RDI: ffff8880789a4240
RBP: 0000000000000000 R08: ffffffff896117da R09: 1ffffffff1f5cf4d
R10: dffffc0000000000 R11: fffffbfff1f5cf4e R12: 0000000000000001
R13: ffffc9000d1af820 R14: ffff8880789a4240 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f20312356b8 CR3: 0000000079b12000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	df e8                	fucomip %st(0),%st
   2:	40 d8 d6             	rex fcom %st(6)
   5:	ff 49 8d             	decl   -0x73(%rcx)
   8:	5e                   	pop    %rsi
   9:	50                   	push   %rax
   a:	48 89 d8             	mov    %rbx,%rax
   d:	48 c1 e8 03          	shr    $0x3,%rax
  11:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  16:	74 08                	je     0x20
  18:	48 89 df             	mov    %rbx,%rdi
  1b:	e8 f6 e8 3a 00       	call   0x3ae916
  20:	48 8b 2b             	mov    (%rbx),%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 1d 05 00 00    	jne    0x554
  37:	44 8b 65 00          	mov    0x0(%rbp),%r12d
  3b:	4d 8d 6e 58          	lea    0x58(%r14),%r13
  3f:	4c                   	rex.WR


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

