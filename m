Return-Path: <bpf+bounces-28103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F04E8B5C10
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 16:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F16F1F227E4
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 14:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F0D811F2;
	Mon, 29 Apr 2024 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knUO9XcY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79014745C5;
	Mon, 29 Apr 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402641; cv=none; b=OtFiXc9MHab4IdbSfSwcrMeM12cIGv7EX6ixjfFo+KDpukTYuLsoQTEp3zRVW+R+ta92K4IgzuJida9IV5PrpszcHfTUluXrEBLaOW2Uw31onJRN85KPX29k0/EKl8AkTU5rZXI1Fk+qaeIrqF5gyTNfjsSv0ClP6Zrdi0pRhlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402641; c=relaxed/simple;
	bh=hWivQfQuF0fT04SNK+ienLT/ACa8KyiRA5sWZVweDL0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=toco0n/mVdCQ8J7dD6upI4zaY1sMHhf5yDD8uezJ4oiHDCnMzsGUQkjNp8YHnThexxiQnud9uMJG1wwqRrLUdEAZ9aSlAdvKHyedmuxPY3S398UVtw1MdmzCFBkT50LcYyXN/8PYVAZWPRqGxVh63ObAO/r7hS2lIRszjlbNtFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knUO9XcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D58C113CD;
	Mon, 29 Apr 2024 14:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714402641;
	bh=hWivQfQuF0fT04SNK+ienLT/ACa8KyiRA5sWZVweDL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=knUO9XcY4eGnQctWABveJeL0qRZmdybzZ834JWlQaEIXJ+2ElpTriIqFU9x5Y8R+d
	 30zsFdVFpC4mqRED4c3tkyQISWeOWgX42OSKkPZGlHoDtu82gNa8SxpmuG7hjYxC6t
	 Cz/k3L5UAFdloPiRpd1r+EoaRLG8emYBjiS012e5+6L2M0ud1O4cy7IdpOP5a8e924
	 10PdGhurGmH83ffIg5bJjYJUK3cgGllmHWeAQ6447ejo+RSme6Zfmi+fIwME8ulx1W
	 OkcHGTFolS8rdOrRkHO5Gam0a+nganFmdEwPoJ8QML7UH5TzD5kte9J1B3l6oCBeTd
	 54Sz03oE8dqoQ==
Date: Mon, 29 Apr 2024 23:57:14 +0900
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
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v9 29/36] bpf: Enable kprobe_multi feature if
 CONFIG_FPROBE is enabled
Message-Id: <20240429235714.54135bc2d6dfcf4d0e338c46@kernel.org>
In-Reply-To: <CAEf4BzZ2cZ-jJDj3Qdc4T_9FmCK21Ae-mr-d2RJRMtdUK8HOjQ@mail.gmail.com>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
	<171318568081.254850.16193015880509111721.stgit@devnote2>
	<CAEf4BzZ2cZ-jJDj3Qdc4T_9FmCK21Ae-mr-d2RJRMtdUK8HOjQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 25 Apr 2024 13:09:32 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Mon, Apr 15, 2024 at 6:22 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Enable kprobe_multi feature if CONFIG_FPROBE is enabled. The pt_regs is
> > converted from ftrace_regs by ftrace_partial_regs(), thus some registers
> > may always returns 0. But it should be enough for function entry (access
> > arguments) and exit (access return value).
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Florent Revest <revest@chromium.org>
> > ---
> >  Changes from previous series: NOTHING, Update against the new series.
> > ---
> >  kernel/trace/bpf_trace.c |   22 +++++++++-------------
> >  1 file changed, 9 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index e51a6ef87167..57b1174030c9 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2577,7 +2577,7 @@ static int __init bpf_event_init(void)
> >  fs_initcall(bpf_event_init);
> >  #endif /* CONFIG_MODULES */
> >
> > -#if defined(CONFIG_FPROBE) && defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
> > +#ifdef CONFIG_FPROBE
> >  struct bpf_kprobe_multi_link {
> >         struct bpf_link link;
> >         struct fprobe fp;
> > @@ -2600,6 +2600,8 @@ struct user_syms {
> >         char *buf;
> >  };
> >
> > +static DEFINE_PER_CPU(struct pt_regs, bpf_kprobe_multi_pt_regs);
> 
> this is a waste if CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST=y, right?
> Can we guard it?

Good catch! Yes, we can guard it.

> 
> 
> > +
> >  static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32 cnt)
> >  {
> >         unsigned long __user usymbol;
> > @@ -2792,13 +2794,14 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
> >
> >  static int
> >  kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> > -                          unsigned long entry_ip, struct pt_regs *regs)
> > +                          unsigned long entry_ip, struct ftrace_regs *fregs)
> >  {
> >         struct bpf_kprobe_multi_run_ctx run_ctx = {
> >                 .link = link,
> >                 .entry_ip = entry_ip,
> >         };
> >         struct bpf_run_ctx *old_run_ctx;
> > +       struct pt_regs *regs;
> >         int err;
> >
> >         if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> > @@ -2809,6 +2812,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> >
> >         migrate_disable();
> >         rcu_read_lock();
> > +       regs = ftrace_partial_regs(fregs, this_cpu_ptr(&bpf_kprobe_multi_pt_regs));
> 
> and then pass NULL if defined(CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST)?

Indeed.

Thank you!

> 
> 
> >         old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> >         err = bpf_prog_run(link->link.prog, regs);
> >         bpf_reset_run_ctx(old_run_ctx);
> > @@ -2826,13 +2830,9 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
> >                           void *data)
> >  {
> >         struct bpf_kprobe_multi_link *link;
> > -       struct pt_regs *regs = ftrace_get_regs(fregs);
> > -
> > -       if (!regs)
> > -               return 0;
> >
> >         link = container_of(fp, struct bpf_kprobe_multi_link, fp);
> > -       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> > +       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs);
> >         return 0;
> >  }
> >
> > @@ -2842,13 +2842,9 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
> >                                void *data)
> >  {
> >         struct bpf_kprobe_multi_link *link;
> > -       struct pt_regs *regs = ftrace_get_regs(fregs);
> > -
> > -       if (!regs)
> > -               return;
> >
> >         link = container_of(fp, struct bpf_kprobe_multi_link, fp);
> > -       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> > +       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs);
> >  }
> >
> >  static int symbols_cmp_r(const void *a, const void *b, const void *priv)
> > @@ -3107,7 +3103,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >         kvfree(cookies);
> >         return err;
> >  }
> > -#else /* !CONFIG_FPROBE || !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> > +#else /* !CONFIG_FPROBE */
> >  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> >  {
> >         return -EOPNOTSUPP;
> >
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

