Return-Path: <bpf+bounces-9302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD1B7932E6
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 02:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD651C20971
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 00:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB2A374;
	Wed,  6 Sep 2023 00:28:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506A4362
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 00:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09624C433C7;
	Wed,  6 Sep 2023 00:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693960131;
	bh=aZ3H8HxXEtYnYpl+2MkB0U0M6BrNOKKNBdJveQb22C0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZSJODVKirg4FCXqk252o/1CZ7i7f0IFDds/anCm2fMWhIAbWnJopScVB519+xey0V
	 yFqeMxgayVClMAdGcqi/I4RM9881S9O02430r8EA98ON2KzJ4cyKtMrohmo3AQv8OE
	 kTo/2gO68vga5xt88u+cxCOg7pZLMbeVpxaxU9IQEpEwbhLTKkzjg3bzr7Lxk1wic8
	 /XBq8UeIYcIh3nceupbpVBHsMnc0+8p5fGBRQAW8bnwULGx8g8AYAJEskfPC+rrTGf
	 314n7UoJvn3KlrEATWo1keIqZmx7fMiiecNsoeWrAECZ66o/KcthEmVKcvmSNLAGNY
	 QnH54swXevwLw==
Date: Wed, 6 Sep 2023 09:28:45 +0900
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
Message-Id: <20230906092845.ce5ff494d379c73cef58cb08@kernel.org>
In-Reply-To: <CAEf4BzY3dySkeAuOgnNCykZwowbw0ZB9FvM2rE1oBUd_=_U6oA@mail.gmail.com>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
	<169280378611.282662.4078983611827223131.stgit@devnote2>
	<CAEf4Bzb9CBnQp1_bEW-DOhw9rpDj6jt79DMmsKL2L4a_4ts9gQ@mail.gmail.com>
	<20230826105632.e3eb35fc69a65ebaf11c7741@kernel.org>
	<CAEf4BzY3dySkeAuOgnNCykZwowbw0ZB9FvM2rE1oBUd_=_U6oA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 5 Sep 2023 12:50:28 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Fri, Aug 25, 2023 at 6:56 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Fri, 25 Aug 2023 14:49:48 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > > On Wed, Aug 23, 2023 at 8:16 AM Masami Hiramatsu (Google)
> > > <mhiramat@kernel.org> wrote:
> > > >
> > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > >
> > > > Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
> > > > If the architecture defines its own ftrace_regs, this copies partial
> > > > registers to pt_regs and returns it. If not, ftrace_regs is the same as
> > > > pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
> > > >
> > > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > Acked-by: Florent Revest <revest@chromium.org>
> > > > ---
> > > >  Changes in v3:
> > > >   - Fix to use pt_regs::regs instead of x.
> > > >   - Return ftrace_regs::regs forcibly if HAVE_PT_REGS_COMPAT_FTRACE_REGS=y.
> > > >   - Fix typo.
> > > >   - Fix to copy correct registers to the pt_regs on arm64.
> > > >  Changes in v4:
> > > >   - Change the patch order in the series so that fprobe event can use this.
> > > > ---
> > > >  arch/arm64/include/asm/ftrace.h |   11 +++++++++++
> > > >  include/linux/ftrace.h          |   17 +++++++++++++++++
> > > >  2 files changed, 28 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > > > index ab158196480c..5ad24f315d52 100644
> > > > --- a/arch/arm64/include/asm/ftrace.h
> > > > +++ b/arch/arm64/include/asm/ftrace.h
> > > > @@ -137,6 +137,17 @@ ftrace_override_function_with_return(struct ftrace_regs *fregs)
> > > >         fregs->pc = fregs->lr;
> > > >  }
> > > >
> > > > +static __always_inline struct pt_regs *
> > > > +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> > > > +{
> > > > +       memcpy(regs->regs, fregs->regs, sizeof(u64) * 9);
> > > > +       regs->sp = fregs->sp;
> > > > +       regs->pc = fregs->pc;
> > > > +       regs->regs[29] = fregs->fp;
> > > > +       regs->regs[30] = fregs->lr;
> > >
> > > I see that orig_x0 from pt_regs is used on arm64 to get syscall's
> > > first parameter. And it seems like this ftrace_regs to pt_regs
> > > conversion doesn't touch orig_x0 at all. Is it maintained/preserved
> > > somewhere else, or will we lose the ability to get the first syscall's
> > > argument?
> >
> > Thanks for checking it!
> >
> > Does BPF uses kprobe probe to trace syscalls? Since we have raw_syscall
> > trace events, no need to use kprobe to do that. (and I don't recommend to
> > use kprobe to do such fixed event)
> 
> Yeah, lots of tools and projects actually trace syscalls with kprobes.
> I don't think there is anything we can do to quickly change that, so
> we should avoid breaking all of them.

Yes, ah, but anyway, this is the fprobe case, not kprobe. Do you use
multi_kprobes for tracing syscalls? 

Jiri, do you know when the multi-kprobe feature is used? Is that used
implicitly or explicitly?

> 
> So getting back to my original question, is it possible to preserve orig_x0?

I'm curious that the orig_x0 is stored to pt_regs of the kprobes itself
because it is not a real register. There is no way to access it. You can
use regs->x0 instead of that.

I think the orig_x0 is stored when the syscall happened because it has
another user pt_regs on the stack, right?

If so, we don't need to save orig_x0 on the pt_regs for kprobes, but user can
dig the stack to find the orig_x0. Here the arm64, syscall entry handler,

static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
                           const syscall_fn_t syscall_table[])
{
        unsigned long flags = read_thread_flags();

        regs->orig_x0 = regs->regs[0];
        regs->syscallno = scno;

(BTW, it seems syscall number is saved on regs->syscallno.)

It seems that if you probe the el0_svc_common() for tracing syscall,
all you need is tracing $arg1 == pt_regs and $arg2 == syscall number.

Thank you,

> 
> >
> > >
> > > Looking at libbpf's bpf_tracing.h, other than orig_x0, I think all the
> > > other registers are still preserved, so this seems to be the only
> > > potential problem.
> >
> > Great!
> >
> > Thank you,
> >
> > >
> > >
> > > > +       return regs;
> > > > +}
> > > > +
> > > >  int ftrace_regs_query_register_offset(const char *name);
> > > >
> > > >  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
> > > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > > index c0a42d0860b8..a6ed2aa71efc 100644
> > > > --- a/include/linux/ftrace.h
> > > > +++ b/include/linux/ftrace.h
> > > > @@ -165,6 +165,23 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
> > > >         return arch_ftrace_get_regs(fregs);
> > > >  }
> > > >
> > > > +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
> > > > +       defined(CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST)
> > > > +
> > > > +static __always_inline struct pt_regs *
> > > > +ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
> > > > +{
> > > > +       /*
> > > > +        * If CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST=y, ftrace_regs memory
> > > > +        * layout is the same as pt_regs. So always returns that address.
> > > > +        * Since arch_ftrace_get_regs() will check some members and may return
> > > > +        * NULL, we can not use it.
> > > > +        */
> > > > +       return &fregs->regs;
> > > > +}
> > > > +
> > > > +#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
> > > > +
> > > >  /*
> > > >   * When true, the ftrace_regs_{get,set}_*() functions may be used on fregs.
> > > >   * Note: this can be true even when ftrace_get_regs() cannot provide a pt_regs.
> > > >
> > > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

