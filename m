Return-Path: <bpf+bounces-65009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE968B1A828
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 18:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516761890DF8
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 16:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E1228A707;
	Mon,  4 Aug 2025 16:50:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACDE286439
	for <bpf@vger.kernel.org>; Mon,  4 Aug 2025 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326233; cv=none; b=SIz/0B5qQgFOG9kp6D/s9n/L1bLeG8vE22ybWnFOIAxDy2HPLxox2DG7E1Z0FF6bzoFT/IhDbFEYGyeGTePkHBEiZaOhYDOjL9eWf/tN6EjHaBsml4tSLksjuiMeFL7z7psDi6cv+LqidRFRzkTcPnPl9JKscv19ret7MVtViMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326233; c=relaxed/simple;
	bh=kK0pAZEQ3UTDnUPphllVs8Qqcw43r7Oswt4hrdkA9rY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JFB3w4y7RF3JXVVvbnB3pbQJTmFjsEGhZzWg9keVY3gS2wvBoUG0rVxbgTJNuxB6HpoxpQoFOEKBBBB3Cc0w6HEt9zChvmSMF9Av5J3VSSItQ8A11Ta+0/z1pACf+DTERYwDeipVkJ2dbOB26Z6RyKpn0lxnHNE4cjhd9q2h9F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e3fe1d77ccso31384405ab.2
        for <bpf@vger.kernel.org>; Mon, 04 Aug 2025 09:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754326230; x=1754931030;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fagjy2iLto/pnsl8DNKQe4B2WHfyVOXCDXwDQMZ0quQ=;
        b=u936/tPjZA2xhRfr+A45NqCLaFFhCCjcLRf0UbXRwomSNfBCkbxekuoS/VqikU4XBy
         RMp0z4ouXY7KLR271RRYTO/KJrGDgRkew7bAAFuwozWfKRyG9F7B7YJTkVlbrj0eGNuq
         q2QtwH8z3/iboWt/zxkdDlBObD9owcR9EtIufpFSYxgrZGIwoqUJ8ycoMrithve26hcw
         k2LnhPjyWDo5j9RaJ47G0+VK3FhA5MClvMV4s9vrxYLsnyTAhFV5jO8KvJSMZYpDbcZW
         V3cpJzCsjHGqa3nha3q0V9Q364SmBfebbewGR9wRwhHoc5gTU+5ywsdztIwMKEJePxUs
         ydOA==
X-Forwarded-Encrypted: i=1; AJvYcCXkxHYwY7ePEk+dAwdkYLrsRBdDeOoJUqPdmr8YSMWxap39EQohu4rVjsm99vhiBtUr3hA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4yrnY8/rB7EzVseCOM7Tbh4C4ROfYevRS+z1R+8a+cA4xFdag
	c7DXQ8EILnTX2PNLhACGhBLQR5G/VxTxUzHVs55netiOERRrfl4IxBqmZ/aKnsX4gwQ+zI6LwSA
	KTPcVxa6XsC4kFvxxYfEnk7zv/5sP5IZ3ot9H82LXrOi9gsgAnXdQMuVmAy8=
X-Google-Smtp-Source: AGHT+IFIhmNbFt0lmxEGAmQHdR0pjiegiXE6hRN7V8igjGNkj/roFw/kYULydhUwmZa1fRnvEO0KAi4rfFVJOgjGTTLbdhJBUSXG
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:3dc:7f3b:acb1 with SMTP id
 e9e14a558f8ab-3e41618be7dmr155298785ab.13.1754326230187; Mon, 04 Aug 2025
 09:50:30 -0700 (PDT)
Date: Mon, 04 Aug 2025 09:50:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6890e4d6.050a0220.7f033.000e.GAE@google.com>
Subject: [syzbot] [trace?] [bpf?] possible deadlock in down_trylock (3)
From: syzbot <syzbot+c3740bc819eb55460ec3@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    84b92a499e7e Add linux-next specific files for 20250731
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11065aa2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b335f01a07f73eac
dashboard link: https://syzkaller.appspot.com/bug?extid=c3740bc819eb55460ec3
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14167834580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f27cf0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/97d9ce461c85/disk-84b92a49.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0ca812ed76e7/vmlinux-84b92a49.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0959d28a047f/bzImage-84b92a49.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c3740bc819eb55460ec3@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name fail_usercopy, interval 1, probability 0, space 0, times 0
============================================
WARNING: possible recursive locking detected
6.16.0-next-20250731-syzkaller #0 Not tainted
--------------------------------------------
syz.3.22/6137 is trying to acquire lock:
ffffffff8e12e278 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x20/0xb0 kernel/locking/semaphore.c:176

but task is already holding lock:
ffffffff8e12e278 ((console_sem).lock){-...}-{2:2}, at: down+0x39/0xd0 kernel/locking/semaphore.c:96

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock((console_sem).lock);
  lock((console_sem).lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.3.22/6137:
 #0: ffffffff8e12e278 ((console_sem).lock){-...}-{2:2}, at: down+0x39/0xd0 kernel/locking/semaphore.c:96
 #1: ffffffff8e139f20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8e139f20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8e139f20 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2256 [inline]
 #1: ffffffff8e139f20 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x186/0x4b0 kernel/trace/bpf_trace.c:2298

stack backtrace:
CPU: 0 UID: 0 PID: 6137 Comm: syz.3.22 Not tainted 6.16.0-next-20250731-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_deadlock_bug+0x28b/0x2a0 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain+0x1a3f/0x2140 kernel/locking/lockdep.c:3895
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
 down_trylock+0x20/0xb0 kernel/locking/semaphore.c:176
 __down_trylock_console_sem+0xd0/0x1e0 kernel/printk/printk.c:326
 console_trylock kernel/printk/printk.c:2868 [inline]
 console_trylock_spinning kernel/printk/printk.c:2009 [inline]
 vprintk_emit+0x320/0x7a0 kernel/printk/printk.c:2449
 _printk+0xcf/0x120 kernel/printk/printk.c:2475
 fail_dump lib/fault-inject.c:66 [inline]
 should_fail_ex+0x3f5/0x560 lib/fault-inject.c:174
 strncpy_from_user+0x36/0x290 lib/strncpy_from_user.c:118
 strncpy_from_user_nofault+0x72/0x150 mm/maccess.c:192
 bpf_trace_copy_string kernel/bpf/helpers.c:755 [inline]
 bpf_bprintf_prepare+0xbbc/0x13d0 kernel/bpf/helpers.c:976
 ____bpf_trace_printk kernel/trace/bpf_trace.c:373 [inline]
 bpf_trace_printk+0xdb/0x190 kernel/trace/bpf_trace.c:363
 bpf_prog_7c77c7e0f6645ad8+0x3e/0x44
 bpf_dispatcher_nop_func include/linux/bpf.h:1322 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2257 [inline]
 bpf_trace_run2+0x284/0x4b0 kernel/trace/bpf_trace.c:2298
 __bpf_trace_contention_begin+0xdc/0x130 include/trace/events/lock.h:95
 __do_trace_contention_begin include/trace/events/lock.h:95 [inline]
 trace_contention_begin include/trace/events/lock.h:95 [inline]
 __down_common+0x5ad/0x6a0 kernel/locking/semaphore.c:292
 down+0x80/0xd0 kernel/locking/semaphore.c:100
 console_lock+0x145/0x1b0 kernel/printk/printk.c:2849
 do_fb_ioctl+0x509/0x750 drivers/video/fbdev/core/fb_chrdev.c:123
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f92c678eb69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda68c54f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f92c69b5fa0 RCX: 00007f92c678eb69
RDX: 0000200000000080 RSI: 0000000000004606 RDI: 0000000000000005
RBP: 00007ffda68c5550 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f92c69b5fa0 R14: 00007f92c69b5fa0 R15: 0000000000000003
 </TASK>


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

