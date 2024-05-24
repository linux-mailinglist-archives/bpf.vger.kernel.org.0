Return-Path: <bpf+bounces-30451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DDB8CDF35
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 03:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 484D7B227F9
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 01:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF18FD29B;
	Fri, 24 May 2024 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovhcodTh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5BE2C9A;
	Fri, 24 May 2024 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716514682; cv=none; b=OekxhGZDPUmFXdXbUtAeUd0X/CtpMm9c4td0tOCrJ75TFnTTaL7NHUrvxjsADYkJ7rPbUMQucvHNeYJQ5hZRB7JSJl2GhOwkfT7RNjYhI2JQvxlKebNyj+yVE2qNSoKzFKpwsPav4h2bBaaxVRguJC5ZtGgZu5zmk76CYX+F19Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716514682; c=relaxed/simple;
	bh=ERTEB/rrvFFUiItZl/zrUe64/CzxlWTyD7+e4trZpKE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l923e2EHy1TmxlMCi6X7C2ighEVrH1DmPz/8ea9h5A2cB+g354pUfInb4u9morjHL8mvqDglmG1VPkebW4e3b67ifBFEtS0NIIb7N/MIAEToC4wEAY2uKHx/hBdsMglSInPyrjXZHe581OEUGUAnnghw8MIIvvuLe05Pvqlw350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovhcodTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15B4C2BD10;
	Fri, 24 May 2024 01:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716514681;
	bh=ERTEB/rrvFFUiItZl/zrUe64/CzxlWTyD7+e4trZpKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ovhcodThVewrSpfrV9VkdW+LIyXHL6Q2eJf56rE0PCaSpfF+0XoQSs5O1nZ7xs4eP
	 0UDDForbp8uQDuC7Udc/xKn4Goz7aNHoIH/GxGejJCAxNh8oedzYzCWk8WB+YKwfdy
	 xF3am6hLfYVXJr848LTH1gAKQYWPxL560khUp9DOlCR89KpMkkfgUltCXQTVD04jnF
	 1pXmZFYS8LdGVydogbh36SAEGHMr9zkh1OC7Zp0gLWoZdSiKxNppit/jowiMNJWq4d
	 3fruZG/0dGtxEf0GQ9KSWS7Rd7ygs0Qi9F8apaZvyqtgP4tYQs2Aei1MsvmrizZSrB
	 dVI3rh21vfsxw==
Date: Fri, 24 May 2024 10:37:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v10 03/36] x86: tracing: Add ftrace_regs definition in
 the header
Message-Id: <20240524103754.1df43a670eeb15bca9df48c7@kernel.org>
In-Reply-To: <20240523191459.3858aecf@gandalf.local.home>
References: <171509088006.162236.7227326999861366050.stgit@devnote2>
	<171509091569.162236.17928081833857878443.stgit@devnote2>
	<20240523191459.3858aecf@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 19:14:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  7 May 2024 23:08:35 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add ftrace_regs definition for x86_64 in the ftrace header to
> > clarify what register will be accessible from ftrace_regs.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v3:
> >   - Add rip to be saved.
> >  Changes in v2:
> >   - Newly added.
> > ---
> >  arch/x86/include/asm/ftrace.h |    6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> > index cf88cc8cc74d..c88bf47f46da 100644
> > --- a/arch/x86/include/asm/ftrace.h
> > +++ b/arch/x86/include/asm/ftrace.h
> > @@ -36,6 +36,12 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
> >  
> >  #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >  struct ftrace_regs {
> > +	/*
> > +	 * On the x86_64, the ftrace_regs saves;
> > +	 * rax, rcx, rdx, rdi, rsi, r8, r9, rbp, rip and rsp.
> > +	 * Also orig_ax is used for passing direct trampoline address.
> > +	 * x86_32 doesn't support ftrace_regs.
> 
> Should add a comment that if fregs->regs.cs is set, then all of the pt_regs
> is valid.

But what about rbx and r1*? Only regs->cs should be care for pt_regs?
Or, did you mean "the ftrace_regs is valid"?

> And x86_32 does support ftrace_regs, it just doesn't support
> having a subset of it.

Oh, thanks. I'll update the comment about x86_32.

Thank you,

> 
> -- Steve
> 
> 
> > +	 */
> >  	struct pt_regs		regs;
> >  };
> >  
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

