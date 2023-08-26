Return-Path: <bpf+bounces-8728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B86789332
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 03:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D641C2108E
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 01:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB4439F;
	Sat, 26 Aug 2023 01:56:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FFE37F
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 01:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1948DC433C7;
	Sat, 26 Aug 2023 01:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693014998;
	bh=FDJQm0lEdxEl7GHr2MhuQeH1Rf/Kq/tHYutQ/As814g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qJKH/+bb1cN1LVpaPkqhHoGrR34vdEwRAri3DueB33zVXRJuzpa6W7gl8lWrZhh96
	 ltiJN25RxWL5e9zwbDCq7Zxzncc2gQ6v134QVWdPaK+iqzTbDzUypKpLbVmPBzDknR
	 Cv1kLCH8dAuMorCBVhYIzt+y27+kpQvdv7ExZDyWWKthn7fyxt+ClLISUUB1ksuPKg
	 wMH3EU/0K5LSoDD8bwehTvcsz3NvwO8ptZdWqihR2NYgq2KWzjXwUO6KOyJw16vQUp
	 oinvSY9AYjnKGini5yUIX/+7yeRzJoU+YcOQYdZx9dhBGHRupP4GbR1IzeREqnJS8W
	 FjRwJfL495pMQ==
Date: Sat, 26 Aug 2023 10:56:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 5/9] ftrace: Add ftrace_partial_regs() for converting
 ftrace_regs to pt_regs
Message-Id: <20230826105632.e3eb35fc69a65ebaf11c7741@kernel.org>
In-Reply-To: <CAEf4Bzb9CBnQp1_bEW-DOhw9rpDj6jt79DMmsKL2L4a_4ts9gQ@mail.gmail.com>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
	<169280378611.282662.4078983611827223131.stgit@devnote2>
	<CAEf4Bzb9CBnQp1_bEW-DOhw9rpDj6jt79DMmsKL2L4a_4ts9gQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 25 Aug 2023 14:49:48 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, Aug 23, 2023 at 8:16 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
> > If the architecture defines its own ftrace_regs, this copies partial
> > registers to pt_regs and returns it. If not, ftrace_regs is the same as
> > pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Florent Revest <revest@chromium.org>
> > ---
> >  Changes in v3:
> >   - Fix to use pt_regs::regs instead of x.
> >   - Return ftrace_regs::regs forcibly if HAVE_PT_REGS_COMPAT_FTRACE_REGS=y.
> >   - Fix typo.
> >   - Fix to copy correct registers to the pt_regs on arm64.
> >  Changes in v4:
> >   - Change the patch order in the series so that fprobe event can use this.
> > ---
> >  arch/arm64/include/asm/ftrace.h |   11 +++++++++++
> >  include/linux/ftrace.h          |   17 +++++++++++++++++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index ab158196480c..5ad24f315d52 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -137,6 +137,17 @@ ftrace_override_function_with_return(struct ftrace_regs *fregs)
> >         fregs->pc = fregs->lr;
> >  }
> >
> > +static __always_inline struct pt_regs *
> > +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> > +{
> > +       memcpy(regs->regs, fregs->regs, sizeof(u64) * 9);
> > +       regs->sp = fregs->sp;
> > +       regs->pc = fregs->pc;
> > +       regs->regs[29] = fregs->fp;
> > +       regs->regs[30] = fregs->lr;
> 
> I see that orig_x0 from pt_regs is used on arm64 to get syscall's
> first parameter. And it seems like this ftrace_regs to pt_regs
> conversion doesn't touch orig_x0 at all. Is it maintained/preserved
> somewhere else, or will we lose the ability to get the first syscall's
> argument?

Thanks for checking it!

Does BPF uses kprobe probe to trace syscalls? Since we have raw_syscall
trace events, no need to use kprobe to do that. (and I don't recommend to
use kprobe to do such fixed event)

> 
> Looking at libbpf's bpf_tracing.h, other than orig_x0, I think all the
> other registers are still preserved, so this seems to be the only
> potential problem.

Great!

Thank you,

> 
> 
> > +       return regs;
> > +}
> > +
> >  int ftrace_regs_query_register_offset(const char *name);
> >
> >  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index c0a42d0860b8..a6ed2aa71efc 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -165,6 +165,23 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
> >         return arch_ftrace_get_regs(fregs);
> >  }
> >
> > +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
> > +       defined(CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST)
> > +
> > +static __always_inline struct pt_regs *
> > +ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
> > +{
> > +       /*
> > +        * If CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST=y, ftrace_regs memory
> > +        * layout is the same as pt_regs. So always returns that address.
> > +        * Since arch_ftrace_get_regs() will check some members and may return
> > +        * NULL, we can not use it.
> > +        */
> > +       return &fregs->regs;
> > +}
> > +
> > +#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
> > +
> >  /*
> >   * When true, the ftrace_regs_{get,set}_*() functions may be used on fregs.
> >   * Note: this can be true even when ftrace_get_regs() cannot provide a pt_regs.
> >
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

