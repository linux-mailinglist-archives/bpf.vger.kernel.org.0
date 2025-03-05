Return-Path: <bpf+bounces-53292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64395A4F6B6
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 06:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2C0188C6BF
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 05:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748AD1D7E42;
	Wed,  5 Mar 2025 05:54:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C419C55E
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741154068; cv=none; b=nLnPr/v3Cnj5L71SbJi1u/SBBq6Hdjyy6lGyWe0qb36JKQtvB4b2Y2KaVI9AnJzVP4ADJxttMyBe0TJTN3oNg3rGAvHbXKQjZHilegcVL4BW6xhAnEYH/E3GcIAfLqAxdfF0esy4QYvi1/lczGyPzn/3zrbTfGYQA+MTg3uZO6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741154068; c=relaxed/simple;
	bh=LaAntkE8kADInbFez1tYr4UgDOC9fiPwbJFcVkbTmVk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cYRkbcEeDCCeLIoSkDjCOulaDDLx5Qxp7rYCfIkQGYH+EHKFSkRXMAvMVIVS+xfx7k+A4qY2HOJOQgiQueSf7xTRNPy9ogDlZPw9wTtWOO4/amoXxZkZcoa027JsYpCB/j0l1iynzA17gZFA5f1z0XbiFAKaz9XJ6oRhy5DDdBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so145899425ab.0
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 21:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741154065; x=1741758865;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTa6ANGjulTOYXkBQuLvCQ5G8ZTr11Jh5hb4hDDIvvw=;
        b=Ri5Tf1Pq+eU2E6R0810erPwiBwyiFOWcj4d2KeyPYOI2z1lwLd5XgOORYS6WuIpW5u
         zjYgUEjG2biByK0OGPIX53rQ0R0n0KMOxKa+3k08Pp/eFQHNtjj5tQ41eMa4CNHSbNFl
         ci0VLSsDRJLIeyRqu16qqzO47e/r627xUk7NDQqaZKJV2GtLYNV78qsyxU2AEJB55YFv
         lHgZnxBmEJure8ItC63oBs+gHlFFDgpnzvxKZjEDXEXKwQD3S7cv+vb3FpWXb/Um5Jyx
         r5ms0+1ylmQBVpRwGhzeGIKCcwSSvgSZplsm2w7P0B5ZGoEEVyb3F6ZKOlfh4IVF3XMW
         Xg6A==
X-Forwarded-Encrypted: i=1; AJvYcCX5Wfc43YlPOYZsuiCceEEXNCzmlOlGzQJ9XbhyxCvHLn4SZf46bFHyKbW6/Qaa6mVHn8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCJJU+p530zKeozLVxcSXFqsaxpbdwinFRAfydCLedxnSLnY5o
	MV1C7BEmLTL/pcylVkw5/WQ0oUoUDwvNmRRwUwRPAuI2OLQ7r8ulPWy8gD6PU+LMO59j0e+ouqM
	gDe+ymYwIN061G4+QYh0DQuCvtIOcibkNna/ZO5ov4Gctnr8vzCFvkFQ=
X-Google-Smtp-Source: AGHT+IHsTwIzki3hN8M1gz3aj4zL7mqjiNOOW2ftwWjjXxaIYdDjaMmDaEeJdvdAudBjJ9/Lwp7LcIF3wZlkzjCobtZMqm6aOlJi
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2196:b0:3d3:f6ee:cc4c with SMTP id
 e9e14a558f8ab-3d42b75000cmr24850835ab.0.1741154065560; Tue, 04 Mar 2025
 21:54:25 -0800 (PST)
Date: Tue, 04 Mar 2025 21:54:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c7e711.050a0220.15b4b9.001f.GAE@google.com>
Subject: [syzbot] [bpf?] [bcachefs?] BUG: unable to handle kernel paging
 request in handle_softirqs
From: syzbot <syzbot+c32100a0bb8cae0c3dde@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kent.overstreet@linux.dev, 
	kpsingh@kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    276f98efb64a Merge tag 'block-6.14-20250228' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16614864580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b4c41bdaeea1964
dashboard link: https://syzkaller.appspot.com/bug?extid=c32100a0bb8cae0c3dde
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11614864580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-276f98ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5a036150d62e/vmlinux-276f98ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0b6c8e5972f/bzImage-276f98ef.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/65413c368879/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c32100a0bb8cae0c3dde@syzkaller.appspotmail.com

kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
BUG: unable to handle page fault for address: ffff8880316c0000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0011) - permissions violation
PGD 1ac01067 P4D 1ac01067 PUD 1ac02067 PMD 1c3d0063 PTE 80000000316c0163
Oops: Oops: 0011 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 7082 Comm: syz.2.568 Not tainted 6.14.0-rc4-syzkaller-00212-g276f98efb64a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:0xffff8880316c0000
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 20 6e 31 80 88 ff ff 00 40 eb 30 80 88 ff ff 08 00 00 00 0c 00
RSP: 0018:ffffc90000007bd8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 1ffff1100840de14 RCX: ffff888000a5af28
RDX: dffffc0000000000 RSI: ffffffff8c2ab700 RDI: ffff88804206f098
RBP: ffffc90000007e10 R08: ffffffff9454985f R09: 1ffffffff28a930b
R10: dffffc0000000000 R11: ffff8880316c0000 R12: ffffffff81a8d7d7
R13: ffff88804206f0a0 R14: ffff8880316c0000 R15: ffff88804206f098
FS:  00007ff346e2f6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880316c0000 CR3: 0000000042300000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
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
Code: 2b 00 74 08 4c 89 f7 e8 3a 45 8c 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc9000260f040 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff920004c1e14 RCX: ffff888000a5af28
RDX: dffffc0000000000 RSI: ffffffff8c2ab700 RDI: ffffffff8c80f060
RBP: ffffc9000260f190 R08: ffffffff94549847 R09: 1ffffffff28a9308
R10: dffffc0000000000 R11: fffffbfff28a9309 R12: 1ffff920004c1e10
R13: dffffc0000000000 R14: ffffc9000260f0a0 R15: 0000000000000246
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
 __fput+0x60b/0x9f0 fs/file_table.c:472
 __do_sys_close fs/open.c:1580 [inline]
 __se_sys_close fs/open.c:1565 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1565
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff345f8bdca
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 43 91 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 a3 91 02 00 8b 44 24
RSP: 002b:00007ff346e2ee00 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007ff345f8bdca
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000002 R08: 0000000000000000 R09: 000000000000590c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 00007ff346e2eef0 R14: 00007ff346e2eeb0 R15: 00007ff33cc00000
 </TASK>
Modules linked in:
CR2: ffff8880316c0000
---[ end trace 0000000000000000 ]---
RIP: 0010:0xffff8880316c0000
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 20 6e 31 80 88 ff ff 00 40 eb 30 80 88 ff ff 08 00 00 00 0c 00
RSP: 0018:ffffc90000007bd8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 1ffff1100840de14 RCX: ffff888000a5af28
RDX: dffffc0000000000 RSI: ffffffff8c2ab700 RDI: ffff88804206f098
RBP: ffffc90000007e10 R08: ffffffff9454985f R09: 1ffffffff28a930b
R10: dffffc0000000000 R11: ffff8880316c0000 R12: ffffffff81a8d7d7
R13: ffff88804206f0a0 R14: ffff8880316c0000 R15: ffff88804206f098
FS:  00007ff346e2f6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880316c0000 CR3: 0000000042300000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
  28:	00 00                	add    %al,(%rax)
* 2a:	00 20                	add    %ah,(%rax) <-- trapping instruction
  2c:	6e                   	outsb  %ds:(%rsi),(%dx)
  2d:	31 80 88 ff ff 00    	xor    %eax,0xffff88(%rax)
  33:	40 eb 30             	rex jmp 0x66
  36:	80 88 ff ff 08 00 00 	orb    $0x0,0x8ffff(%rax)
  3d:	00 0c 00             	add    %cl,(%rax,%rax,1)


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

