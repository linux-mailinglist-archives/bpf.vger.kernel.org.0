Return-Path: <bpf+bounces-19183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0292C826DC3
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 13:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609F11F2264A
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73575405C5;
	Mon,  8 Jan 2024 12:26:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56B13FE4E;
	Mon,  8 Jan 2024 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AEAFC15;
	Mon,  8 Jan 2024 04:26:49 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A62BB3F64C;
	Mon,  8 Jan 2024 04:26:00 -0800 (PST)
Date: Mon, 8 Jan 2024 12:25:55 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 11/34] function_graph: Have the instances use their
 own ftrace_ops for filtering
Message-ID: <ZZvp08OFIFbP3rnk@FVFF77S0Q05N>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
 <170290522555.220107.1435543481968270637.stgit@devnote2>
 <ZZg3tlOynx7YVLGQ@FVFF77S0Q05N>
 <20240108101436.07509def635fbecf80a59ae6@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108101436.07509def635fbecf80a59ae6@kernel.org>

Hi,

There's a bit more of an info-dump below; I'll go try to dump the fgraph shadow
stack so that we can analyse this in more detail.

On Mon, Jan 08, 2024 at 10:14:36AM +0900, Masami Hiramatsu wrote:
> On Fri, 5 Jan 2024 17:09:10 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Mon, Dec 18, 2023 at 10:13:46PM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > 
> > > Allow for instances to have their own ftrace_ops part of the fgraph_ops
> > > that makes the funtion_graph tracer filter on the set_ftrace_filter file
> > > of the instance and not the top instance.
> > > 
> > > This also change how the function_graph handles multiple instances on the
> > > shadow stack. Previously we use ARRAY type entries to record which one
> > > is enabled, and this makes it a bitmap of the fgraph_array's indexes.
> > > Previous function_graph_enter() expects calling back from
> > > prepare_ftrace_return() function which is called back only once if it is
> > > enabled. But this introduces different ftrace_ops for each fgraph
> > > instance and those are called from ftrace_graph_func() one by one. Thus
> > > we can not loop on the fgraph_array(), and need to reuse the ret_stack
> > > pushed by the previous instance. Finding the ret_stack is easy because
> > > we can check the ret_stack->func. But that is not enough for the self-
> > > recursive tail-call case. Thus fgraph uses the bitmap entry to find it
> > > is already set (this means that entry is for previous tail call).
> > > 
> > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > As a heads-up, while testing the topic/fprobe-on-fgraph branch on arm64, I get
> > a warning which bisets down to this commit:
> 
> Hmm, so does this happen when enabling function graph tracer?

Yes; I see it during the function_graph boot-time self-test if I also enable
CONFIG_IRQSOFF_TRACER=y. I can also trigger it regardless of
CONFIG_IRQSOFF_TRACER if I cat /proc/self/stack with the function_graph tracer
enabled (note that I hacked the unwinder to continue after failing to recover a
return address):

| # mount -t tracefs none /sys/kernel/tracing/
| # echo function_graph > /sys/kernel/tracing/current_tracer
| # cat /proc/self/stack
| [   37.469980] ------------[ cut here ]------------
| [   37.471503] WARNING: CPU: 2 PID: 174 at arch/arm64/kernel/stacktrace.c:84 arch_stack_walk+0x2d8/0x338
| [   37.474381] Modules linked in:
| [   37.475501] CPU: 2 PID: 174 Comm: cat Not tainted 6.7.0-rc2-00026-gea1e68a341c2-dirty #15
| [   37.478133] Hardware name: linux,dummy-virt (DT)
| [   37.479670] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| [   37.481923] pc : arch_stack_walk+0x2d8/0x338
| [   37.483373] lr : arch_stack_walk+0x1bc/0x338
| [   37.484818] sp : ffff8000835f3a90
| [   37.485974] x29: ffff8000835f3a90 x28: ffff8000835f3b80 x27: ffff8000835f3b38
| [   37.488405] x26: ffff000004341e00 x25: ffff8000835f4000 x24: ffff80008002df18
| [   37.490842] x23: ffff80008002df18 x22: ffff8000835f3b60 x21: ffff80008015d240
| [   37.493269] x20: ffff8000835f3b50 x19: ffff8000835f3b40 x18: 0000000000000000
| [   37.495704] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
| [   37.498144] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
| [   37.500579] x11: ffff800082b4d920 x10: ffff8000835f3a70 x9 : ffff8000800e55a0
| [   37.503021] x8 : ffff80008002df18 x7 : ffff000004341e00 x6 : 00000000ffffffff
| [   37.505452] x5 : 0000000000000000 x4 : ffff8000835f3e48 x3 : ffff8000835f3b80
| [   37.507888] x2 : ffff80008002df18 x1 : ffff000007f7b000 x0 : ffff80008002df18
| [   37.510319] Call trace:
| [   37.511202]  arch_stack_walk+0x2d8/0x338
| [   37.512541]  stack_trace_save_tsk+0x90/0x110
| [   37.514012]  return_to_handler+0x0/0x48
| [   37.515336]  return_to_handler+0x0/0x48
| [   37.516657]  return_to_handler+0x0/0x48
| [   37.517985]  return_to_handler+0x0/0x48
| [   37.519305]  return_to_handler+0x0/0x48
| [   37.520623]  return_to_handler+0x0/0x48
| [   37.521957]  return_to_handler+0x0/0x48
| [   37.523272]  return_to_handler+0x0/0x48
| [   37.524595]  return_to_handler+0x0/0x48
| [   37.525931]  return_to_handler+0x0/0x48
| [   37.527254]  return_to_handler+0x0/0x48
| [   37.528564]  el0t_64_sync_handler+0x120/0x130
| [   37.530046]  el0t_64_sync+0x190/0x198
| [   37.531310] ---[ end trace 0000000000000000 ]---
| [<0>] ftrace_stub_graph+0x8/0x8
| [<0>] ftrace_stub_graph+0x8/0x8
| [<0>] ftrace_stub_graph+0x8/0x8
| [<0>] ftrace_stub_graph+0x8/0x8
| [<0>] ftrace_stub_graph+0x8/0x8
| [<0>] ftrace_stub_graph+0x8/0x8
| [<0>] ftrace_stub_graph+0x8/0x8
| [<0>] ftrace_stub_graph+0x8/0x8
| [<0>] ftrace_stub_graph+0x8/0x8
| [<0>] ftrace_stub_graph+0x8/0x8
| [<0>] ftrace_stub_graph+0x8/0x8
| [<0>] el0t_64_sync_handler+0x120/0x130
| [<0>] el0t_64_sync+0x190/0x198

One interesting thing there is that there are two distinct failure modes: the
unwind for the WARNING gives return_to_handler instead of the original return
address, and the unwind returned from /proc/self/stack gives ftrace_stub_graph
rather than the original return address.

> > 
> > | Testing tracer function_graph: 
> > | ------------[ cut here ]------------
> > | WARNING: CPU: 2 PID: 0 at arch/arm64/kernel/stacktrace.c:84 arch_stack_walk+0x3c0/0x3d8
> > | Modules linked in:
> > | CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.7.0-rc2-00026-gea1e68a341c2 #12
> > | Hardware name: linux,dummy-virt (DT)
> > | pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > | pc : arch_stack_walk+0x3c0/0x3d8
> > | lr : arch_stack_walk+0x260/0x3d8
> > | sp : ffff80008318be00
> > | x29: ffff80008318be00 x28: ffff000003c0ae80 x27: 0000000000000000
> > | x26: 0000000000000000 x25: ffff000003c0ae80 x24: 0000000000000000
> > | x23: ffff8000800234c8 x22: ffff80008002dc30 x21: ffff800080035d10
> > | x20: ffff80008318bee8 x19: ffff800080023460 x18: ffff800083453c68
> > | x17: 0000000000000000 x16: ffff800083188000 x15: 000000008ccc5058
> > | x14: 0000000000000004 x13: ffff800082b8c4f0 x12: 0000000000000000
> > | x11: ffff800081fba9b0 x10: ffff80008318bff0 x9 : ffff800080010798
> > | x8 : ffff80008002dc30 x7 : ffff000003c0ae80 x6 : 00000000ffffffff
> > | x5 : 0000000000000000 x4 : ffff8000832a3c18 x3 : ffff80008318bff0
> > | x2 : ffff80008002dc30 x1 : ffff80008002dc30 x0 : ffff80008002dc30
> > | Call trace:
> > |  arch_stack_walk+0x3c0/0x3d8
> > |  return_address+0x40/0x80
> > |  trace_hardirqs_on+0x8c/0x198
> > |  __do_softirq+0xe8/0x440
> > | ---[ end trace 0000000000000000 ]---

With the smae hack to continue after failing to recover a return address, the
failure in the selftest looks like:

| ------------[ cut here ]------------
| WARNING: CPU: 7 PID: 0 at arch/arm64/kernel/stacktrace.c:84 arch_stack_walk+0x2d8/0x338
| Modules linked in:
| CPU: 7 PID: 0 Comm: swapper/7 Not tainted 6.7.0-rc2-00026-gea1e68a341c2-dirty #14
| Hardware name: linux,dummy-virt (DT)
| pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : arch_stack_walk+0x2d8/0x338
| lr : arch_stack_walk+0x1bc/0x338
| sp : ffff8000830c3e20
| x29: ffff8000830c3e20 x28: ffff8000830c3ff0 x27: ffff8000830c3ec8
| x26: ffff0000037e0000 x25: ffff8000830c4000 x24: ffff80008002e080
| x23: ffff80008002e080 x22: ffff8000830c3ee8 x21: ffff800080023418
| x20: ffff8000830c3f50 x19: ffff8000830c3f40 x18: ffffffffffffffff
| x17: 0000000000000000 x16: ffff8000830c0000 x15: 0000000000000000
| x14: 0000000000000002 x13: ffff8000800360f8 x12: ffff800080028330
| x11: ffff800081f4a978 x10: ffff8000830c3ff0 x9 : ffff800080010798
| x8 : ffff80008002e080 x7 : ffff0000037e0000 x6 : 00000000ffffffff
| x5 : 0000000000000000 x4 : ffff8000831dbc18 x3 : ffff8000830c3ff0
| x2 : ffff80008002e080 x1 : ffff0000040a3000 x0 : ffff80008002e080
| Call trace:
|  arch_stack_walk+0x2d8/0x338
|  return_address+0x40/0x80
|  trace_hardirqs_on+0x8c/0x198
|  __do_softirq+0xe8/0x43c
|  return_to_handler+0x0/0x48
|  return_to_handler+0x0/0x48
|  do_softirq_own_stack+0x24/0x38
|  return_to_handler+0x0/0x48
|  el1_interrupt+0x38/0x68
|  el1h_64_irq_handler+0x18/0x28
|  el1h_64_irq+0x64/0x68
|  default_idle_call+0x70/0x178
|  do_idle+0x228/0x290
|  cpu_startup_entry+0x40/0x50
|  secondary_start_kernel+0x138/0x160
|  __secondary_switched+0xb8/0xc0
| ---[ end trace 0000000000000000 ]---

The portion of the trace with:

	__do_softirq+0xe8/0x43c
	return_to_handler+0x0/0x48
	return_to_handler+0x0/0x48
	do_softirq_own_stack+0x24/0x38

... should be something like:

	__do_softirq
	____do_softirq
	call_on_irq_stack	// asm trampoline, not traceable
	do_softirq_own_stack

The generated assembly for do_softirq_own_stack(), ____do_softirq(), and
__do_softirq() is as I'd expect with no tail calls, so I can't see an obvious
reason the return address cannot be recovered correctly.

> > That's a warning in arm64's unwind_recover_return_address() function, which
> > fires when ftrace_graph_ret_addr() finds return_to_handler:
> > 
> > 	if (state->task->ret_stack &&
> > 	    (state->pc == (unsigned long)return_to_handler)) {
> > 		unsigned long orig_pc;
> > 		orig_pc = ftrace_graph_ret_addr(state->task, NULL, state->pc,
> > 						(void *)state->fp);
> > 		if (WARN_ON_ONCE(state->pc == orig_pc))
> > 			return -EINVAL;
> > 		state->pc = orig_pc;
> > 	}
> > 
> > The rationale there is that since tail calls are (currently) disabled on arm64,
> > the only reason for ftrace_graph_ret_addr() to return return_to_handler is when
> > it fails to find the original return address.
> 
> Yes. what about FP check?

Do you mean HAVE_FUNCTION_GRAPH_FP_TEST?

That is enabled, and there are warnings from ftrace_pop_return_trace(), so I
believe push/pop is balanced.

We also have HAVE_FUNCTION_GRAPH_RET_ADDR_PTR, but since the return address is
not on the stack at the point function-entry is intercepted we use the FP as
the retp value -- in the absence of tail calls this will be different between a
caller and callee.

> > Does this change make it legitimate for ftrace_graph_ret_addr() to return
> > return_to_handler in other cases, or is that a bug?
> 
> It should be a bug to be fixed.

Cool; thanks for confirming!

> > Either way, we'll need *some* way to recover the original return addresss...
> 
> At least it needs to dump the shadow stack so that we can analyze what
> happened. 

Sounds like a plan; as above I'll have a go at putting that together and will
dump the results here.

Thanks for the help! :)

Mark.

