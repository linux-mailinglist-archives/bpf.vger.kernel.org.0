Return-Path: <bpf+bounces-69494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51F6B97DA9
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 02:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C394A61ED
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 00:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56042C86D;
	Wed, 24 Sep 2025 00:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Twi6DgEd"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A6E1A294
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673088; cv=none; b=eBc1dTOpaSXjGWZHBOX0knYvwFNQZQJRw4jf/e6Fw4JGW0lGf5aNzLx4KWrEyuqntu9lscie9dIGf+Ey82pRxpKQGzLOP0CRRDZ9ofzAigOXz4WDKDlBN2HBWhaCq2wE14l/zpkdWUm348RtkswjL4wOR/b0F9OQ4K5xSWqXfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673088; c=relaxed/simple;
	bh=wrEePM+8hKCWdVG7Gfw7OKyKVmttuD8CzctotvyjZNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehbScva53XouHfHXKrToGGsenG4ok55UhJA9nG86UnT56dctlAxC3Slvd+MX83JBOYkJN93XBIBJoUso+RFNZdz4bkJvwGW3kMjoB3ZsCFfWXzgaxr4z+9nctWqAhX4Hl5cX96T5wowGdCQhKm+FgWZEwkh2S13ORiBH8H1C2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Twi6DgEd; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758673072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JB7tYfJuNQ7C5aHmol95cXCFRAbFvrYN+hFgflk9BLE=;
	b=Twi6DgEd5M+EAp5b9MWNSK9kmSxQEYT3u+s8SAriBeUN48C+llXy+ab6VKUBZzi+qmUCMR
	PyiaVvax3Jarczoez7RJgeyZj4JbLnWXjsqYPYBDNTVnAJfvIgn3KPod+xmqxI1/+ODgBU
	1Yb2UStsu90fRMsOez8ziNtgdm+DDxU=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject:
 Re: [PATCH 1/2] tracing: fprobe: rename fprobe_entry to fprobe_fgraph_entry
Date: Wed, 24 Sep 2025 08:17:45 +0800
Message-ID: <5056228.31r3eYUQgx@7950hx>
In-Reply-To: <20250924080722.c05ac758a018be619d01b6a9@kernel.org>
References:
 <20250923092001.1087678-1-dongml2@chinatelecom.cn>
 <20250924080722.c05ac758a018be619d01b6a9@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/24 07:07, Masami Hiramatsu wrote:
> On Tue, 23 Sep 2025 17:20:00 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
> 
> > The fprobe_entry() is used by fgraph_ops, so rename it to
> > fprobe_fgraph_entry to be more distinctive.
> 
> Sorry, NAK. fprobe is based on fgraph by design.
> So "fprobe_fgraph" sounds redundant.

Hi, Masami. Did you see my next patch that use ftrace
for the fprobe to obtain better performance?

Hmm, it seems that the cover-letter is necessary :/

Thanks!
Menglong Dong

> 
> Thanks,
> 
> > 
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  kernel/trace/fprobe.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 6a205903b1ed..1785fba367c9 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -254,8 +254,8 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
> >  	return ret;
> >  }
> >  
> > -static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> > -			struct ftrace_regs *fregs)
> > +static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> > +			       struct ftrace_regs *fregs)
> >  {
> >  	unsigned long *fgraph_data = NULL;
> >  	unsigned long func = trace->func;
> > @@ -340,7 +340,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> >  	/* If any exit_handler is set, data must be used. */
> >  	return used != 0;
> >  }
> > -NOKPROBE_SYMBOL(fprobe_entry);
> > +NOKPROBE_SYMBOL(fprobe_fgraph_entry);
> >  
> >  static void fprobe_return(struct ftrace_graph_ret *trace,
> >  			  struct fgraph_ops *gops,
> > @@ -379,7 +379,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
> >  NOKPROBE_SYMBOL(fprobe_return);
> >  
> >  static struct fgraph_ops fprobe_graph_ops = {
> > -	.entryfunc	= fprobe_entry,
> > +	.entryfunc	= fprobe_fgraph_entry,
> >  	.retfunc	= fprobe_return,
> >  };
> >  static int fprobe_graph_active;
> 
> 
> 





