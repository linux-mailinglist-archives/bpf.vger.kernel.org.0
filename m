Return-Path: <bpf+bounces-69164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9F4B8E955
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 01:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BEF07AC098
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 22:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFBB2472AA;
	Sun, 21 Sep 2025 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLV2eMtq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA691A76BB;
	Sun, 21 Sep 2025 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758495663; cv=none; b=gpB3a3s/bxT0bDNrrwTS+d3nHdX/4CDaecL0yhevhoGpFcx0iPXX7OJg6e9agUUA/qZce+PmxyjNTUPdwda76HoWnSQjveaTlGfeeETOdypc2f8UJIwz2r9pfGdJWVPikGP/jMNJk9Z8Ahx9avApXtBttHTuM7v2t0yCSUTEIe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758495663; c=relaxed/simple;
	bh=NGcq/u9PxpBZ7j6rtjeYb6cF6phAz6BmvCZx6ODT5E0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rp49u3+CTwdqB7pwiY4s/Pk7bdyE8SCHDipkQvRLZhNO7MFDrmby0rbTScf2gainYP72gaisfww91zGBpy4MawacNY6cTtM6KWHVChVFSVXWwGtv0Z58V0tvN1dGOC5wChp5GRcP8Ry5n4D6wZyFOP33PmjVevQgIFXQ086DWpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLV2eMtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A9AC4CEE7;
	Sun, 21 Sep 2025 23:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758495663;
	bh=NGcq/u9PxpBZ7j6rtjeYb6cF6phAz6BmvCZx6ODT5E0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VLV2eMtq64xW9boInMnL9+i7ixAZjH8E2GFLs5LOtCBFi9Ce9y2hXTSvzOBRYSBSp
	 8AOYyqjnFIN4qgjLI7GfLoXIGV8lUwsc6vF6ZT5YX6IzwpP5jj4bReGxVC9byiJHpY
	 rmCK3k/R1QcMtgGsBINI8RfiR3Wpa4he+qDXW+Y2iAOZos8VENqW67tTsCkOFZ4H3m
	 zR9I+5o0GUS4bUFG3SDZSjjHgJqTsU0ZnlI/hUkd6caVOdPBz7UnICBxNCnBy4bhvv
	 orNJrGeFp+QEvCTS3eiaP/6YqWUO4/5w63IXA0ePbdbk90DL/PMECcJsGWf5JoVb7J
	 s50uQT8ksw8lQ==
Date: Sun, 21 Sep 2025 19:00:56 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Menglong Dong <menglong.dong@linux.dev>, Peter Zijlstra
 <peterz@infradead.org>, Menglong Dong <menglong8.dong@gmail.com>,
 jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 kees@kernel.org, samitolvanen@google.com, rppt@kernel.org, luto@kernel.org,
 ast@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] tracing: fgraph: Protect return handler from recursion
 loop
Message-ID: <20250921190056.2a17d4cc@batman.local.home>
In-Reply-To: <20250921130647.9bd0cba7d49b15d0b0ebe6f7@kernel.org>
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
	<175828305637.117978.4183947592750468265.stgit@devnote2>
	<5974303.DvuYhMxLoT@7950hx>
	<20250921130647.9bd0cba7d49b15d0b0ebe6f7@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Sep 2025 13:06:47 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > Hi, the logic seems right, but the warning is triggered when
> > I try to run the bpf bench testing:  
> 
> Hmm, this is strange. Let me check why this happens.
> 
> Thank you,
> 
> > 
> > $ ./benchs/run_bench_trigger.sh kretprobe-multi-all
> > [   20.619642] NOTICE: Automounting of tracing to debugfs is deprecated and will be removed in 2030
> > [  139.509036] ------------[ cut here ]------------
> > [  139.509180] WARNING: CPU: 2 PID: 522 at kernel/trace/fgraph.c:839 ftrace_return_to_handler+0x2b9/0x2d0
> > [  139.509411] Modules linked in: virtio_net
> > [  139.509514] CPU: 2 UID: 0 PID: 522 Comm: bench Not tainted 6.17.0-rc5-g1fe6d652bfa0 #106 NONE 
> > [  139.509720] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-1-1 04/01/2014
> > [  139.509948] RIP: 0010:ftrace_return_to_handler+0x2b9/0x2d0
> > [  139.510086] Code: e8 0c 08 0e 00 0f 0b 49 c7 c1 00 73 20 81 e9 d1 fe ff ff 40 f6 c6 10 75 11 49 c7 c3 ef ff ff ff ba 10 00 00 00 e9 57 fe ff ff <0f> 0b e9 a5 fe ff ff e8 1b 72 0d 01 66 66 2e 0f 1f 84 00 00 00 00
> > [  139.510536] RSP: 0018:ffffc9000012cef8 EFLAGS: 00010002
> > [  139.510664] RAX: ffff88810f709800 RBX: ffffc900007c3678 RCX: 0000000000000003
> > [  139.510835] RDX: 0000000000000008 RSI: 0000000000000018 RDI: 0000000000000000
> > [  139.511007] RBP: 0000000000000000 R08: 0000000000000034 R09: ffffffff82550319
> > [  139.511184] R10: ffffc9000012cf50 R11: fffffffffffffff7 R12: 0000000000000000
> > [  139.511357] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [  139.511532] FS:  00007fe58276fb00(0000) GS:ffff8884ab3b8000(0000) knlGS:0000000000000000
> > [  139.511724] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  139.511865] CR2: 0000562a28314b67 CR3: 00000001143f9000 CR4: 0000000000750ef0
> > [  139.512038] PKRU: 55555554
> > [  139.512106] Call Trace:
> > [  139.512177]  <IRQ>
> > [  139.512232]  ? irq_exit_rcu+0x4/0xb0
> > [  139.512322]  return_to_handler+0x1e/0x50
> > [  139.512422]  ? idle_cpu+0x9/0x50
> > [  139.512506]  ? sysvec_apic_timer_interrupt+0x69/0x80
> > [  139.512638]  ? idle_cpu+0x9/0x50
> > [  139.512731]  ? irq_exit_rcu+0x3a/0xb0
> > [  139.512833]  ? ftrace_stub_direct_tramp+0x10/0x10
> > [  139.512961]  ? sysvec_apic_timer_interrupt+0x69/0x80
> > [  139.513101]  </IRQ>
> > [  139.513168]  <TASK>
> >   
> > > +
> > >  #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> > >  	trace.retval = ftrace_regs_get_return_value(fregs);
> > >  #endif
> > > @@ -852,6 +862,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> > >  		}
> > >  	}
> > >  
> > > +	ftrace_test_recursion_unlock(bit);
> > > +out:
> > >  	/*
> > >  	 * The ftrace_graph_return() may still access the current
> > >  	 * ret_stack structure, we need to make sure the update of


Hmm, I wonder if this has to do with the "TRANSITION BIT". The
ftrace_test_recursion_trylock() allows one level of recursion. This is
to handle the case of an interrupt happening after the recursion bit is
set and traces something before it updates the context in the preempt
count. This would cause a false positive of the recursion test. To
handle this case, it allows a single level of recursion.

I originally was going to mention this, but I still can't see how this
would affect it. Because if the entry were to allow one level of
recursion, so would the exit. I still see the entry preventing the exit
to be called. But perhaps there's an combination that I missed?

-- Steve

