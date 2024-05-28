Return-Path: <bpf+bounces-30746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED198D1D0C
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 15:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8731C2332E
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 13:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C776416F270;
	Tue, 28 May 2024 13:32:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C426416E87B
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903151; cv=none; b=CQWOD65ztWZiXvF602iRKBx8s8+Vr90/My5nfPSUnZpxsQZ7u6ZC+1VMpykXejV796SheGto1tRDp4xmtJU0N0MfIQFKZ2np6lAmDn2xH2IL/HLkDKMziGw2oZoXrG9JHpFkQnLbjZnQtpysNAAoi/fPpTC8+ik2SPoMrwuOVp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903151; c=relaxed/simple;
	bh=Hcf6/+K0cr2AEWIBn+Ow6WDFFhALJcCW+K/xMomulBg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nYzNJ718XVeIQvVkc3Qd1x+7jTxtjtLVhIfFC1XlaXqIb6C96iNTPUiXR/YoJLx7TKRdgIl2SHkhz23CZyI9CBjACXmouJEVkGbDc8re0VZ3l4C+xZe2RkKFrqUTIOBMWJTOqHM2WR0UojVHpvkT71UHXH0uAanPkm8EikrDHCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7ead3d6a782so71073939f.3
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 06:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716903149; x=1717507949;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9WW/RlwC054vVaIwA33rGavwmt7/1xkbxwnwhy0KHg=;
        b=IG6HB02/jZqRAhZv85nW66FmsoeeVrrgVbZ5zG0aoOgCKUd2/gb7kQ0+5B/tnMhZYa
         haZQ/wVmbaYfskQHF4kSxieAGNv357Hl2AJrR1Cg5JaVlvyMcIjO+NuRLeKSUBipiPlH
         dupaQ9J29ZU/Vd9kCxbSspWBPghc3VKjs6vPoZMfSvM2Pwrt7bLgUS7Vb0qQowQ7fRJA
         q3Ve4MvR47nanahX/GOWOK16t1GNEFHtT+I3b1phDowF2AmMM9z5yfcMtbR59+RSNVh6
         kVL6i1DA1DiF0Uq2XCdYn19UPbobjb8cNYAWlKgU1QU6r3cEsh1FcOH+BWra59/M/RnV
         FFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWueo75ixzbrgl9Gix3wx7xnBEeo3mDZmz48djPSxkND/kcpzLf0SDwL08xeBAtav1o3Vhv9o/nYHG6X6dzxDuIhsuC
X-Gm-Message-State: AOJu0Ywaw4PidFAbKJWjcsv72Sg4AhRmA/qIXCFdel/LsSh10itcxr+p
	gG3KeXrDtg90fDLM5sSpa8lQtz47YluUohcAyWqNsX3ygJybiIcdhrcDQ0grwbsYZNCqPJOMNMe
	ZjkfUBCr2vVEgeLM0Kx2aizmOfUi1+Ukt5HcqfydPqoJ10kN3Snu7DXE=
X-Google-Smtp-Source: AGHT+IH061RFAZP5YJwlyjhet5L6Lhz0vPfet8cSLde+5yUFzBiat/Nf9XpP1xQqQsbpV3KVzb5TybgLokh3j5tvvV8FjtjlUTsk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f94:b0:7cc:cc9:4332 with SMTP id
 ca18e2360f4ac-7e8c75d37d9mr46784539f.4.1716903149092; Tue, 28 May 2024
 06:32:29 -0700 (PDT)
Date: Tue, 28 May 2024 06:32:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050d101061983aa9c@google.com>
Subject: [syzbot] [bpf?] [net?] INFO: rcu detected stall in sys_bpf (9)
From: syzbot <syzbot+4fe86fa6110c580ea1f5@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    124cfbcd6d18 Add linux-next specific files for 20240521
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15c02784980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c3a67a38201bdf7
dashboard link: https://syzkaller.appspot.com/bug?extid=4fe86fa6110c580ea1f5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a8297c980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b60342980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ff8e45d8b821/disk-124cfbcd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6aeeec759cde/vmlinux-124cfbcd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e7d931d0a4b/bzImage-124cfbcd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4fe86fa6110c580ea1f5@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5156
rcu: 	(detected by 0, t=10503 jiffies, g=9261, q=651 ncpus=2)
task:syz-executor302 state:R  running task     stack:23696 pid:5156  tgid:5156  ppid:5104   flags:0x00004002
Call Trace:
 <IRQ>
 sched_show_task+0x50c/0x6d0 kernel/sched/core.c:9191
 rcu_print_detail_task_stall_rnp kernel/rcu/tree_stall.h:262 [inline]
 print_other_cpu_stall+0x122d/0x15e0 kernel/rcu/tree_stall.h:639
 check_cpu_stall kernel/rcu/tree_stall.h:799 [inline]
 rcu_pending kernel/rcu/tree.c:4309 [inline]
 rcu_sched_clock_irq+0x9f4/0x10a0 kernel/rcu/tree.c:2636
 update_process_times+0x1ce/0x230 kernel/time/timer.c:2485
 tick_sched_handle kernel/time/tick-sched.c:276 [inline]
 tick_nohz_handler+0x37c/0x500 kernel/time/tick-sched.c:297
 __run_hrtimer kernel/time/hrtimer.c:1687 [inline]
 __hrtimer_run_queues+0x55b/0xd50 kernel/time/hrtimer.c:1751
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1813
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
RIP: 0010:rcu_dynticks_curr_cpu_in_eqs include/linux/context_tracking.h:122 [inline]
RIP: 0010:rcu_is_watching+0x5e/0xb0 kernel/rcu/tree.c:724
Code: 03 42 80 3c 38 00 74 08 4c 89 f7 e8 bc bb 7f 00 48 c7 c3 08 7d 03 00 49 03 1e 48 89 d8 48 c1 e8 03 42 0f b6 04 38 84 c0 75 22 <8b> 03 65 ff 0d 91 46 87 7e 74 10 83 e0 04 c1 e8 02 5b 41 5e 41 5f
RSP: 0018:ffffc900044070e8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff8880b9437d08 RCX: dffffc0000000000
RDX: ffff8880223cbc00 RSI: ffffffff8c1fe2e0 RDI: ffffffff8c1fe2a0
RBP: 0000000000000001 R08: ffffffff8100b50d R09: ffffffff814128cf
R10: 0000000000000003 R11: ffff8880223cbc00 R12: ffff8880223cbc00
R13: ffffffff81821c30 R14: ffffffff8ddbb9e0 R15: dffffc0000000000
 kernel_text_address+0x82/0xe0 kernel/extable.c:113
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x5d/0xc0 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0x125/0x1b0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4000 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4043
 kmalloc_reserve+0xa8/0x2a0 net/core/skbuff.c:575
 pskb_expand_head+0x202/0x1390 net/core/skbuff.c:2240
 __bpf_try_make_writable net/core/filter.c:1668 [inline]
 bpf_try_make_writable net/core/filter.c:1674 [inline]
 bpf_try_make_head_writable net/core/filter.c:1682 [inline]
 ____bpf_clone_redirect net/core/filter.c:2456 [inline]
 bpf_clone_redirect+0x119/0x370 net/core/filter.c:2434
 bpf_prog_de5959beb1c8948f+0x5a/0x5f
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 bpf_test_run+0x409/0x910 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0xafa/0x13a0 net/bpf/test_run.c:1066
 bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4291
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5705
 __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffa8dbee859
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe8675d058 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ffa8dbee859
RDX: 0000000000000050 RSI: 0000000020000080 RDI: 000000000000000a
RBP: 0000000000000000 R08: 0000000100000000 R09: 0000000100000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 10553 jiffies! g9261 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26512 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a50 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 rcu_gp_fqs_loop+0x2df/0x1370 kernel/rcu/tree.c:2000
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2202
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 PID: 5156 Comm: syz-executor302 Not tainted 6.9.0-next-20240521-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
RIP: 0010:rcu_dynticks_curr_cpu_in_eqs include/linux/context_tracking.h:122 [inline]
RIP: 0010:rcu_is_watching+0x5e/0xb0 kernel/rcu/tree.c:724
Code: 03 42 80 3c 38 00 74 08 4c 89 f7 e8 bc bb 7f 00 48 c7 c3 08 7d 03 00 49 03 1e 48 89 d8 48 c1 e8 03 42 0f b6 04 38 84 c0 75 22 <8b> 03 65 ff 0d 91 46 87 7e 74 10 83 e0 04 c1 e8 02 5b 41 5e 41 5f
RSP: 0018:ffffc900044070e8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff8880b9437d08 RCX: dffffc0000000000
RDX: ffff8880223cbc00 RSI: ffffffff8c1fe2e0 RDI: ffffffff8c1fe2a0
RBP: 0000000000000001 R08: ffffffff8100b50d R09: ffffffff814128cf
R10: 0000000000000003 R11: ffff8880223cbc00 R12: ffff8880223cbc00
R13: ffffffff81821c30 R14: ffffffff8ddbb9e0 R15: dffffc0000000000
FS:  000055557e93c380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffa8dc6b0f0 CR3: 000000007b0de000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 kernel_text_address+0x82/0xe0 kernel/extable.c:113
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x5d/0xc0 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0x125/0x1b0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4000 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4043
 kmalloc_reserve+0xa8/0x2a0 net/core/skbuff.c:575
 pskb_expand_head+0x202/0x1390 net/core/skbuff.c:2240
 __bpf_try_make_writable net/core/filter.c:1668 [inline]
 bpf_try_make_writable net/core/filter.c:1674 [inline]
 bpf_try_make_head_writable net/core/filter.c:1682 [inline]
 ____bpf_clone_redirect net/core/filter.c:2456 [inline]
 bpf_clone_redirect+0x119/0x370 net/core/filter.c:2434
 bpf_prog_de5959beb1c8948f+0x5a/0x5f
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 bpf_test_run+0x409/0x910 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0xafa/0x13a0 net/bpf/test_run.c:1066
 bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4291
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5705
 __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffa8dbee859
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe8675d058 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ffa8dbee859
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

