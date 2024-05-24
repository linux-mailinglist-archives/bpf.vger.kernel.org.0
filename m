Return-Path: <bpf+bounces-30496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C69C8CE70A
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EADE6B21616
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD7312C47C;
	Fri, 24 May 2024 14:31:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB0F1AACC;
	Fri, 24 May 2024 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561061; cv=none; b=r2KVktV2AXWqbIUoZ/LhU7G+8oQX2hRAwIHy4c6yLs4bbOb/9P1XpaUS358rx6XS4oXnLrikArJAb+xGagw/mg75SPcHFTM6AIYOs2oEqTNBBjuhysAp6aSTzBHT7HnH/Y2nn3WSyUa7hY27vW2Lwn336TCZgyskzI2Ydf4M4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561061; c=relaxed/simple;
	bh=aOZq1tNo2kEdYYZTGQpJMZiV8l/3wuWC+gR87EmXRAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWgFwn1e0Dax7p3vwytrHcKHLk05SEP1vrxU6sUuFVHnvYp4TD6zjoxgIHsmhS9QzOSX+WOAGfvXf1qGnrzC1hYWsfi326CmA3MiZ1kEhBFarwspF6KG98c7ggXJHkSgNs8ArEMGrizsB0tOZCTfaXBb622SHJOjmr5kyYUShvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EB9C2BBFC;
	Fri, 24 May 2024 14:30:58 +0000 (UTC)
Date: Fri, 24 May 2024 10:31:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
Message-ID: <20240524103144.4cd800c0@gandalf.local.home>
In-Reply-To: <20240524103754.1df43a670eeb15bca9df48c7@kernel.org>
References: <171509088006.162236.7227326999861366050.stgit@devnote2>
	<171509091569.162236.17928081833857878443.stgit@devnote2>
	<20240523191459.3858aecf@gandalf.local.home>
	<20240524103754.1df43a670eeb15bca9df48c7@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 10:37:54 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > >  
> > >  #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> > >  struct ftrace_regs {
> > > +	/*
> > > +	 * On the x86_64, the ftrace_regs saves;
> > > +	 * rax, rcx, rdx, rdi, rsi, r8, r9, rbp, rip and rsp.
> > > +	 * Also orig_ax is used for passing direct trampoline address.
> > > +	 * x86_32 doesn't support ftrace_regs.  
> > 
> > Should add a comment that if fregs->regs.cs is set, then all of the pt_regs
> > is valid.  
> 
> But what about rbx and r1*? Only regs->cs should be care for pt_regs?
> Or, did you mean "the ftrace_regs is valid"?

Yeah, on x86_64 ftrace_regs uses regs.cs to denote if it is valid or not:

static __always_inline struct pt_regs *
arch_ftrace_get_regs(struct ftrace_regs *fregs)
{
	/* Only when FL_SAVE_REGS is set, cs will be non zero */
	if (!fregs->regs.cs)
		return NULL;
	return &fregs->regs;
}


-- Steve

