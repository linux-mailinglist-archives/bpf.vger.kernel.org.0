Return-Path: <bpf+bounces-74269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7CEC50911
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 05:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51B944ECAA9
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 04:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E405C23E330;
	Wed, 12 Nov 2025 04:52:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1090257835
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 04:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762923149; cv=none; b=JiFUDfeP/Stda9Ub2olKDS4rcnqwH3ojIl/edO3eu5FrDuv3gqcvN8GNVkd434EuwjLhk8tnuTpHP2FV+gxg8cMxYzb1+zdPCXQ7RO1aKyCYErpyF6bfTTlxaLzCuncwKpCDqtnHy3ecIIb41cmPGJahesDJAgvfBwEjcppnZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762923149; c=relaxed/simple;
	bh=CIvLkOUS047TucL7cgNJmviXjqebQR1vjTOiVoJgcGA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Vmd+UTCjIwz8g3BvfespyG62Pzr8c+onwu0DXVH3PkvhfzPQEHcqb0PDeNsbS4quXT63UDjv9RNDchOUi5m2CznBUPOWpXquAADBbwDHQByIBJHGyeIP61DEKpHzZDyoMIDiBrdgSOldmAv4BbldtXyo/esGSL2FIAD1eWK8koA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-43377268125so6041965ab.0
        for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 20:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762923147; x=1763527947;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xR/S0akTM9IizGbyH/pcTSsfCiAbNA5aO/SzN0S+qc=;
        b=v6/XFfD8SrpfZBYiTkeOHBnrBeNQGO7sBa3dYyOfE3QQPRgb3byTJpVMdflJ7dzY6P
         6QOgYu6IK4s7WzPhw5c2Z0DEVXTOgEMw2UMLfA9ZorCNhK1fdeXEauwMnxGfY3CHjh7M
         89t3rUwZqXMYNWFVy3327T6miCS3IZMe0XTsYbpadp7xCHpaze1rKyDNsyXFsOrfNOoz
         JG2xHOZ8FKc6k4wTL1hen+4528GCqvdQHnjfZqCaTPpI4KVoKoJ/mneDHMbgV1SgTblf
         dV21zI7DuBik76L5r8Lamevms9JuDcuGpe4k6kamCoqqi0jX6hTMzKvILtKMHwdJpBju
         ESMw==
X-Forwarded-Encrypted: i=1; AJvYcCUKXTTP63fJXH9+J62r+97ABPPd680z3C5O6u4eM+88JTjniXh5gprKWKhbWhQ3HZo9hSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOfhmMh5gIntKaxlUsN4E9PaGWkiXYDxzIBavGAPsh3XRO+ncb
	NA7ruHiPy2HCYMOKOJEtlqqmjyaxtZ6P+n9pcI5Pr9XULuuA/AxtyneIgHz6i6qSySK2rybkYRs
	dEfiLTAGi0i3qH/5oHcx2pYVJSPQpcVOzXUzZuSN6vDcDCK1vs/PxuxBAUck=
X-Google-Smtp-Source: AGHT+IEalNLm4nKk8fLi4y0xYX+5Nao4o3HK0geVhuKlrQfqUMB7hx94C8r2EruYYup9yM47XvRjz6EN4BkpAlS+Fzf0/eO5s8G7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcc:b0:433:7a2f:a40a with SMTP id
 e9e14a558f8ab-43473cff396mr21170735ab.4.1762923147120; Tue, 11 Nov 2025
 20:52:27 -0800 (PST)
Date: Tue, 11 Nov 2025 20:52:27 -0800
In-Reply-To: <68af39ae.a70a0220.3cafd4.002c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6914128b.050a0220.417c2.0004.GAE@google.com>
Subject: Re: [syzbot] [hams?] WARNING: ODEBUG bug in handle_softirqs
From: syzbot <syzbot+60db000b8468baeddbb1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2666975a8905 Add linux-next specific files for 20251111
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13748212580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e82ba9dc816af74c
dashboard link: https://syzkaller.appspot.com/bug?extid=60db000b8468baeddbb1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10646b42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133eec12580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/26ac789d9bdd/disk-2666975a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fabfe7978a23/vmlinux-2666975a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/82f010d50b37/bzImage-2666975a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60db000b8468baeddbb1@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff888028ee8090 object type: timer_list hint: rose_t0timer_expiry+0x0/0x350 net/rose/rose_link.c:-1
WARNING: lib/debugobjects.c:615 at debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612, CPU#1: syz.2.1147/9544
Modules linked in:
CPU: 1 UID: 0 PID: 9544 Comm: syz.2.1147 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Code: 4c 89 ff e8 d7 19 86 fd 4d 8b 0f 48 c7 c7 80 1b e1 8b 48 8b 34 24 4c 89 ea 89 e9 4d 89 f0 41 54 e8 0a 38 e2 fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 47 22 1e 0b 48 83 c4 08 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc90000a08a00 EFLAGS: 00010296
RAX: cfc2b002eab41900 RBX: dffffc0000000000 RCX: ffff888031311e80
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1c3a744 R12: ffffffff8a5327d0
R13: ffffffff8be11d00 R14: ffff888028ee8090 R15: ffffffff8b8cf8e0
FS:  00007fda22dbb6c0(0000) GS:ffff888125b82000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000000d000 CR3: 0000000078a42000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
 debug_check_no_obj_freed+0x3a2/0x470 lib/debugobjects.c:1129
 slab_free_hook mm/slub.c:2470 [inline]
 slab_free mm/slub.c:6661 [inline]
 kfree+0x10c/0x6e0 mm/slub.c:6869
 rose_neigh_put include/net/rose.h:166 [inline]
 rose_timer_expiry+0x4cb/0x600 net/rose/rose_timer.c:183
 call_timer_fn+0x16e/0x600 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
 handle_softirqs+0x27d/0x880 kernel/softirq.c:626
 __do_softirq kernel/softirq.c:660 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:727
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:743
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1055 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1055
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lock_release+0x2ac/0x3d0 kernel/locking/lockdep.c:5893
Code: 51 48 c7 44 24 20 00 00 00 00 9c 8f 44 24 20 f7 44 24 20 00 02 00 00 75 56 f7 c3 00 02 00 00 74 01 fb 65 48 8b 05 64 98 1b 11 <48> 3b 44 24 28 0f 85 8b 00 00 00 48 83 c4 30 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc90004e8f918 EFLAGS: 00000206
RAX: cfc2b002eab41900 RBX: 0000000000000283 RCX: cfc2b002eab41900
RDX: 0000000000000000 RSI: ffffffff8dc71e5c RDI: ffffffff8be111e0
RBP: ffff8880313129b0 R08: 0000000000000000 R09: ffffffff820eec00
R10: dffffc0000000000 R11: fffffbfff1f7eeef R12: 0000000000000000
R13: 0000000000000000 R14: ffff888034a18ca0 R15: ffff888031311e80
 _inline_copy_from_user include/linux/uaccess.h:169 [inline]
 _copy_from_user+0x28/0xb0 lib/usercopy.c:18
 copy_from_user include/linux/uaccess.h:219 [inline]
 snd_rawmidi_kernel_write1+0x3ab/0x650 sound/core/rawmidi.c:1560
 snd_rawmidi_write+0x5a8/0xbc0 sound/core/rawmidi.c:1629
 do_loop_readv_writev fs/read_write.c:850 [inline]
 vfs_writev+0x4b6/0x960 fs/read_write.c:1059
 do_writev+0x14d/0x2d0 fs/read_write.c:1103
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fda21f8f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fda22dbb038 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007fda221e5fa0 RCX: 00007fda21f8f6c9
RDX: 0000000000000002 RSI: 0000200000000840 RDI: 0000000000000004
RBP: 00007fda22011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fda221e6038 R14: 00007fda221e5fa0 R15: 00007ffd404da6b8
 </TASK>
----------------
Code disassembly (best guess):
   0:	51                   	push   %rcx
   1:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   8:	00 00
   a:	9c                   	pushf
   b:	8f 44 24 20          	pop    0x20(%rsp)
   f:	f7 44 24 20 00 02 00 	testl  $0x200,0x20(%rsp)
  16:	00
  17:	75 56                	jne    0x6f
  19:	f7 c3 00 02 00 00    	test   $0x200,%ebx
  1f:	74 01                	je     0x22
  21:	fb                   	sti
  22:	65 48 8b 05 64 98 1b 	mov    %gs:0x111b9864(%rip),%rax        # 0x111b988e
  29:	11
* 2a:	48 3b 44 24 28       	cmp    0x28(%rsp),%rax <-- trapping instruction
  2f:	0f 85 8b 00 00 00    	jne    0xc0
  35:	48 83 c4 30          	add    $0x30,%rsp
  39:	5b                   	pop    %rbx
  3a:	41 5c                	pop    %r12
  3c:	41 5d                	pop    %r13
  3e:	41 5e                	pop    %r14


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

