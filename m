Return-Path: <bpf+bounces-15068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023D97EB649
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 19:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59728281506
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 18:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C0933CDE;
	Tue, 14 Nov 2023 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9601D2E8
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 18:18:29 +0000 (UTC)
Received: from mail-pf1-f206.google.com (mail-pf1-f206.google.com [209.85.210.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8990C122
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 10:18:26 -0800 (PST)
Received: by mail-pf1-f206.google.com with SMTP id d2e1a72fcca58-6bd00edc63fso8217751b3a.0
        for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 10:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699985906; x=1700590706;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nmq3sA/5qirDYLDWr1c7vN6b9d9XYljC8rUAXD8oKFI=;
        b=vnkqBDI5Y533IADNvwLd5+FuEZX4hD+vkFXWfVJRgB4uhFOJtvaDsU5x9rAGvzx9NO
         u52RjisQeaQjaPc6xZ5UBB5XAJXUW6Ogcv500PBhdVbq+FaSbKTaUBdWDyMBTIbFD6k8
         jGEYaG0IbR4FejWgwGvw8sxoCpLVk7WmdNCSvD7Mi40OLefGkRxW74Isx0AZqKJF+Rp1
         RSRUVWaqcDIEZZCBN2tUEoeKfW64zdVnaWuQul7qaYG14/xpU3DQSMNjq+HCacX46BRY
         1a23+X5kEzQQAi6rK7k0mzw9c9ov3huxprzxIS5yaUVOMfkezrKl2RYip9Sf23TS1frz
         p3XA==
X-Gm-Message-State: AOJu0YybMhkAg+841HdlhiAGk9cY4CW6ByN7P5tzQ1rZX0t3xasmqYcl
	SBPQu2YZNgdQSDRadkmO9HH/A9eqz7U1gBp5PyI0KDOv0yjd
X-Google-Smtp-Source: AGHT+IGO7oMUxHG/fEjzy5nnebPQzHxwaR7G01RM1H2FRFp1+VNwL4qLiM5qrLmaWjypnoeiWoHIW3+dUJ2Qbx0usZRQAKijACuJ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:330b:b0:6be:2a27:63f0 with SMTP id
 cq11-20020a056a00330b00b006be2a2763f0mr3413246pfb.6.1699985905960; Tue, 14
 Nov 2023 10:18:25 -0800 (PST)
Date: Tue, 14 Nov 2023 10:18:25 -0800
In-Reply-To: <0000000000003495bf060724994a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c5617060a20d06b@google.com>
Subject: Re: [syzbot] [batman?] INFO: rcu detected stall in worker_thread (9)
From: syzbot <syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com>
To: a@unstable.cc, admini@syzkaller.appspotmail.com, 
	b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, coreteam@netfilter.org, 
	davem@davemloft.net, edumazet@google.com, fw@strlen.de, 
	gregkh@linuxfoundation.org, hdanton@sina.com, horms@kernel.org, 
	jiri@nvidia.com, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	rafael@kernel.org, server@syzkaller.appspotmail.com, sven@narfation.org, 
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

syzbot has found a reproducer for the following issue on:

HEAD commit:    9bacdd8996c7 Merge tag 'for-6.7-rc1-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13e932ff680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d05dd66e2eb2c872
dashboard link: https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1041f91f680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10cc7b98e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8e9d5e2b6665/disk-9bacdd89.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8ee67db540d/vmlinux-9bacdd89.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3477230ef7a9/bzImage-9bacdd89.xz

The issue was bisected to:

commit c2368b19807affd7621f7c4638cd2e17fec13021
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:35 2022 +0000

    net: devlink: introduce "unregistering" mark and use it during devlinks iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1758e1e3680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14d8e1e3680000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d8e1e3680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com
Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 ticks this GP) idle=3b94/1/0x4000000000000000 softirq=6057/6057 fqs=9
rcu: 	(detected by 1, t=10502 jiffies, g=6949, q=188 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.7.0-rc1-syzkaller-00012-g9bacdd8996c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: events_power_efficient gc_worker
RIP: 0010:pv_queued_spin_unlock arch/x86/include/asm/paravirt.h:591 [inline]
RIP: 0010:queued_spin_unlock arch/x86/include/asm/qspinlock.h:57 [inline]
RIP: 0010:do_raw_spin_unlock+0x117/0x8b0 kernel/locking/spinlock_debug.c:141
Code: 49 c7 45 00 ff ff ff ff 0f b6 04 2b 84 c0 0f 85 c9 03 00 00 41 c7 06 ff ff ff ff 48 c7 c0 60 b8 79 8d 48 c1 e8 03 80 3c 28 00 <74> 0c 48 c7 c7 60 b8 79 8d e8 9b d3 7b 00 48 83 3d 73 30 0b 0c 00
RSP: 0018:ffffc90000007c20 EFLAGS: 00000046
RAX: 1ffffffff1af370c RBX: 1ffff110042eac5e RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880217562e8
RBP: dffffc0000000000 R08: ffff8880217562eb R09: 1ffff110042eac5d
R10: dffffc0000000000 R11: ffffed10042eac5e R12: 1ffff110042eac5f
R13: ffff8880217562f8 R14: ffff8880217562f0 R15: ffff8880217562e8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000600 CR3: 000000000d730000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __raw_spin_unlock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_unlock+0x1e/0x40 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 advance_sched+0x9bd/0xcb0 net/sched/sch_taprio.c:992
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x59f/0xd20 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x396/0x980 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
 __sysvec_apic_timer_interrupt+0x104/0x3a0 arch/x86/kernel/apic/apic.c:1082
 sysvec_apic_timer_interrupt+0x92/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:lock_acquire+0x25a/0x530 kernel/locking/lockdep.c:5757
Code: 2b 00 74 08 4c 89 f7 e8 04 33 7d 00 f6 44 24 61 02 0f 85 8a 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc900000d7940 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff9200001af34 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8b6ac0c0 RDI: ffffffff8bbdf300
RBP: ffffc900000d7a88 R08: ffffffff90dd4367 R09: 1ffffffff21ba86c
R10: dffffc0000000000 R11: fffffbfff21ba86d R12: 1ffff9200001af30
R13: dffffc0000000000 R14: ffffc900000d79a0 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 rcu_read_lock include/linux/rcupdate.h:747 [inline]
 gc_worker+0x28c/0x15a0 net/netfilter/nf_conntrack_core.c:1488
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1420 kernel/workqueue.c:2703
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.422 msecs
rcu: rcu_preempt kthread starved for 9734 jiffies! g6949 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26576 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1961/0x4ab0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6778
 schedule_timeout+0x1bd/0x300 kernel/time/timer.c:2167
 rcu_gp_fqs_loop+0x30a/0x1500 kernel/rcu/tree.c:1631
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:1830
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 1272 Comm: kworker/u4:6 Not tainted 6.7.0-rc1-syzkaller-00012-g9bacdd8996c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:311 [inline]
RIP: 0010:smp_call_function_many_cond+0x1832/0x2940 kernel/smp.c:855
Code: 45 8b 65 00 44 89 e6 83 e6 01 31 ff e8 97 88 0b 00 41 83 e4 01 49 bc 00 00 00 00 00 fc ff df 75 07 e8 d2 84 0b 00 eb 38 f3 90 <42> 0f b6 04 23 84 c0 75 11 41 f7 45 00 01 00 00 00 74 1e e8 b6 84
RSP: 0018:ffffc9000562f720 EFLAGS: 00000293
RAX: ffffffff8182f9fa RBX: 1ffff110173087c5 RCX: ffff8880201a0000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000562f920 R08: ffffffff8182f9c9 R09: 1ffffffff21ba86c
R10: dffffc0000000000 R11: fffffbfff21ba86d R12: dffffc0000000000
R13: ffff8880b9843e28 R14: ffff8880b993d480 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe63960000 CR3: 000000000d730000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1023
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2006 [inline]
 text_poke_bp_batch+0x352/0xb30 arch/x86/kernel/alternative.c:2216
 text_poke_flush arch/x86/kernel/alternative.c:2407 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2414
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x132/0x260 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate+0xb5/0x250 mm/kfence/core.c:830
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1420 kernel/workqueue.c:2703
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

