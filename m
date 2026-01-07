Return-Path: <bpf+bounces-78127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0942ECFEC14
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 17:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECE213003B2C
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F9236AB4C;
	Wed,  7 Jan 2026 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gTbsO4XS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA493A6403
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801592; cv=none; b=bjYlh/K2bx4rXlwillj5d7JlnUUOgJ+mTDYuS4WhyxPgpNw0gU2MvL1Q8XHqo586eFUxQvdIXqae2X/xzk0hmSrUXncG7qUAB1nce76+4F9Hu/Wy/ldXkBNF7o/K9z3oy0OQ1Y0//jUXHdn3dXn019Ut2O2Qp8Rsp5wjUo9CES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801592; c=relaxed/simple;
	bh=YDxCfBVL9bkBjoKLy+kHl0X3j7N8WFSP8OQpNKbOPKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p27l9GsORUNZjM7El87YA6IcAom6/jfLLZHj2sPYaWT+TMZRMZPbfT3IdlBkAkhoCMvJO6fE8dWM4K6f633rzHZyFluQXhsJyQFk1K1HWHwjZl+EJeCbxhbl1/FZwbiE8YT7CN9CCIq827TPbAvKL3GPIyrC/ATNNC67bG+2VCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gTbsO4XS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so14903775e9.3
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 07:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767801582; x=1768406382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XcBi7VB/+yzKywmy1I6V+/p4GHHR/86XUIPprAw/n/Y=;
        b=gTbsO4XS2NYTYeWWid6v/TgBriaX3NTIFnfPRKieqiKTxrwMs/L3BC6K/ISb0HDYzR
         A9NrXZVOrcdx9ToE02fTCcBMUCMKGsKOYpJvbCmAvA3E0jLX1bm8012LBUN1p6U0o/rI
         kYopl6V6YNSuAwPdHgd4jSvtLSY1CpO0RJkyuNDu1d66n7M36t7Ys13vsOgHpn839Bop
         BYAy4dqb2PzpNGLFHbr6uNcaF8n/f3lX7PbsPiQ9QpvP1sUWUDc66oilcPPjMkbh8CUg
         qRM3REU39OXn8H4dAZ6LQ7lsceNlbFpSbqCIZJRs3sepCuerlk/VjylgavmveVqzTwJ5
         JPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767801582; x=1768406382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcBi7VB/+yzKywmy1I6V+/p4GHHR/86XUIPprAw/n/Y=;
        b=n1+0TyQw4PTqf8na1ywWbLhsQG398qfw1zmz+ftwYhMNKVKgUiiFMtQmYhIZLoMmSO
         FeHCy6sp21Ba72+sLFCbv7eb/wm8Tqqfi7D0/tqldbUj/R91fzysJfAktY5ul7pfTwzq
         Hf21XswFkdfO2ye9U50OOriAQv/2Ea5SpX8LxNsymxxngvlt9458ImCTal2DR0BbFHTk
         pbkq8rIxdvzwKFgqcHpzFiikprvEuQurDmZUNvznJsVd4Olcm6x9Ve0qq6k/KzGQmFpH
         vTvj6I6yhVVhnCIK35wLzku0j1f9C3BnLHhcHaeqMcOvFtBV2TIpV2b2Hw8Sn7LPAUZs
         MIpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuX6Ble/50AYjFuXrUza7jEj9Xw5B3vlUe1CpcLV0Hb40WeWvY4YDdLSs3ThTdcwg6U9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtOCrgpwAI/DNBsZEdgFZjQVrh8MY7sFUSlpFW5O635FrZJ++
	4Ufw844m8pSQfUGmoGWz7gaTXhzxYYhqNUH+F7h0z12FNlEH17N3tigVcIzonmixQmI=
X-Gm-Gg: AY/fxX4ERp9At+NPzGOyjuJkhHfwRhaZ4v5Qd6dHJg71b1jL0TWS8xrRxUSxUsdmdWd
	4B36I/5hf+zCo/zud9lOqSiJJiiWDHGjuR9nU6sIXFfbgGSZSap0oRtN8mKdbtBjsPjdbCMd4TO
	BuGRbCaqwRBY2pH2IYecy+cKO3uf9FeEpoM9kdHpMln7qZ1kFABIqeMYfX2vnazFsmeiDG/C3ON
	iZWtVNsHsq0/2L9PpLR+VG54mRq0iIclVT1l4EeVMQex/oTMjTNR0VYmwdSgQstMUUDI0YJbZSq
	cjeS00tP/dOplEH2P+hbSEZhAadIaVKUw5izvk+Jg85JsETslk9ZP/O1+ut7siVRggbHJJ9tvdr
	WxI+tk3Hm0ZmRi9e4eu75BovG/x0hvFAmE8p9uwAlepbrePRLMiDIYrHcd9tLd2VEcyWytM0hQk
	bOp4ayyLXf1U+0RbK0wwUyevLk
X-Google-Smtp-Source: AGHT+IFjp/d1CD2wKCPtCqrirwoPPsZ0u9aXD3mLadUtxpd0+q/JXwTm9lSdGLshtzlqlgE+qhzyAA==
X-Received: by 2002:a05:600c:1988:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d84b54025mr31093575e9.34.1767801582072;
        Wed, 07 Jan 2026 07:59:42 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8662ffaasm16069895e9.6.2026.01.07.07.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:59:41 -0800 (PST)
Date: Wed, 7 Jan 2026 16:59:39 +0100
From: Petr Mladek <pmladek@suse.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: syzbot <syzbot+085983798339fb1b6e51@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	mhiramat@kernel.org, John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in watchdog (2)
Message-ID: <aV6C68oZgbIGEXiV@pathway.suse.cz>
References: <694a2745.050a0220.19928e.0016.GAE@google.com>
 <4b3462bb-1cb5-4240-a57a-49b0f39f233f@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b3462bb-1cb5-4240-a57a-49b0f39f233f@linux.dev>

Adding John, tracing, and BPF people into Cc.

On Tue 2025-12-23 17:35:42, Lance Yang wrote:
> 
> 
> On 2025/12/23 13:23, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    7b8e9264f55a Merge tag 'net-6.19-rc2' of git://git.kernel...
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1207562a580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
> > dashboard link: https://syzkaller.appspot.com/bug?extid=085983798339fb1b6e51
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174cab1a580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122e777c580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/8974d9d662d1/disk-7b8e9264.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/127f2bb7aa37/vmlinux-7b8e9264.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/2dc3e335ca80/bzImage-7b8e9264.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+085983798339fb1b6e51@syzkaller.appspotmail.com
> > 
> > rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > rcu: 	(detected by 0, t=10502 jiffies, g=18609, q=500 ncpus=2)
> > rcu: All QSes seen, last rcu_preempt kthread activity 10502 (4294978752-4294968250), jiffies_till_next_fqs=1, root ->qsmask 0x0
> > rcu: rcu_preempt kthread starved for 10502 jiffies! g18609 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
> > rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> > rcu: RCU grace-period kthread stack dump:
> > task:rcu_preempt     state:R  running task     stack:27272 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
> > Call Trace:
> >   <TASK>
> >   context_switch kernel/sched/core.c:5256 [inline]
> >   __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
> >   __schedule_loop kernel/sched/core.c:6945 [inline]
> >   schedule+0x165/0x360 kernel/sched/core.c:6960
> >   schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
> >   rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
> >   rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
> >   kthread+0x711/0x8a0 kernel/kthread.c:463
> >   ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
> >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> >   </TASK>
> > rcu: Stack dump where RCU GP kthread last ran:
> > Sending NMI from CPU 0 to CPUs 1:
> > NMI backtrace for cpu 1
> > CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> > RIP: 0010:check_kcov_mode kernel/kcov.c:183 [inline]
> > RIP: 0010:write_comp_data kernel/kcov.c:246 [inline]
> > RIP: 0010:__sanitizer_cov_trace_switch+0x97/0x130 kernel/kcov.c:351

I am a bit confused here.

  1. Why there are 3 RIP entries?

  2. Why RIP points to kcov code? The last return address on stack
     is rb_event_length() which does not seem to call kcov code...

  3. Who calls __sanitizer_cov_trace_switch()? It seems to be
     an exported symbol which is not directly called from kernel.

Note that I am not familiar with the kcov code and how it is used.

> > Code: 54 53 48 8b 54 24 20 65 4c 8b 04 25 08 b0 7e 92 45 31 c9 eb 08 49 ff c1 4c 39 c8 74 77 4e 8b 54 ce 10 65 44 8b 1d c9 f7 bc 10 <41> 81 e3 00 01 ff 00 74 13 41 81 fb 00 01 00 00 75 d9 41 83 b8 6c
> > RSP: 0018:ffffc90000a082e0 EFLAGS: 00000016
> > RAX: 0000000000000020 RBX: 0000000000000004 RCX: 0000000000000005
> > RDX: ffffffff81c39275 RSI: ffffffff8df9a280 RDI: 0000000000000004
> > RBP: 0000006100d347d2 R08: ffff88801e2b0000 R09: 000000000000001b
> > R10: 000000000000001b R11: 0000000080010005 R12: dffffc0000000000
> > R13: ffff88801bed6010 R14: ffff88801bed64c0 R15: 00000000000667c4
> > FS:  0000000000000000(0000) GS:ffff888125f35000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000055d3cfba3a38 CR3: 00000000727a4000 CR4: 00000000003526f0
> > Call Trace:
> >   <IRQ>
> >   rb_event_length+0x45/0x400 kernel/trace/ring_buffer.c:222
> >   rb_read_data_buffer+0x438/0x580 kernel/trace/ring_buffer.c:1858
> >   check_buffer+0x28a/0x750 kernel/trace/ring_buffer.c:4410
> >   __rb_reserve_next+0x592/0xdb0 kernel/trace/ring_buffer.c:4509
> >   rb_reserve_next_event kernel/trace/ring_buffer.c:4646 [inline]
> >   ring_buffer_lock_reserve+0xbb5/0x1010 kernel/trace/ring_buffer.c:4705
> >   __trace_buffer_lock_reserve kernel/trace/trace.c:1079 [inline]
> >   trace_event_buffer_lock_reserve+0x1d0/0x6f0 kernel/trace/trace.c:2808
> >   trace_event_buffer_reserve+0x248/0x340 kernel/trace/trace_events.c:672
> >   do_trace_event_raw_event_bpf_trace_printk kernel/trace/bpf_trace.h:11 [inline]
> >   trace_event_raw_event_bpf_trace_printk+0x100/0x260 kernel/trace/bpf_trace.h:11
> >   __do_trace_bpf_trace_printk kernel/trace/bpf_trace.h:11 [inline]
> >   trace_bpf_trace_printk+0x153/0x1b0 kernel/trace/bpf_trace.h:11
> >   ____bpf_trace_printk kernel/trace/bpf_trace.c:379 [inline]
> >   bpf_trace_printk+0x11e/0x190 kernel/trace/bpf_trace.c:362
> >   bpf_prog_b1367f0be6c54012+0x39/0x3f
> >   bpf_dispatcher_nop_func include/linux/bpf.h:1378 [inline]
> >   __bpf_prog_run include/linux/filter.h:723 [inline]
> >   bpf_prog_run include/linux/filter.h:730 [inline]
> >   __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
> >   bpf_trace_run1+0x27f/0x4c0 kernel/trace/bpf_trace.c:2115
> >   __bpf_trace_rcu_utilization+0xa1/0xf0 include/trace/events/rcu.h:27
> >   __traceiter_rcu_utilization+0x7a/0xb0 include/trace/events/rcu.h:27
> >   __do_trace_rcu_utilization include/trace/events/rcu.h:27 [inline]
> >   trace_rcu_utilization+0x191/0x1c0 include/trace/events/rcu.h:27
> >   rcu_sched_clock_irq+0xd3/0x1280 kernel/rcu/tree.c:2693
> >   update_process_times+0x23c/0x2f0 kernel/time/timer.c:2474
> >   tick_sched_handle kernel/time/tick-sched.c:298 [inline]
> >   tick_nohz_handler+0x3e9/0x710 kernel/time/tick-sched.c:319
> >   __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
> >   __hrtimer_run_queues+0x4d0/0xc30 kernel/time/hrtimer.c:1841
> >   hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1903
> >   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1045 [inline]
> >   __sysvec_apic_timer_interrupt+0x102/0x3e0 arch/x86/kernel/apic/apic.c:1062
> >   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
> >   sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1056
> >   </IRQ>
> >   <TASK>
> >   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
> > RIP: 0010:console_trylock_spinning kernel/printk/printk.c:2037 [inline]
> 
> The khungtaskd was trying to print something

The "full" log at
https://syzkaller.appspot.com/text?tag=CrashLog&x=1207562a580000
shows the following:

[  416.485474][    C0] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  416.492530][    C0] rcu: 	(detected by 0, t=10502 jiffies, g=18609, q=500 ncpus=2)
[  416.500319][    C0] rcu: All QSes seen, last rcu_preempt kthread activity 10502 (4294978752-4294968250), jiffies_till_next_fqs=1, root ->qsmask 0x0
[  416.513804][    C0] rcu: rcu_preempt kthread starved for 10502 jiffies! g18609 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
[  416.525197][    C0] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[  416.535358][    C0] rcu: RCU grace-period kthread stack dump:
[  416.541258][    C0] task:rcu_preempt     state:R  running task     stack:27272 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
[  416.554783][    C0] Call Trace:
[  416.558097][    C0]  <TASK>
[  416.561050][    C0]  __schedule+0x14bc/0x5000
[  416.565598][    C0]  ? lockdep_hardirqs_on+0x98/0x140
[...]
[  416.611648][    C0]  rcu_gp_fqs_loop+0x301/0x1540
[  416.616548][    C0]  ? __pfx_rcu_gp_init+0x10/0x10
[  416.617417][   T31] INFO: task kworker/u8:12:4866 blocked for more than 157 seconds.
[  416.621584][    C0]  ? lockdep_hardirqs_on+0x98/0x140
[...]

So, the hung task detector detected that "kworker/u8:12:4866" was in
TASK_UNINTERRUPTIBLE for more that 157 seconds.

Note that this task should not cause RCU stall. The hung task is sleeping...

Anyway, this is the line which was added by the printk() on CPU1
from watchdog() function.

>  and got stuck in console_trylock_spinning ...

The time spent in console_trylock_spinning should be limited
by the lenght of a single printk record and speed of the console.

The spinning is allowed only around single record flush,
see console_lock_spinning_enable() in console_emit_next_record()
or nbcon_legacy_emit_next_record().

It should not take more than 1sec even on pretty slow serial consoles.
Unless something went wrong, of course...

But wait!

The RCU report says:

  [  416.492530][    C0] rcu: 	(detected by 0, t=10502 jiffies, g=18609, q=500 ncpus=2)

There seems to be two CPUs, aka CPU0 and CPU1. And the backtrace from
CPU1 was taken via NMI:

  [  416.622108][    C0] Sending NMI from CPU 0 to CPUs 1:
  [  416.622135][    C1] NMI backtrace for cpu 1
  [  416.622148][    C1] CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 

It means that CPU1 should not be blocked in console_lock_spinning_enable()
when the other CPU0 is calling __schedule() in rcu_gp_kthread() and
detects the RCU stall. It is not in a code where spinning is allowed,
definitely.

Possibilities:

1. The stall might be caused by the BPF or tracing code which is
   called in IRQ context from hrtimer_interrupt().

2. The backtrace might be misleading. There are only two CPUs.
   Maybe the rcu_preempt kthread was scheduled after the system
   got unstuck => backtraces might be from a state when the system is
   already running "properly".

3. printk() causes stalls. And there were many lines added between
   213s and 237s. From the full log:

   [  213.498587][ T5898] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > 1
   [  213.517072][ T5898] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > 9
   [ ... 279 lines, 31kB printed ...]
   [  237.623198][   T13] netdevsim netdevsim3 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
   [  237.831401][ T6144] veth1_vlan: entered promiscuous mode

   So this might cause stall in theory.

   The strange thing is that the stall was reported almost 200s later:

   [  416.485474][    C0] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
   [  416.492530][    C0] rcu: 	(detected by 0, t=10502 jiffies, g=18609, q=500 ncpus=2)

   It is possible that only CPU1 was doing some real job during this time.
   And CPU0 was busy flushing the 31kB lines in an atomic context.

   Does anyone know how long was the RCU stall?
   How long are t=10502 jiffies in this case?

Best Regards,
Petr

> While waiting there, a timer interrupt fired and ran a BPF program
> that traces RCU events with bpf_trace_printk.
> 
> So both printk being slow and BPF/tracing running in the interrupt
> seem to be contributing to the RCU stall :(
>
> #syz set subsystems: bpf, trace
> 
> 
> > RIP: 0010:vprintk_emit+0x4d0/0x5f0 kernel/printk/printk.c:2425
> > Code: 0f 84 34 ff ff ff e8 cf 62 20 00 fb eb 44 e8 c7 62 20 00 e8 82 72 ba 09 4d 85 f6 74 94 e8 b8 62 20 00 fb 48 c7 c7 e0 58 f3 8d <31> f6 ba 01 00 00 00 31 c9 41 b8 01 00 00 00 45 31 c9 53 e8 28 26
> > RSP: 0018:ffffc90000a77a80 EFLAGS: 00000293
> > RAX: ffffffff81a14f98 RBX: ffffffff81a14df1 RCX: ffff88801e2b0000
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8df358e0
> > RBP: ffffc90000a77b90 R08: ffffffff8f822077 R09: 1ffffffff1f0440e
> > R10: dffffc0000000000 R11: fffffbfff1f0440f R12: 0000000000000000
> > R13: 0000000000000040 R14: 0000000000000200 R15: 1ffff9200014ef54
> >   _printk+0xcf/0x120 kernel/printk/printk.c:2451
> >   check_hung_task kernel/hung_task.c:255 [inline]
> >   check_hung_uninterruptible_tasks kernel/hung_task.c:331 [inline]
> >   watchdog+0xb35/0xfe0 kernel/hung_task.c:515
> >   kthread+0x711/0x8a0 kernel/kthread.c:463
> >   ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
> >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> >   </TASK>
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > 
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> > 
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> > 
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> > 
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> > 
> > If you want to undo deduplication, reply with:
> > #syz undup

