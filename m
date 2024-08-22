Return-Path: <bpf+bounces-37840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D943A95B0DC
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 10:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092561C22A96
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3725171E69;
	Thu, 22 Aug 2024 08:45:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79013699B
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316333; cv=none; b=pCqHKPPjL6+acw5DYJchlAHkOCfSbfVP+c3XAG0L8kAu8QMlHfA2YNG4+n3y/Moosr/rFx/8zYrFophBlsmjvSRkaAhPqgYt11b9cR5+OtL4cvnMD2M3G125AiXLINpIRZpgyY0WIi7ZaOkbbZM86nvkR9N1bZtJXclCoby7zak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316333; c=relaxed/simple;
	bh=0Mo+4l1qwJxT7WT4DSjc4fwiVAck/LED6dtdHPJMOcE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z/BKsAG/WxghkTZ8tAvNRChxVl2AN5qCrzjsCPYLOjxcsQJ/z54Vn1fER1Og9nXifo0kpDpUQ81sVKLK8UKHeABXi/E1ULLaagFn4ok9zyGWIVuZlqdrR8yFB7gltLIvpD1qki9ZrvDjZbV+ggslNslmhXfPoeNPG7qMICqWt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d2ceca837so6715185ab.2
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724316330; x=1724921130;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2h7jqj1fFmtqZgTdzjWs+nMkRAvpSqEaG3NeRYVTlE=;
        b=Z77BS7r4yjmKy9iu93298jv7HQMJKfUo7RQdVtMr7q5Mcw4BfCt4UF+3zE3izKVVYL
         aBSkYPln0XIpAmf5yLGM9H1D2QnUtf7GgJDnWD/P2CgW+vu0Q2ysRCJeIsy9h2Dt2/Tc
         DIDL9R2QeSVsjKcqwvOsSNw0M5O298szG1Mt/kbhjzB2m8mf3PIVS7Yg6lkBeJ04tHLf
         y1kLYBNxe8BAjIzYC5Jel4ZNEOTkmCxPCEsIEMulQcPtXQ4gA8aOVGHy3pzkiTlGUjfF
         PDZqW6dTfVQK14+woXP4faSTMbvIQwmpfTcmc5nx8ouJ6X+BycyZgQ1upxrdoBHWARlc
         i5jw==
X-Forwarded-Encrypted: i=1; AJvYcCV7KLH8D1IQ08wie9Xa8XxmZ4dfk1AYWn/Lz4RC46KPMtaOnnYjBJLM1nTk4F3WzvvwQsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnj+/LIaOAih7nZwk9mi+yOgCZe1c2JEqzMqD0jybzahFJeUMo
	NFuDEWcm8/eBBnH/iV/W70XMQgC5eAShRm20g6efm3uonrr83sCzpVdlvZVzGXS/HnfK8Y/8/8Y
	WNSd5kU9t/U0Za2ZmVx0gX0dpn3cRTOPJuN9caXMUYYyZp+VDZ+jCMBg=
X-Google-Smtp-Source: AGHT+IGCLlJLUFe4pkakz4hY8kRovunsHq/JSpZhYTlpRyCy9clQYQ7f7JmEFN4Lmfm74YBfJd6EYWmplAamp9zjJrCYJuMXS+jy
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d94:b0:398:36c0:796e with SMTP id
 e9e14a558f8ab-39d6c343399mr3313545ab.1.1724316329957; Thu, 22 Aug 2024
 01:45:29 -0700 (PDT)
Date: Thu, 22 Aug 2024 01:45:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053eb57062041aef7@google.com>
Subject: [syzbot] [bpf?] possible deadlock in work_grab_pending
From: syzbot <syzbot+fbf8ab9c22c12e84f438@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    367b5c3d53e5 Add linux-next specific files for 20240816
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1567fde5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=fbf8ab9c22c12e84f438
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0b1b4e3cad3c/disk-367b5c3d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5bb090f7813c/vmlinux-367b5c3d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6674cb0709b1/bzImage-367b5c3d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbf8ab9c22c12e84f438@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc3-next-20240816-syzkaller #0 Not tainted
------------------------------------------------------
swapper/1/0 is trying to acquire lock:
ffff8880158a0018 (&pool->lock){-.-.}-{2:2}, at: try_to_grab_pending kernel/workqueue.c:2084 [inline]
ffff8880158a0018 (&pool->lock){-.-.}-{2:2}, at: work_grab_pending+0x294/0xae0 kernel/workqueue.c:2160

but task is already holding lock:
ffff8880b9129430 (krc.lock){..-.}-{2:2}, at: krc_this_cpu_lock kernel/rcu/tree.c:3312 [inline]
ffff8880b9129430 (krc.lock){..-.}-{2:2}, at: add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3724 [inline]
ffff8880b9129430 (krc.lock){..-.}-{2:2}, at: kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3810

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (krc.lock){..-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5762
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       krc_this_cpu_lock kernel/rcu/tree.c:3312 [inline]
       add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3724 [inline]
       kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3810
       trie_delete_elem+0x546/0x6a0 kernel/bpf/lpm_trie.c:540
       0xffffffffa0001fe3
       bpf_dispatcher_nop_func include/linux/bpf.h:1252 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2338 [inline]
       bpf_trace_run4+0x334/0x590 kernel/trace/bpf_trace.c:2381
       trace_sched_switch include/trace/events/sched.h:222 [inline]
       __schedule+0x2591/0x4ad0 kernel/sched/core.c:6636
       preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6818
       preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6842
       preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
       class_preempt_destructor include/linux/preempt.h:480 [inline]
       try_to_wake_up+0x9a1/0x1470 kernel/sched/core.c:4236
       wake_up_process kernel/sched/core.c:4361 [inline]
       wake_up_q+0xc8/0x120 kernel/sched/core.c:1056
       futex_wake+0x523/0x5c0 kernel/futex/waitwake.c:199
       do_futex+0x392/0x560 kernel/futex/syscalls.c:107
       __do_sys_futex kernel/futex/syscalls.c:179 [inline]
       __se_sys_futex+0x3f9/0x480 kernel/futex/syscalls.c:160
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5762
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:587
       raw_spin_rq_lock kernel/sched/sched.h:1485 [inline]
       task_rq_lock+0xc6/0x360 kernel/sched/core.c:689
       cgroup_move_task+0x92/0x2d0 kernel/sched/psi.c:1161
       css_set_move_task+0x72e/0x950 kernel/cgroup/cgroup.c:898
       cgroup_post_fork+0x256/0x880 kernel/cgroup/cgroup.c:6690
       copy_process+0x3ab1/0x3e30 kernel/fork.c:2620
       kernel_clone+0x226/0x8f0 kernel/fork.c:2806
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2884
       rest_init+0x23/0x300 init/main.c:712
       start_kernel+0x47a/0x500 init/main.c:1103
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5762
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
       try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4113
       create_worker+0x507/0x720 kernel/workqueue.c:2828
       workqueue_init+0x520/0x8a0 kernel/workqueue.c:7902
       kernel_init_freeable+0x3fe/0x5d0 init/main.c:1562
       kernel_init+0x1d/0x2b0 init/main.c:1467
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&pool->lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3136 [inline]
       check_prevs_add kernel/locking/lockdep.c:3255 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3871
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5145
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5762
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       try_to_grab_pending kernel/workqueue.c:2084 [inline]
       work_grab_pending+0x294/0xae0 kernel/workqueue.c:2160
       mod_delayed_work_on+0xd4/0x370 kernel/workqueue.c:2588
       kvfree_call_rcu+0x47f/0x790 kernel/rcu/tree.c:3838
       cfg80211_update_known_bss+0xb39/0x1500 net/wireless/scan.c:1891
       __cfg80211_bss_update+0x153/0x2170 net/wireless/scan.c:1937
       cfg80211_inform_single_bss_data+0xd51/0x2030 net/wireless/scan.c:2331
       cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3159
       cfg80211_inform_bss_frame_data+0x3b8/0x720 net/wireless/scan.c:3254
       ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
       ieee80211_scan_rx+0x526/0x9c0 net/mac80211/scan.c:340
       __ieee80211_rx_handle_packet net/mac80211/rx.c:5225 [inline]
       ieee80211_rx_list+0x2b02/0x3780 net/mac80211/rx.c:5462
       ieee80211_rx_napi+0x18a/0x3c0 net/mac80211/rx.c:5485
       ieee80211_rx include/net/mac80211.h:5124 [inline]
       ieee80211_handle_queued_frames+0xe7/0x1e0 net/mac80211/main.c:439
       tasklet_action_common+0x321/0x4d0 kernel/softirq.c:785
       handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
       __do_softirq kernel/softirq.c:588 [inline]
       invoke_softirq kernel/softirq.c:428 [inline]
       __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
       irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
       instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
       sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1037
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
       native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
       arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
       acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:111
       acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:702
       cpuidle_enter_state+0x112/0x480 drivers/cpuidle/cpuidle.c:267
       cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
       call_cpuidle kernel/sched/idle.c:155 [inline]
       cpuidle_idle_call kernel/sched/idle.c:230 [inline]
       do_idle+0x375/0x5d0 kernel/sched/idle.c:326
       cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:424
       __pfx_ap_starting+0x0/0x10 arch/x86/kernel/smpboot.c:313
       common_startup_64+0x13e/0x147

other info that might help us debug this:

Chain exists of:
  &pool->lock --> &rq->__lock --> krc.lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(krc.lock);
                               lock(&rq->__lock);
                               lock(krc.lock);
  lock(&pool->lock);

 *** DEADLOCK ***

4 locks held by swapper/1/0:
 #0: ffffffff8e939720 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e939720 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e939720 (rcu_read_lock){....}-{1:2}, at: ieee80211_rx_napi+0xd6/0x3c0 net/mac80211/rx.c:5484
 #1: ffff8880799c0168 (&rdev->bss_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #1: ffff8880799c0168 (&rdev->bss_lock){+.-.}-{2:2}, at: cfg80211_inform_single_bss_data+0xd3d/0x2030 net/wireless/scan.c:2330
 #2: ffff8880b9129430 (krc.lock){..-.}-{2:2}, at: krc_this_cpu_lock kernel/rcu/tree.c:3312 [inline]
 #2: ffff8880b9129430 (krc.lock){..-.}-{2:2}, at: add_ptr_to_bulk_krc_lock kernel/rcu/tree.c:3724 [inline]
 #2: ffff8880b9129430 (krc.lock){..-.}-{2:2}, at: kvfree_call_rcu+0x18a/0x790 kernel/rcu/tree.c:3810
 #3: ffffffff8e939720 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #3: ffffffff8e939720 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8e939720 (rcu_read_lock){....}-{1:2}, at: try_to_grab_pending kernel/workqueue.c:2075 [inline]
 #3: ffffffff8e939720 (rcu_read_lock){....}-{1:2}, at: work_grab_pending+0x1d3/0xae0 kernel/workqueue.c:2160

stack backtrace:
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.11.0-rc3-next-20240816-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2189
 check_prev_add kernel/locking/lockdep.c:3136 [inline]
 check_prevs_add kernel/locking/lockdep.c:3255 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3871
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5145
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5762
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 try_to_grab_pending kernel/workqueue.c:2084 [inline]
 work_grab_pending+0x294/0xae0 kernel/workqueue.c:2160
 mod_delayed_work_on+0xd4/0x370 kernel/workqueue.c:2588
 kvfree_call_rcu+0x47f/0x790 kernel/rcu/tree.c:3838
 cfg80211_update_known_bss+0xb39/0x1500 net/wireless/scan.c:1891
 __cfg80211_bss_update+0x153/0x2170 net/wireless/scan.c:1937
 cfg80211_inform_single_bss_data+0xd51/0x2030 net/wireless/scan.c:2331
 cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3159
 cfg80211_inform_bss_frame_data+0x3b8/0x720 net/wireless/scan.c:3254
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x526/0x9c0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5225 [inline]
 ieee80211_rx_list+0x2b02/0x3780 net/mac80211/rx.c:5462
 ieee80211_rx_napi+0x18a/0x3c0 net/mac80211/rx.c:5485
 ieee80211_rx include/net/mac80211.h:5124 [inline]
 ieee80211_handle_queued_frames+0xe7/0x1e0 net/mac80211/main.c:439
 tasklet_action_common+0x321/0x4d0 kernel/softirq.c:785
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1037
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:92 [inline]
RIP: 0010:acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:112
Code: 90 90 90 90 90 90 90 90 90 65 48 8b 04 25 80 d7 03 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d d5 69 ae 00 f3 0f 1e fa fb f4 <fa> c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc900001a7d08 EFLAGS: 00000246
RAX: ffff888017ec0000 RBX: ffff88801bea9864 RCX: 000000000019e8c9
RDX: 0000000000000001 RSI: ffff88801bea9800 RDI: ffff88801bea9864
RBP: 000000000003a6f8 R08: ffff8880b9137c7b R09: 1ffff11017226f8f
R10: dffffc0000000000 R11: ffffffff8bbbf1e0 R12: ffff888018b56000
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8f0e8660
 acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:702
 cpuidle_enter_state+0x112/0x480 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:230 [inline]
 do_idle+0x375/0x5d0 kernel/sched/idle.c:326
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:424
 start_secondary+0x100/0x100 arch/x86/kernel/smpboot.c:313
 common_startup_64+0x13e/0x147
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	65 48 8b 04 25 80 d7 	mov    %gs:0x3d780,%rax
  10:	03 00
  12:	48 f7 00 08 00 00 00 	testq  $0x8,(%rax)
  19:	75 10                	jne    0x2b
  1b:	66 90                	xchg   %ax,%ax
  1d:	0f 00 2d d5 69 ae 00 	verw   0xae69d5(%rip)        # 0xae69f9
  24:	f3 0f 1e fa          	endbr64
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  37:	00 00
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


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

