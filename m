Return-Path: <bpf+bounces-14290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E5C7E2258
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 13:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFF11C20B63
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 12:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D218B1EB5B;
	Mon,  6 Nov 2023 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="myycUMlv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B341A278;
	Mon,  6 Nov 2023 12:53:04 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C3CBD;
	Mon,  6 Nov 2023 04:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d7JIE/1D3Ga6c+JTVVNZxpCgazNnMt6mFtB/dDS9GUM=; b=myycUMlvg6YWS07kbUyVxY8NEg
	i6GijSiiQz1Q5ipUKSaw6uxW520hXeuSRQZdQRO9EPC0b5+SCC0AEyRVI6kKQvSy+f+ISJ9ZKpm72
	NeOTPm+A4VGovEsIZktwGet2L4ZyZ9Lkcf7k4oT2a07cWH6bUKILpi3GLREmlDa3bnfqzotYv0nOD
	wW4ovbA9V6lJKrhHkCOthsv4dE0JKe0tXq0FXGgtDj1wa1MMXF9aTEe5CbOt7OUG+TbG0hW//MqBV
	1euoqAqA2LhsyycPvIjcakbEGzyQhZKXMi3xmcV8TnnEN+D48GAFPkD2Vj+zaErLhPQA0KDbhOEvl
	1zRJlpbw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qzz5u-0060hL-Mm; Mon, 06 Nov 2023 12:52:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0FCF430049D; Mon,  6 Nov 2023 13:52:43 +0100 (CET)
Date: Mon, 6 Nov 2023 13:52:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 24/32] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-ID: <20231106125243.GN8262@noisy.programming.kicks-ass.net>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
 <169920068069.482486.6540417903833579700.stgit@devnote2>
 <20231105172536.GA7124@noisy.programming.kicks-ass.net>
 <20231105141130.6ef7d8bd@rorschach.local.home>
 <20231105231734.GE3818@noisy.programming.kicks-ass.net>
 <20231105183301.38be5598@rorschach.local.home>
 <20231105183409.424bc368@rorschach.local.home>
 <20231106093850.62702d5bf1779e30cdecf1eb@kernel.org>
 <20231106101932.GJ8262@noisy.programming.kicks-ass.net>
 <20231106214708.d132cfd9984beac55e4b420e@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106214708.d132cfd9984beac55e4b420e@kernel.org>

On Mon, Nov 06, 2023 at 09:47:08PM +0900, Masami Hiramatsu wrote:
> On Mon, 6 Nov 2023 11:19:32 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Nov 06, 2023 at 09:38:50AM +0900, Masami Hiramatsu wrote:
> > > On Sun, 5 Nov 2023 18:34:09 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > > On Sun, 5 Nov 2023 18:33:01 -0500
> > > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > 
> > > > > For x86_64, that would be:
> > > > > 
> > > > >   rdi, rsi, rdx, r8, r9, rsp
> > > > 
> > > > I missed rcx.
> > > 
> > > I would like to add rax to the list so that it can handle the return value too. :)
> > 
> > So something like so?
> > 
> > 
> > diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> > index 897cf02c20b1..71bfe27594a5 100644
> > --- a/arch/x86/include/asm/ftrace.h
> > +++ b/arch/x86/include/asm/ftrace.h
> > @@ -36,6 +36,10 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
> >  
> >  #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >  struct ftrace_regs {
> > +	/*
> > +	 * Partial, filled with:
> > +	 *  rax, rcx, rdx, rdi, rsi, r8, r9, rsp
> 
> Don't we need rbp too? (for frame pointer)

/me goes stare at ftrace_64.S, and yes it appears it fills out rbp too.



