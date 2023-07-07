Return-Path: <bpf+bounces-4432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5363B74B2F3
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF1B2817A3
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE9AD518;
	Fri,  7 Jul 2023 14:17:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473BD2F7
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 14:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61B6C433C7;
	Fri,  7 Jul 2023 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688739461;
	bh=74TZJ8DeE44QYRS49fC72fWhJ1prqaoZEaYSRbQGNqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R/zk6E3JYbftUInhMFoZYTLJTS9Ver38FrAGJYGDLg48/1nqGS/SziwjqaI0uQ8mF
	 9uLLO7Cp94P6wOdloklj2Y/7wrSRJt7CEE0DXPQ2KSBBrbXG+mYq6wLslX/vTfI+1W
	 pgq6NN6xNIFIcguJ639U3T/ObwuslPK5zEjXdlTFPNrJMc+jdRCDoMCiT4GP4oMufr
	 x6Cim/0DLMaOFwwTK3vOt8fmQO3/TnbVISve1eyccMtkGCkMoKGsy5ufum64rvMcyu
	 0KyIrk7yPq+zWMhYfRTNEs5ovJGutkCRmo8w8bkGnE8D5Q8BUg4Vq2a/jG8QT6c535
	 LnQlVdhJcw2rA==
Date: Fri, 7 Jul 2023 23:17:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florent Revest <revest@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v11 02/11] tracing/probes: Add fprobe events for tracing
 function entry and exit.
Message-Id: <20230707231730.7e2d176d729718a9ba51255a@kernel.org>
In-Reply-To: <20230608165234.0c00c146@gandalf.local.home>
References: <168432112492.1351929.9265172785506392923.stgit@mhiramat.roam.corp.google.com>
	<168432114441.1351929.4695419422051966931.stgit@mhiramat.roam.corp.google.com>
	<20230608165234.0c00c146@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jun 2023 16:52:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 17 May 2023 19:59:04 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > Add fprobe events for tracing function entry and exit instead of kprobe
> > events. With this change, we can continue to trace function entry/exit
> > even if the CONFIG_KPROBES_ON_FTRACE is not available. Since
> > CONFIG_KPROBES_ON_FTRACE requires the CONFIG_DYNAMIC_FTRACE_WITH_REGS,
> > it is not available if the architecture only supports
> > CONFIG_DYNAMIC_FTRACE_WITH_ARGS. And that means kprobe events can not
> > probe function entry/exit effectively on such architecture.
> > But this can be solved if the dynamic events supports fprobe events.
> > 
> > The fprobe event is a new dynamic events which is only for the function
> > (symbol) entry and exit. This event accepts non register fetch arguments
> > so that user can trace the function arguments and return values.
> > 
> > The fprobe events syntax is here;
> > 
> >  f[:[GRP/][EVENT]] FUNCTION [FETCHARGS]
> >  f[MAXACTIVE][:[GRP/][EVENT]] FUNCTION%return [FETCHARGS]
> 
> I finally got around to look at these (I know you already queued them), but
> looking at the above, the "%return" is redundant.
> 
> > 
> > E.g.
> > 
> >  # echo 'f vfs_read $arg1'  >> dynamic_events
> >  # echo 'f vfs_read%return $retval'  >> dynamic_events
> >  # cat dynamic_events
> >  f:fprobes/vfs_read__entry vfs_read arg1=$arg1
> >  f:fprobes/vfs_read__exit vfs_read%return arg1=$retval
> 
> Can't we just have:
> 
>   f:fprobes/vfs_read__entry vfs_read arg1=$arg1
>   f:fprobes/vfs_read__exit vfs_read arg1=$retval
> 
> Where if "$retval" is specified, it automatically becomes a return? If
> anything else is specified, it errors out. That is, if $retval is
> specified, it becomes a return probe, as a return probe can only have
> $retval. If anything else is specified, it errors out if $retval is also
> specified.

Hmm, current implementation design doesn't allow that.
It parses the 'place' and 'args' sequencially because what 'args' is
available depends on the place.

> 
> Now if it's a void function, and you just want to make it a return then we
> can have your:
> 
>   f:fprobes/vfs_read__exit vfs_read%return
> 
> Thoughts?

But this sounds useful. Let me try to scan the argument to find $retval.

Thank you,

> 
> -- Steve
> 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

