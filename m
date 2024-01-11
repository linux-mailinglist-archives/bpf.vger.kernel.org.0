Return-Path: <bpf+bounces-19366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5F382AFEE
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 14:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17A91C23DC3
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 13:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7928E36B0E;
	Thu, 11 Jan 2024 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Otuorx5P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C1E360B1;
	Thu, 11 Jan 2024 13:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D947C433C7;
	Thu, 11 Jan 2024 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704980846;
	bh=VmYIuHNFpAz3LOz9NBDiJCUeFlaLSYys+F8WdobNIWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Otuorx5P1ZH+ifPjHawCm0vkd+0hzqgsloxeS60G75hlMfsHHww6a2ZKKRJm2dUVR
	 mXDpLoqwenyisqT9aP3L2+qViHBsFZW15X8WxyclbXTD+91bFsaKxNatFGGmg7m6vJ
	 LSMmmDmIenIuz2aNFCjrdoN0AOx8C22c9B8PAXXEpt13N7CbcyCGMBaxthC5zb0C+h
	 cYfdac8ERIJ9dnuff5R2KCm3xdnqjXq/qz0tul35ujIQbPqD1d8fjgHqOw/FXxJhOT
	 6CuhPSYa6SVAFUZBXH3zynca1S9X5twmQG0uZO7aeUaP3OQeOapXjq37+lJTdCrJ3/
	 mqfSR80rUzdjQ==
Date: Thu, 11 Jan 2024 22:47:20 +0900
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
Message-Id: <20240111224720.12d2062d360641be25deb9d2@kernel.org>
In-Reply-To: <ZZwOubTSbB_FucVz@FVFF77S0Q05N>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
	<170290522555.220107.1435543481968270637.stgit@devnote2>
	<ZZg3tlOynx7YVLGQ@FVFF77S0Q05N>
	<20240108101436.07509def635fbecf80a59ae6@kernel.org>
	<ZZvp08OFIFbP3rnk@FVFF77S0Q05N>
	<ZZwEz8HsTa2IZE3L@FVFF77S0Q05N>
	<ZZwOubTSbB_FucVz@FVFF77S0Q05N>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jan 2024 15:03:21 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Mon, Jan 08, 2024 at 02:21:03PM +0000, Mark Rutland wrote:
> > On Mon, Jan 08, 2024 at 12:25:55PM +0000, Mark Rutland wrote:
> > > We also have HAVE_FUNCTION_GRAPH_RET_ADDR_PTR, but since the return address is
> > > not on the stack at the point function-entry is intercepted we use the FP as
> > > the retp value -- in the absence of tail calls this will be different between a
> > > caller and callee.
> > 
> > Ah; I just spotted that this patch changed that in ftrace_graph_func(), which
> > is the source of the bug. 
> > 
> > As of this patch, we use the address of fregs->lr as the retp value, but the
> > unwinder still uses the FP value, and so when unwind_recover_return_address()
> > calls ftrace_graph_ret_addr(), the retp value won't match the expected entry on
> > the fgraph ret_stack, resulting in failing to find the expected entry.
> > 
> > Since the ftrace_regs only exist transiently during function entry/exit, it's
> > possible for a stackframe to reuse that same address on the stack, which would
> > result in finding a different entry by mistake.
> > 
> > The diff below restores the existing behaviour and fixes the issue for me.
> > Could you please fold that into this patch?
> > 
> > On a separate note, looking at how this patch changed arm64's
> > ftrace_graph_func(), do we need similar changes to arm64's
> > prepare_ftrace_return() for the old-style mcount based ftrace?
> > 
> > Mark.
> > 
> > ---->8----
> > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > index 205937e04ece..329092ce06ba 100644
> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -495,7 +495,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> >         if (bit < 0)
> >                 return;
> >  
> > -       if (!function_graph_enter_ops(*parent, ip, fregs->fp, parent, gops))
> > +       if (!function_graph_enter_ops(*parent, ip, fregs->fp, (void *)fregs->fp, gops))
> >                 *parent = (unsigned long)&return_to_handler;
> >  
> >         ftrace_test_recursion_unlock(bit);
> 
> Thinking some more, this line gets excessively long when we pass the fregs too,
> so it's probably worth adding a local variable for fp, i.e. the diff below.

Yeah, that will be better to keep the line short.

Thank you,

> 
> Mark.
> 
> ---->8----
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index 205937e04ece..d4e142ef4686 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -481,8 +481,9 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
>  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>                        struct ftrace_ops *op, struct ftrace_regs *fregs)
>  {
> -       unsigned long *parent = &fregs->lr;
>         struct fgraph_ops *gops = container_of(op, struct fgraph_ops, ops);
> +       unsigned long *parent = &fregs->lr;
> +       unsigned long fp = fregs->fp;
>         int bit;
>  
>         if (unlikely(ftrace_graph_is_dead()))
> @@ -495,7 +496,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>         if (bit < 0)
>                 return;
>  
> -       if (!function_graph_enter_ops(*parent, ip, fregs->fp, parent, gops))
> +       if (!function_graph_enter_ops(*parent, ip, fp, (void *)fp, gops))
>                 *parent = (unsigned long)&return_to_handler;
>  
>         ftrace_test_recursion_unlock(bit);
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

