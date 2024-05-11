Return-Path: <bpf+bounces-29589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9728C300D
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 09:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845711C20D30
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 07:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB03D2FE;
	Sat, 11 May 2024 07:31:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D54A525D
	for <bpf@vger.kernel.org>; Sat, 11 May 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715412684; cv=none; b=VUx5QKPKbc4r6zuvaoR1Q5ous0k8ywQh8VH8eTf7XdAcaIQx+4gbpcQk4Wgjz71vra1/aTmqP8LR6UE/vnAzkk6Y/Zgc5MxpZgPh03UNp4in49+ose6HkiXQN0Ly1UE7Md9UZQztEKI+YUH1FZ1fJRy55PuC5hg9Z+QMRYrUITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715412684; c=relaxed/simple;
	bh=UBQWQ6I/sUhgEl48zUHpWpDSy/ONCK+e9qW3MQ9tG0M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=g71PpNbpCGGCS5kNMc/K+P1HfcvphG0USRjYT7wPJnk+Nhg9TByw1Hg0gc4V0inj9PyzoOSy4YTxePLv1wmvtz8VFxbFzi0pcJmvxahonyP3G33NHiUX6l486COpd9QzqY1lQU0Qx6v/lmSC4BzTxprhI9StWzKI9vQ/Pu+zPsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7da52a99cbdso266442339f.1
        for <bpf@vger.kernel.org>; Sat, 11 May 2024 00:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715412681; x=1716017481;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBBeotwzoiTXU/b7t2lIcAInQUnhSMX5oUXUu76x1nw=;
        b=ryQe+I/JpejBEBuGhGyD6g2749x85hsakJEmK12/QIsE12qZy11zjqlZGC1jQQ/Ihs
         ys8MgHADZNAeXrqgkjFLNEA8LYijRIu80fa5+FPS/MrtGmxrqbQEWQMOclbJNI9p/4/P
         taF52X3EjAd2oY3rdsMnhzRUNtsb4gFIzG+xIHDYR32t8HB+mfM0lqWfchXndlkdpTzm
         sdlsw0cX/ZwL5vE3hRcBP+6KUdOQ7EcSEvrEXxEHJP3JKGl3cgNKAN9qaTKgNcpZUPsh
         LbvfzRx8MPW5Ocfvn6HP6Ir2cg5T++ttBtl/hNMMby08xhu/Fgfnw5eMn73A5SsUYBTd
         /w/g==
X-Forwarded-Encrypted: i=1; AJvYcCW/1m8MKWFljRK64lbKb/Y3Lzp6I/SGgfBpriEucIJi5zkh4TkhSM7sLunEhyRM4GNZ7yRob6Q+9JuTljqaKw/vYKHA
X-Gm-Message-State: AOJu0Yz0yUovflghcQNK9lc/QovPUChx61JkIN8+Si9L3hlQ75TyRV8i
	j98QfrryMrQOWN49XIP1dfGrvDy9G5jrhklNw1pekSuYOmlQtpAZVd2gVvAaLw4N0Zq7nsP5qRG
	1oOeeaoWwCnzMulb98PJ64Yri1AJGK6AoEHV2EDqtFM+GA7hb7EbF7Fc=
X-Google-Smtp-Source: AGHT+IFJW+3xqgQOufMxV8L9Th/abXFpuwPGXVqUmlnw97471Lbki9WX436tYYgii0lI0JaPSbCsGxHVozIlukWnBAv1zP9KPOm7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:608c:b0:7de:3f44:a6fe with SMTP id
 ca18e2360f4ac-7e1b519cfb4mr15320339f.1.1715412681541; Sat, 11 May 2024
 00:31:21 -0700 (PDT)
Date: Sat, 11 May 2024 00:31:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086d9cb061828a317@google.com>
Subject: [syzbot] [bpf?] [net?] INFO: rcu detected stall in handle_softirqs
From: syzbot <syzbot+afcbef13b9fa6ae41f9a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, edumazet@google.com, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kerneljasonxing@gmail.com, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, yhs@fb.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ee5b455b0ada Merge tag 'slab-for-6.9-rc7-fixes' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=151c534b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7144b4fe7fbf5900
dashboard link: https://syzkaller.appspot.com/bug?extid=afcbef13b9fa6ae41f9a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12618698980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105fcb4b180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b58fa6d8c032/disk-ee5b455b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fe2cdcfb1b25/vmlinux-ee5b455b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9347ec3b62cf/bzImage-ee5b455b.xz

The issue was bisected to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1693d03f180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1593d03f180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1193d03f180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afcbef13b9fa6ae41f9a@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5144
rcu: 	(detected by 1, t=10503 jiffies, g=11073, q=192 ncpus=2)
task:syz-executor172 state:R  running task     stack:27056 pid:5144  tgid:5144  ppid:5099   flags:0x00004002
Call Trace:
 <IRQ>
 sched_show_task kernel/sched/core.c:9192 [inline]
 sched_show_task+0x42e/0x650 kernel/sched/core.c:9166
 rcu_print_detail_task_stall_rnp kernel/rcu/tree_stall.h:262 [inline]
 print_other_cpu_stall kernel/rcu/tree_stall.h:637 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:796 [inline]
 rcu_pending kernel/rcu/tree.c:3934 [inline]
 rcu_sched_clock_irq+0x2613/0x3100 kernel/rcu/tree.c:2297
 update_process_times+0x175/0x220 kernel/time/timer.c:2486
 tick_sched_handle kernel/time/tick-sched.c:276 [inline]
 tick_nohz_handler+0x376/0x530 kernel/time/tick-sched.c:297
 __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
 __hrtimer_run_queues+0x657/0xcc0 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x450 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x43/0xb0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
Code: 90 f3 0f 1e fa 53 48 8b 74 24 08 48 89 fb 48 83 c7 18 e8 6a 98 8c f6 48 89 df e8 c2 14 8d f6 e8 ed 98 b5 f6 fb bf 01 00 00 00 <e8> b2 4f 7e f6 65 8b 05 b3 88 24 75 85 c0 74 06 5b c3 cc cc cc cc
RSP: 0018:ffffc90000a08d18 EFLAGS: 00000202
RAX: 000000000184d5fe RBX: ffff8880b95401d0 RCX: 1ffffffff1f3e269
RDX: 0000000000000000 RSI: ffffffff8b0cae00 RDI: 0000000000000001
RBP: ffff8880b9540210 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8f9f55d7 R11: 0000000000000001 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000040 R15: ffff8880b95401b8
 spin_unlock_irq include/linux/spinlock.h:401 [inline]
 rps_unlock_irq_enable net/core/dev.c:229 [inline]
 process_backlog+0x3e7/0x6f0 net/core/dev.c:6011
 __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6638
 napi_poll net/core/dev.c:6707 [inline]
 net_rx_action+0x9ad/0xf10 net/core/dev.c:6822
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 do_softirq kernel/softirq.c:455 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:442
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 bpf_test_run+0x335/0x9e0 net/bpf/test_run.c:426
 bpf_prog_test_run_skb+0xb17/0x1db0 net/bpf/test_run.c:1058
 bpf_prog_test_run kernel/bpf/syscall.c:4269 [inline]
 __sys_bpf+0xd56/0x4b40 kernel/bpf/syscall.c:5678
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2466eba819
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc5f447668 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f2466eba819
RDX: 0000000000000050 RSI: 0000000020000080 RDI: 000000000000000a
RBP: 0000000000000000 R08: 0000000100000000 R09: 0000000100000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 10546 jiffies! g11073 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28736 pid:16    tgid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6838
 schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2582
 rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:1663
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:1862
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 5144 Comm: syz-executor172 Not tainted 6.9.0-rc7-syzkaller-00008-gee5b455b0ada #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
Code: 90 f3 0f 1e fa 53 48 8b 74 24 08 48 89 fb 48 83 c7 18 e8 6a 98 8c f6 48 89 df e8 c2 14 8d f6 e8 ed 98 b5 f6 fb bf 01 00 00 00 <e8> b2 4f 7e f6 65 8b 05 b3 88 24 75 85 c0 74 06 5b c3 cc cc cc cc
RSP: 0018:ffffc90000a08d18 EFLAGS: 00000202
RAX: 000000000184d5fe RBX: ffff8880b95401d0 RCX: 1ffffffff1f3e269
RDX: 0000000000000000 RSI: ffffffff8b0cae00 RDI: 0000000000000001
RBP: ffff8880b9540210 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8f9f55d7 R11: 0000000000000001 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000040 R15: ffff8880b95401b8
FS:  00005555756a8380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2466f370f0 CR3: 000000007c110000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 spin_unlock_irq include/linux/spinlock.h:401 [inline]
 rps_unlock_irq_enable net/core/dev.c:229 [inline]
 process_backlog+0x3e7/0x6f0 net/core/dev.c:6011
 __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6638
 napi_poll net/core/dev.c:6707 [inline]
 net_rx_action+0x9ad/0xf10 net/core/dev.c:6822
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 do_softirq kernel/softirq.c:455 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:442
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 bpf_test_run+0x335/0x9e0 net/bpf/test_run.c:426
 bpf_prog_test_run_skb+0xb17/0x1db0 net/bpf/test_run.c:1058
 bpf_prog_test_run kernel/bpf/syscall.c:4269 [inline]
 __sys_bpf+0xd56/0x4b40 kernel/bpf/syscall.c:5678
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2466eba819
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc5f447668 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f2466eba819
RDX: 0000000000000050 RSI: 0000000020000080 RDI: 000000000000000a
RBP: 0000000000000000 R08: 0000000100000000 R09: 0000000100000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
sched: RT throttling activated


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

