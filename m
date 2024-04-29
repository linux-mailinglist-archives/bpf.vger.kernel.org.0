Return-Path: <bpf+bounces-28102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869248B5C0B
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 16:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF89284B01
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 14:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5188980058;
	Mon, 29 Apr 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+p+QHU3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C323C745C5;
	Mon, 29 Apr 2024 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402579; cv=none; b=i93Mn8Di+UeLNAUG6dMOHvDdBA++3xsEtbJbnLRKTmrRHV+n+8JoQUlXJ3g1IJ/oCeTzW9rWopzz/WfxRdemgZAtALblBHSGgv1LSJ5hG420Xrbn2OSeNKAS9tcCCZnsrvvMdSnzcEcoPNopE/SoucYRw+HiFUHPVG83/3GNp/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402579; c=relaxed/simple;
	bh=fCYjkbds6+k3U7rGawEZ2BQELDslwiIzCq0b1cVevoY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rjsw3FRb4qzUxMt2CaG8Mwk0XWJ8kdbtT1IbZTUJyun20WVcqGe/tSrcCE3RDGPdnbgq7GcC9H6wciKTMEP8PEp39JyslsYbdViV044tkypKp4M0ALB5D4++Lvt7ohY/k2cR4L1u0991cPG49R+PcNDMPFLCnD7LFedQmqDqTqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+p+QHU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D10C113CD;
	Mon, 29 Apr 2024 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714402579;
	bh=fCYjkbds6+k3U7rGawEZ2BQELDslwiIzCq0b1cVevoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i+p+QHU3Yvn2nxaT5tP2uoTDxPHU1gIBRx2z8tmHGgbXJxhYr/uO/MFSS972M0lT+
	 7XcC1A3MuPiAt5nCWDQDSqOAJZI8X76SieMpvJZ4Oey+fNANRjJMr9QhOSRtYy7srz
	 iDQM6md2m5pNDLv1aJzmA724kLUWclE+Ih1L+lzqpgpmE/k3yDOqRP1PrOMNbNDmGf
	 ObgZi5rTDRglasez2L9rpHn2y/6XJTwsa5YCtEAiYezewA0RXCTBpkyFbw5Ra3mOq2
	 eP27rft7AYo4v1iw61sAvgex52Oe1bgORaJCRGZcyO4BdiAAkvq1cl2OYizlAMx755
	 NsAwfiuVNLXVw==
Date: Mon, 29 Apr 2024 23:56:13 +0900
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
Subject: Re: [PATCH v9 36/36] fgraph: Skip recording calltime/rettime if it
 is not nneeded
Message-Id: <20240429235613.784fa3266d15047af3e467df@kernel.org>
In-Reply-To: <CAEf4BzZz_4RGyam5GW6Do3Z-sCtk2Cj2D6rYyciYOcJihKdDww@mail.gmail.com>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
	<171318575984.254850.17464878774926779209.stgit@devnote2>
	<CAEf4BzZz_4RGyam5GW6Do3Z-sCtk2Cj2D6rYyciYOcJihKdDww@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 25 Apr 2024 13:15:08 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Mon, Apr 15, 2024 at 6:25 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Skip recording calltime and rettime if the fgraph_ops does not need it.
> > This is a kind of performance optimization for fprobe. Since the fprobe
> > user does not use these entries, recording timestamp in fgraph is just
> > a overhead (e.g. eBPF, ftrace). So introduce the skip_timestamp flag,
> > and all fgraph_ops sets this flag, skip recording calltime and rettime.
> >
> > Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v9:
> >   - Newly added.
> > ---
> >  include/linux/ftrace.h |    2 ++
> >  kernel/trace/fgraph.c  |   46 +++++++++++++++++++++++++++++++++++++++-------
> >  kernel/trace/fprobe.c  |    1 +
> >  3 files changed, 42 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index d845a80a3d56..06fc7cbef897 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -1156,6 +1156,8 @@ struct fgraph_ops {
> >         struct ftrace_ops               ops; /* for the hash lists */
> >         void                            *private;
> >         int                             idx;
> > +       /* If skip_timestamp is true, this does not record timestamps. */
> > +       bool                            skip_timestamp;
> >  };
> >
> >  void *fgraph_reserve_data(int idx, int size_bytes);
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index 7556fbbae323..a5722537bb79 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -131,6 +131,7 @@ DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
> >  int ftrace_graph_active;
> >
> >  static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
> > +static bool fgraph_skip_timestamp;
> >
> >  /* LRU index table for fgraph_array */
> >  static int fgraph_lru_table[FGRAPH_ARRAY_SIZE];
> > @@ -475,7 +476,7 @@ void ftrace_graph_stop(void)
> >  static int
> >  ftrace_push_return_trace(unsigned long ret, unsigned long func,
> >                          unsigned long frame_pointer, unsigned long *retp,
> > -                        int fgraph_idx)
> > +                        int fgraph_idx, bool skip_ts)
> >  {
> >         struct ftrace_ret_stack *ret_stack;
> >         unsigned long long calltime;
> > @@ -498,8 +499,12 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
> >         ret_stack = get_ret_stack(current, current->curr_ret_stack, &index);
> >         if (ret_stack && ret_stack->func == func &&
> >             get_fgraph_type(current, index + FGRAPH_RET_INDEX) == FGRAPH_TYPE_BITMAP &&
> > -           !is_fgraph_index_set(current, index + FGRAPH_RET_INDEX, fgraph_idx))
> > +           !is_fgraph_index_set(current, index + FGRAPH_RET_INDEX, fgraph_idx)) {
> > +               /* If previous one skips calltime, update it. */
> > +               if (!skip_ts && !ret_stack->calltime)
> > +                       ret_stack->calltime = trace_clock_local();
> >                 return index + FGRAPH_RET_INDEX;
> > +       }
> >
> >         val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_RET_INDEX;
> >
> > @@ -517,7 +522,10 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
> >                 return -EBUSY;
> >         }
> >
> > -       calltime = trace_clock_local();
> > +       if (skip_ts)
> 
> would it be ok to add likely() here to keep the least-overhead code path linear?

It's not "likely", but hmm, yes as you said. We can keep the least overhead.
OK, let me add likely. 

Thank you,

> 
> > +               calltime = 0LL;
> > +       else
> > +               calltime = trace_clock_local();
> >
> >         index = READ_ONCE(current->curr_ret_stack);
> >         ret_stack = RET_STACK(current, index);
> > @@ -601,7 +609,8 @@ int function_graph_enter_regs(unsigned long ret, unsigned long func,
> >         trace.func = func;
> >         trace.depth = ++current->curr_ret_depth;
> >
> > -       index = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
> > +       index = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0,
> > +                                        fgraph_skip_timestamp);
> >         if (index < 0)
> >                 goto out;
> >
> > @@ -654,7 +663,8 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
> >                 return -ENODEV;
> >
> >         /* Use start for the distance to ret_stack (skipping over reserve) */
> > -       index = ftrace_push_return_trace(ret, func, frame_pointer, retp, gops->idx);
> > +       index = ftrace_push_return_trace(ret, func, frame_pointer, retp, gops->idx,
> > +                                        gops->skip_timestamp);
> >         if (index < 0)
> >                 return index;
> >         type = get_fgraph_type(current, index);
> > @@ -732,6 +742,7 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
> >         *ret = ret_stack->ret;
> >         trace->func = ret_stack->func;
> >         trace->calltime = ret_stack->calltime;
> > +       trace->rettime = 0;
> >         trace->overrun = atomic_read(&current->trace_overrun);
> >         trace->depth = current->curr_ret_depth;
> >         /*
> > @@ -792,7 +803,6 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> >                 return (unsigned long)panic;
> >         }
> >
> > -       trace.rettime = trace_clock_local();
> >         if (fregs)
> >                 ftrace_regs_set_instruction_pointer(fregs, ret);
> >
> > @@ -808,6 +818,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
> >                         continue;
> >                 if (gops == &fgraph_stub)
> >                         continue;
> > +               if (!trace.rettime && !gops->skip_timestamp)
> 
> In addition to the above, do you mind adding unlikely() here as well?
> 
> > +                       trace.rettime = trace_clock_local();
> >
> >                 gops->retfunc(&trace, gops, fregs);
> >         }
> 
> [...]


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

