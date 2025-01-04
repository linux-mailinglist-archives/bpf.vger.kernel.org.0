Return-Path: <bpf+bounces-47865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ECDA0124B
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 05:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8410E1884C37
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 04:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1B7148FF0;
	Sat,  4 Jan 2025 04:47:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095112B73
	for <bpf@vger.kernel.org>; Sat,  4 Jan 2025 04:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735966049; cv=none; b=ddV0VZwUuhNz8vQCKk+F7Vw3if8fJ+GfJg3b5d+i5mRySugk0z3vJeSfyu/w3pFPd6dqIiyJOUEdXeCN002n1D9bRTAhiga9naqkzULW3wnYovAPwgVXi0m3P8gLocqfrftTyNQPFB4Jt/qOcc8PRSOwlq5q4PepG1OF+m/Bw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735966049; c=relaxed/simple;
	bh=33iJw/+mKmoNd1FMSMdxB9ds4KFOMtRynQYrqUIC/Yc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AUt2WYuXnf3Wr9RryUp+PyKjxbM8UvVSvFqPa6OjbZd454zCYPBOzfjyw8iUKDkJFsKRPf5S/eQtP4ERd3Nysnny2rvYSrEHKyEZ8UvHkNEnX/TjVwpokIBiukekBjGrSwTqJDWllkbuhGb+tUllOyyocIz3YTqmfk5vq/WA6MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a9cd0b54c1so112268905ab.0
        for <bpf@vger.kernel.org>; Fri, 03 Jan 2025 20:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735966047; x=1736570847;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+eAegMw/zFe577Wn3cNUiojLlobGznPJZ85zO5qI1s=;
        b=tVXTholzmUprM+HsF22Tz4DLTkIOUZDZj8wjeBbZHs8dYhEsqCz0ezQi6YWOaE2DAY
         ylHIRaCJao3fdv2eR4MBkVf6t27IVPvM5Mf0t5sQRZUnbssLh52/57Qbzu8IP/hSUCcH
         qjGMhK5+D6OkgKvecRUi+q0814wIvSOf9uD0Xgd253KjGHjQkS+TrPWXt+XtPMSEFXjt
         JMkg+ecyOEkO2kG+EaHRUnOQTu38q+KCIJ+ieYlcXUZajw2H67dlSkHrOkwX0cExZTXA
         xWHmfAZ6SYr0rrPM2EgcRYJmI3PRQP16KqSTuJA77tevRGShC14soJzquBJV2V2plrcj
         Sq+w==
X-Forwarded-Encrypted: i=1; AJvYcCVwdIedYp04Dy+nEsqry51NyNnIG7zdZlxG2CcYZbyYtZd77UMUNjyHboWB4cftNakgNlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB81XTAKmSMsewf8mgWeD6woFpIBXvljfPzM/R0Jy+Od/gifqa
	K7EkAjqhHdJibQuLloK4IJCkuQv8Dk8sv1iTnCNTaIaxOjhbMg4nSKcGb//0OGS4D8jAmYlhO9k
	b5vjy0r+oHHNqrRT+xcqBQ56sLnDghC5iEa4iAHGQSEj5m48UA4dVFts=
X-Google-Smtp-Source: AGHT+IH2e/1eJ/6nRj86OcNKHNruaqYPQZnrYPAkC5mBe7zARWHlpKlAkcr91thYMU0BbBg1/5drYNCiLpbWYyPkwb3aLpkUPRF7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3210:b0:3a0:9c99:32d6 with SMTP id
 e9e14a558f8ab-3c2d54349admr404716935ab.24.1735966047297; Fri, 03 Jan 2025
 20:47:27 -0800 (PST)
Date: Fri, 03 Jan 2025 20:47:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6778bd5f.050a0220.7f35c.0001.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in task_numa_work (2)
From: syzbot <syzbot+06d48cbf3e767907cec2@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9268abe611b0 Merge branch 'net-lan969x-add-rgmii-support'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=156e88b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b087c24b921cdc16
dashboard link: https://syzkaller.appspot.com/bug?extid=06d48cbf3e767907cec2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10651818580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1202eac4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8274f60b0163/disk-9268abe6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7b3fde537e7/vmlinux-9268abe6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db4cccf7caae/bzImage-9268abe6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+06d48cbf3e767907cec2@syzkaller.appspotmail.com

bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5865/2:b..l
rcu: 	(detected by 0, t=10503 jiffies, g=7645, q=122 ncpus=2)
task:syz-executor118 state:R  running task     stack:19936 pid:5865  tgid:5865  ppid:5860   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7078
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5853
Code: 2b 00 74 08 4c 89 f7 e8 9a 23 8b 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc9000408f3c0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92000811e84 RCX: ffff88807ef5c6d8
RDX: dffffc0000000000 RSI: ffffffff8c0aa960 RDI: ffffffff8c5faee0
RBP: ffffc9000408f510 R08: ffffffff942bc887 R09: 1ffffffff2857910
R10: dffffc0000000000 R11: fffffbfff2857911 R12: 1ffff92000811e80
R13: dffffc0000000000 R14: ffffc9000408f420 R15: 0000000000000246
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
 free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2657
 discard_slab mm/slub.c:2688 [inline]
 __put_partials+0x160/0x1c0 mm/slub.c:3157
 put_cpu_partial+0x17c/0x250 mm/slub.c:3232
 __slab_free+0x290/0x380 mm/slub.c:4483
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_kmalloc+0x23/0xb0 mm/kasan/common.c:385
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4329
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 task_numa_work+0xad5/0x14b0 kernel/sched/fair.c:3407
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faf0e7f728a
RSP: 002b:00007ffc20bea148 EFLAGS: 00000286
 ORIG_RAX: 0000000000000106
RAX: 0000000000000000 RBX: 000000000000004a RCX: 00007faf0e7f728a
RDX: 00007ffc20bea170 RSI: 00007ffc20bea200 RDI: 00000000ffffff9c
RBP: 00007ffc20bea200 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000286 R12: 00007ffc20beb270
R13: 000055557d6a56c0 R14: 00007ffc20beb2b0 R15: 000000000000000d
 </TASK>
rcu: rcu_preempt kthread starved for 7869 jiffies! g7645 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26264 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:get_current arch/x86/include/asm/current.h:49 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x8/0x70 kernel/kcov.c:216
Code: 8b 3d 74 8f 8f 0c 48 89 de 5b e9 63 f0 5a 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 04 24 <65> 48 8b 0c 25 00 d6 03 00 65 8b 15 00 62 64 7e 81 e2 00 01 ff 00
RSP: 0018:ffffc90000156db8 EFLAGS: 00000246
RAX: ffffffff8a91fc9d RBX: 00000000000048e0 RCX: ffff88801cad5a00
RDX: ffff88801cad5a00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8880b203a173 R08: ffffffff8a91fc92 R09: ffffffff8a91fa99
R10: 0000000000000003 R11: ffff88801cad5a00 R12: 0000000000000000
R13: ffff8881426b0800 R14: ffff888034f80e08 R15: ffff8881426b0818
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcd0e05e580 CR3: 000000000e736000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 br_flood+0x2cd/0x680 net/bridge/br_forward.c:232
 br_handle_frame_finish+0x18d2/0x2000 net/bridge/br_input.c:220
 br_nf_hook_thresh+0x472/0x590
 br_nf_pre_routing_finish_ipv6+0xaa0/0xdd0
 NF_HOOK include/linux/netfilter.h:314 [inline]
 br_nf_pre_routing_ipv6+0x379/0x770 net/bridge/br_netfilter_ipv6.c:184
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:282 [inline]
 br_handle_frame+0x9f3/0x1530 net/bridge/br_input.c:433
 __netif_receive_skb_core+0x14eb/0x4690 net/core/dev.c:5566
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 process_backlog+0x662/0x15b0 net/core/dev.c:6117
 __napi_poll+0xcb/0x490 net/core/dev.c:6883
 napi_poll net/core/dev.c:6952 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:7074
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:950
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)


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

