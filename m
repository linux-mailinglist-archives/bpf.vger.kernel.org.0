Return-Path: <bpf+bounces-47614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F1F9FC6A3
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 23:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C123C1629DA
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 22:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EB61A83F1;
	Wed, 25 Dec 2024 22:02:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9498F2AD2C;
	Wed, 25 Dec 2024 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735164147; cv=none; b=MyuXS63UymgM+qfYiVDwlOREslSm7dzO93Ru4r5N1m1PJ2xM6B4w556nBVYBYDVY8unX/jnLi7rJcJ9OJoP/694w4ni7KkcuNfViAnOKSdBa/neM939CsyMjvtoVsMKYjkhbHYKCG6OaR3PdtFt2vbiBErr4YR7y+4G2vjbPbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735164147; c=relaxed/simple;
	bh=aDCKVfMHE4Ad0UO21uNXy+FiRlLW5HlGhJo+XbOuAHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amztMxWhcdJuCfiYHeQpC7/YCmvfxfIIPErlLe34sZQ+72uWdjAtPQB9HVZNyeI5dozwsTpvVY4a0jgqLjvKNDOWCOKupxZvY7GRbGclVXVJR+0VCKOgmURhi470pYardSpizywQwPMH1HFxL+zfU0TgingNGp87NWF9yRygusk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E042C4CECD;
	Wed, 25 Dec 2024 22:02:25 +0000 (UTC)
Date: Wed, 25 Dec 2024 17:02:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sven Schnelle <svens@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Donglin
 Peng <dolinux.peng@gmail.com>, Zheng Yejian <zhengyejian@huaweicloud.com>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ftrace: Add support for function argument to
 graph tracer
Message-ID: <20241225170225.0e1ac99e@batman.local.home>
In-Reply-To: <20241226004152.0bddb524aed8bb0de4eeb43c@kernel.org>
References: <20241223201347.609298489@goodmis.org>
	<20241223201542.067076254@goodmis.org>
	<20241226004152.0bddb524aed8bb0de4eeb43c@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Dec 2024 00:41:52 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> > index d0e4f412c298..c8eda9bebdf4 100644
> > --- a/kernel/trace/trace_functions_graph.c
> > +++ b/kernel/trace/trace_functions_graph.c
> > @@ -12,6 +12,8 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/slab.h>
> >  #include <linux/fs.h>
> > +#include <linux/btf.h>
> > +#include <linux/bpf.h>  
> 
> Do we need these headers? I think it is wrapped by print_function_args().

Oh, probably not. This is just leftovers from the original patch.

> > @@ -814,7 +853,14 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
> >  		if (entry->ent.type != TRACE_GRAPH_RETADDR_ENT)
> >  			print_retaddr = false;
> >  
> > -		trace_seq_printf(s, "%ps();", func);
> > +		trace_seq_printf(s, "%ps", func);
> > +
> > +		if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
> > +			print_function_args(s, entry->args, (unsigned long)func);
> > +			trace_seq_putc(s, ';');
> > +		} else
> > +			trace_seq_puts(s, "();");
> > +
> >  		if (print_retval || print_retaddr)
> >  			trace_seq_puts(s, " /*");
> >  		else
> > @@ -836,12 +882,13 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
> >  	}
> >  
> >  	if (!entry || print_retval || print_retaddr)
> > -		trace_seq_puts(s, " */\n");
> > +		trace_seq_puts(s, " */");  
> 
> Do we need this change?

Hmm, maybe not. It may have been caused by added (and removed) debugging.

Thanks for the review.

-- Steve

