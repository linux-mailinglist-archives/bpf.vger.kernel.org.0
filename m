Return-Path: <bpf+bounces-57981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B44AB24E5
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 19:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DE99E4457
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DB124BBEC;
	Sat, 10 May 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO5+M0ET"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905CF19E83C;
	Sat, 10 May 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746899971; cv=none; b=glJUfCYFoeFgps9ujo5rJTQveK2EM0FRvTOFzFh9Tp1Jqmb5xGCY1jRhnzqI531PlYnOUPNQX6IX8EcK/fXsXst0qPiNgwlzlXHWxlrevqciSN+gu3ubRlXB0Ag4vlGXlnvxXg+RXwZEpiHDP0VBcX1YzAXnBSnSSVxtoS8+Zbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746899971; c=relaxed/simple;
	bh=WqEjHEZ9IJasOYlyFGSLyVBQCdmCu4M2D4iDTxhfvCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXeX4XqjWtpHmL504BHGeUW4vPVVvLGeHcxQPaTfbT0A3+q5k0XNUucKi6aJGc0qWNLOXV1US+UQSB1P1eY+LsdsBE0ST+UvbHKhBGXpiPGVaGnFKAD45T95Rk7vb5hFU6AKHhJxiVVc4RGtmenFXCCQjE+dt+oL1DSW9yvzFaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO5+M0ET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42493C4CEE2;
	Sat, 10 May 2025 17:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746899971;
	bh=WqEjHEZ9IJasOYlyFGSLyVBQCdmCu4M2D4iDTxhfvCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DO5+M0ETEot2p+oh0wiw0rapHfYB+Rd6nimCfp9uJAEr4RtihRn3/6RPy61J/+68a
	 wiovBBvmsIkyAU1WtyvmNENTbfZ+TmwfvJLZdN/YzvQP75PgI1qbsrLVE3GbyPcCxb
	 lRIW1aHt9bQV/UMPXlwysAXzVNNrk740H5kgj9aUKebaFZdGa0TOPq/wzG9TPd+aZ1
	 XW7A21HkIqnqByFo5sLMdXrW4ITIewsauQa2yQNk7yPZgoQzrcO/NOMfevVPcv7qN0
	 ARBov4QFaPu5TYm2sSt7sDWt8WFVhWSiDOrCCsKxAsjKOOdQV53m97ukctM6WsUgwN
	 zTDdr9cndPIFw==
Date: Sat, 10 May 2025 10:59:27 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v8 15/18] perf: Have get_perf_callchain() return NULL if
 crosstask and user are set
Message-ID: <ak36qadrkrplficbyceqx4cadgokxwolyyu3slgq4ag2kfjif5@7bxxiipqgdam>
References: <20250509164524.448387100@goodmis.org>
 <20250509165156.135430576@goodmis.org>
 <CAEf4BzaKfvCu2T+jJ2e-CCt0N50urfx+p6kQfV899_jkmT_XKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaKfvCu2T+jJ2e-CCt0N50urfx+p6kQfV899_jkmT_XKQ@mail.gmail.com>

On Fri, May 09, 2025 at 02:53:38PM -0700, Andrii Nakryiko wrote:
> On Fri, May 9, 2025 at 9:52 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > From: Josh Poimboeuf <jpoimboe@kernel.org>
> >
> > get_perf_callchain() doesn't support cross-task unwinding for user space
> > stacks, have it return NULL if both the crosstask and user arguments are
> > set.
> >
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  kernel/events/callchain.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> > index b0f5bd228cd8..abf258913ab6 100644
> > --- a/kernel/events/callchain.c
> > +++ b/kernel/events/callchain.c
> > @@ -224,6 +224,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> >         struct perf_callchain_entry_ctx ctx;
> >         int rctx, start_entry_idx;
> >
> > +       /* crosstask is not supported for user stacks */
> > +       if (crosstask && user)
> > +               return NULL;
> 
> I think get_perf_callchain() supports requesting both user and kernel
> stack traces, and if it's crosstask, you can still get kernel (but not
> user) stack, if I'm reading the code correctly.
> 
> So by just returning NULL early you will change this behavior, no?

Yeah, that does seem like a bug.

Though crosstask in general is dubious, even for kernel stacks.

If the task is running while you're unwinding it, hilarity ensues.
There are guardrails in place, so it should be safe, it may just produce
nonsense.  But maybe the callers don't need perfection.

But also, it would seem to be a bad idea to allow one task to spy on
what another task's kernelspace is doing.  Does unpriv BPF allow that?

Though it seems even 'cat /proc/self/stack' is a privileged operation
these days, does unpriv BPF allow that as well?

-- 
Josh

