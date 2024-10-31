Return-Path: <bpf+bounces-43665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E1E9B8378
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 20:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6726C1F222ED
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9321CB337;
	Thu, 31 Oct 2024 19:32:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC2D19FA8D
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730403150; cv=none; b=cegjNhami47nVNQtEo7ETw8CysXJJlk54iuU5HVJ2FjkKHNM/IbtifjNc6aUbl9jJTMMEyjWAVkD7lgL+eQrl7Ulew4MytfuSwYdWe3J8U513VvbyKnlGdapm8hX/H4f1j7McEeCUTD9PrCiNddvTJ9/FZCHPljMLp1e6m/o6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730403150; c=relaxed/simple;
	bh=r1tLnTJ3PkKxqfQ8VQZhwgRSFZ2oHY+mhBKDujdy0pU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FVNhLOV5WW+OCozNv5xenJm5Upv3DfZDA3mZVPOwoHB70yOfBS1ZlKkQBdNtwND9lxGATPDjZlPFQp55i2Qc06dkz+196XTv0qVY2IDAEO9f6TE48HDpPD8O5u/uvwm6xfhAs2/RQS5HgjYAbJaqLpxuoQ7OeGVgjl7/p32EbAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3bcae85a5so8253935ab.1
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 12:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730403147; x=1731007947;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mWBfLUqmRVzaB5gmoSMl/IKqtWBVlT8PhQ9WpCfa1H8=;
        b=cFpUr5ZdIOoRF8ZlRdLYFFr8d0dnt2ze8GpBF2wU+b8mb/o3PVFL38HCJdWguSvLcs
         F9y7u8jEPdwdKVvp+1Ih9NFs2Kd/ptctIb9AhRYyBuf+Nwt58t5ZkmMhRjOshOQDWIm5
         phGFWMGCC4xDSvZGDKUf329aHEPhuPl2ITZwe2seJSoRZeuuz4FHsMMFNp8nCfumeypz
         3+R9+8IHXp+jXati9vd19lFA7o+pKtsSZkpdyPTUDTuBs6rAfG0oSfHAyYp9TX8bZYco
         gKbaaCFxPL6UQVYJn1N65AQDxiJx9R12M/TP8f7stbTG7zk6pw3Z3fZk6XyauPL5xAvF
         tVyg==
X-Forwarded-Encrypted: i=1; AJvYcCW2XH4XICtECKfVJRvrExSWF/7bQ2LXiKgX+s2u8kwpBrjIjoc3ly4LRBlPn4sdzJ6oaSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7XjEoPtWLwMvw8nLWH7ecfpSE+xHYe2FSLmYmT5ZX7wWSil86
	5VvrwDUtFsQFwTvMhdoFFvvieYjyx2J7T2l7U1tt8FcvvC3rtrU2D6ZHBnPh7aZaLyE9YScqhLq
	iVWc2gbLgUjb9k8JUpN82t3S+p061MUlEjls3oMERHVMi5NKX4rPpOGA=
X-Google-Smtp-Source: AGHT+IG0aM2/1nEWp1URkw+xnzdmXk6hXnW/ExoUJu6dyH9Jj3laNX9lAwtjgqEi67byXpa8C6pTZAcktsHJSLk6yqspX4hpUHaI
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a3:b0:3a5:e0df:57ba with SMTP id
 e9e14a558f8ab-3a6a947d5bemr24758385ab.1.1730403146834; Thu, 31 Oct 2024
 12:32:26 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:32:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6723db4a.050a0220.35b515.0168.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING: locking bug in trie_delete_elem
From: syzbot <syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1387c6f7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=b506de56cbbb63148c33
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1387655f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ac5540580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb84549dd6b3/disk-f9f24ca3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/beb29bdfa297/vmlinux-f9f24ca3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8881fe3245ad/bzImage-f9f24ca3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com

=============================
[ BUG: Invalid wait context ]
6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
-----------------------------
swapper/0/0 is trying to lock:
ffff8880261e7a00 (&trie->lock){....}-{3:3}, at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
other info that might help us debug this:
context-{3:3}
5 locks held by swapper/0/0:
 #0: ffff888020bb75c8 (&vp_dev->lock){-...}-{3:3}, at: vp_vring_interrupt drivers/virtio/virtio_pci_common.c:80 [inline]
 #0: ffff888020bb75c8 (&vp_dev->lock){-...}-{3:3}, at: vp_interrupt+0x142/0x200 drivers/virtio/virtio_pci_common.c:113
 #1: ffff88814174a120 (&vb->stop_update_lock){-...}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #1: ffff88814174a120 (&vb->stop_update_lock){-...}-{3:3}, at: stats_request+0x6f/0x230 drivers/virtio/virtio_balloon.c:438
 #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: __queue_work+0x199/0xf50 kernel/workqueue.c:2259
 #3: ffff8880b863dd18 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x759/0xf50
 #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2339 [inline]
 #4: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run1+0x1d6/0x520 kernel/trace/bpf_trace.c:2380
stack backtrace:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc5-next-20241031-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
 check_wait_context kernel/locking/lockdep.c:4898 [inline]
 __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
 bpf_prog_2c29ac5cdc6b1842+0x43/0x47
 bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2340 [inline]
 bpf_trace_run1+0x2ca/0x520 kernel/trace/bpf_trace.c:2380
 trace_workqueue_activate_work+0x186/0x1f0 include/trace/events/workqueue.h:59
 __queue_work+0xc7b/0xf50 kernel/workqueue.c:2338
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:662 [inline]
 stats_request+0x1a3/0x230 drivers/virtio/virtio_balloon.c:441
 vring_interrupt+0x21d/0x380 drivers/virtio/virtio_ring.c:2595
 vp_vring_interrupt drivers/virtio/virtio_pci_common.c:82 [inline]
 vp_interrupt+0x192/0x200 drivers/virtio/virtio_pci_common.c:113
 __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
 handle_fasteoi_irq+0x48a/0xae0 kernel/irq/chip.c:720
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq arch/x86/kernel/irq.c:247 [inline]
 call_irq_handler arch/x86/kernel/irq.c:259 [inline]
 __common_interrupt+0x136/0x230 arch/x86/kernel/irq.c:285
 common_interrupt+0xb4/0xd0 arch/x86/kernel/irq.c:278
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5201
Code: c9 50 e8 29 05 0c 00 48 83 c4 08 4c 89 f7 e8 4d 39 00 00 0f 1f 44 00 00 4c 89 f7 e8 a0 45 69 0a e8 4b 9e 38 00 fb 48 8b 5d c0 <48> 8d bb f8 15 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
RSP: 0018:ffffffff8e607ae8 EFLAGS: 00000282
RAX: 467bb178e56b5700 RBX: ffffffff8e6945c0 RCX: ffffffff9a3d4903
RDX: dffffc0000000000 RSI: ffffffff8c0ad3a0 RDI: ffffffff8c604dc0
RBP: ffffffff8e607b30 R08: ffffffff901d03b7 R09: 1ffffffff203a076
R10: dffffc0000000000 R11: fffffbfff203a077 R12: 1ffff110170c7e74
R13: dffffc0000000000 R14: ffff8880b863e580 R15: ffff8880b863f3a0
 context_switch kernel/sched/core.c:5330 [inline]
 __schedule+0x1857/0x4c30 kernel/sched/core.c:6707
 schedule_idle+0x56/0x90 kernel/sched/core.c:6825
 do_idle+0x567/0x5c0 kernel/sched/idle.c:353
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:423
 rest_init+0x2dc/0x300 init/main.c:747
 start_kernel+0x47f/0x500 init/main.c:1102
 x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
 common_startup_64+0x13e/0x147
 </TASK>
----------------
Code disassembly (best guess):
   0:	c9                   	leave
   1:	50                   	push   %rax
   2:	e8 29 05 0c 00       	call   0xc0530
   7:	48 83 c4 08          	add    $0x8,%rsp
   b:	4c 89 f7             	mov    %r14,%rdi
   e:	e8 4d 39 00 00       	call   0x3960
  13:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  18:	4c 89 f7             	mov    %r14,%rdi
  1b:	e8 a0 45 69 0a       	call   0xa6945c0
  20:	e8 4b 9e 38 00       	call   0x389e70
  25:	fb                   	sti
  26:	48 8b 5d c0          	mov    -0x40(%rbp),%rbx
* 2a:	48 8d bb f8 15 00 00 	lea    0x15f8(%rbx),%rdi <-- trapping instruction
  31:	48 89 f8             	mov    %rdi,%rax
  34:	48 c1 e8 03          	shr    $0x3,%rax
  38:	49                   	rex.WB
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


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

