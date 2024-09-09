Return-Path: <bpf+bounces-39360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD239723F1
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE531C217BA
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 20:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D703D18A943;
	Mon,  9 Sep 2024 20:48:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF3189F58
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914910; cv=none; b=FdZ2K+e8NqIvAUC4lFRLTwYgRMmCA6fGUgaqHKzpSWc/7pnqNDwJ2dBY//yel+tX2lwk2ZclzNBnyZQSiWfB/zz9IWcYkxmNU5SWyvldht7AWU5TtaCHBqAWvuKX9KgPFWBVm52aHofsuWz/yLtTfTzhhInqASpy+ZhIP684FF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914910; c=relaxed/simple;
	bh=bj6ezJJE8uySLEKRV5p5i2Fhqa3olKMS7tCk2tUmnow=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DlghA/PUChn6whRyp/Ws/qcl2eA3gv2WbU1jI8z7/wIJEgb/I0LhsBE+DjMxd7L/mJPVakF6EFII5CeAI1fqJCJzniAY7vFql7ogzefdkMWOjQs2GQV1Dow0whO8InMUNYknNDl30M4fIlFgeJNCNAcU5sOZFKYWGjA6E6G4dg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cd682f1d2so511598239f.3
        for <bpf@vger.kernel.org>; Mon, 09 Sep 2024 13:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725914908; x=1726519708;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVS/B4fowCqshOqqe1tybrV3sYd/BufTUKjXFrWD6fE=;
        b=gDaRlyMSE8dLAkaKPoS3j2YFffhoSvCGb7fGADEAhr8sGG3Z98AnMQUajmwKDnbzRf
         mopn8muMJK+/p0Q0kyZyJGJgebS5gDimkwpA5flpateMOKO5mrvwrEJonALtx7b+79Gp
         zoupd0eJnjw9yncUh+pT8FK/3dRAROkPN+KvDWnd20xU8JM4XxDvjy0gO1IN3j1UaBu4
         qqkbzWpO+lR9ZM012z/JNOj7zCztDrwpNY2nTF+klhf31mWVqtd+W87CprkvDwvrYaT1
         vVDg8Hb/B3xmQK2x/2fHsrSEA10EzX0fMwyV17ZGV0I/vUpuTrNtfk92ErmfkO7tyyhy
         tuiw==
X-Forwarded-Encrypted: i=1; AJvYcCXLLz0uTcBgXTDywjHKmE4HispGryWYuyxHG2FSLabw5s4TVdWKkz1H+KctbbJUpnl2Fpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6o8RqfAhlDoqgvhWXBBuxY5Gqmeo1h+ck4pVl+AcQTpnTxNZH
	xQkXUrTZROtTdUsQybjf1DBdWZM9XZaQI9JpAcfEWs0YESdBSSz7LrB2vRj8+aGCLnkX2WfG/z5
	3i/rE7zR7OHiL/bG5vlMVWUbRUHeboyt1OQmSGJr2qsWR9ZLzjuyF23I=
X-Google-Smtp-Source: AGHT+IHmruXnFcQ6JbCYmTmD5Jfh7d3+UwMnisn5V8GB2eqiyaeaFotUkK0agG2NJxHiPRunkSuDT3jJ6Pe1iFeW/i0C961A8vHn
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13d2:b0:82a:2a0b:1c7d with SMTP id
 ca18e2360f4ac-82a9618c51fmr1979118239f.5.1725914908031; Mon, 09 Sep 2024
 13:48:28 -0700 (PDT)
Date: Mon, 09 Sep 2024 13:48:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000189dc0621b5e193@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in x64_sys_call
From: syzbot <syzbot+65203730e781d98f23a0@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, martin.lau@linux.dev, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89f5e14d05b4 Merge tag 'timers_urgent_for_v6.11_rc7' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161dc807980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc7fa3453562e8b
dashboard link: https://syzkaller.appspot.com/bug?extid=65203730e781d98f23a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32d5513fda9e/disk-89f5e14d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a58c26d03524/vmlinux-89f5e14d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efa23a51ded0/bzImage-89f5e14d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65203730e781d98f23a0@syzkaller.appspotmail.com

bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P1072/1:b..l P6746/2:b..l
rcu: 	(detected by 0, t=10502 jiffies, g=26081, q=1102 ncpus=2)
task:syz.0.260       state:R  running task     stack:24672 pid:6746  tgid:6746  ppid:6370   flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6851
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:trace_lock_release include/trace/events/lock.h:69 [inline]
RIP: 0010:lock_release+0xb8/0xa30 kernel/locking/lockdep.c:5770
Code: 08 0f 83 fe 05 00 00 89 c3 48 89 d8 48 c1 e8 06 48 8d 3c c5 e8 4a f7 8f be 08 00 00 00 e8 80 be 87 00 48 0f a3 1d 50 57 87 0e <73> 16 e8 f1 ce 09 00 84 c0 75 0d 80 3d 11 2a 71 0e 00 0f 84 fc 05
RSP: 0018:ffffc90004216ba0 EFLAGS: 00000257
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff816ff390
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8ff74ae8
RBP: ffffc90004216cd0 R08: ffffffff8ff74aef R09: 1ffffffff1fee95d
R10: dffffc0000000000 R11: fffffbfff1fee95e R12: 1ffff92000842d80
R13: ffffffff81a23d46 R14: 0000000000000000 R15: dffffc0000000000
 rcu_lock_release include/linux/rcupdate.h:336 [inline]
 rcu_read_unlock include/linux/rcupdate.h:869 [inline]
 is_bpf_text_address+0x280/0x2a0 kernel/bpf/core.c:769
 kernel_text_address+0xa7/0xe0 kernel/extable.c:125
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x5d/0xc0 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0x125/0x1b0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_folios+0x100f/0x1ac0 mm/page_alloc.c:2667
 folios_put_refs+0x76e/0x860 mm/swap.c:1039
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 zap_pte_range mm/memory.c:1697 [inline]
 zap_pmd_range mm/memory.c:1736 [inline]
 zap_pud_range mm/memory.c:1765 [inline]
 zap_p4d_range mm/memory.c:1786 [inline]
 unmap_page_range+0x38d9/0x42c0 mm/memory.c:1807
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1897
 exit_mmap+0x264/0xc80 mm/mmap.c:3412
 __mmput+0x115/0x380 kernel/fork.c:1345
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x27f0 kernel/exit.c:869
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd22ad7cef9
RSP: 002b:00007ffcbce70338 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd22ad7cef9
RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffcbce7038c R08: 00007ffcbce7041f R09: 0000000000057a2a
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000032
R13: 0000000000057a2a R14: 00000000000579f3 R15: 00007ffcbce703e0
 </TASK>
task:kworker/u8:7    state:R  running task     stack:21008 pid:1072  tgid:1072  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6851
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__kernel_text_address+0x5/0x40 kernel/extable.c:78
Code: c3 48 c7 c7 40 08 f7 8f e8 08 19 98 00 eb b5 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 53 <48> 89 fb e8 43 00 00 00 85 c0 0f 95 c0 48 c7 c1 00 40 53 91 48 39
RSP: 0018:ffffc900042d65a8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffc900042d6628 RCX: ffff888027a00000
RDX: ffff888027a00000 RSI: 0000000000000001 RDI: ffffffff8260b639
RBP: 0000000000000001 R08: ffffffff814125c7 R09: ffffffff814140bf
R10: 0000000000000003 R11: ffff888027a00000 R12: ffff888027a00000
R13: ffffffff817f2f30 R14: dffffc0000000000 R15: 1ffff9200085acc5
 unwind_get_return_address+0x5d/0xc0 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0x125/0x1b0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2619
 __slab_free+0x31b/0x3d0 mm/slub.c:4388
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3992 [inline]
 slab_alloc_node mm/slub.c:4041 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4048
 ext4_init_io_end+0x29/0x130 fs/ext4/page-io.c:277
 ext4_do_writepages+0xc13/0x3d40 fs/ext4/inode.c:2701
 ext4_writepages+0x213/0x3c0 fs/ext4/inode.c:2842
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 __writeback_single_inode+0x165/0x10b0 fs/fs-writeback.c:1651
 writeback_sb_inodes+0x99c/0x1380 fs/fs-writeback.c:1947
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2018
 wb_writeback+0x495/0xd40 fs/fs-writeback.c:2129
 wb_check_old_data_flush fs/fs-writeback.c:2233 [inline]
 wb_do_writeback fs/fs-writeback.c:2286 [inline]
 wb_workfn+0xba1/0x1090 fs/fs-writeback.c:2314
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: rcu_preempt kthread starved for 9599 jiffies! g26081 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:25816 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2034
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2236
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:111
net_ratelimit: 16634 callbacks suppressed
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:32:a6:3d:0b:9e:62, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:32:a6:3d:0b:9e:62, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
net_ratelimit: 18130 callbacks suppressed
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:32:a6:3d:0b:9e:62, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:32:a6:3d:0b:9e:62, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:32:a6:3d:0b:9e:62, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)


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

