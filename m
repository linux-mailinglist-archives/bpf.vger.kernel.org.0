Return-Path: <bpf+bounces-72113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8325C06D19
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 16:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA4F135C82A
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8321C302CA7;
	Fri, 24 Oct 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ByMETuEG"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A2225408;
	Fri, 24 Oct 2025 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317867; cv=none; b=TyIiJjiK66BsXLq5QGv9UhVYasfCmpHMt0n/5Vvd6oAy9xJnL6Qd2R03sjpFB3yFSpl/1x+N4EzI/d/xICEVmoEZ8lJLu4YlvTu2HKwi3Kl9FCCHfEO2PMSTf7f9vHFL16Kk4qPMJuyJaJimdXfdo/LWYJw0rK+2SyRLqfwnSIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317867; c=relaxed/simple;
	bh=QK4aJY680teuriwhvqbFspVk1f2xb4cOjlSTu90g2pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iF8pTfWzJRVSj81ltG4E59aLZpdkUK1VY+jdEFX2SHcWAuoQ0EEMTMp048rfwo3nayTxx0gUhJJ5I3jiyhrH4wyaYjBiFATi6Pbmu51eCgyAXEziHdTjJfYUtA43evV1uUlH1Z4II2spJ3Lims9YfzUop6smERRtmnvpyvikI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ByMETuEG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vKzRyAd2hVMEX1Z1e4JcQVmSosinPTt2Ja01j5OaQV0=; b=ByMETuEGAD/X2jrSfUJdhpqL5M
	dUafxU4fmvuj0dRQwNYAzXmp60ySg9UPNVRaF0JIZPw1K5YiqhVISJzFS3BjU9EVeQUC0zKxdFMNt
	4Odjqc5VRospfv4tJOgf+UNYXtrjKyqCVFwZNxLtDt3zDQyOTtsXT3e3D2cv8hRGtNspV6WAjMaW+
	u7/5jzz8Aq/k1Wg+gmB3mQjwhvkGf5lBus5ADOlla7zRIkju81dvGj1YhwoEDQVApx6HfFgPfr9Vs
	j0DqgQexgTdqeo02DUIQcMCDBGSpOf9RMDTc+Bx4b/hAHlJK1ZEsdwasJnzuvdtNHWnbkWNmWJCeo
	vuLN2A6A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCIMs-00000002LAc-0spl;
	Fri, 24 Oct 2025 14:02:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9BD423003C4; Fri, 24 Oct 2025 16:57:35 +0200 (CEST)
Date: Fri, 24 Oct 2025 16:57:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v16 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20251024145735.GO4068168@noisy.programming.kicks-ass.net>
References: <20251007214008.080852573@kernel.org>
 <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
 <20251024092926.GI4068168@noisy.programming.kicks-ass.net>
 <20251024104119.GJ4068168@noisy.programming.kicks-ass.net>
 <a59509f0-5888-4663-9e82-98e27fc3e813@linux.ibm.com>
 <20251024140815.GE3245006@noisy.programming.kicks-ass.net>
 <20251024145156.GM4068168@noisy.programming.kicks-ass.net>
 <20251024145401.GN4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024145401.GN4068168@noisy.programming.kicks-ass.net>

On Fri, Oct 24, 2025 at 04:54:02PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 24, 2025 at 04:51:56PM +0200, Peter Zijlstra wrote:
> 
> > --- a/arch/x86/include/asm/unwind_user.h
> > +++ b/arch/x86/include/asm/unwind_user.h
> > @@ -3,6 +3,7 @@
> >  #define _ASM_X86_UNWIND_USER_H
> >  
> >  #include <asm/ptrace.h>
> > +#include <asm/uprobes.h>
> >  
> >  #define ARCH_INIT_USER_FP_FRAME(ws)			\
> >  	.cfa_off	=  2*(ws),			\
> > @@ -10,6 +11,12 @@
> >  	.fp_off		= -2*(ws),			\
> >  	.use_fp		= true,
> >  
> > +#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
> > +	.cfa_off	=  1*(ws),			\
> > +	.ra_off		= -1*(ws),			\
> > +	.fp_off		= 0,				\
> > +	.use_fp		= false,
> > +
> >  static inline int unwind_user_word_size(struct pt_regs *regs)
> >  {
> >  	/* We can't unwind VM86 stacks */
> > @@ -22,4 +29,9 @@ static inline int unwind_user_word_size(
> >  	return sizeof(long);
> >  }
> >  
> > +static inline bool unwind_user_at_function_start(struct pt_regs *regs)
> > +{
> > +	return is_uprobe_at_func_entry(regs);
> > +}
> > +
> >  #endif /* _ASM_X86_UNWIND_USER_H */
> 
> > --- a/include/linux/unwind_user_types.h
> > +++ b/include/linux/unwind_user_types.h
> > @@ -39,6 +39,7 @@ struct unwind_user_state {
> >  	unsigned int				ws;
> >  	enum unwind_user_type			current_type;
> >  	unsigned int				available_types;
> > +	bool					topmost;
> >  	bool					done;
> >  };
> >  
> > --- a/kernel/unwind/user.c
> > +++ b/kernel/unwind/user.c
> 
> >  
> > +static int unwind_user_next_fp(struct unwind_user_state *state)
> > +{
> > +	struct pt_regs *regs = task_pt_regs(current);
> > +
> > +	const struct unwind_user_frame fp_frame = {
> > +		ARCH_INIT_USER_FP_FRAME(state->ws)
> > +	};
> > +	const struct unwind_user_frame fp_entry_frame = {
> > +		ARCH_INIT_USER_FP_ENTRY_FRAME(state->ws)
> > +	};
> > +
> > +	if (state->topmost && unwind_user_at_function_start(regs))
> > +		return unwind_user_next_common(state, &fp_entry_frame);
> > +
> > +	return unwind_user_next_common(state, &fp_frame);
> > +}
> > +
> >  static int unwind_user_next(struct unwind_user_state *state)
> >  {
> >  	unsigned long iter_mask = state->available_types;
> > @@ -118,6 +134,7 @@ static int unwind_user_start(struct unwi
> >  		state->done = true;
> >  		return -EINVAL;
> >  	}
> > +	state->topmost = true;
> >  
> >  	return 0;
> >  }
> 
> And right before sending this; I realized we could do the
> unwind_user_at_function_start() in unwind_user_start() and set something
> like state->entry = true instead of topmost.
> 
> That saves having to do task_pt_regs() in unwind_user_next_fp().
> 
> Does that make sense?

Urgh, that makes us call that weird hack for sframe too, which isn't
needed. Oh well, ignore this.

