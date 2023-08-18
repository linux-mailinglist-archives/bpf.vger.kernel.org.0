Return-Path: <bpf+bounces-8062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7642F780ACD
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 13:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E5328237A
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 11:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2C0182B3;
	Fri, 18 Aug 2023 11:11:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4CCA52
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 11:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D1FC433C7;
	Fri, 18 Aug 2023 11:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692357083;
	bh=3tFPg4VK+0BFiXk7MjOrkHGiHQEiG891l3KvS3yLs6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jTVkWXw7GU9TkKcCcyS/kkGyrXvXbPyehvK6A+5RDwMUAH6IhMYqVMxUeZMYG7TaJ
	 6+QCZpq6M0SXqRQpr76RTuKeErFTbvyKgXKv4ErIYRQIMEmFdFeItI8fk9H/fMYa8Q
	 gyRcpSof2hOkliW4sRneQEXGTi4JjDLeznvD8iUiKqC1vROsEiL4y9GbNeAutBA8ux
	 ciTdiI/D7mVU8EAYhY3bLtoGuktpG7nJKtIeguZIhHesC+5TzIj3jG97zsyqI2A9wN
	 ylcynKOjQBnUOYXyyRwTun1nba/k6ECb4xM3jTNUK6o7Kb+csI0PLn3TpPsPsOZf9j
	 nBz1wXXDx5rJg==
Date: Fri, 18 Aug 2023 20:11:15 +0900
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
Subject: Re: [PATCH v3 5/8] tracing/fprobe: Enable fprobe events with
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Message-Id: <20230818201115.8d191a891174b9657be2ff36@kernel.org>
In-Reply-To: <CABRcYm+ayJwS+YMaKBF9pdnHYcJvioOoOrXHWOeRAg1hPacYiA@mail.gmail.com>
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
	<169181865486.505132.6447946094827872988.stgit@devnote2>
	<CABRcYm+ayJwS+YMaKBF9pdnHYcJvioOoOrXHWOeRAg1hPacYiA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 17 Aug 2023 10:57:50 +0200
Florent Revest <revest@chromium.org> wrote:

> On Sat, Aug 12, 2023 at 7:37 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index d56304276318..6fb4ecf8767d 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -679,7 +679,6 @@ config FPROBE_EVENTS
> >         select TRACING
> >         select PROBE_EVENTS
> >         select DYNAMIC_EVENTS
> > -       depends on DYNAMIC_FTRACE_WITH_REGS
> 
> I believe that, in practice, fprobe events still rely on WITH_REGS:
> 
> > diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> > index f440c97e050f..94c01dc061ec 100644
> > --- a/kernel/trace/trace_fprobe.c
> > +++ b/kernel/trace/trace_fprobe.c
> > @@ -327,14 +328,15 @@ static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
> >         struct pt_regs *regs = ftrace_get_regs(fregs);
> 
> Because here you require the entry handler needs ftrace_regs that are
> full pt_regs.

Ah, that is for perf events. Yes, that is the problematic point.
Since perf's interfaces are depending on the pt_regs (especially stacktrace)
I can not remove this part. This is the next issue to be solved.
Maybe we can use partial pt_regs for stack tracing, so we can swap the order
of the patches to introduce ftrace_partial_regs() before this and use it for
perf event.

> 
> >         int ret = 0;
> >
> > +       if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
> > +               fentry_trace_func(tf, entry_ip, fregs);
> > +
> > +#ifdef CONFIG_PERF_EVENTS
> >         if (!regs)
> >                 return 0;
> >
> > -       if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
> > -               fentry_trace_func(tf, entry_ip, regs);
> > -#ifdef CONFIG_PERF_EVENTS
> >         if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
> > -               ret = fentry_perf_func(tf, entry_ip, regs);
> > +               ret = fentry_perf_func(tf, entry_ip, fregs, regs);
> >  #endif
> >         return ret;
> >  }
> > @@ -347,14 +349,15 @@ static void fexit_dispatcher(struct fprobe *fp, unsigned long entry_ip,
> >         struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
> >         struct pt_regs *regs = ftrace_get_regs(fregs);
> 
> And same here with the return handler
> 
> I think fprobe events would need the same sort of refactoring as
> kprobe_multi bpf: using ftrace_partial_regs so they work on build
> !WITH_REGS.

Actually, kprobe_multi is using fprobe directly, so this is not related
to bpf part.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

