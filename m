Return-Path: <bpf+bounces-69518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1676B98C5C
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 10:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E06E4A19AD
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 08:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8518128135B;
	Wed, 24 Sep 2025 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WibWyPVD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039F95FDA7;
	Wed, 24 Sep 2025 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701595; cv=none; b=TsQwY4MHh9sYSS2qIUS53a7cd+QUP9kj7KxWbTKsHUwBEHebd5+mD8rixWJnL7a1jYvT6aRXHBwlT6D/HKGRFEZnfJBVYnr6KSm8MK1cysCzbVWZlZTy+a4p+RrjmKGnzeVkAsFK5CDs7/6l7OzhIUbd/kUfVD3x9ZQns47Z0rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701595; c=relaxed/simple;
	bh=bduhBxwlzkxiqK0p2rlEquqVgehvVIbz0epKgJvieeU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HA9q5F4riEnbAC/L0qVGrXkcWM7mz6844QXQ1xlP3rCNv5ncqVpK+IbvocjxfPTIY+/Cz24598550247cuTRYPoQPjcDreRm2DV48/rDVZOLPOF0FK3v5QtkcG3MCqazFWLXL0/Z5QpRj7GI7skNA4vhkgvVcJuRQBppY5TP48E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WibWyPVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5075AC113CF;
	Wed, 24 Sep 2025 08:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758701594;
	bh=bduhBxwlzkxiqK0p2rlEquqVgehvVIbz0epKgJvieeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WibWyPVDE4S5ffXfVIaLUgJAm0sf8+xPMKr5SjU4IXRk7wDUEhh+eN6O0iFx5mYer
	 Mc1uaTufmTeV9n/HY074Zcj3LEX0RgqShSHEeVt0+ioiZ7wMwxFOZpswd28n3+Qn2S
	 ECNv3GIO5rSK0pwz7Jrw6wrlWexKeraxNw4uu30vv5ZVcUe61uUVlkAu8AXzeIkdfr
	 T8jxzY+RyL+oKkyKEelF3fQzELhYBdJW0RD7OYRPSK4mrMJBPJan6piiBnSj1Txsow
	 od25p0ED5s7voWtgRtBwv2qxMAVleASIwM/x1JIeVCnzqr13TuLKdjNzCmcwYQUd19
	 FUSZIl8WhtqRA==
Date: Wed, 24 Sep 2025 17:13:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: fprobe: rename fprobe_entry to
 fprobe_fgraph_entry
Message-Id: <20250924171312.5790795400c78d87d5309333@kernel.org>
In-Reply-To: <5056228.31r3eYUQgx@7950hx>
References: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
	<20250924080722.c05ac758a018be619d01b6a9@kernel.org>
	<5056228.31r3eYUQgx@7950hx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 08:17:45 +0800
Menglong Dong <menglong.dong@linux.dev> wrote:

> On 2025/9/24 07:07, Masami Hiramatsu wrote:
> > On Tue, 23 Sep 2025 17:20:00 +0800
> > Menglong Dong <menglong8.dong@gmail.com> wrote:
> > 
> > > The fprobe_entry() is used by fgraph_ops, so rename it to
> > > fprobe_fgraph_entry to be more distinctive.
> > 
> > Sorry, NAK. fprobe is based on fgraph by design.
> > So "fprobe_fgraph" sounds redundant.
> 
> Hi, Masami. Did you see my next patch that use ftrace
> for the fprobe to obtain better performance?
> 
> Hmm, it seems that the cover-letter is necessary :/

Yeah, I missed [2/2]. And anyway I think this should be
merged to [2/2].

Thank you,

> 
> Thanks!
> Menglong Dong
> 
> > 
> > Thanks,
> > 
> > > 
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > ---
> > >  kernel/trace/fprobe.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > > index 6a205903b1ed..1785fba367c9 100644
> > > --- a/kernel/trace/fprobe.c
> > > +++ b/kernel/trace/fprobe.c
> > > @@ -254,8 +254,8 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
> > >  	return ret;
> > >  }
> > >  
> > > -static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> > > -			struct ftrace_regs *fregs)
> > > +static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> > > +			       struct ftrace_regs *fregs)
> > >  {
> > >  	unsigned long *fgraph_data = NULL;
> > >  	unsigned long func = trace->func;
> > > @@ -340,7 +340,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> > >  	/* If any exit_handler is set, data must be used. */
> > >  	return used != 0;
> > >  }
> > > -NOKPROBE_SYMBOL(fprobe_entry);
> > > +NOKPROBE_SYMBOL(fprobe_fgraph_entry);
> > >  
> > >  static void fprobe_return(struct ftrace_graph_ret *trace,
> > >  			  struct fgraph_ops *gops,
> > > @@ -379,7 +379,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
> > >  NOKPROBE_SYMBOL(fprobe_return);
> > >  
> > >  static struct fgraph_ops fprobe_graph_ops = {
> > > -	.entryfunc	= fprobe_entry,
> > > +	.entryfunc	= fprobe_fgraph_entry,
> > >  	.retfunc	= fprobe_return,
> > >  };
> > >  static int fprobe_graph_active;
> > 
> > 
> > 
> 
> 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

