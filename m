Return-Path: <bpf+bounces-38606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7706966B00
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379A3B237E5
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 20:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250051C4EC3;
	Fri, 30 Aug 2024 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="Pa7JVIkd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541481C4EEB
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051124; cv=none; b=H9QyDPZ/G/SwiaE4WMoDJVAgsNkqeKNtBgxTAdqpve2AGDDX3DMTYXxn7OsNVP0dOpePu12ojtgWMy11vA02lH/VBQBrgxIS4KsulnexqB9KSbpfSgVbiMMD2jJ4YYpKLqKywGIQl6jnSSNa59kbBtkPL6XnFZtT7xUIj7SYMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051124; c=relaxed/simple;
	bh=Ejj7BVD/yOJszEoNWUQKe3ldNGbDP8sIkSDpXLXUCNg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=n7/V4cRzohRPKSWe8gsSh3t5G6YkyQ+p4rF//dvAxGZgpJ/3fh0VeyJ/HZtzIsN0xFUxQnXdZKRUGuaIDUp7VPPwesEuAfhOxY8Mx0AlSV0k730r+Ut1LrThqoU2Dq+KgYn+b5hecxKKAVNSnWGn5jynemDoyEMhYgOKLIA4IVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=Pa7JVIkd; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5342109d726so1699108e87.0
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 13:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1725051120; x=1725655920; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=puJeBdn4sKonRdO9CYZqMy/hfkaPIwV+lK9Y2SyDOqw=;
        b=Pa7JVIkdH64gdz6Wya7UH3JO9IVARDtMwkAido1JKfDuUl+SVLfmeveeEPS8MRr1dC
         cDM+UQNEUEzu2c2UNCSHmszv+7anem9OBhRma+MLHYXJQ7b0Vvq7XTO4JRJ1JDrH4cko
         N0Rkekn4q0T2My00UreDNbeoqZrmikaELKaAmLyYRo64Dx3x/6wWD+5D8/Zy/HPnKogt
         /V5K3dfqVaJKA0ZUwCigiAaV7tJRYXkqqySoY3RNiL0AV8Y3UTOJLU9bVLMWLA2QElDH
         3wKTZoHeEfHcoVgA3yPD9qi28N3qYx6wcX2ULNH8QA7w6DWtTkNvn5Ln/BA5xRadmb3w
         7JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725051120; x=1725655920;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=puJeBdn4sKonRdO9CYZqMy/hfkaPIwV+lK9Y2SyDOqw=;
        b=rAdxDZGMyVZeMfhMpW9NZaNq1FbnVAC4P7f9LBTz8ypN/8yZPEB13jH62fKQqO3ggY
         34LrpM2ItkZ5Gk2cy5WM0w/Li7QH+vKFteoZKtMear81SmFysJbeC6YhYbZrdYtCqtjp
         aLRz5i138uhOv+3n2YUyfVZbBHN+EarfMjuhmtVwn5OGuGk1B0LkEp2f0qI7sgt1I5oM
         tZ8V652zffAqqT4FIiRpXQf2klrzOEOPWSpWugdBIwxXYbN+xB9Txdkbg7tiDzMls08e
         tuCMS93RxIemq9SWMPG9UdKwBRHWGaECLlFEx/lL8qJQ8VrYLijm2ipohdMb9UPxdqZu
         PvhQ==
X-Gm-Message-State: AOJu0Yyf8TeSCiuV4LRlgHIXvLlBGEZCGWN+hYHWME/4YpcFqXEhn3Rw
	uQ85PZXDVPecEya5NsAdM38PgQMdForO6a1gjM3RcDFPeuQ9A8grPOD1o9pHqROX7dBG0ZxtZ6a
	CSpsKVImHNcUNULtT1nOKv/ZKvHmfbEaXRnSIoQ==
X-Google-Smtp-Source: AGHT+IG/O4H9RD+OpPpdIgnKWQapUFuMUkRGSFOdkKfDnL2TXn88ZfTNsICrDiZ85sEBVt1WkBg1cNsiU9rmqmJMjXI=
X-Received: by 2002:a05:6512:220c:b0:52e:f91b:f7c7 with SMTP id
 2adb3069b0e04-5353ebdb2c9mr2425738e87.19.1725051119969; Fri, 30 Aug 2024
 13:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Fri, 30 Aug 2024 13:51:47 -0700
Message-ID: <CAPPBnEaCB1rFAYU7Wf8UxqcqOWKmRPU1Nuzk3_oLk6qXR7LBOA@mail.gmail.com>
Subject: Possible deadlock in bpf_lru_pop_free
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Hsin-Wei Hung <hsinweih@uci.edu>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"

Hello,

We are developing a tool to perform static analysis on the bpf
subsystem to detect locking violations. Our tool reported a nested bpf
locking issue with bpf lru percpu hashtable map. The function
bpf_percpu_lru_pop_free takes a spin_lock and can be called from eBPF
programs through bpf_map_update_elem. A deadlock will occur if an eBPF
program calls bpf_map_update_elem, takes the spin lock in
bpf_percpu_lru_pop_free, and another eBPF program calling
bpf_map_update_elem is triggered before the first program can release
the lock.

We tried to validate the report on v6.10 kernel by running a PoC.
Below is the lockdep splat. The PoC is attached at the end.

Thanks,
Priya

============================================
 WARNING: possible recursive locking detected
 6.10.0-rc7+ #53 Not tainted
 --------------------------------------------
 cp_user/2035 is trying to acquire lock:
 ffffe8fffda39758 (&l->lock){....}-{2:2}, at: bpf_lru_pop_free+0x5d7/0x2010

 but task is already holding lock:
 ffffe8fffda39758 (&l->lock){....}-{2:2}, at: bpf_lru_pop_free+0x5d7/0x2010

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&l->lock);
   lock(&l->lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 3 locks held by cp_user/2035:
  #0: ffffffff85d5be80 (rcu_read_lock_trace){....}-{0:0}, at:
bpf_prog_test_run_syscall+0x2ae/0x770
  #1: ffffe8fffda39758 (&l->lock){....}-{2:2}, at: bpf_lru_pop_free+0x5d7/0x2010
  #2: ffffffff85d5cbc0 (rcu_read_lock){....}-{1:3}, at:
trace_call_bpf+0xc3/0x810

 stack backtrace:
 CPU: 7 PID: 2035 Comm: cp_user Not tainted 6.10.0-rc7+ #53
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x9f/0xf0
  dump_stack+0x14/0x20
  print_deadlock_bug+0x3ca/0x680
  __lock_acquire+0x2ff5/0x6a60
  ? __pfx___lock_acquire+0x10/0x10
  ? __kasan_check_read+0x15/0x20
  ? rb_commit+0xec/0x960
  lock_acquire+0x1be/0x560
  ? bpf_lru_pop_free+0x5d7/0x2010
  ? __kasan_check_read+0x15/0x20
  ? __pfx_lock_acquire+0x10/0x10
  ? trace_buffer_unlock_commit_regs+0x51/0x4b0
  ? trace_event_buffer_commit+0x19c/0xb60
  _raw_spin_lock_irqsave+0x55/0xa0
  ? bpf_lru_pop_free+0x5d7/0x2010
  bpf_lru_pop_free+0x5d7/0x2010
  ? __pfx_trace_event_raw_event_bpf_trace_printk+0x10/0x10
  ? __pfx_bstr_printf+0x10/0x10
  ? __this_cpu_preempt_check+0x17/0x20
  prealloc_lru_pop+0x24/0xd0
  __htab_lru_percpu_map_update_elem+0x19d/0x5d0
  ? __pfx___htab_lru_percpu_map_update_elem+0x10/0x10
  htab_lru_percpu_map_update_elem+0x15/0x20
  bpf_prog_2ee6c180efbc46fd_test_prog2+0x5e/0x62
  trace_call_bpf+0x24d/0x810
  ? __pfx_trace_call_bpf+0x10/0x10
  ? __bpf_lru_list_rotate_inactive+0x1/0x3b0
  kprobe_perf_func+0x108/0x8c0
  ? __pfx_kprobe_perf_func+0x10/0x10
  ? __this_cpu_preempt_check+0x17/0x20
  kprobe_dispatcher+0xbc/0x160
  ? __bpf_lru_list_rotate_inactive+0x1/0x3b0
  kprobe_ftrace_handler+0x2f3/0x4d0
  ? __bpf_lru_list_rotate_inactive+0x5/0x3b0
  e1000_init_module+0xe9/0xff0 [e1000]
 RIP: 0010:__bpf_lru_list_rotate_inactive+0x1/0x3b0
 Code: c7 c7 60 66 f6 85 e8 6e 99 10 01 e9 58 fe ff ff 66 0f 1f 84 00
00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 <eb> f7
08 1f 48 b8 00 00 00 00 00 fc ff df 55 48 89 f9 48 89 e5 41
 RSP: 0018:ffff8881186e7788 EFLAGS: 00000002 ORIG_RAX: 0000000000000000
 RAX: 0000000000000000 RBX: 0000000000000246 RCX: 0000000000000000
 RDX: 1ffffd1fffb472e6 RSI: ffffe8fffda39700 RDI: ffff888116710300
 RBP: ffff8881186e7858 R08: ffff8881f4a319a0 R09: 1ffffffff0a41faf
 R10: ffffffff88097967 R11: 00000000028bcecb R12: ffffe8fffda39740
 R13: ffff888116710300 R14: 0000000000000001 R15: ffffe8fffda39700
  ? __bpf_lru_list_rotate_inactive+0x5/0x3b0
  ? bpf_lru_pop_free+0x17d/0x2010
  ? __bpf_lru_list_rotate_inactive+0x5/0x3b0
  ? bpf_lru_pop_free+0x17d/0x2010
  ? __pfx_trace_event_raw_event_bpf_trace_printk+0x10/0x10
  prealloc_lru_pop+0x24/0xd0
  __htab_lru_percpu_map_update_elem+0x19d/0x5d0
  ? __pfx___htab_lru_percpu_map_update_elem+0x10/0x10
  htab_lru_percpu_map_update_elem+0x15/0x20
  bpf_prog_097db1e6f91af2e2_test_prog1+0x5e/0x76
  bpf_prog_test_run_syscall+0x319/0x770
  ? __pfx_bpf_prog_test_run_syscall+0x10/0x10
  ? __kasan_check_write+0x18/0x20
  ? __bpf_prog_get+0x1c0/0x260
  __sys_bpf+0xa2d/0x3d00
  ? __pfx___sys_bpf+0x10/0x10
  ? debug_smp_processor_id+0x1b/0x30
  ? do_syscall_64+0x97/0x140
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  ? __pfx_lock_release+0x10/0x10
  __x64_sys_bpf+0x78/0xc0
  ? lockdep_hardirqs_on+0xcf/0x150
  x64_sys_call+0x124a/0x1f20
  do_syscall_64+0x8b/0x140
  ? __pfx___mutex_unlock_slowpath+0x10/0x10
  ? perf_event_ctx_lock_nested+0x35/0x3a0
  ? trace_hardirqs_on+0x51/0x60
  ? debug_smp_processor_id+0x1b/0x30
  ? do_syscall_64+0x97/0x140
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? debug_smp_processor_id+0x1b/0x30
  ? do_syscall_64+0x97/0x140
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? do_syscall_64+0x97/0x140
  ? do_syscall_64+0x97/0x140
  ? exc_page_fault+0x8d/0x110
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7fc40791e88d
 Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
 RSP: 002b:00007ffccd5919d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
 RAX: ffffffffffffffda RBX: 00007ffccd591ad0 RCX: 00007fc40791e88d
 RDX: 0000000000000050 RSI: 00007ffccd5919e0 RDI: 000000000000000a
 RBP: 00007ffccd591b80 R08: 00005569b3169480 R09: 0000000000000007
 R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffccd591c98
 R13: 0000556991bcf351 R14: 0000556991bd1d40 R15: 00007fc407ca7040
  </TASK>
 BUG: workqueue lockup - pool cpus=7 node=0 flags=0x0 nice=0 stuck for 70s!
 Showing busy workqueues and worker pools:
 workqueue events: flags=0x0
   pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
     pending: vmstat_shepherd
 workqueue mm_percpu_wq: flags=0x8
   pwq 30: cpus=7 node=0 flags=0x0 nice=0 active=1 refcnt=2
     pending: vmstat_update
 Showing backtraces of running workers in stalled CPU-bound worker pools:
 rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
 rcu:      7-...0: (1 GPs behind) idle=aae4/1/0x4000000000000000
softirq=67260/67284 fqs=5218
 rcu:      (detected by 6, t=26252 jiffies, g=329697, q=7812 ncpus=16)
 Sending NMI from CPU 6 to CPUs 7:
 NMI backtrace for cpu 7
 CPU: 7 PID: 2035 Comm: cp_user Not tainted 6.10.0-rc7+ #53
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
 RIP: 0010:native_halt+0xe/0x20
 Code: 41 89 11 c9 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 03 4b 03 f4 <c3> cc
cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90
 RSP: 0018:ffff8881186e7060 EFLAGS: 00000046
 RAX: 0000000000000003 RBX: ffffe8fffda39740 RCX: ffffffff842142ea
 RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffe8fffda39740
 RBP: ffff8881186e7078 R08: 0000000000000001 R09: fffff91fffb472e8
 R10: ffffe8fffda39740 R11: 0000000000000001 R12: dffffc0000000000
 R13: ffff8881f4c1a200 R14: 0000000000000000 R15: ffff8881186e7180
 FS:  00007fc407bb9fc0(0000) GS:ffff8881f4a00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fc407c3f210 CR3: 0000000117280004 CR4: 0000000000370ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <NMI>
  ? show_regs+0x68/0x80
  ? nmi_cpu_backtrace+0x12d/0x220
  ? nmi_cpu_backtrace_handler+0x15/0x20
  ? nmi_handle+0x168/0x4a0
  ? native_halt+0xe/0x20
  ? default_do_nmi+0x6e/0x180
  ? exc_nmi+0x1cd/0x2a0
  ? end_repeat_nmi+0xf/0x53
  ? __pv_queued_spin_lock_slowpath+0xb2a/0xe80
  ? native_halt+0xe/0x20
  ? native_halt+0xe/0x20
  ? native_halt+0xe/0x20
  </NMI>
  <TASK>
  ? kvm_wait+0xb2/0x120
  ? __kasan_check_write+0x18/0x20
  __pv_queued_spin_lock_slowpath+0x530/0xe80
  ? __pfx___pv_queued_spin_lock_slowpath+0x10/0x10
  ? debug_smp_processor_id+0x1b/0x30
  ? rcu_is_watching+0x17/0xd0
  ? spin_bug+0x1f/0x1e0
  do_raw_spin_lock+0x1f2/0x280
  ? __pfx_do_raw_spin_lock+0x10/0x10
  ? trace_event_buffer_commit+0x19c/0xb60
  _raw_spin_lock_irqsave+0x9b/0xa0
  bpf_lru_pop_free+0x5d7/0x2010
  ? __pfx_trace_event_raw_event_bpf_trace_printk+0x10/0x10
  ? __pfx_bstr_printf+0x10/0x10
  ? __this_cpu_preempt_check+0x17/0x20
  prealloc_lru_pop+0x24/0xd0
  __htab_lru_percpu_map_update_elem+0x19d/0x5d0
  ? __pfx___htab_lru_percpu_map_update_elem+0x10/0x10
  htab_lru_percpu_map_update_elem+0x15/0x20
  bpf_prog_2ee6c180efbc46fd_test_prog2+0x5e/0x62
  trace_call_bpf+0x24d/0x810
  ? __pfx_trace_call_bpf+0x10/0x10
  ? __bpf_lru_list_rotate_inactive+0x1/0x3b0
  kprobe_perf_func+0x108/0x8c0
  ? __pfx_kprobe_perf_func+0x10/0x10
  ? __this_cpu_preempt_check+0x17/0x20
  kprobe_dispatcher+0xbc/0x160
  ? __bpf_lru_list_rotate_inactive+0x1/0x3b0
  kprobe_ftrace_handler+0x2f3/0x4d0
  ? __bpf_lru_list_rotate_inactive+0x5/0x3b0
  e1000_init_module+0xe9/0xff0 [e1000]
 RIP: 0010:__bpf_lru_list_rotate_inactive+0x1/0x3b0
 Code: c7 c7 60 66 f6 85 e8 6e 99 10 01 e9 58 fe ff ff 66 0f 1f 84 00
00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 <eb> f7
08 1f 48 b8 00 00 00 00 00 fc ff df 55 48 89 f9 48 89 e5 41
 RSP: 0018:ffff8881186e7788 EFLAGS: 00000002 ORIG_RAX: 0000000000000000
 RAX: 0000000000000000 RBX: 0000000000000246 RCX: 0000000000000000
 RDX: 1ffffd1fffb472e6 RSI: ffffe8fffda39700 RDI: ffff888116710300
 RBP: ffff8881186e7858 R08: ffff8881f4a319a0 R09: 1ffffffff0a41faf
 R10: ffffffff88097967 R11: 00000000028bcecb R12: ffffe8fffda39740
 R13: ffff888116710300 R14: 0000000000000001 R15: ffffe8fffda39700
  ? __bpf_lru_list_rotate_inactive+0x5/0x3b0
  ? bpf_lru_pop_free+0x17d/0x2010
  ? __bpf_lru_list_rotate_inactive+0x5/0x3b0
  ? bpf_lru_pop_free+0x17d/0x2010
  ? __pfx_trace_event_raw_event_bpf_trace_printk+0x10/0x10
  prealloc_lru_pop+0x24/0xd0
  __htab_lru_percpu_map_update_elem+0x19d/0x5d0
  ? __pfx___htab_lru_percpu_map_update_elem+0x10/0x10
  htab_lru_percpu_map_update_elem+0x15/0x20
  bpf_prog_097db1e6f91af2e2_test_prog1+0x5e/0x76
  bpf_prog_test_run_syscall+0x319/0x770
  ? __pfx_bpf_prog_test_run_syscall+0x10/0x10
  ? __kasan_check_write+0x18/0x20
  ? __bpf_prog_get+0x1c0/0x260
  __sys_bpf+0xa2d/0x3d00
  ? __pfx___sys_bpf+0x10/0x10
  ? debug_smp_processor_id+0x1b/0x30
  ? do_syscall_64+0x97/0x140
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  ? __pfx_lock_release+0x10/0x10
  __x64_sys_bpf+0x78/0xc0
  ? lockdep_hardirqs_on+0xcf/0x150
  x64_sys_call+0x124a/0x1f20
  do_syscall_64+0x8b/0x140
  ? __pfx___mutex_unlock_slowpath+0x10/0x10
  ? perf_event_ctx_lock_nested+0x35/0x3a0
  ? trace_hardirqs_on+0x51/0x60
  ? debug_smp_processor_id+0x1b/0x30
  ? do_syscall_64+0x97/0x140
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? debug_smp_processor_id+0x1b/0x30
  ? do_syscall_64+0x97/0x140
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? do_syscall_64+0x97/0x140
  ? do_syscall_64+0x97/0x140
  ? exc_page_fault+0x8d/0x110
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7fc40791e88d
 Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
 RSP: 002b:00007ffccd5919d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
 RAX: ffffffffffffffda RBX: 00007ffccd591ad0 RCX: 00007fc40791e88d
 RDX: 0000000000000050 RSI: 00007ffccd5919e0 RDI: 000000000000000a
 RBP: 00007ffccd591b80 R08: 00005569b3169480 R09: 0000000000000007
 R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffccd591c98
 R13: 0000556991bcf351 R14: 0000556991bd1d40 R15: 00007fc407ca7040
  </TASK>

The deadlock can be triggered using the following bpf and user programs.
================================================================================

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include <bpf/bpf_endian.h>

char LICENSE[] SEC("license") = "GPL";


struct {
        __uint(type, BPF_MAP_TYPE_LRU_PERCPU_HASH);
        __uint(max_entries, 1024);
        __type(key, __u32);
        __type(value, __u64);
        __uint(map_flags, 2);
} this_map SEC(".maps");


SEC("classifier")
int test_prog1(struct __sk_buff *ctx){
        __u32 key = 1;
        __u64 value = 2;
        bpf_map_update_elem(&this_map, &key, &value, BPF_ANY);
        bpf_printk("classifier");
        return 0;
}


SEC("kprobe/__bpf_lru_list_rotate_inactive")
int test_prog2(void *ctx){
        __u32 key = 1;
        __u64 value = 2;
        bpf_printk("kprobe");
        bpf_map_update_elem(&this_map, &key, &value, BPF_ANY);
        return 0;
}

=====================================================================================================

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <bpf/libbpf.h>
#include <bpf/bpf.h>
#include <signal.h>

#define LO_IFINDEX 1

static int libbpf_print_fn(enum libbpf_print_level level, const char
*format, va_list args)
{
        return vfprintf(stderr, format, args);
}

static volatile bool exiting = false;

static void sig_handler(int sig)
{
        exiting = true;
}



int main(int argc, char **argv)
{
        int err;

        libbpf_set_print(libbpf_print_fn);

        //handling ctrl+c
        signal(SIGINT, sig_handler);
        signal(SIGTERM, sig_handler);

        DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook, .ifindex = LO_IFINDEX,
                            .attach_point = BPF_TC_INGRESS);
        DECLARE_LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
        bool hook_created = false;

        const char *obj_file = "cp_user.bpf.o";
        struct bpf_object *obj = bpf_object__open_file(obj_file, NULL);
        if (!obj)
                return 1;

        err = bpf_object__load(obj);
        if (err) {
                fprintf(stderr, "Error loading BPF target object\n");
                return 1;
        }

        struct bpf_program *prog1 =
bpf_object__find_program_by_name(obj, "test_prog1");
        if (!prog1) {
                fprintf(stderr, "Error finding BPF program by title\n");
                goto cleanup;
        }


        err = bpf_tc_hook_create(&tc_hook);
        if (!err)
                hook_created = true;
        if (err && err != -EEXIST) {
                fprintf(stderr, "Failed to create TC hook: %d\n", err);
                goto cleanup;
        }

        tc_opts.prog_fd = bpf_program__fd(prog1);
        err = bpf_tc_attach(&tc_hook, &tc_opts);
        if (err) {
                fprintf(stderr, "Failed to attach TC: %d\n", err);
                goto cleanup;
        }



        struct bpf_program *prog2 =
bpf_object__find_program_by_name(obj, "test_prog2");
        if (!prog2) {
                fprintf(stderr, "Error finding BPF program by title\n");
                goto cleanup;
        }

struct bpf_link *link2 = bpf_program__attach(prog2);
        if (!link2) {
                fprintf(stderr, "Error attaching kprobe\n");
                return 1;
        }


        printf("Started successfully");


        //for (int i=0; i<10000000; i++) printf("");
        while(!exiting) {}
        bpf_link__destroy(link2);

        tc_opts.flags = tc_opts.prog_fd = tc_opts.prog_id = 0;
        err = bpf_tc_detach(&tc_hook, &tc_opts);
        if (err) {
                fprintf(stderr, "Failed to detach TC: %d\n", err);
                goto cleanup;
        }

cleanup:
        if (hook_created)
                bpf_tc_hook_destroy(&tc_hook);
        bpf_object__close(obj);
        return 0;

