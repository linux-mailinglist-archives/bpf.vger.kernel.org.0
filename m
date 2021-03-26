Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C2F34A6CB
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 13:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhCZMEF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 08:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhCZMD7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 08:03:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32CB86194B;
        Fri, 26 Mar 2021 12:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616760235;
        bh=8h2SmvYpT1Z+mdnymZzkHoSxcblXfBcLpq9cNLD9rvs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ObS/o1ezjBhN/DEEwQln2MbNFK4SOzdHFtjOJ2U4m0ifBg/eG82nnPdTE0yvcjAn3
         bK/SrDDp9NR4r41k1GAQZf/mqGjvdAB/q5PfcgAp071A4D9aPAHzWe2MCprLzrAR2Q
         nPyfXYjjiIV7gRV3gusZ0/aTgs3TUK4wykQlTS6DwytSmJC4xKZd1PLDy1CcvMb2yR
         1cjS8X+Yg4Etai6JqJgd/aoluN/LgejHniApTOwqgOZPGAY93J+BtBLHL7B9O5PUIP
         6hhauGKjRDTvx5UKHQc7iFQ3ij73kQYEO4DV2X36pvk6I9JXTLvlst/GooNcMzEvha
         hsYWukRXt1NuQ==
Date:   Fri, 26 Mar 2021 21:03:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v4 10/12] x86/kprobes: Push a fake return address
 at kretprobe_trampoline
Message-Id: <20210326210349.22f6d34b229dd3a139a53686@kernel.org>
In-Reply-To: <20210326030503.7fa72da34e25ad35cf5ed3de@kernel.org>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
        <161639530062.895304.16962383429668412873.stgit@devnote2>
        <20210323223007.GG4746@worktop.programming.kicks-ass.net>
        <20210324104058.7c06aaeb0408e24db6ba46f8@kernel.org>
        <20210326030503.7fa72da34e25ad35cf5ed3de@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 26 Mar 2021 03:05:03 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 24 Mar 2021 10:40:58 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Tue, 23 Mar 2021 23:30:07 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Mon, Mar 22, 2021 at 03:41:40PM +0900, Masami Hiramatsu wrote:
> > > >  	".global kretprobe_trampoline\n"
> > > >  	".type kretprobe_trampoline, @function\n"
> > > >  	"kretprobe_trampoline:\n"
> > > >  #ifdef CONFIG_X86_64
> > > 
> > > So what happens if we get an NMI here? That is, after the RET but before
> > > the push? Then our IP points into the trampoline but we've not done that
> > > push yet.
> > 
> > Not only NMI, but also interrupts can happen. There is no cli/sti here.
> > 
> > Anyway, thanks for pointing!
> > I think in UNWIND_HINT_TYPE_REGS and UNWIND_HINT_TYPE_REGS_PARTIAL cases
> > ORC unwinder also has to check the state->ip and if it is kretprobe_trampoline,
> > it should be recovered.
> > What about this?
> 
> Hmm, this seems to intoduce another issue on stacktrace from kprobes.
> 
>            <...>-137     [003] d.Z.    17.250714: p_full_proxy_read_5: (full_proxy_read+0x5/0x80)
>            <...>-137     [003] d.Z.    17.250737: <stack trace>
>  => kprobe_trace_func+0x1d0/0x2c0
>  => kprobe_dispatcher+0x39/0x60
>  => aggr_pre_handler+0x4f/0x90
>  => kprobe_int3_handler+0x152/0x1a0
>  => exc_int3+0x47/0x140
>  => asm_exc_int3+0x31/0x40
>  => 0
>  => 0
>  => 0
>  => 0
>  => 0
>  => 0
>  => 0
> 
> Let me check...

I confirmed this is not related to this series, but occurs when I build kernels with different
configs without cleanup.

Once I build kernel with CONFIG_UNWIND_GUESS=y (for testing), and after that,
I build kernel again with CONFIG_UNWIND_ORC=y (but without make clean), this
happened. In this case, I guess ORC data might be corrupted?
When I cleanup and rebuild, the stacktrace seems correct.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
