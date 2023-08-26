Return-Path: <bpf+bounces-8746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A6A7896A6
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 14:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEEF1C20EFA
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535AED53C;
	Sat, 26 Aug 2023 12:21:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D9AC2F7
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 12:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89D2C433C8;
	Sat, 26 Aug 2023 12:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693052461;
	bh=7EXJ1LENbcLPurI5Z9dQe+9Ef/4yp4DqUevs1jxxCUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QXrZon6mgILY3byNR5FdVO14AfRXgGliokWBj7UEH8qMyJK/L4H/fLd/0PGSstUtk
	 8AzAaWTrePhSf5jH8OmNMttFBD2vmnuAvdmelceQiZAlcrA6MORPqeCiEkB4aDK9jM
	 iSbZj8kB3KW23QR5XfS2zkchwmSvq60aY0LHMDqO6Gr931s/+D07jbYobJfPiLEXuM
	 oawV7+GlZWxvnoR6pNFUzLleWtQ/EngVNDVbY+FinkTuR120DUMCpIp3J0FUFlwXOt
	 l0/DRPNc2Nxmgg2ItwrXI1m6FR1TdOhWUaPmY3tTicHR9x6hKvylQeAyJjCPIUqlyr
	 Cx9r6xEKuuNPQ==
Date: Sat, 26 Aug 2023 12:38:38 +0900
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
 Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 6/9] tracing/fprobe: Enable fprobe events with
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Message-Id: <20230826123838.610b3fe09b9fa1aab75f158d@kernel.org>
In-Reply-To: <CABRcYmLcTBey7QY9Ln3aVvJPV7weeTR0FA6DOU3_QObuAM8_Zg@mail.gmail.com>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
	<169280379741.282662.12221517584561036597.stgit@devnote2>
	<CABRcYmLcTBey7QY9Ln3aVvJPV7weeTR0FA6DOU3_QObuAM8_Zg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

(Cc: Peter)

On Fri, 25 Aug 2023 18:12:07 +0200
Florent Revest <revest@chromium.org> wrote:

> On Wed, Aug 23, 2023 at 5:16 PM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> > index c60d0d9f1a95..90ad28260a9f 100644
> > --- a/kernel/trace/trace_fprobe.c
> > +++ b/kernel/trace/trace_fprobe.c
> > +#else /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
> > +
> > +/* Since fprobe handlers can be nested, pt_regs buffer need to be a stack */
> > +#define PERF_FPROBE_REGS_MAX   4
> > +
> > +struct pt_regs_stack {
> > +       struct pt_regs regs[PERF_FPROBE_REGS_MAX];
> > +       int idx;
> > +};
> > +
> > +static DEFINE_PER_CPU(struct pt_regs_stack, perf_fprobe_regs);
> > +
> > +static __always_inline
> > +struct pt_regs *perf_fprobe_partial_regs(struct ftrace_regs *fregs)
> > +{
> > +       struct pt_regs_stack *stack = this_cpu_ptr(&perf_fprobe_regs);
> > +       struct pt_regs *regs;
> > +
> > +       if (stack->idx < PERF_FPROBE_REGS_MAX) {
> > +               regs = stack->regs[stack->idx++];
> 
> This is missing an &:
> regs = &stack->regs[stack->idx++];

Oops, good point. I'm curious it didin't cause compile error...
(I thought I built it on arm64)

> 
> > +               return ftrace_partial_regs(fregs, regs);
> 
> I think this is incorrect on arm64 and will likely cause very subtle
> failure modes down the line on other architectures too. The problem on
> arm64 is that Perf calls "user_mode(regs)" somewhere down the line,
> that macro tries to read the "pstate" register, which is not populated
> in ftrace_regs, so it's not copied into a "partial" pt_regs either and
> Perf can take wrong decisions based on that.

I think we can assure the ftrace_regs is always !user_mode() so in that case
ftrace_partial_regs() should fill the 'pstate' register as kernel mode.

> 
> I already mentioned this problem in the past:
> - in the third answer block of:
> https://lore.kernel.org/all/CABRcYmJjtVq-330ktqTAUiNO1=yG_aHd0xz=c550O5C7QP++UA@mail.gmail.com/
> - in the fourth answer block of:
> https://lore.kernel.org/all/CABRcYm+esb8J2O1v6=C+h+HSa5NxraPUgo63w7-iZj0CXbpusg@mail.gmail.com/
> 

Oops, sorry I missed that. And I basically agreed that we need a special
care for perf. Let me reply it.

> It is quite possible that other architectures at some point introduce
> a light ftrace "args" trampoline that misses one of the registers
> expected by Perf because they don't realize that this trampoline calls
> fprobe which calls Perf which has specific registers expectations.

Agreed.

> 
> We got the green light from Alexei to use ftrace_partial_regs for "BPF
> mutli_kprobe" because these BPF programs can gracefully deal with
> sparse pt_regs but I think a similar conversation needs to happen with
> the Perf folks.

Indeed. Who is the best person to involve, Peterz? (but I think
we need arm64 PMU part maintainer to talk)

> 
> ----
> 
> On a side-note, a subtle difference between ftrace_partial_regs with
> and without HAVE_PT_REGS_TO_FTRACE_REGS_CAST is that one does a copy
> and the other does not. If a subsystem receives a partial regs under
> HAVE_PT_REGS_TO_FTRACE_REGS_CAST, it can modify register fields and
> the modified values will be restored by the ftrace trampoline. Without
> HAVE_PT_REGS_TO_FTRACE_REGS_CAST, only the copy will be modified and
> ftrace won't restore them. I think the least we can do is to document
> thoroughly the guarantees of the ftrace_partial_regs API: users
> shouldn't rely on modifying the resulting regs because depending on
> the architecture this could do different things. People shouldn't rely
> on any register that isn't covered by one of the ftrace_regs_get_*
> helpers because it can be unpopulated on some architectures. I believe
> this is the case for BPF multi_kprobe but not for Perf.

I agree with the documentation requirement, but since the fprobe official
interface becomes ftrace_regs, user naturally expects it is not pt_regs.
The problem is that the perf's case. Since the perf is natively only
support pt_regs (and there is no reason to support ftrace_regs, yes).
Hmm, I will recheck how the perf events on trace-event is implementd.

Thank you,

> 
> > +       }
> > +       return NULL;
> > +}
> > +
> > +static __always_inline void perf_fprobe_return_regs(struct pt_regs *regs)
> > +{
> > +       struct pt_regs_stack *stack = this_cpu_ptr(&perf_fprobe_regs);
> > +
> > +       if (WARN_ON_ONCE(regs != stack->regs[stack->idx]))
> 
> This is missing an & too:
> if (WARN_ON_ONCE(regs != &stack->regs[stack->idx]))
> 
> 
> 
> 
> > +               return;
> > +
> > +       --stack->idx;
> > +}
> > +
> > +#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

