Return-Path: <bpf+bounces-50243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA5AA24426
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 21:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0353A2E3B
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2C01F3D4E;
	Fri, 31 Jan 2025 20:35:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4CB1B87E9
	for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355730; cv=none; b=JYfzR3q9NunKk2qRQ/yYVZ4h9Lk0d0ESrP+wJVVJniThNBc+sGAXzntRGnwmmW9ljppvT9/Rr5z3ku4tJvr4TCTMKvvj145jgBypuFSSJCm42qtN1DVgoM3DqY+8YsDZ88UzRs479Qo8e5C5Qe+EnEOXUWzaZZMjXWC6WAEKhiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355730; c=relaxed/simple;
	bh=VBjUnlNOn+EVDiH6fRRvhesvn00/DILaUmcqLDFhfxQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OvvMVPbjPH07eVDgeUjk3lMFgagzwY5Ftgt8J6UY6WGjBmkJ3C6mLN0WuHjExlKnqnMZnPQOsbC8G12QkamS51qvY8r2UxMdh8d2Q3J2fV0s1vNtwpHkhRADcejwMiRjOUGzvt6sdxqzHDOyTcG4GDTL7uNQ/0b0CBKfudt7myw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d0203cf90cso1548115ab.2
        for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 12:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355727; x=1738960527;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZNVDCmrZGxeCizZsIi9ccPmoiK4QwS5J9i3YpJJ4eo=;
        b=VAYNAuDiGEP7RGqqMJnFukEF7eHinNMdeG7BQgZCP5j0wOpVvQkyrXJHOFH4t89vGH
         f/xtxd1hE2Vz5OqfSiCT5bphz+YKNzIBKSkuypZ0HzLvqVApq5K7sZprZnKmKLM9eVkc
         RS6vM18BGBkg2+fQyKEPjlC5OPR2QdFexNcpJDo+HpNafNMKt4pGsJApg5F3tojhVlo6
         EGJgaUctVFWuBKhAIewrgGdepx03WLA1bBIcWUTDxqabZK9ZJU6SR6MvAOvNQKPwRjMs
         Dyt88QfgThkgd7EJ02YegywoG8SveV/OFzPDP99tiY0KabC2Q8sJ9gtuigXOUvhvAi1Y
         twSw==
X-Forwarded-Encrypted: i=1; AJvYcCXYXYGvauQApes8p4On+f9YjgUOKY3kgSeFV3etoel1IjHR04qS3jRMwDSdSkRpqKR+6/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCaY5njMrkbgO/TrIHXo47OWwFK5+2fKLxi0mgM6q0hh7V5e5h
	dJHneJsaXJj5FE1zsRhCOMpBdkKOjbrjaPKh5E1yU/lSjidzpJ1zSeQhjOeW69HI6zRG+bUM91q
	ATXwtPCXsDxZziCX9GvGwsPDwwAxGQ5ACRonHABI8IDiQCScSY7OiEPA=
X-Google-Smtp-Source: AGHT+IEnLQEJLwGfE0k8yKwmacHXPCP7tD6bVQ/dZNFsVw/XyTIj7e3S1Q34fq56I/EN9QNsN3MhWuChyAq0ewt5L9tQY/ga7Nrr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caa:b0:3cf:f88b:b51a with SMTP id
 e9e14a558f8ab-3cffe3a6ed0mr126561415ab.2.1738355727398; Fri, 31 Jan 2025
 12:35:27 -0800 (PST)
Date: Fri, 31 Jan 2025 12:35:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679d340f.050a0220.163cdc.000e.GAE@google.com>
Subject: [syzbot] [usb?] general protection fault in count_matching_names
From: syzbot <syzbot+1aa04f53a21b8994067f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, martin.lau@linux.dev, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1523f6b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d033b14aeef39158
dashboard link: https://syzkaller.appspot.com/bug?extid=1aa04f53a21b8994067f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1323f6b0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-69e858e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a53b888c1f3f/vmlinux-69e858e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6b5e17edafc0/bzImage-69e858e0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6e8041af9503/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1aa04f53a21b8994067f@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000060: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000300-0x0000000000000307]
CPU: 0 UID: 0 PID: 6160 Comm: syz.3.224 Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:strcmp+0x42/0xa0 lib/string.c:277
Code: 00 fc ff df 31 db 49 8d 3c 1c 48 89 f8 48 c1 e8 03 42 0f b6 04 38 84 c0 75 29 41 0f b6 2c 1c 49 8d 3c 1e 48 89 f8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 20 41 3a 2c 1e 75 2a 48 ff c3 40 84 ed 75
RSP: 0018:ffffc900000077f8 EFLAGS: 00010006
RAX: 0000000000000060 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000001 RSI: 0000000000000300 RDI: 0000000000000300
RBP: 0000000000000026 R08: ffffffff942f696f R09: 1ffffffff285ed2d
R10: dffffc0000000000 R11: fffffbfff285ed2e R12: ffffffff8c608700
R13: ffffffff93cd6c88 R14: 0000000000000300 R15: dffffc0000000000
FS:  00007f97c077e6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1e6ddd1000 CR3: 0000000058d3a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 count_matching_names+0xfa/0x1c0 kernel/locking/lockdep.c:877
 register_lock_class+0x450/0x980 kernel/locking/lockdep.c:1342
 __lock_acquire+0xf3/0x2100 kernel/locking/lockdep.c:5103
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 call_timer_fn+0xdd/0x650 kernel/time/timer.c:1786
 expire_timers kernel/time/timer.c:1835 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x695/0x8e0 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2445
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5855
Code: 2b 00 74 08 4c 89 f7 e8 8a 2b 8b 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc9000ce9f040 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff920019d3e14 RCX: ffff8880347e0ae8
RDX: dffffc0000000000 RSI: ffffffff8c0ab8e0 RDI: ffffffff8c608060
RBP: ffffc9000ce9f190 R08: ffffffff942f6847 R09: 1ffffffff285ed08
R10: dffffc0000000000 R11: fffffbfff285ed09 R12: 1ffff920019d3e10
R13: dffffc0000000000 R14: ffffc9000ce9f0a0 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 is_bpf_text_address+0x46/0x2a0 kernel/bpf/core.c:772
 kernel_text_address+0xa7/0xe0 kernel/extable.c:125
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x4d/0x90 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0xfd/0x150 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xe40/0x18b0 mm/page_alloc.c:2707
 folios_put_refs+0x76c/0x860 mm/swap.c:994
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x593/0x1820 mm/shmem.c:1112
 shmem_truncate_range mm/shmem.c:1224 [inline]
 shmem_evict_inode+0x29b/0xa80 mm/shmem.c:1352
 evict+0x4e8/0x9a0 fs/inode.c:796
 __dentry_kill+0x20d/0x630 fs/dcache.c:643
 dput+0x19f/0x2b0 fs/dcache.c:885
 __fput+0x60b/0x9f0 fs/file_table.c:458
 __do_sys_close fs/open.c:1579 [inline]
 __se_sys_close fs/open.c:1564 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1564
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f97bf98ba0a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 43 91 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 a3 91 02 00 8b 44 24
RSP: 002b:00007f97c077de00 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f97bf98ba0a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000005939
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 00007f97c077def0 R14: 00007f97c077deb0 R15: 00007f97b6600000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strcmp+0x42/0xa0 lib/string.c:277
Code: 00 fc ff df 31 db 49 8d 3c 1c 48 89 f8 48 c1 e8 03 42 0f b6 04 38 84 c0 75 29 41 0f b6 2c 1c 49 8d 3c 1e 48 89 f8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 20 41 3a 2c 1e 75 2a 48 ff c3 40 84 ed 75
RSP: 0018:ffffc900000077f8 EFLAGS: 00010006
RAX: 0000000000000060 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000001 RSI: 0000000000000300 RDI: 0000000000000300
RBP: 0000000000000026 R08: ffffffff942f696f R09: 1ffffffff285ed2d
R10: dffffc0000000000 R11: fffffbfff285ed2e R12: ffffffff8c608700
R13: ffffffff93cd6c88 R14: 0000000000000300 R15: dffffc0000000000
FS:  00007f97c077e6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1e6ddd1000 CR3: 0000000058d3a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	df 31                	fbstp  (%rcx)
   2:	db 49 8d             	fisttpl -0x73(%rcx)
   5:	3c 1c                	cmp    $0x1c,%al
   7:	48 89 f8             	mov    %rdi,%rax
   a:	48 c1 e8 03          	shr    $0x3,%rax
   e:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax
  13:	84 c0                	test   %al,%al
  15:	75 29                	jne    0x40
  17:	41 0f b6 2c 1c       	movzbl (%r12,%rbx,1),%ebp
  1c:	49 8d 3c 1e          	lea    (%r14,%rbx,1),%rdi
  20:	48 89 f8             	mov    %rdi,%rax
  23:	48 c1 e8 03          	shr    $0x3,%rax
* 27:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2c:	84 c0                	test   %al,%al
  2e:	75 20                	jne    0x50
  30:	41 3a 2c 1e          	cmp    (%r14,%rbx,1),%bpl
  34:	75 2a                	jne    0x60
  36:	48 ff c3             	inc    %rbx
  39:	40 84 ed             	test   %bpl,%bpl
  3c:	75                   	.byte 0x75


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

