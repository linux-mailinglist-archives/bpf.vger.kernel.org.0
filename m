Return-Path: <bpf+bounces-7363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 927D5776232
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF86281C7A
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE2819BB1;
	Wed,  9 Aug 2023 14:16:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B5612D
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 14:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982C1C433C9;
	Wed,  9 Aug 2023 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691590572;
	bh=1SsVUXtWZgOegRFQu/GbBOH3DZTNW23JsvaY2VEYgBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U1CjP3mWibzJWHlC+0WnkiYzptEzDbUEGoUKGfIq13sTvP5wK9jycbLETah8A4uHz
	 iTlb/R0Qtz6uGeKJE3Au1LooZ601DpkjB+604scSfx55ovfJRN5gd43KUzLXG/WnLk
	 ABdowwihO3Dh788RrYv5zy7hEb0U8ET8wH64r8ZYq0RleqaQEopIAxOn+F+swadv4S
	 8BbhiYTOTnHQGDY18ffsYNZaIWrBXUlpNkzXbVYsa1ngNVVwY6fq5JgkQWK0Ex8iHZ
	 UVQyWpG55QO1akmjijvJDSzzRZ8bzMzlNK0Ntp6hZNmi90F74cChRsgswa2CANnr42
	 hWYULQmdXtlFQ==
Date: Wed, 9 Aug 2023 23:16:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Florent Revest <revest@chromium.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v2 2/6] tracing: Expose ftrace_regs regardless of
 CONFIG_FUNCTION_TRACER
Message-Id: <20230809231607.0c5c75e7c3b69fcc96d82cb4@kernel.org>
In-Reply-To: <CABRcYmJpA7tWk7pNxMy-44aoT9fFByQY3kGiEfKDbOe9WPkmNg@mail.gmail.com>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
	<169139092722.324433.16681957760325391475.stgit@devnote2>
	<CABRcYmJpA7tWk7pNxMy-44aoT9fFByQY3kGiEfKDbOe9WPkmNg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 9 Aug 2023 12:29:13 +0200
Florent Revest <revest@chromium.org> wrote:

> On Mon, Aug 7, 2023 at 8:48 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index ce156c7704ee..3fb94a1a2461 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -112,11 +112,11 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
> >  }
> >  #endif
> >
> > -#ifdef CONFIG_FUNCTION_TRACER
> > -
> > -extern int ftrace_enabled;
> > -
> > -#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> > +/*
> > + * If the architecture doesn't support FTRACE_WITH_ARGS or disable function
> 
> nit: disables*

Thanks!

> 
> > + * tracer, define the default(pt_regs compatible) ftrace_regs.
> > + */
> > +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || !defined(CONFIG_FUNCTION_TRACER)
> 
> I wonder if we should make things simpler with:
> 
> #if defined(HAVE_PT_REGS_COMPAT_FTRACE_REGS) || !defined(CONFIG_FUNCTION_TRACER)
> 
> And remove the ftrace_regs definitions that are copy-pastes of this
> block in arch specific headers. Then we can enforce in a single point
> that HAVE_PT_REGS_COMPAT_FTRACE_REGS holds.

Here, the "HAVE_PT_REGS_COMPAT_FTRACE_REGS" does not mean that the
ftrace_regs is completely compatible with pt_regs, but on the memory
it wraps struct pt_regs (thus we can just cast the type).

- CONFIG_DYNAMIC_FTRACE_WITH_REGS
  ftrace_regs is completely compatible with pt_regs

- CONFIG_DYNAMIC_FTRACE_WITH_ARGS
  |   ftrace_regs may not compatible with pt_regs
  |
  +- CONFIG_HAVE_PT_REGS_COMPAT_FTRACE_REGS
     but on memory image, ftrace_regs includes pt_regs.

Thank you,

> 
> Maybe that's a question for Steven ?


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

