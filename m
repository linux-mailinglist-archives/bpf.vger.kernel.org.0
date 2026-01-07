Return-Path: <bpf+bounces-78132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D7ECFFE0E
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 20:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFD0F3082D21
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 19:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3273624D9;
	Wed,  7 Jan 2026 16:54:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F60935BDB7;
	Wed,  7 Jan 2026 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804871; cv=none; b=U5WmmLAkMMwxLXV8rUP1fnuIKr/39x9kdkTpJWqrzLy26TyBpt4iydFBA7Jp0vkDQbvgvG0+wGtF/+FFRKo1LMpLInHUnthU/MCkfIvUzpXf5suNzD0yB6fv1AI0hCwAd74C4qh2ur9chtxTHoTlHt4rCiFK3aAszapozdi1p3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804871; c=relaxed/simple;
	bh=uoAGtfRbYArfoPSNs6e3ZxQU2rrUeNSguaMbjEQ+TbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oM6+TVnb5+3JhCzPJeYw6qIi5lXSGmXNpFdt+UFLkQIXaVYePypXFf23TsAu6wKgFOXpDauOudONy0i9Zj+JfoVkxXzaRpxDvdDKneLmiwwAF6sTX5xXSUWRh2WcLYk68my5O9uVscr3RUFBAd2Blf1e+tkoWVHL0IMUXWc6yOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id D7A7C1B5A5;
	Wed,  7 Jan 2026 16:54:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id C72342002A;
	Wed,  7 Jan 2026 16:54:13 +0000 (UTC)
Date: Wed, 7 Jan 2026 11:54:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Lance Yang <lance.yang@linux.dev>, syzbot
 <syzbot+085983798339fb1b6e51@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 mhiramat@kernel.org, John Ogness <john.ogness@linutronix.de>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in watchdog (2)
Message-ID: <20260107115440.5714c8f2@gandalf.local.home>
In-Reply-To: <aV6C68oZgbIGEXiV@pathway.suse.cz>
References: <694a2745.050a0220.19928e.0016.GAE@google.com>
	<4b3462bb-1cb5-4240-a57a-49b0f39f233f@linux.dev>
	<aV6C68oZgbIGEXiV@pathway.suse.cz>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: w965ewa938co3cftju61eq3pzspjsst7
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: C72342002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19QZpGmB30Dyfjof9iM/w4/8GjcpMKEwVA=
X-HE-Tag: 1767804853-455056
X-HE-Meta: U2FsdGVkX18T2uWTzBioJt2tkN4GAxZ4ZDHCM3ByWx7LHywKbwmAv9+mIubCjsamDAB3G1tfbTrP7zHhOXyGq9eVaqHJRBBsuyAwv7bZRF0EVAv0BhJW8QI13mar3AV/cLBZOdTWBjjcSzs4O3uAYniT7X/e313zm4t5quNUumjoKncGoShJXUQxCpqMZZ0JHw69LBCiAmPv3yfvtkvFiAJYO0TulQLpNFbVBhCSZQh4kGfufKCeezzsHE/JceLShDB7cn2LP5YAkY3YVuOS8GQraznnlJvaFrLV+AZR4Oyga3k4Mw9d+3E3pjoAE4Xg7LDNDioxgQ2UWwiV2TDyl4q1OKXxwgKrzqx2kUNmktpR96JXF+JbcbQEnhhXJJhMqzeex4zucrkbp+1S6opXv8dPa1v/w0fFTfuqDcBRHEHuSUVkFgEY7GfqW7UgSH/v0ZXr9NuzD3s8o9dWPYw4FsPN3iIOZ1hEOmrzSkTmiK3fTrpJWthUqnBvkDjU5tN2D4uUZq0Br4c1s7nSGGxugGCPAMVL+nvOT2U1UQs4ahT30fSAASvlPEyjcxGKkdy1G2F2fgydRft1fbw13+3hw8ZjCJ4mYETV2111fJXdtCoQZY/FEu6fHF2b9cZzrYspROPs3rQdK1Imu3aYhzncNzD2RQTPNapycduiD4WbgmIhIj6AqL9cIaVJzBIlKZRvyWvya3a3n46owrwzCB5rluUP/+GAOM/JAshBP+VHaAvvbzE27q2Kg7/maFb3Zy4+ALmoa72WSwI=

On Wed, 7 Jan 2026 16:59:39 +0100
Petr Mladek <pmladek@suse.com> wrote:

> Adding John, tracing, and BPF people into Cc.
> 
> On Tue 2025-12-23 17:35:42, Lance Yang wrote:
> > 
> > 
> > On 2025/12/23 13:23, syzbot wrote:  
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    7b8e9264f55a Merge tag 'net-6.19-rc2' of git://git.kernel...
> > > git tree:       net-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1207562a580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=085983798339fb1b6e51
> > > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174cab1a580000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122e777c580000
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/8974d9d662d1/disk-7b8e9264.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/127f2bb7aa37/vmlinux-7b8e9264.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/2dc3e335ca80/bzImage-7b8e9264.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+085983798339fb1b6e51@syzkaller.appspotmail.com
> > > 
> > > rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > rcu: 	(detected by 0, t=10502 jiffies, g=18609, q=500 ncpus=2)
> > > rcu: All QSes seen, last rcu_preempt kthread activity 10502 (4294978752-4294968250), jiffies_till_next_fqs=1, root ->qsmask 0x0
> > > rcu: rcu_preempt kthread starved for 10502 jiffies! g18609 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
> > > rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> > > rcu: RCU grace-period kthread stack dump:
> > > task:rcu_preempt     state:R  running task     stack:27272 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
> > > Call Trace:
> > >   <TASK>
> > >   context_switch kernel/sched/core.c:5256 [inline]
> > >   __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
> > >   __schedule_loop kernel/sched/core.c:6945 [inline]
> > >   schedule+0x165/0x360 kernel/sched/core.c:6960
> > >   schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
> > >   rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
> > >   rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
> > >   kthread+0x711/0x8a0 kernel/kthread.c:463
> > >   ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
> > >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> > >   </TASK>
> > > rcu: Stack dump where RCU GP kthread last ran:
> > > Sending NMI from CPU 0 to CPUs 1:
> > > NMI backtrace for cpu 1
> > > CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full)
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> > > RIP: 0010:check_kcov_mode kernel/kcov.c:183 [inline]
> > > RIP: 0010:write_comp_data kernel/kcov.c:246 [inline]
> > > RIP: 0010:__sanitizer_cov_trace_switch+0x97/0x130 kernel/kcov.c:351  
> 
> I am a bit confused here.
> 
>   1. Why there are 3 RIP entries?
> 
>   2. Why RIP points to kcov code? The last return address on stack
>      is rb_event_length() which does not seem to call kcov code...
> 
>   3. Who calls __sanitizer_cov_trace_switch()? It seems to be
>      an exported symbol which is not directly called from kernel.
> 
> Note that I am not familiar with the kcov code and how it is used.
> 
> > > Code: 54 53 48 8b 54 24 20 65 4c 8b 04 25 08 b0 7e 92 45 31 c9 eb 08 49 ff c1 4c 39 c8 74 77 4e 8b 54 ce 10 65 44 8b 1d c9 f7 bc 10 <41> 81 e3 00 01 ff 00 74 13 41 81 fb 00 01 00 00 75 d9 41 83 b8 6c
> > > RSP: 0018:ffffc90000a082e0 EFLAGS: 00000016
> > > RAX: 0000000000000020 RBX: 0000000000000004 RCX: 0000000000000005
> > > RDX: ffffffff81c39275 RSI: ffffffff8df9a280 RDI: 0000000000000004
> > > RBP: 0000006100d347d2 R08: ffff88801e2b0000 R09: 000000000000001b
> > > R10: 000000000000001b R11: 0000000080010005 R12: dffffc0000000000
> > > R13: ffff88801bed6010 R14: ffff88801bed64c0 R15: 00000000000667c4
> > > FS:  0000000000000000(0000) GS:ffff888125f35000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 000055d3cfba3a38 CR3: 00000000727a4000 CR4: 00000000003526f0
> > > Call Trace:
> > >   <IRQ>
> > >   rb_event_length+0x45/0x400 kernel/trace/ring_buffer.c:222
> > >   rb_read_data_buffer+0x438/0x580 kernel/trace/ring_buffer.c:1858

Oh, they have CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS enabled.

This is a purely debug feature that will iterate all the events in the
sub-buffer every time a new event is added, checking the integrity of the
timestamps in the sub-buffer.

This *will* add a lot of overhead to tracing. This is an O(n^2) operation
where 'n' is the number of events in a sub-buffer. For a typical event that
may be 32 bytes, that's 127 events in a sub-buffer. n^2 = 16129. If it is
triggering timeouts, simply disable that config.

-- Steve


> > >   check_buffer+0x28a/0x750 kernel/trace/ring_buffer.c:4410
> > >   __rb_reserve_next+0x592/0xdb0 kernel/trace/ring_buffer.c:4509
> > >   rb_reserve_next_event kernel/trace/ring_buffer.c:4646 [inline]
> > >   ring_buffer_lock_reserve+0xbb5/0x1010 kernel/trace/ring_buffer.c:4705
> > >   __trace_buffer_lock_reserve kernel/trace/trace.c:1079 [inline]
> > >   trace_event_buffer_lock_reserve+0x1d0/0x6f0 kernel/trace/trace.c:2808
> > >   trace_event_buffer_reserve+0x248/0x340 kernel/trace/trace_events.c:672
> > >   do_trace_event_raw_event_bpf_trace_printk kernel/trace/bpf_trace.h:11 [inline]
> > >   trace_event_raw_event_bpf_trace_printk+0x100/0x260 kernel/trace/bpf_trace.h:11
> > >   __do_trace_bpf_trace_printk kernel/trace/bpf_trace.h:11 [inline]
> > >   trace_bpf_trace_printk+0x153/0x1b0 kernel/trace/bpf_trace.h:11
> > >   ____bpf_trace_printk kernel/trace/bpf_trace.c:379 [inline]
> > >   bpf_trace_printk+0x11e/0x190 kernel/trace/bpf_trace.c:362
> > >   bpf_prog_b1367f0be6c54012+0x39/0x3f
> > >   bpf_dispatcher_nop_func include/linux/bpf.h:1378 [inline]
> > >   __bpf_prog_run include/linux/filter.h:723 [inline]
> > >   bpf_prog_run include/linux/filter.h:730 [inline]
> > >   __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
> > >   bpf_trace_run1+0x27f/0x4c0 kernel/trace/bpf_trace.c:2115
> > >   __bpf_trace_rcu_utilization+0xa1/0xf0 include/trace/events/rcu.h:27
> > >   __traceiter_rcu_utilization+0x7a/0xb0 include/trace/events/rcu.h:27
> > >   __do_trace_rcu_utilization include/trace/events/rcu.h:27 [inline]
> > >   trace_rcu_utilization+0x191/0x1c0 include/trace/events/rcu.h:27
> > >   rcu_sched_clock_irq+0xd3/0x1280 kernel/rcu/tree.c:2693
> > >   update_process_times+0x23c/0x2f0 kernel/time/timer.c:2474
> > >   tick_sched_handle kernel/time/tick-sched.c:298 [inline]
> > >   tick_nohz_handler+0x3e9/0x710 kernel/time/tick-sched.c:319
> > >   __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
> > >   __hrtimer_run_queues+0x4d0/0xc30 kernel/time/hrtimer.c:1841
> > >   hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1903
> > >   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1045 [inline]
> > >   __sysvec_apic_timer_interrupt+0x102/0x3e0 arch/x86/kernel/apic/apic.c:1062
> > >   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
> > >   sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1056
> > >   </IRQ>
> > >   <TASK>
> > >   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
> > > RIP: 0010:console_trylock_spinning kernel/printk/printk.c:2037 [inline]  
> > 
> > The khungtaskd was trying to print something  
> 

