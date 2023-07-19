Return-Path: <bpf+bounces-5332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5163759A61
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A62728194E
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BE23D3A7;
	Wed, 19 Jul 2023 16:01:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5B20F96
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 16:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCBEC433C8;
	Wed, 19 Jul 2023 16:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689782509;
	bh=FaWWJpUjc/tTpmXUJCgAeEWVusJ8GV+cXlCBePLxu78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uogWx1Ag+l1S4/Lwm+Z3N0aKUC3iImduHwHK5PaNwVxqKUKjqRkwP2IWXoblAa/Ok
	 J1VwthfEwnWhgzFJkZcK6BhPbHMzLbTsMS2ZkuBXhse1T1BsxmGwnQyMGsSB/UnPGa
	 DItkC+JRLMFcDyy2wO+XUPYrZgCXC3GkKuGVeQpAC+5g5+SKFl1ja3FH7Fb9ecRIFN
	 G0TpD7uFX8IqnDUAz4zcr/Wdgtjr9b5hbzz9fCoJRHj+pmC5slJCfLyLW2IYWJx7C0
	 +48Te2TtDd+UKgpCCAqpuR1iuVSyXPXthqdTAfsbakPqlyX1qf7OtUkV9HWgYYFSS/
	 vmM/LIWSLMNbQ==
Date: Thu, 20 Jul 2023 01:01:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 0/9] tracing: Improbe BTF support on probe events
Message-Id: <20230720010144.a2a70b1db0f636401e96909a@kernel.org>
In-Reply-To: <e002b414-0e12-0ee8-08a9-2a2b2f21c7bc@oracle.com>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
	<e002b414-0e12-0ee8-08a9-2a2b2f21c7bc@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jul 2023 10:02:06 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> On 17/07/2023 16:23, Masami Hiramatsu (Google) wrote:
> > Hi,
> > 
> > Here is the 2nd version of series to improve the BTF support on probe events.
> > The previous series is here:
> > 
> > https://lore.kernel.org/linux-trace-kernel/168699521817.528797.13179901018528120324.stgit@mhiramat.roam.corp.google.com/
> > 
> > In this version, I added a NULL check fix patch [1/9] (which will go to
> > fixes branch) and move BTF related API to kernel/bpf/btf.c [2/9] and add
> > a new BTF API [3/9] so that anyone can reuse it.
> > Also I decided to use '$retval' directly instead of 'retval' pseudo BTF
> > variable for field access at [5/9] because I introduced an idea to choose
> > function 'exit' event automatically if '$retval' is used [7/9]. With that
> > change, we can not use 'retval' because if a function has 'retval'
> > argument, we can not decide 'f func retval' is function exit or entry.
> 
> this is fantastic work! (FWIW I ran into the retval argument issue with
> ksnoop as well; I got around it by using "return" to signify the return
> value since as a reserved word it won't clash with a variable name.
> However in the trace subsystem context retval is used extensively so
> makes sense to stick with that).

Thanks!

> 
> One thing we should probably figure out is a common approach to handling
> ambiguous static functions that will work across ftrace and BPF.  A few
> edge cases that are worth figuring out:
> 
> 1. a static function with the same name exists in multiple modules,
> either with different or identical function signatures
> 2. a static function has .isra.0 and other gcc suffixes applied to
> static functions during optimization
> 
> As Alexei mentioned, we're still working on 1, so it would be good
> to figure out a naming scheme that works well in both ftrace and BPF
> contexts. There are a few hundred of these ambiguous functions. My
> reading of the fprobe docs seems to suggest that there is no mechanism
> to specify a specific module for a given symbol (as in ftrace filters),
> is that right?

Yes, it doesn't have module specificaiton at this moment. I'll considering
to fix this. BTW, for the same-name functions, we are discussing another
approach. We also need to sync this with BTF. 

https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carminati@gmail.com/

> 
> Jiri led a session on this topic at LSF/MM/BPF ; perhaps we should
> carve out some time at Plumbers to discuss this?

Yeah, good idea.

> 
> With respect to 2, pahole v1.25 will generate representations for these
> "."-suffixed functions in BTF via --btf_gen_optimized [1]. (BTF
> representation is skipped if the optimizations impact on the registers
> used for function arguments; if these don't match calling conventions
> due to optimized-out params, we don't represent the function in BTF,
> as the tracing expectations are violated).

Correct. But can't we know which argument is skipped by the optimization
from the DWARF? At least the function parameters will be changed.

> However the BTF function name - in line with DWARF representation -
> will not have the .isra suffix. So the thing to bear in mind is if
> you use the function name with suffix as the fprobe function name,
> a BTF lookup of that exact ("foo.isra.0") name will not find anything,
> while a lookup of "foo" will succeed. I'll add some specifics in your
> patch doing the lookups, but just wanted to highlight the issue at
> the top-level.

So, what about adding an index sorted list of the address and BTF entry
index as an expansion of the BTF? It allowed us to easily map the suffixed
symbol address (we can get it from kallsyms) to BTF quickly.
So the module will have

[BTF data][array length][BTF index array]

Index array member will be like this.

struct btf_index {
	u32	offset;	// offset from the start text
	u32	id:		// BTF type id
};

We can do binary search the function type id from the symbol address.

Thank you,

> 
> Thanks!
> 
> Alan
> 
> [1]
> https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/
> 
> > Selftest test case [8/9] and document [9/9] are also updated according to
> > those changes.
> > 
> > This series can be applied on top of "v6.5-rc2" kernel.
> > 
> > You can also get this series from:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext
> > 
> > 
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (Google) (9):
> >       tracing/probes: Fix to add NULL check for BTF APIs
> >       bpf/btf: tracing: Move finding func-proto API and getting func-param API to BTF
> >       bpf/btf: Add a function to search a member of a struct/union
> >       tracing/probes: Support BTF based data structure field access
> >       tracing/probes: Support BTF field access from $retval
> >       tracing/probes: Add string type check with BTF
> >       tracing/fprobe-event: Assume fprobe is a return event by $retval
> >       selftests/ftrace: Add BTF fields access testcases
> >       Documentation: tracing: Update fprobe event example with BTF field
> > 
> > 
> >  Documentation/trace/fprobetrace.rst                |   50 ++
> >  include/linux/btf.h                                |    7 
> >  kernel/bpf/btf.c                                   |   83 ++++
> >  kernel/trace/trace_fprobe.c                        |   58 ++-
> >  kernel/trace/trace_probe.c                         |  402 +++++++++++++++-----
> >  kernel/trace/trace_probe.h                         |   12 +
> >  .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   11 +
> >  .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    6 
> >  8 files changed, 503 insertions(+), 126 deletions(-)
> > 
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

