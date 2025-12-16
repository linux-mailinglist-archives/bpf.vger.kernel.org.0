Return-Path: <bpf+bounces-76745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1141CC4EBE
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 332FC30CBEB8
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBF6324712;
	Tue, 16 Dec 2025 18:33:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1B1FF1B4
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765910010; cv=none; b=Yuk8qD53glkehTglKrPuAAnGVEd3s/t4T2lOESvoR08X7rpHDEmXqHcuuu5fPNouGTNPBMBFgios+b8vAOhhKAJYsxtK1O0yr70lW/GV2OK0I5dr1xrNtD0rWx56yhPmtotnHsaEuPFTPcFimQHjf1811c2FymOeRgxOiV+r8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765910010; c=relaxed/simple;
	bh=FBSiNYmab12TRSxMM4Oxp8C8jjnZ0ePlDDkAKpYP52w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mS7NL/PHHqFNlmym4p4EwXy6Br7FD0mB2JhsfpZ4Bw9WH7NesRwftujBQV2I2RZSWsqgS4h4FXU571WJ/mzeQ8FIj8W2jtekiR6pxf+2uthXOqrsIjM7OXhDIaMcdqmubSWF+FIMtUylbeb54vvcN/fTvggG73DHf1hZkATgU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-65b153371efso7722854eaf.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 10:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765910007; x=1766514807;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tu7BnA+NYDhexR6ROYUuNL/3STa/RQ8mie6iuMuuUvc=;
        b=fQtc3gbev5rWlZfQEsDsDl+ulJPQWybgTCCERdaSH/w/fve/Yoxubx/ZIwEP2PdGdk
         TVug1E/rPRTRXakHV8iD66JLUPgQNsrT4557JHUvJ66P0vfw7S0XhEiiR1szY6SjavFz
         3CqDUEExXNJD+0PSDy4yXKOfaP8BQ35zsorJAA1j4rR525lde5meHt78ko5UwqxzckKe
         tNejLkumZ71VBrTi8+JTHskswVep9XAxy5JFzykiUXozcFsAC5sPY45o0/Hu3ZACAtX6
         7jFIwyofxhrpWOVmA0pHviEVd0mjliExw/Mq9WreWV8c2/9rez1hYU6XeTff4gqjN9bo
         vkJA==
X-Forwarded-Encrypted: i=1; AJvYcCVFc2pNGOLbh5CDUz1sNIuoPH08toXBVhW8WLr6O1EZiaGCW6REW0f2/e9EpqS5iQpzngU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8fs9Yf6Ct3EisYnJxvfIeOeoj3XJqFab832lOF7rdOgkvNSuo
	OcBXusr2YF7VBSAvK38/dshg3zYkrc794o0HHG1cL+bRMCrNDGcV33ybi+CXfIPWIYEFplswWl4
	RgDimX/mMnp9RB48FvPFuiiZ9zW6esB2vTCuIhyC8LoxgNYUSqSHG93oYcKA=
X-Google-Smtp-Source: AGHT+IFOeZzcMhdAR655rqjQUi8eis1u9YCVMthFB+cB/lXOc1yh8J/POHRSLE7I8p+1rNR41PQ9t+pAa386cRQzsp6feUoG8G5S
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee0f:0:b0:659:9a49:8e38 with SMTP id
 006d021491bc7-65b38027330mr9052702eaf.42.1765910006911; Tue, 16 Dec 2025
 10:33:26 -0800 (PST)
Date: Tue, 16 Dec 2025 10:33:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6941a5f6.a70a0220.25eec0.0005.GAE@google.com>
Subject: [syzbot] [bpf?] INFO: rcu detected stall in unwind_get_return_address (2)
From: syzbot <syzbot+a60fc566f2bff263d4c4@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f7aa3d3c732 Merge tag 'net-next-6.19' of git://git.kernel..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=143dd592580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e5198eaf003f1d1
dashboard link: https://syzkaller.appspot.com/bug?extid=a60fc566f2bff263d4c4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123dd592580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5fe312c4cf90/disk-8f7aa3d3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7a1f54ef730/vmlinux-8f7aa3d3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/64a3779458bb/bzImage-8f7aa3d3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a60fc566f2bff263d4c4@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6092/1:b..l
rcu: 	(detected by 0, t=10504 jiffies, g=14093, q=390 ncpus=2)
task:syz.0.24        state:R  running task     stack:25784 pid:6092  tgid:6092  ppid:5948   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7190
 irqentry_exit+0x5d8/0x660 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:__rcu_read_lock+0x39/0x60 kernel/rcu/tree_plugin.h:420
Code: 81 c3 84 04 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 18 ff 03 8b 03 3d 00 00 00 40 7d 07 <5b> e9 41 2b a4 09 cc 90 0f 0b 90 eb f3 89 d9 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90002ea7920 EFLAGS: 00000283
RAX: 0000000000000001 RBX: ffff88802e7d6004 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff8d952009 RDI: 00007f070e78f749
RBP: 0000000000000001 R08: ffffffff81abc2cd R09: ffffffff8df41cc0
R10: ffffc90002ea7a18 R11: ffffffff81ad4ad0 R12: ffff88802e7d5b80
R13: 0000000000000000 R14: 00007f070e78f749 R15: 1ffff920005d4f42
 rcu_read_lock include/linux/rcupdate.h:865 [inline]
 is_bpf_text_address+0x1f/0x2b0 kernel/bpf/core.c:744
 kernel_text_address+0xa5/0xe0 kernel/extable.c:125
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x4d/0x90 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0xfc/0x150 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:559
 slab_free_hook mm/slub.c:2501 [inline]
 slab_free mm/slub.c:6663 [inline]
 kmem_cache_free+0x475/0x620 mm/slub.c:6774
 task_work_run+0x1d4/0x260 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
 exit_to_user_mode_loop+0xff/0x4f0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2e3/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f070e78f749
RSP: 002b:00007ffdac4cad28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f070e9e7da0 RCX: 00007f070e78f749
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f070e9e7da0 R08: 0000000000000000 R09: 00000007ac4cb01f
R10: 000000000003fd8c R11: 0000000000000246 R12: 000000000001c975
R13: 00007f070e9e5fa0 R14: ffffffffffffffff R15: 0000000000000003
 </TASK>
rcu: rcu_preempt kthread starved for 8379 jiffies! g14093 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27520 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 935 Comm: kworker/1:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: wg-crypt-wg1 wg_packet_decrypt_worker
RIP: 0010:check_kcov_mode kernel/kcov.c:185 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:246 [inline]
RIP: 0010:__sanitizer_cov_trace_switch+0xb3/0x130 kernel/kcov.c:351
Code: 77 4e 8b 54 ce 10 65 44 8b 1d b9 9f b5 10 41 81 e3 00 01 ff 00 74 13 41 81 fb 00 01 00 00 75 d9 41 83 b8 6c 16 00 00 00 74 cf <45> 8b 98 48 16 00 00 41 83 fb 03 75 c2 4d 8b 98 50 16 00 00 45 8b
RSP: 0018:ffffc90003c667a0 EFLAGS: 00000046
RAX: 0000000000000020 RBX: 0000000000000004 RCX: 0000000000000005
RDX: ffffffff81c32a05 RSI: ffffffff8df99b60 RDI: 0000000000000004
RBP: 0000003403a09659 R08: ffff888024e28000 R09: 0000000000000011
R10: 0000000000000011 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88801d2b2010 R14: ffff88801d2b2894 R15: 00000000000b4004
FS:  0000000000000000(0000) GS:ffff8881261b1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30663fff CR3: 0000000030904000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rb_event_length+0x45/0x400 kernel/trace/ring_buffer.c:222
 rb_read_data_buffer+0x438/0x580 kernel/trace/ring_buffer.c:1823
 check_buffer+0x28a/0x750 kernel/trace/ring_buffer.c:4394
 __rb_reserve_next+0x592/0xdb0 kernel/trace/ring_buffer.c:4493
 rb_reserve_next_event kernel/trace/ring_buffer.c:4630 [inline]
 ring_buffer_lock_reserve+0xbb5/0x1010 kernel/trace/ring_buffer.c:4689
 __trace_buffer_lock_reserve kernel/trace/trace.c:1081 [inline]
 trace_event_buffer_lock_reserve+0x1d0/0x6f0 kernel/trace/trace.c:2799
 trace_event_buffer_reserve+0x248/0x340 kernel/trace/trace_events.c:672
 do_trace_event_raw_event_bpf_trace_printk kernel/trace/bpf_trace.h:11 [inline]
 trace_event_raw_event_bpf_trace_printk+0x100/0x260 kernel/trace/bpf_trace.h:11
 __do_trace_bpf_trace_printk kernel/trace/bpf_trace.h:11 [inline]
 trace_bpf_trace_printk+0x153/0x1b0 kernel/trace/bpf_trace.h:11
 ____bpf_trace_printk kernel/trace/bpf_trace.c:379 [inline]
 bpf_trace_printk+0x11e/0x190 kernel/trace/bpf_trace.c:362
 bpf_prog_b1367f0be6c54012+0x39/0x3f
 bpf_dispatcher_nop_func include/linux/bpf.h:1376 [inline]
 __bpf_prog_run include/linux/filter.h:723 [inline]
 bpf_prog_run include/linux/filter.h:730 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
 bpf_trace_run1+0x27f/0x4c0 kernel/trace/bpf_trace.c:2115
 __bpf_trace_rcu_utilization+0xa1/0xf0 include/trace/events/rcu.h:27
 __traceiter_rcu_utilization+0x7a/0xb0 include/trace/events/rcu.h:27
 __do_trace_rcu_utilization include/trace/events/rcu.h:27 [inline]
 trace_rcu_utilization+0x191/0x1c0 include/trace/events/rcu.h:27
 rcu_note_context_switch+0xc9/0x1120 kernel/rcu/tree_plugin.h:330
 __schedule+0x346/0x5000 kernel/sched/core.c:6748
 preempt_schedule_common+0x83/0xd0 kernel/sched/core.c:7047
 preempt_schedule+0xae/0xc0 kernel/sched/core.c:7071
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
 __local_bh_enable_ip+0x13e/0x1c0 kernel/softirq.c:457
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 ptr_ring_consume_bh include/linux/ptr_ring.h:377 [inline]
 wg_packet_decrypt_worker+0xca4/0xd40 drivers/net/wireguard/receive.c:499
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
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

