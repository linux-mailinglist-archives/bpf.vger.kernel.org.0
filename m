Return-Path: <bpf+bounces-69123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1521B8D498
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 06:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A7517B851
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 04:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306D329B781;
	Sun, 21 Sep 2025 04:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+8E5Hod"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BCD19CC37;
	Sun, 21 Sep 2025 04:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758427613; cv=none; b=BaY5cNttpHfqIQNHjBSsfvyeGcYhknWx+jxm2N7X13EoRF/gIJuaGtyMebDWVl0JGhjuQn9LQKrTh9c+yiTdG497VWsOPyAPjvxqZX/htO3+VlSe61yg13atZ0JwF/siLF5ULm5h4+UMCajesZl7n9UqXPoECYXRhW3z6YneBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758427613; c=relaxed/simple;
	bh=/CoKvyr+IjZcTa51WhKWINnInCLmnQ7g61ojj/n1zzU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r5iBiHkEPny/n7Mi8h2JeVwg4ErjtKvxYUOA+6NErNTkqo6kNyLVWBzU/RJUuZUra/V5fd6SK0GFFl+9JR6CTOIW3IS1bi6zlR2Y6TafgpBzya7N4MYbGOEqK97b40E3mFEqYNkQqqwGLe/KQ73LvgjzUynZHeOG+Xrho2Z2ht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+8E5Hod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7311EC4CEE7;
	Sun, 21 Sep 2025 04:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758427613;
	bh=/CoKvyr+IjZcTa51WhKWINnInCLmnQ7g61ojj/n1zzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g+8E5HoduDSsarBCfi8x91otYLuKkBQEOx9r7LcQkGerifpPBJfhCUDurd3Vn69WI
	 b4Xi3O2YyIO4TlhmnhB+XaaSRcArV9vB/oE/ngCaczzDUqDJwwXUcAlL+x+gWw3F/Z
	 4vn2DVT+qbpm84Ui+7aoRUl4XaGUznFinR1dm29vFES2bbpFrxg/khwkx8OcSAupzE
	 PpDNBPVTHOGwNFGou+HFMTRjxVOYfiGuXe/uoL/NPKyjukcFnfRjJknL0S5aVLp1AE
	 ydwW+iQO/svai63EG88HKRx8dhVtmw/0q5uCe7omyV2phwmGxcqY2Q5wuP28b92meA
	 VirR3Nlu/pUaQ==
Date: Sun, 21 Sep 2025 13:06:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>,
 jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 kees@kernel.org, samitolvanen@google.com, rppt@kernel.org, luto@kernel.org,
 ast@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] tracing: fgraph: Protect return handler from recursion
 loop
Message-Id: <20250921130647.9bd0cba7d49b15d0b0ebe6f7@kernel.org>
In-Reply-To: <5974303.DvuYhMxLoT@7950hx>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
	<175828305637.117978.4183947592750468265.stgit@devnote2>
	<5974303.DvuYhMxLoT@7950hx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 21:39:25 +0800
Menglong Dong <menglong.dong@linux.dev> wrote:

> On 2025/9/19 19:57, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > function_graph_enter_regs() prevents itself from recursion by
> > ftrace_test_recursion_trylock(), but __ftrace_return_to_handler(),
> > which is called at the exit, does not prevent such recursion.
> > Therefore, while it can prevent recursive calls from
> > fgraph_ops::entryfunc(), it is not able to prevent recursive calls
> > to fgraph from fgraph_ops::retfunc(), resulting in a recursive loop.
> > This can lead an unexpected recursion bug reported by Menglong.
> > 
> >  is_endbr() is called in __ftrace_return_to_handler -> fprobe_return
> >   -> kprobe_multi_link_exit_handler -> is_endbr.
> > 
> > To fix this issue, acquire ftrace_test_recursion_trylock() in the
> > __ftrace_return_to_handler() after unwind the shadow stack to mark
> > this section must prevent recursive call of fgraph inside user-defined
> > fgraph_ops::retfunc().
> > 
> > This is essentially a fix to commit 4346ba160409 ("fprobe: Rewrite
> > fprobe on function-graph tracer"), because before that fgraph was
> > only used from the function graph tracer. Fprobe allowed user to run
> > any callbacks from fgraph after that commit.
> > 
> > Reported-by: Menglong Dong <menglong8.dong@gmail.com>
> > Closes: https://lore.kernel.org/all/20250918120939.1706585-1-dongml2@chinatelecom.cn/
> > Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/fgraph.c |   12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index 1e3b32b1e82c..08dde420635b 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -815,6 +815,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> >  	unsigned long bitmap;
> >  	unsigned long ret;
> >  	int offset;
> > +	int bit;
> >  	int i;
> >  
> >  	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
> > @@ -829,6 +830,15 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> >  	if (fregs)
> >  		ftrace_regs_set_instruction_pointer(fregs, ret);
> >  
> > +	bit = ftrace_test_recursion_trylock(trace.func, ret);
> > +	/*
> > +	 * This must be succeeded because the entry handler returns before
> > +	 * modifying the return address if it is nested. Anyway, we need to
> > +	 * avoid calling user callbacks if it is nested.
> > +	 */
> > +	if (WARN_ON_ONCE(bit < 0))
> > +		goto out;
> 
> Hi, the logic seems right, but the warning is triggered when
> I try to run the bpf bench testing:

Hmm, this is strange. Let me check why this happens.

Thank you,

> 
> $ ./benchs/run_bench_trigger.sh kretprobe-multi-all
> [   20.619642] NOTICE: Automounting of tracing to debugfs is deprecated and will be removed in 2030
> [  139.509036] ------------[ cut here ]------------
> [  139.509180] WARNING: CPU: 2 PID: 522 at kernel/trace/fgraph.c:839 ftrace_return_to_handler+0x2b9/0x2d0
> [  139.509411] Modules linked in: virtio_net
> [  139.509514] CPU: 2 UID: 0 PID: 522 Comm: bench Not tainted 6.17.0-rc5-g1fe6d652bfa0 #106 NONE 
> [  139.509720] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-1-1 04/01/2014
> [  139.509948] RIP: 0010:ftrace_return_to_handler+0x2b9/0x2d0
> [  139.510086] Code: e8 0c 08 0e 00 0f 0b 49 c7 c1 00 73 20 81 e9 d1 fe ff ff 40 f6 c6 10 75 11 49 c7 c3 ef ff ff ff ba 10 00 00 00 e9 57 fe ff ff <0f> 0b e9 a5 fe ff ff e8 1b 72 0d 01 66 66 2e 0f 1f 84 00 00 00 00
> [  139.510536] RSP: 0018:ffffc9000012cef8 EFLAGS: 00010002
> [  139.510664] RAX: ffff88810f709800 RBX: ffffc900007c3678 RCX: 0000000000000003
> [  139.510835] RDX: 0000000000000008 RSI: 0000000000000018 RDI: 0000000000000000
> [  139.511007] RBP: 0000000000000000 R08: 0000000000000034 R09: ffffffff82550319
> [  139.511184] R10: ffffc9000012cf50 R11: fffffffffffffff7 R12: 0000000000000000
> [  139.511357] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  139.511532] FS:  00007fe58276fb00(0000) GS:ffff8884ab3b8000(0000) knlGS:0000000000000000
> [  139.511724] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  139.511865] CR2: 0000562a28314b67 CR3: 00000001143f9000 CR4: 0000000000750ef0
> [  139.512038] PKRU: 55555554
> [  139.512106] Call Trace:
> [  139.512177]  <IRQ>
> [  139.512232]  ? irq_exit_rcu+0x4/0xb0
> [  139.512322]  return_to_handler+0x1e/0x50
> [  139.512422]  ? idle_cpu+0x9/0x50
> [  139.512506]  ? sysvec_apic_timer_interrupt+0x69/0x80
> [  139.512638]  ? idle_cpu+0x9/0x50
> [  139.512731]  ? irq_exit_rcu+0x3a/0xb0
> [  139.512833]  ? ftrace_stub_direct_tramp+0x10/0x10
> [  139.512961]  ? sysvec_apic_timer_interrupt+0x69/0x80
> [  139.513101]  </IRQ>
> [  139.513168]  <TASK>
> 
> > +
> >  #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> >  	trace.retval = ftrace_regs_get_return_value(fregs);
> >  #endif
> > @@ -852,6 +862,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> >  		}
> >  	}
> >  
> > +	ftrace_test_recursion_unlock(bit);
> > +out:
> >  	/*
> >  	 * The ftrace_graph_return() may still access the current
> >  	 * ret_stack structure, we need to make sure the update of
> > 
> > 
> > 
> 
> 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

