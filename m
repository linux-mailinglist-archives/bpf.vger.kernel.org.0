Return-Path: <bpf+bounces-19365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C8482AFE9
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 14:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84279287EE8
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 13:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B6319479;
	Thu, 11 Jan 2024 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRlWy5mO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFAC2901;
	Thu, 11 Jan 2024 13:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4244AC433F1;
	Thu, 11 Jan 2024 13:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704980742;
	bh=jv7UzHqFMwIMQDnMNbqXjemYHQSFg41O+g9OnEz5VYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kRlWy5mOndqXH1/h88Ruhc+T32o85FJiUYtz1u/nAFGrvKn+LePezNmL87Z6ZTFoh
	 FcUPA+fdMQb9ONHJrayzfyPBUH+VQYCR3d1rq2H29LUhgdDdklX3uiaobigo1x0J70
	 mjLPQc/L39eSR9yn+G41U7Z1XEqa6SpQ0H5WRdaJNs0omuZKYZce5UB8Af0O5dzLs2
	 VgX3OC7Io5Q4fzo/xAhBxdqV7k5U2VFiXXnzFARZJiNv0+krs/WhFBQNE7jgOO6ILk
	 KcRt5WCK22I4/PELVdH3m2wNhbIWfTR+psjAHH7+ZvvpnTpZf28XeEFRXpv26sVvZQ
	 nYTx92jI33Ynw==
Date: Thu, 11 Jan 2024 22:45:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 11/34] function_graph: Have the instances use their
 own ftrace_ops for filtering
Message-Id: <20240111224535.552b3046b5f54baf187ae663@kernel.org>
In-Reply-To: <ZZ_KpEXvm5I26ltB@FVFF77S0Q05N>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
	<170290522555.220107.1435543481968270637.stgit@devnote2>
	<ZZg3tlOynx7YVLGQ@FVFF77S0Q05N>
	<20240108101436.07509def635fbecf80a59ae6@kernel.org>
	<ZZvp08OFIFbP3rnk@FVFF77S0Q05N>
	<20240111111533.41b39378a61512cc7462079e@kernel.org>
	<ZZ_KpEXvm5I26ltB@FVFF77S0Q05N>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Mark,

On Thu, 11 Jan 2024 11:01:56 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Thu, Jan 11, 2024 at 11:15:33AM +0900, Masami Hiramatsu wrote:
> > Hi Mark,
> > 
> > Thanks for the investigation.
> 
> Hi!
> 
> As a heads-up, I already figured out the problem and sent a fixup at:
> 
>   https://lore.kernel.org/lkml/ZZwEz8HsTa2IZE3L@FVFF77S0Q05N/
> 
> ... and a more refined fix at:
> 
>   https://lore.kernel.org/lkml/ZZwOubTSbB_FucVz@FVFF77S0Q05N/

Oops, I missed it. And I also confirmed that.

> 
> The gist was that before this patch, arm64 used the FP as the 'retp' value, but
> this patch changed that to the address of fregs->lr. This meant that the fgraph
> ret_stack contained all of the correct return addresses, but when the unwinder
> called ftrace_graph_ret_addr() with FP as the 'retp' value, it failed to match
> any entry in the ret_stack.

Yeah, this patch introduced new arm64 ftrace_graph_func(). and I missed
to pass the 'parent'... OK let me fix that.

> 
> Since the fregs only exist transiently at function entry and exit, I'd prefer
> that we still use the FP as the 'retp' value, which is what I proposed in the
> fixups above.

OK. Let me add it.

Thank you!

> 
> Thanks,
> Mark.
> 
> > On Mon, 8 Jan 2024 12:25:55 +0000
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > Hi,
> > > 
> > > There's a bit more of an info-dump below; I'll go try to dump the fgraph shadow
> > > stack so that we can analyse this in more detail.
> > > 
> > > On Mon, Jan 08, 2024 at 10:14:36AM +0900, Masami Hiramatsu wrote:
> > > > On Fri, 5 Jan 2024 17:09:10 +0000
> > > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > > 
> > > > > On Mon, Dec 18, 2023 at 10:13:46PM +0900, Masami Hiramatsu (Google) wrote:
> > > > > > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > > > > 
> > > > > > Allow for instances to have their own ftrace_ops part of the fgraph_ops
> > > > > > that makes the funtion_graph tracer filter on the set_ftrace_filter file
> > > > > > of the instance and not the top instance.
> > > > > > 
> > > > > > This also change how the function_graph handles multiple instances on the
> > > > > > shadow stack. Previously we use ARRAY type entries to record which one
> > > > > > is enabled, and this makes it a bitmap of the fgraph_array's indexes.
> > > > > > Previous function_graph_enter() expects calling back from
> > > > > > prepare_ftrace_return() function which is called back only once if it is
> > > > > > enabled. But this introduces different ftrace_ops for each fgraph
> > > > > > instance and those are called from ftrace_graph_func() one by one. Thus
> > > > > > we can not loop on the fgraph_array(), and need to reuse the ret_stack
> > > > > > pushed by the previous instance. Finding the ret_stack is easy because
> > > > > > we can check the ret_stack->func. But that is not enough for the self-
> > > > > > recursive tail-call case. Thus fgraph uses the bitmap entry to find it
> > > > > > is already set (this means that entry is for previous tail call).
> > > > > > 
> > > > > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > > > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > 
> > > > > As a heads-up, while testing the topic/fprobe-on-fgraph branch on arm64, I get
> > > > > a warning which bisets down to this commit:
> > > > 
> > > > Hmm, so does this happen when enabling function graph tracer?
> > > 
> > > Yes; I see it during the function_graph boot-time self-test if I also enable
> > > CONFIG_IRQSOFF_TRACER=y. I can also trigger it regardless of
> > > CONFIG_IRQSOFF_TRACER if I cat /proc/self/stack with the function_graph tracer
> > > enabled (note that I hacked the unwinder to continue after failing to recover a
> > > return address):
> > > 
> > > | # mount -t tracefs none /sys/kernel/tracing/
> > > | # echo function_graph > /sys/kernel/tracing/current_tracer
> > > | # cat /proc/self/stack
> > > | [   37.469980] ------------[ cut here ]------------
> > > | [   37.471503] WARNING: CPU: 2 PID: 174 at arch/arm64/kernel/stacktrace.c:84 arch_stack_walk+0x2d8/0x338
> > > | [   37.474381] Modules linked in:
> > > | [   37.475501] CPU: 2 PID: 174 Comm: cat Not tainted 6.7.0-rc2-00026-gea1e68a341c2-dirty #15
> > > | [   37.478133] Hardware name: linux,dummy-virt (DT)
> > > | [   37.479670] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > | [   37.481923] pc : arch_stack_walk+0x2d8/0x338
> > > | [   37.483373] lr : arch_stack_walk+0x1bc/0x338
> > > | [   37.484818] sp : ffff8000835f3a90
> > > | [   37.485974] x29: ffff8000835f3a90 x28: ffff8000835f3b80 x27: ffff8000835f3b38
> > > | [   37.488405] x26: ffff000004341e00 x25: ffff8000835f4000 x24: ffff80008002df18
> > > | [   37.490842] x23: ffff80008002df18 x22: ffff8000835f3b60 x21: ffff80008015d240
> > > | [   37.493269] x20: ffff8000835f3b50 x19: ffff8000835f3b40 x18: 0000000000000000
> > > | [   37.495704] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > > | [   37.498144] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > > | [   37.500579] x11: ffff800082b4d920 x10: ffff8000835f3a70 x9 : ffff8000800e55a0
> > > | [   37.503021] x8 : ffff80008002df18 x7 : ffff000004341e00 x6 : 00000000ffffffff
> > > | [   37.505452] x5 : 0000000000000000 x4 : ffff8000835f3e48 x3 : ffff8000835f3b80
> > > | [   37.507888] x2 : ffff80008002df18 x1 : ffff000007f7b000 x0 : ffff80008002df18
> > > | [   37.510319] Call trace:
> > > | [   37.511202]  arch_stack_walk+0x2d8/0x338
> > > | [   37.512541]  stack_trace_save_tsk+0x90/0x110
> > > | [   37.514012]  return_to_handler+0x0/0x48
> > > | [   37.515336]  return_to_handler+0x0/0x48
> > > | [   37.516657]  return_to_handler+0x0/0x48
> > > | [   37.517985]  return_to_handler+0x0/0x48
> > > | [   37.519305]  return_to_handler+0x0/0x48
> > > | [   37.520623]  return_to_handler+0x0/0x48
> > > | [   37.521957]  return_to_handler+0x0/0x48
> > > | [   37.523272]  return_to_handler+0x0/0x48
> > > | [   37.524595]  return_to_handler+0x0/0x48
> > > | [   37.525931]  return_to_handler+0x0/0x48
> > > | [   37.527254]  return_to_handler+0x0/0x48
> > > | [   37.528564]  el0t_64_sync_handler+0x120/0x130
> > > | [   37.530046]  el0t_64_sync+0x190/0x198
> > > | [   37.531310] ---[ end trace 0000000000000000 ]---
> > > | [<0>] ftrace_stub_graph+0x8/0x8
> > > | [<0>] ftrace_stub_graph+0x8/0x8
> > > | [<0>] ftrace_stub_graph+0x8/0x8
> > > | [<0>] ftrace_stub_graph+0x8/0x8
> > > | [<0>] ftrace_stub_graph+0x8/0x8
> > > | [<0>] ftrace_stub_graph+0x8/0x8
> > > | [<0>] ftrace_stub_graph+0x8/0x8
> > > | [<0>] ftrace_stub_graph+0x8/0x8
> > > | [<0>] ftrace_stub_graph+0x8/0x8
> > > | [<0>] ftrace_stub_graph+0x8/0x8
> > > | [<0>] ftrace_stub_graph+0x8/0x8
> > > | [<0>] el0t_64_sync_handler+0x120/0x130
> > > | [<0>] el0t_64_sync+0x190/0x198
> > 
> > Hmm, I haven't see this mode.
> > 
> > > 
> > > One interesting thing there is that there are two distinct failure modes: the
> > > unwind for the WARNING gives return_to_handler instead of the original return
> > > address, and the unwind returned from /proc/self/stack gives ftrace_stub_graph
> > > rather than the original return address.
> > > 
> > > > > 
> > > > > | Testing tracer function_graph: 
> > > > > | ------------[ cut here ]------------
> > > > > | WARNING: CPU: 2 PID: 0 at arch/arm64/kernel/stacktrace.c:84 arch_stack_walk+0x3c0/0x3d8
> > > > > | Modules linked in:
> > > > > | CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.7.0-rc2-00026-gea1e68a341c2 #12
> > > > > | Hardware name: linux,dummy-virt (DT)
> > > > > | pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > > | pc : arch_stack_walk+0x3c0/0x3d8
> > > > > | lr : arch_stack_walk+0x260/0x3d8
> > > > > | sp : ffff80008318be00
> > > > > | x29: ffff80008318be00 x28: ffff000003c0ae80 x27: 0000000000000000
> > > > > | x26: 0000000000000000 x25: ffff000003c0ae80 x24: 0000000000000000
> > > > > | x23: ffff8000800234c8 x22: ffff80008002dc30 x21: ffff800080035d10
> > > > > | x20: ffff80008318bee8 x19: ffff800080023460 x18: ffff800083453c68
> > > > > | x17: 0000000000000000 x16: ffff800083188000 x15: 000000008ccc5058
> > > > > | x14: 0000000000000004 x13: ffff800082b8c4f0 x12: 0000000000000000
> > > > > | x11: ffff800081fba9b0 x10: ffff80008318bff0 x9 : ffff800080010798
> > > > > | x8 : ffff80008002dc30 x7 : ffff000003c0ae80 x6 : 00000000ffffffff
> > > > > | x5 : 0000000000000000 x4 : ffff8000832a3c18 x3 : ffff80008318bff0
> > > > > | x2 : ffff80008002dc30 x1 : ffff80008002dc30 x0 : ffff80008002dc30
> > > > > | Call trace:
> > > > > |  arch_stack_walk+0x3c0/0x3d8
> > > > > |  return_address+0x40/0x80
> > > > > |  trace_hardirqs_on+0x8c/0x198
> > > > > |  __do_softirq+0xe8/0x440
> > > > > | ---[ end trace 0000000000000000 ]---
> > > 
> > > With the smae hack to continue after failing to recover a return address, the
> > > failure in the selftest looks like:
> > > 
> > > | ------------[ cut here ]------------
> > > | WARNING: CPU: 7 PID: 0 at arch/arm64/kernel/stacktrace.c:84 arch_stack_walk+0x2d8/0x338
> > > | Modules linked in:
> > > | CPU: 7 PID: 0 Comm: swapper/7 Not tainted 6.7.0-rc2-00026-gea1e68a341c2-dirty #14
> > > | Hardware name: linux,dummy-virt (DT)
> > > | pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > | pc : arch_stack_walk+0x2d8/0x338
> > > | lr : arch_stack_walk+0x1bc/0x338
> > > | sp : ffff8000830c3e20
> > > | x29: ffff8000830c3e20 x28: ffff8000830c3ff0 x27: ffff8000830c3ec8
> > > | x26: ffff0000037e0000 x25: ffff8000830c4000 x24: ffff80008002e080
> > > | x23: ffff80008002e080 x22: ffff8000830c3ee8 x21: ffff800080023418
> > > | x20: ffff8000830c3f50 x19: ffff8000830c3f40 x18: ffffffffffffffff
> > > | x17: 0000000000000000 x16: ffff8000830c0000 x15: 0000000000000000
> > > | x14: 0000000000000002 x13: ffff8000800360f8 x12: ffff800080028330
> > > | x11: ffff800081f4a978 x10: ffff8000830c3ff0 x9 : ffff800080010798
> > > | x8 : ffff80008002e080 x7 : ffff0000037e0000 x6 : 00000000ffffffff
> > > | x5 : 0000000000000000 x4 : ffff8000831dbc18 x3 : ffff8000830c3ff0
> > > | x2 : ffff80008002e080 x1 : ffff0000040a3000 x0 : ffff80008002e080
> > > | Call trace:
> > > |  arch_stack_walk+0x2d8/0x338
> > > |  return_address+0x40/0x80
> > > |  trace_hardirqs_on+0x8c/0x198
> > > |  __do_softirq+0xe8/0x43c
> > > |  return_to_handler+0x0/0x48
> > > |  return_to_handler+0x0/0x48
> > > |  do_softirq_own_stack+0x24/0x38
> > > |  return_to_handler+0x0/0x48
> > > |  el1_interrupt+0x38/0x68
> > > |  el1h_64_irq_handler+0x18/0x28
> > > |  el1h_64_irq+0x64/0x68
> > > |  default_idle_call+0x70/0x178
> > > |  do_idle+0x228/0x290
> > > |  cpu_startup_entry+0x40/0x50
> > > |  secondary_start_kernel+0x138/0x160
> > > |  __secondary_switched+0xb8/0xc0
> > > | ---[ end trace 0000000000000000 ]---
> > 
> > I usually see this and reproduced. Here, I also add a dump of shadow stack.
> > It seems that the unwinder goes to the bottome of the shadow stack.
> > 
> > /sys/kernel/tracing # echo function_graph > current_tracer 
> > [   89.887750] ------------[ cut here ]------------
> > [   89.889864] Dump: return_to_handler = ffffb45fc6a2f1e8
> > [   89.891833]  ret_stack[20]: 20406 0x20406 type = 1, index = 6
> > [   89.896118]  ret_stack[19]: ffff800080003be8 0xffff800080003be8 type = 2, index = 1000
> > [   89.896233]  ret_stack[18]: ffff800080003c20 0xffff800080003c20 type = 3, index = 32
> > [   89.896362]  ret_stack[17]: 0 0x0 type = 0, index = 0
> > [   89.896425]  ret_stack[16]: 14edac7710 0x14edac7710 type = 1, index = 784
> > [   89.896635]  ret_stack[15]: ffffb45fc6a1610c call_break_hook+0x4/0x108 type = 0, index = 268
> > [   89.897882]  ret_stack[14]: ffffb45fc6a162fc brk_handler+0x24/0x70 type = 0, index = 764
> > [   89.898139]  ret_stack[13]: 20406 0x20406 type = 1, index = 6
> > [   89.898337]  ret_stack[12]: ffff800080003c08 0xffff800080003c08 type = 3, index = 8
> > [   89.898554]  ret_stack[11]: ffff800080003c40 0xffff800080003c40 type = 3, index = 64
> > [   89.898645]  ret_stack[10]: 0 0x0 type = 0, index = 0
> > [   89.898832]  ret_stack[9]: 14eda8f920 0x14eda8f920 type = 2, index = 288
> > [   89.899069]  ret_stack[8]: ffffb45fc6a162dc brk_handler+0x4/0x70 type = 0, index = 732
> > [   89.899230]  ret_stack[7]: ffffb45fc6a36c24 do_debug_exception+0x74/0x108 type = 3, index = 36
> > [   89.899385]  ret_stack[6]: 20406 0x20406 type = 1, index = 6
> > [   89.899456]  ret_stack[5]: ffff800080003fb8 0xffff800080003fb8 type = 3, index = 952
> > [   89.899518]  ret_stack[4]: ffff800080003ff0 0xffff800080003ff0 type = 3, index = 1008
> > [   89.899578]  ret_stack[3]: ffff62a80534d21c 0xffff62a80534d21c type = 0, index = 540
> > [   89.899637]  ret_stack[2]: 14ed8ed2e0 0x14ed8ed2e0 type = 0, index = 736
> > [   89.899695]  ret_stack[1]: ffffb45fc6a1069c __do_softirq+0x4/0x4f0 type = 1, index = 668
> > [   89.899986] ret_stack[15]: ffff62a80534d070
> > [   89.900221] 	func: call_break_hook, return:brk_handler
> > [   89.901025] ret_stack[8]: ffff62a80534d038
> > [   89.901223] 	func: brk_handler, return:do_debug_exception
> > [   89.901450] ret_stack[1]: ffff62a80534d000
> > [   89.901501] 	func: __do_softirq, return:____do_softirq
> > [   89.901693] ret_stack[1]: 0
> > [   90.015738] WARNING: CPU: 0 PID: 0 at arch/arm64/kernel/stacktrace.c:84 arch_stack_walk+0x2d8/0x380
> > [   90.022314] Modules linked in:
> > [   90.032375] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G                 N 6.7.0-rc8-00036-g3897e34e8ae2-dirty #79
> > [   90.038797] Hardware name: linux,dummy-virt (DT)
> > [   90.044170] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [   90.048879] pc : arch_stack_walk+0x2d8/0x380
> > [   90.052222] lr : arch_stack_walk+0x248/0x380
> > [   90.055635] sp : ffff800080003e20
> > [   90.058147] x29: ffff800080003e20 x28: ffffb45fc91993c0 x27: 0000000000000000
> > [   90.063705] x26: 0000000000000000 x25: 0000000000000000 x24: ffffb45fc918fb40
> > [   90.068946] x23: ffffb45fc6a247b8 x22: ffffb45fc6a2f1e8 x21: ffffb45fc6a35b30
> > [   90.074894] x20: ffff800080003ef8 x19: ffffb45fc6a24750 x18: 0000000000000000
> > [   90.078796] x17: 0000000000000000 x16: ffff800080000000 x15: 0000ffffff477588
> > [   90.084310] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > [   90.088898] x11: ffffb45fc924ca08 x10: ffff62a8040341c0 x9 : ffffb45fc6a10760
> > [   90.094430] x8 : ffffb45fc6a2f1e8 x7 : ffffb45fc91993c0 x6 : ffff62a80534d000
> > [   90.099829] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800080003ff0
> > [   90.104442] x2 : ffffb45fc6a2f1e8 x1 : ffffb45fc6a2f1e8 x0 : ffffb45fc6a2f1e8
> > [   90.111735] Call trace:
> > [   90.114923]  arch_stack_walk+0x2d8/0x380
> > [   90.118820]  return_address+0x40/0x80
> > [   90.122057]  trace_hardirqs_on+0xa0/0x100
> > [   90.125001]  __do_softirq+0xec/0x4f0
> > [   90.130907] irq event stamp: 102709
> > [   90.134223] hardirqs last  enabled at (102707): [<ffffb45fc7af51d8>] default_idle_call+0xa0/0x160
> > [   90.140612] hardirqs last disabled at (102708): [<ffffb45fc7af26ec>] el1_interrupt+0x24/0x68
> > [   90.145877] softirqs last  enabled at (102702): [<ffffb45fc6a10b40>] __do_softirq+0x4a8/0x4f0
> > [   90.148952] softirqs last disabled at (102709): [<ffffb45fc6a2f1e8>] return_to_handler+0x0/0x50
> > [   90.152834] ---[ end trace 0000000000000000 ]---
> > 
> > 
> > > 
> > > The portion of the trace with:
> > > 
> > > 	__do_softirq+0xe8/0x43c
> > > 	return_to_handler+0x0/0x48
> > > 	return_to_handler+0x0/0x48
> > > 	do_softirq_own_stack+0x24/0x38
> > > 
> > > ... should be something like:
> > > 
> > > 	__do_softirq
> > > 	____do_softirq
> > > 	call_on_irq_stack	// asm trampoline, not traceable
> > > 	do_softirq_own_stack
> > > 
> > > The generated assembly for do_softirq_own_stack(), ____do_softirq(), and
> > > __do_softirq() is as I'd expect with no tail calls, so I can't see an obvious
> > > reason the return address cannot be recovered correctly.
> > 
> > My question is that even if unwinder fails, the program runs normally.
> > Isn't it a real stack entry?
> > 
> > > 
> > > > > That's a warning in arm64's unwind_recover_return_address() function, which
> > > > > fires when ftrace_graph_ret_addr() finds return_to_handler:
> > > > > 
> > > > > 	if (state->task->ret_stack &&
> > > > > 	    (state->pc == (unsigned long)return_to_handler)) {
> > > > > 		unsigned long orig_pc;
> > > > > 		orig_pc = ftrace_graph_ret_addr(state->task, NULL, state->pc,
> > > > > 						(void *)state->fp);
> > > > > 		if (WARN_ON_ONCE(state->pc == orig_pc))
> > > > > 			return -EINVAL;
> > > > > 		state->pc = orig_pc;
> > > > > 	}
> > > > > 
> > > > > The rationale there is that since tail calls are (currently) disabled on arm64,
> > > > > the only reason for ftrace_graph_ret_addr() to return return_to_handler is when
> > > > > it fails to find the original return address.
> > > > 
> > > > Yes. what about FP check?
> > > 
> > > Do you mean HAVE_FUNCTION_GRAPH_FP_TEST?
> > > 
> > > That is enabled, and there are warnings from ftrace_pop_return_trace(), so I
> > > believe push/pop is balanced.
> > 
> > OK.
> > 
> > > 
> > > We also have HAVE_FUNCTION_GRAPH_RET_ADDR_PTR, but since the return address is
> > > not on the stack at the point function-entry is intercepted we use the FP as
> > > the retp value -- in the absence of tail calls this will be different between a
> > > caller and callee.
> > > 
> > > > > Does this change make it legitimate for ftrace_graph_ret_addr() to return
> > > > > return_to_handler in other cases, or is that a bug?
> > > > 
> > > > It should be a bug to be fixed.
> > > 
> > > Cool; thanks for confirming!
> > > 
> > > > > Either way, we'll need *some* way to recover the original return addresss...
> > > > 
> > > > At least it needs to dump the shadow stack so that we can analyze what
> > > > happened. 
> > > 
> > > Sounds like a plan; as above I'll have a go at putting that together and will
> > > dump the results here.
> > 
> > Yeah, please try below patch.
> > 
> > Thanks,
> > 
> > ---
> >  arch/arm64/kernel/stacktrace.c | 10 +++++++++-
> >  include/linux/ftrace.h         |  2 ++
> >  kernel/trace/fgraph.c          | 24 ++++++++++++++++++++++++
> >  3 files changed, 35 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > index 17f66a74c745..0eaba1bad599 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -81,8 +81,16 @@ unwind_recover_return_address(struct unwind_state *state)
> >  		unsigned long orig_pc;
> >  		orig_pc = ftrace_graph_ret_addr(state->task, NULL, state->pc,
> >  						(void *)state->fp);
> > -		if (WARN_ON_ONCE(state->pc == orig_pc))
> > +		if (WARN_ON_ONCE(state->pc == orig_pc)) {
> > +			static bool dumped;
> > +
> > +			if (!dumped) {
> > +				pr_info("Dump: return_to_handler = %lx\n", (unsigned long)return_to_handler);
> > +				dumped = true;
> > +				fgraph_dump_ret_stack(state->task);
> > +			}
> >  			return -EINVAL;
> > +		}
> >  		state->pc = orig_pc;
> >  	}
> >  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index ad28daa507f7..cfb79977fdec 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -1258,6 +1258,8 @@ static inline void unpause_graph_tracing(void)
> >  {
> >  	atomic_dec(&current->tracing_graph_pause);
> >  }
> > +
> > +void fgraph_dump_ret_stack(struct task_struct *t);
> >  #else /* !CONFIG_FUNCTION_GRAPH_TRACER */
> >  
> >  #define __notrace_funcgraph
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index 0f11f80bdd6c..5dd560fbacce 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -437,6 +437,30 @@ get_ret_stack(struct task_struct *t, int offset, int *index)
> >  	return RET_STACK(t, offset);
> >  }
> >  
> > +void fgraph_dump_ret_stack(struct task_struct *t)
> > +{
> > +	struct ftrace_ret_stack *ret_stack;
> > +	unsigned long val;
> > +	int i, offset, next;
> > +
> > +	for (i = t->curr_ret_stack - 1; i > 0; i--) {
> > +		val = get_fgraph_entry(t, i);
> > +		pr_err(" ret_stack[%d]: %lx %pS type = %d, index = %d\n",
> > +			i, val, (void *)val, __get_type(val), __get_index(val));
> > +	}
> > +	offset = t->curr_ret_stack;
> > +	do {
> > +		ret_stack = get_ret_stack(t, offset, &next);
> > +		pr_err("ret_stack[%d]: %lx\n",
> > +			next + 1, (unsigned long)ret_stack);
> > +		if (ret_stack) {
> > +			pr_err("\tfunc: %ps, return:%ps\n",
> > +				(void *)ret_stack->func, (void *)ret_stack->ret);
> > +		}
> > +		offset = next;
> > +	} while (ret_stack);
> > +}
> > +
> >  /* Both enabled by default (can be cleared by function_graph tracer flags */
> >  static bool fgraph_sleep_time = true;
> >  
> > -- 
> > 2.34.1
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

