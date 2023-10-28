Return-Path: <bpf+bounces-13536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D477DA502
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 05:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BD75B21634
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 03:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5354DA5C;
	Sat, 28 Oct 2023 03:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcXwIpdJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953EC396;
	Sat, 28 Oct 2023 03:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A8CC433C8;
	Sat, 28 Oct 2023 03:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698463090;
	bh=d/Vb6DNmTEBIIjqjO5hkSt8UwYYghPzG/0GkjApsIVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TcXwIpdJHA9nIFKmtJNWNLw1daZ7qiOc+Mhes/nR86coS9F9wUOwYUK+OKywcMFoy
	 Ur+QR/k5pLehHfbF6OM15xrEF/OcjooKzJWsJXjVOf1BTRt5vw4ne25G4rFQNykinG
	 VT9wDrUMu16ughKkWxLABC7mGkZ/b5FFTO3L/dZ6W9DPPIMhopoaTX3xJ7vy0Fj3T7
	 hnpuaYFiVFlHJ7O8QLyETjFpYbBlFwA0fUikiUFlsHgBuWDRWXnAYwXWzAN4mMpqkS
	 ckhuXVDFXnrMvzYiB0zTCtjgLb4ctjTMMLaxADBVN1NiHQ0HnhvPBDwUYRWDTNXTQI
	 xNzmCvR9/ENNg==
Date: Sat, 28 Oct 2023 12:18:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Francis Laniel
 <flaniel@linux.microsoft.com>, <stable@vger.kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing/kprobes: Fix symbol counting logic by looking
 at modules as well
Message-Id: <20231028121805.d156c41fa75cfdcf91550c33@kernel.org>
In-Reply-To: <20231028104144.de23c2287281e9228ce92508@kernel.org>
References: <20231027233126.2073148-1-andrii@kernel.org>
	<20231028104144.de23c2287281e9228ce92508@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Oct 2023 10:41:44 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi,
> 
> On Fri, 27 Oct 2023 16:31:26 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> > Recent changes to count number of matching symbols when creating
> > a kprobe event failed to take into account kernel modules. As such, it
> > breaks kprobes on kernel module symbols, by assuming there is no match.
> > 
> > Fix this my calling module_kallsyms_on_each_symbol() in addition to
> > kallsyms_on_each_match_symbol() to perform a proper counting.
> > 
> > Cc: Francis Laniel <flaniel@linux.microsoft.com>
> > Cc: stable@vger.kernel.org
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> This fixes "BPF" kprobe event, but not ftrace kprobe events.
> ftrace kprobe events only checks this if it is in the vmlinux not
> modules and that's why my selftest passed the original one.

Ah, my bad. ftrace kprobe event should accept the target symbol without
module name. Yes, in that case it missed the count.

> Hmm, I need another enhancement like this for the events on offline
> modules.

Also, I need to add another test case update without module name.
(this one should be another fix)

Thank you,

> 
> Thank you,
> 
> > ---
> >  kernel/trace/trace_kprobe.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index effcaede4759..1efb27f35963 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -714,14 +714,30 @@ static int count_symbols(void *data, unsigned long unused)
> >  	return 0;
> >  }
> >  
> > +struct sym_count_ctx {
> > +	unsigned int count;
> > +	const char *name;
> > +};
> > +
> > +static int count_mod_symbols(void *data, const char *name, unsigned long unused)
> > +{
> > +	struct sym_count_ctx *ctx = data;
> > +
> > +	if (strcmp(name, ctx->name) == 0)
> > +		ctx->count++;
> > +
> > +	return 0;
> > +}
> > +
> >  static unsigned int number_of_same_symbols(char *func_name)
> >  {
> > -	unsigned int count;
> > +	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
> > +
> > +	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
> >  
> > -	count = 0;
> > -	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
> > +	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
> >  
> > -	return count;
> > +	return ctx.count;
> >  }
> >  
> >  static int __trace_kprobe_create(int argc, const char *argv[])
> > -- 
> > 2.34.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

