Return-Path: <bpf+bounces-30578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A0E8CEE5E
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 11:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA701F21893
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9911F602;
	Sat, 25 May 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+RYCCbr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0F18044;
	Sat, 25 May 2024 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716630522; cv=none; b=NhfMXEzz1nGoK4Zx+NtI/NPtW9TB9agZE6xBrtyd1P9AZFVhu/OHP8m/e4lp6fIElPRerEurZN0wadZFfvFxOOjDZuKQPnEDoK35xVdd8AODsVGGGf+aOZ8WTA2afhTuaDuP7a+mBUTwUWeGMNNDnizniuXEu+z7FC0Xjh/uwkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716630522; c=relaxed/simple;
	bh=hkVq9wt5jhijGu8t++0r5AFS3tlAo9uhrGC7TUJWOi0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LXe6BjrW8oAGdfb2kVH8Ap19w4BLs+soZPnJ77hzvb1QgIwDFsTBw7VXL1YyEroJHjt3bBOUKKBWqSwOuBoNzuQMP9DBLhGtF92IqlEfiQ2yeaPULm+1cEHONiAZeR53bm+t683yqwJwDwaBFbfOBqC4qp6dXDcwV0HhMK/nffA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+RYCCbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E2AC3277B;
	Sat, 25 May 2024 09:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716630521;
	bh=hkVq9wt5jhijGu8t++0r5AFS3tlAo9uhrGC7TUJWOi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u+RYCCbrnnV50N3hnYaGDr4UFsVlrzLtIktr3MSCkr6fLkTMH5fwT8vr5P7wP7AcC
	 ZkiIfb0l13d17Ygs5GgDXvd4Ci3SRY5M1gWM4Ga4UqeMuiLHSv1A0lpCPHVSiwJFoh
	 MAuvvc5ou30DzjLgDun/2E4p1yq9H4FMEG8K3Zj9SDMsDklzGxVxNy3Wc9hVZEzgWI
	 uPNUMqq46eLcODoav6GvBD3DBHEJmUFci8TAq34LNQEzkdL+uKXj3UQr62H/PkHRce
	 o7dsSP5K51p/QX/PWKiQo0WLa03VzDm8bdjC5V43fs54XYk4U+FDYavsI3bHdJXJ/C
	 HNLYDgzeOsSEw==
Date: Sat, 25 May 2024 18:48:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v10 00/36] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20240525184835.dffd8a4420c159ece0feb63e@kernel.org>
In-Reply-To: <20240524184156.2d9704c2@gandalf.local.home>
References: <171509088006.162236.7227326999861366050.stgit@devnote2>
	<20240524184156.2d9704c2@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 18:41:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  7 May 2024 23:08:00 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > Steven Rostedt (VMware) (15):
> >       function_graph: Convert ret_stack to a series of longs
> >       fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
> >       function_graph: Add an array structure that will allow multiple callbacks
> >       function_graph: Allow multiple users to attach to function graph
> >       function_graph: Remove logic around ftrace_graph_entry and return
> >       ftrace/function_graph: Pass fgraph_ops to function graph callbacks
> >       ftrace: Allow function_graph tracer to be enabled in instances
> >       ftrace: Allow ftrace startup flags exist without dynamic ftrace
> >       function_graph: Have the instances use their own ftrace_ops for filtering
> >       function_graph: Add "task variables" per task for fgraph_ops
> >       function_graph: Move set_graph_function tests to shadow stack global var
> >       function_graph: Move graph depth stored data to shadow stack global var
> >       function_graph: Move graph notrace bit to shadow stack global var
> >       function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
> >       function_graph: Add selftest for passing local variables
> 
> Hi Masami,
> 
> While reviewing these patches, I realized there's several things I dislike
> about the patches I wrote. So I took these patches and started cleaning
> them up a little. Mostly renaming functions and adding comments.

Thanks for cleaning up the patches!!

> 
> As this is a major change to the function graph tracer, and I feel nervous
> about building something on top of this, how about I take over these
> patches and push them out for the next merge window. I'm hoping to get them
> into linux-next by v6.10-rc2 (I spent the day working on them, and it's
> mostly minor tweaks).

OK.

> Then I can push it out to 6.11 and get some good testing against it. Then
> we can add your stuff on top and get that merged in 6.12.

Yeah, it is reasonable plan. I also concerns about the stability. Especially,
this involves fprobe side changes too. If we introduce both at once, it may
mess up many things.

> 
> If all goes well, I'm hoping to get a series on just these patches (and
> your selftest addition) by tonight.
> 
> Thoughts?

I agree with you.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

