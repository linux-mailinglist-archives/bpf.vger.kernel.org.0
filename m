Return-Path: <bpf+bounces-16741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB0E8057AE
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 15:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03961B20D43
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4A15FF13;
	Tue,  5 Dec 2023 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdWm0953"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110939FE9;
	Tue,  5 Dec 2023 14:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EAAC433C7;
	Tue,  5 Dec 2023 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701787518;
	bh=iSLRPNpqu2DhDX7a3Bv1qZm7SYMeG+YKVOYnGPloMmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tdWm09537Wj64Euk5eO7CCrdpTYDozYO8v/fX4rSWSmhjirAPZwKBZNNK4M4M0M/L
	 8oenraM/GuFN3XGRqZA4WjoG/qBZtgBZUtzRk8g2xUQrRA4kbJWRUvPrkNAo/s5Cxp
	 PtaGWBEaxjgOMgcGLQauK4lk4P2z4YskYwnFa7EpdXEHHTwjVXfB2ji62qsIXwbw0J
	 gK1br9Cd7Q42ERYZn4acJK7lFs4wRnr9rafOvbP32OPRt94/PXOk5UcFcbHsPsQfqE
	 iyYTkMafVnxBSKSeMxZAoJYYBKyAVYDYiU/0uTFECAqYrYij3aeDxMFK9u/YCjKsEV
	 LYQ4HuICgE9Iw==
Date: Tue, 5 Dec 2023 23:45:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 12/33] function_graph: Have the instances use their
 own ftrace_ops for filtering
Message-Id: <20231205234511.3839128259dfec153ea7da81@kernel.org>
In-Reply-To: <170109332175.343914.6080879486450909526.stgit@devnote2>
References: <170109317214.343914.4784420430328654397.stgit@devnote2>
	<170109332175.343914.6080879486450909526.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 27 Nov 2023 22:55:22 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -243,6 +254,27 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>  	if (!current->ret_stack)
>  		return -EBUSY;
>  
> +	if (ret == (unsigned long)dereference_kernel_function_descriptor(return_to_handler)) {

I found this condition is not always needed. Actually, this is only needed for
the first one. The second or later entry handlers or tail-call case will pass
this condition.

> +		/*
> +		 * In this case, the previous fgraph callback already pushed the
> +		 * ret_stack, or @func is called by tail-call. Usual tail-call can
> +		 * be detected if ret_stack::func is not @func, but for the self-
> +		 * recursive tail-call case needs to check whether the @fgraph_idx
> +		 * is already recorded or not.
> +		 */
> +		ret_stack = get_ret_stack(current, current->curr_ret_stack, &index);
> +		if ((ret_stack && ret_stack->func == func) &&
> +		     !is_fgraph_index_set(current, index + FGRAPH_RET_INDEX, fgraph_idx)) {
> +			return index + FGRAPH_RET_INDEX;
> +		}

But without that, I found this part caused a kernel panic while the
ftrace_shutdown() when unregistering a current fgraph (which is the
last one, see below). But it starts lockdep warning...
(BTW, lockdep lock acquire location is replaced by return_to_ftrace
and not resolved by ftrace, that is not good, a kind of bug.)

I need to check the bitmap check is really works or not.

/ # cd /sys/kernel/tracing/
/sys/kernel/tracing # echo function_graph > current_tracer
/sys/kernel/tracing # echo nop > current_tracer
[   21.882512] ------------[ cut here ]------------
[   21.884837] DEBUG_LOCKS_WARN_ON(1)
[   21.884885] WARNING: CPU: 18 PID: 477 at kernel/locking/lockdep.c:232 __lock_acquire+0x9a4/0xbc0
[   21.891152] Modules linked in:
[   21.892865] CPU: 18 PID: 477 Comm: sh Tainted: G                 N 6.6.0+ #27
[   21.896383] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   21.901092] RIP: 0010:__lock_acquire+0x9a4/0xbc0
[   21.903540] Code: c8 85 c0 0f 84 14 fd ff ff 8b 35 4b 47 b5 01 85 f6 0f 85 06 fd ff ff 48 c7 c6 10 ac 39 82 48 c7 c7 2e b6 36 82 e8 4c 15 f7 ff <0f> 0b 31 c0 4c 8b 5d c8 44 8b 55 d0 e9 ff f7 ff ff e8 c6 86 56 00
[   21.913175] RSP: 0018:ffffc900005b4ee0 EFLAGS: 00010086
[   21.915850] RAX: 0000000000000000 RBX: ffff888005843cd8 RCX: 000000053b6d0030
[   21.919327] RDX: 0000000000000000 RSI: ffffffff82b800c0 RDI: ffffffff8108e4d3
[   21.922767] RBP: ffffc900005b4f30 R08: 0000000000000001 R09: ffffc900005b4d60
[   21.926247] R10: 0000000000000018 R11: ffff88807cbc0000 R12: ffff888005843200
[   21.929714] R13: 7627623276c27547 R14: 0000000000000000 R15: 0000000000000005
[   21.933174] FS:  0000000000fea3c0(0000) GS:ffff88807d280000(0000) knlGS:0000000000000000
[   21.937093] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.939959] CR2: 000000000059ada5 CR3: 0000000007156000 CR4: 00000000000006a0
[   21.943423] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   21.946863] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   21.950329] Call Trace:
[   21.951725]  <IRQ>
[   21.952924]  ? show_regs+0x69/0x80
[   21.954754]  ? __warn+0x8d/0x190
[   21.956503]  ? __lock_acquire+0x9a4/0xbc0
[   21.958604]  ? report_bug+0x171/0x1a0
[   21.960528]  ? sched_clock_noinstr+0xd/0x20
[   21.962747]  ? handle_bug+0x42/0x80
[   21.964578]  ? exc_invalid_op+0x1c/0x70
[   21.966634]  ? asm_exc_invalid_op+0x1f/0x30
[   21.968844]  ? __warn_printk+0x143/0x160
[   21.970891]  ? __lock_acquire+0x9a4/0xbc0
[   21.973034]  lock_acquire+0xb5/0x2a0
[   21.974887]  ? sysvec_apic_timer_interrupt+0x6b/0xa0
[   21.977505]  _raw_spin_lock+0x36/0x50
[   21.979411]  ? sysvec_apic_timer_interrupt+0x6b/0xa0
[   21.981926]  sysvec_apic_timer_interrupt+0x6b/0xa0
[   21.984364]  </IRQ>
[   21.985585]  <TASK>
[   21.986832]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[   21.989389] RIP: 0010:trace_graph_entry+0x1cf/0x210
[   21.991879] Code: 57 cb fe ff 48 89 de 4c 89 e7 89 c2 e8 aa fd ff ff f0 41 ff 0e 4d 85 ed 0f 84 6d fe ff ff 89 45 d4 e8 45 b6 ff ff fb 8b 45 d4 <e9> 5c fe ff ff 48 89 df e8 34 f3 ff ff 85 c0 0f 84 4a fe ff ff e9
[   22.000539] RSP: 0018:ffffc90001247908 EFLAGS: 00000206
[   22.002962] RAX: 0000000000000001 RBX: ffffc9000124794c RCX: 0000000000000040
[   22.005452] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8120f7db
[   22.007936] RBP: ffffc90001247938 R08: 0000000000000001 R09: 00000000004393b5
[   22.010426] R10: 0000000000000018 R11: ffff888005843c10 R12: ffffffff82b7ca20
[   22.012961] R13: 0000000000000200 R14: ffff88807d2b2f10 R15: 0000000000000100
[   22.015474]  ? trace_graph_entry+0x1cb/0x210
[   22.017052]  ? trace_graph_entry+0x1cb/0x210
[   22.018622]  ? preempt_count_add+0x4/0x80
[   22.020106]  function_graph_enter_ops+0xa1/0x160
[   22.021782]  ? preempt_count_add+0x4/0x80
[   22.023265]  ftrace_graph_func+0xc4/0x170
[   22.024786]  ? __pte_offset_map+0x2f/0x1c0
[   22.026312]  ? preempt_count_add+0x9/0x80
[   22.027795]  ? preempt_count_add+0x9/0x80
[   22.029265]  ? _raw_spin_lock+0x1b/0x50
[   22.030686]  ? preempt_count_add+0x9/0x80
[   22.032154]  ? _raw_spin_lock+0x1b/0x50
[   22.033568]  ? ftrace_stub_direct_tramp+0x20/0x20
[   22.035257]  ? __pte_offset_map_lock+0x72/0x160
[   22.036917]  ? ftrace_stub_direct_tramp+0x20/0x20
[   22.041935]  ? __get_locked_pte+0x43/0x80
[   22.043411]  ? __get_locked_pte+0x9/0x80
[   22.044849]  ? __ia32_sys_waitid+0x5/0x30
[   22.046333]  ? ftrace_stub_direct_tramp+0x20/0x20
[   22.048024]  ? __text_poke+0x14d/0x510
[   22.049413]  ? perf_event_text_poke+0x4/0xc0
[   22.050982]  ? __pfx_text_poke_memcpy+0x10/0x10
[   22.052643]  ? text_poke_bp_batch+0x1c1/0x3b0
[   22.054222]  ? __ia32_sys_waitid+0x5/0x30
[   22.055714]  ? __pfx_ptrace_get_syscall_info+0x10/0x10
[   22.057545]  ? text_poke_flush+0x4c/0x60
[   22.058993]  ? text_poke_queue+0x25/0x60
[   22.060451]  ? ftrace_stub_direct_tramp+0x20/0x20
[   22.062146]  ? ftrace_replace_code+0x188/0x200
[   22.063787]  ? ftrace_modify_all_code+0x154/0x190
[   22.065489]  ? arch_ftrace_update_code+0xd/0x20
[   22.067130]  ? ftrace_shutdown.part.0+0x119/0x250
[   22.068822]  ? ftrace_shutdown+0x2f/0x70
[   22.070270]  ? unregister_ftrace_graph+0x79/0x110
[   22.071989]  ? graph_trace_reset+0x1d/0x30
[   22.073479]  ? tracing_set_tracer+0x12f/0x290
[   22.075075]  ? tracing_set_trace_write+0x9c/0xe0
[   22.076802]  ? vfs_write+0xd5/0x560
[   22.078129]  ? vfs_write+0x9/0x560
[   22.079434]  ? ftrace_stub_direct_tramp+0x20/0x20
[   22.081114]  ? ksys_write+0x7d/0x100
[   22.082474]  ? ftrace_stub_direct_tramp+0x20/0x20
[   22.084155]  ? __x64_sys_write+0x1d/0x30
[   22.085615]  ? ftrace_stub_direct_tramp+0x20/0x20
[   22.087321]  ? do_syscall_64+0x3f/0x90
[   22.088713]  ? entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   22.090624]  </TASK>
[   22.091509] irq event stamp: 5147790
[   22.092837] hardirqs last  enabled at (5147789): [<ffffffff8120f7db>] trace_graph_entry+0x1cb/0x210
[   22.095952] hardirqs last disabled at (5147790): [<ffffffff81c26683>] sysvec_apic_timer_interrupt+0x13/0xa0
[   22.099286] softirqs last  enabled at (5068304): [<ffffffff81066580>] return_to_handler+0x0/0x40
[   22.102320] softirqs last disabled at (5068283): [<ffffffff81066580>] return_to_handler+0x0/0x40
[   22.105357] ---[ end trace 0000000000000000 ]---
[   22.107041] BUG: kernel NULL pointer dereference, address: 00000000000000c8
[   22.109364] #PF: supervisor read access in kernel mode
[   22.111117] #PF: error_code(0x0000) - not-present page
[   22.112871] PGD 800000000735a067 P4D 800000000735a067 PUD 7359067 PMD 0
[   22.115149] Oops: 0000 [#1] PREEMPT SMP PTI
[   22.116631] CPU: 18 PID: 477 Comm: sh Tainted: G        W        N 6.6.0+ #27
[   22.119013] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   22.122196] RIP: 0010:__lock_acquire+0x1b4/0xbc0
[   22.123802] Code: 43 24 4c 89 e8 25 ff 1f 00 00 48 0f a3 05 44 65 13 02 0f 83 e7 04 00 00 48 8d 14 40 48 8d 04 90 48 c1 e0 04 48 05 80 2f 25 83 <0f> b6 90 c8 00 00 00 0f b7 43 20 66 25 ff 1f 0f b7 c0 48 0f a3 05
[   22.129876] RSP: 0018:ffffc900005b4ee0 EFLAGS: 00010046
[   22.131669] RAX: 0000000000000000 RBX: ffff888005843cd8 RCX: 000000053b6d0030
[   22.134050] RDX: 0000000000000000 RSI: ffffffff82b800c0 RDI: ffffffff8108e4d3
[   22.136433] RBP: ffffc900005b4f30 R08: 0000000000000001 R09: ffffc900005b4d60
[   22.138830] R10: 0000000000000001 R11: ffff888005843c10 R12: ffff888005843200
[   22.141217] R13: 7627623276c27547 R14: 0000000000000000 R15: 0000000000000005
[   22.143606] FS:  0000000000fea3c0(0000) GS:ffff88807d280000(0000) knlGS:0000000000000000
[   22.146346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.148307] CR2: 00000000000000c8 CR3: 0000000007156000 CR4: 00000000000006a0
[   22.150702] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   22.153091] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   22.155483] Call Trace:
[   22.156415]  <IRQ>
[   22.157214]  ? show_regs+0x69/0x80
[   22.158450]  ? __die+0x28/0x70
[   22.159577]  ? page_fault_oops+0xa5/0x170
[   22.161013]  ? kernelmode_fixup_or_oops.constprop.0+0x96/0x100
[   22.163016]  ? __bad_area_nosemaphore.constprop.0+0x17e/0x230
[   22.164984]  ? __warn+0xd8/0x190
[   22.166214]  ? bad_area_nosemaphore+0x13/0x20
[   22.167756]  ? do_user_addr_fault+0x252/0x860
[   22.169299]  ? exc_page_fault+0x7f/0x1f0
[   22.170712]  ? asm_exc_page_fault+0x2b/0x30
[   22.172205]  ? __warn_printk+0x143/0x160
[   22.173599]  ? __lock_acquire+0x1b4/0xbc0
[   22.175047]  lock_acquire+0xb5/0x2a0
[   22.176328]  ? sysvec_apic_timer_interrupt+0x6b/0xa0
[   22.178075]  _raw_spin_lock+0x36/0x50
[   22.179392]  ? sysvec_apic_timer_interrupt+0x6b/0xa0
[   22.181107]  sysvec_apic_timer_interrupt+0x6b/0xa0
[   22.182775]  </IRQ>
[   22.183600]  <TASK>
[   22.184428]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[   22.186197] RIP: 0010:trace_graph_entry+0x1cf/0x210
[   22.187893] Code: 57 cb fe ff 48 89 de 4c 89 e7 89 c2 e8 aa fd ff ff f0 41 ff 0e 4d 85 ed 0f 84 6d fe ff ff 89 45 d4 e8 45 b6 ff ff fb 8b 45 d4 <e9> 5c fe ff ff 48 89 df e8 34 f3 ff ff 85 c0 0f 84 4a fe ff ff e9
[   22.194033] RSP: 0018:ffffc90001247908 EFLAGS: 00000206
[   22.195836] RAX: 0000000000000001 RBX: ffffc9000124794c RCX: 0000000000000040
[   22.198226] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8120f7db
[   22.200609] RBP: ffffc90001247938 R08: 0000000000000001 R09: 00000000004393b5
[   22.202998] R10: 0000000000000018 R11: ffff888005843c10 R12: ffffffff82b7ca20
[   22.205386] R13: 0000000000000200 R14: ffff88807d2b2f10 R15: 0000000000000100
[   22.207798]  ? trace_graph_entry+0x1cb/0x210
[   22.209313]  ? trace_graph_entry+0x1cb/0x210
[   22.210836]  ? preempt_count_add+0x4/0x80
[   22.212259]  function_graph_enter_ops+0xa1/0x160
[   22.213872]  ? preempt_count_add+0x4/0x80
[   22.215304]  ftrace_graph_func+0xc4/0x170
[   22.216742]  ? __pte_offset_map+0x2f/0x1c0
[   22.218186]  ? preempt_count_add+0x9/0x80
[   22.219606]  ? preempt_count_add+0x9/0x80
[   22.221027]  ? _raw_spin_lock+0x1b/0x50
[   22.222394]  ? preempt_count_add+0x9/0x80
[   22.223805]  ? _raw_spin_lock+0x1b/0x50
[   22.225164]  ? ftrace_stub_direct_tramp+0x20/0x20
[   22.226801]  ? __pte_offset_map_lock+0x72/0x160
[   22.228389]  ? ftrace_stub_direct_tramp+0x20/0x20
[   22.230016]  ? __get_locked_pte+0x43/0x80
[   22.231427]  ? __get_locked_pte+0x9/0x80
[   22.232815]  ? __ia32_sys_waitid+0x5/0x30
[   22.234228]  ? ftrace_stub_direct_tramp+0x20/0x20
[   22.235855]  ? __text_poke+0x14d/0x510
[   22.237184]  ? perf_event_text_poke+0x4/0xc0
[   22.238686]  ? __pfx_text_poke_memcpy+0x10/0x10
[   22.240270]  ? text_poke_bp_batch+0x1c1/0x3b0
[   22.241787]  ? __ia32_sys_waitid+0x5/0x30
[   22.243218]  ? __pfx_ptrace_get_syscall_info+0x10/0x10
[   22.244987]  ? text_poke_flush+0x4c/0x60
[   22.246379]  ? text_poke_queue+0x25/0x60
[   22.247764]  ? ftrace_stub_direct_tramp+0x20/0x20
[   22.249396]  ? ftrace_replace_code+0x188/0x200
[   22.250961]  ? ftrace_modify_all_code+0x154/0x190
[   22.252601]  ? arch_ftrace_update_code+0xd/0x20
[   22.254175]  ? ftrace_shutdown.part.0+0x119/0x250
[   22.255811]  ? ftrace_shutdown+0x2f/0x70
[   22.257202]  ? unregister_ftrace_graph+0x79/0x110
[   22.258834]  ? graph_trace_reset+0x1d/0x30
[   22.260274]  ? tracing_set_tracer+0x12f/0x290
[   22.261797]  ? tracing_set_trace_write+0x9c/0xe0
[   22.263431]  ? vfs_write+0xd5/0x560
[   22.264692]  ? vfs_write+0x9/0x560
[   22.265956]  ? ftrace_stub_direct_tramp+0x20/0x20
[   22.267596]  ? ksys_write+0x7d/0x100
[   22.268887]  ? ftrace_stub_direct_tramp+0x20/0x20
[   22.270525]  ? __x64_sys_write+0x1d/0x30
[   22.271910]  ? ftrace_stub_direct_tramp+0x20/0x20
[   22.273548]  ? do_syscall_64+0x3f/0x90
[   22.274890]  ? entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   22.276693]  </TASK>
[   22.277542] Modules linked in:
[   22.278672] CR2: 00000000000000c8
[   22.279865] ---[ end trace 0000000000000000 ]---
[   22.281460] RIP: 0010:__lock_acquire+0x1b4/0xbc0
[   22.283072] Code: 43 24 4c 89 e8 25 ff 1f 00 00 48 0f a3 05 44 65 13 02 0f 83 e7 04 00 00 48 8d 14 40 48 8d 04 90 48 c1 e0 04 48 05 80 2f 25 83 <0f> b6 90 c8 00 00 00 0f b7 43 20 66 25 ff 1f 0f b7 c0 48 0f a3 05
[   22.289153] RSP: 0018:ffffc900005b4ee0 EFLAGS: 00010046
[   22.290936] RAX: 0000000000000000 RBX: ffff888005843cd8 RCX: 000000053b6d0030
[   22.293304] RDX: 0000000000000000 RSI: ffffffff82b800c0 RDI: ffffffff8108e4d3
[   22.295673] RBP: ffffc900005b4f30 R08: 0000000000000001 R09: ffffc900005b4d60
[   22.298038] R10: 0000000000000001 R11: ffff888005843c10 R12: ffff888005843200
[   22.300414] R13: 7627623276c27547 R14: 0000000000000000 R15: 0000000000000005
[   22.302803] FS:  0000000000fea3c0(0000) GS:ffff88807d280000(0000) knlGS:0000000000000000
[   22.305523] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.307472] CR2: 00000000000000c8 CR3: 0000000007156000 CR4: 00000000000006a0
[   22.309846] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   22.312224] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   22.314601] Kernel panic - not syncing: Fatal exception in interrupt
[   22.320291] Kernel Offset: disabled
[   22.321563] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

