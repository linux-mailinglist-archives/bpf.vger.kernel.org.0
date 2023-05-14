Return-Path: <bpf+bounces-469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A10C701B48
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 05:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FA51C20A86
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 03:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C70515A0;
	Sun, 14 May 2023 03:02:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F1ED3
	for <bpf@vger.kernel.org>; Sun, 14 May 2023 03:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B317C433D2;
	Sun, 14 May 2023 03:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684033360;
	bh=mJ7FROF21hftwJgCmZhoKpXoDuToifD8eM33mGLt0mQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=prQ4Wm9AAnZCqvzAN1GjX1iBSQn2GOEr1SLXvSKe9p0dqi0+vgKKeojIyijzqwBXM
	 nEFNUGuJHEvUGJl8v3186cvW6GqYvbUdioSpLPX5nNCmPOk1957meNjwQQBu5U47To
	 zw0EpK+E3hf16xPGKAobx/HB7fUUqCaSoyPOgCs52QHRuL+HpWZTR6lMBG4JMiakSy
	 9ypg6FN2zZsEHp7nH6ESpULUWvu/ou4Yqwxcc/1r16c2upH0WV2FGxWsuHpkrzxGJ4
	 QVSwNYhvodTHW42w1qQ89L9XdcVMZhKFaiLRsQlBTVqxND9Csuf6ctEk1OwyELPJeg
	 KuHMZIwBB2hIg==
Date: Sun, 14 May 2023 12:02:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florent Revest <revest@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v9.1 07/11] tracing/probes: Add $$args meta argument for
 all function args
Message-Id: <20230514120236.25fd2bcb174da8ff95ba89c1@kernel.org>
In-Reply-To: <20230505174856.04ca1e6a@gandalf.local.home>
References: <168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com>
	<168299390127.3242086.2714570777321787734.stgit@mhiramat.roam.corp.google.com>
	<20230505174856.04ca1e6a@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 May 2023 17:48:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  2 May 2023 11:18:21 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add the '$$args' meta fetch argument for function-entry probe events. This
> 
> Hmm, couldn't we just use $args ? That would be different from $arg1,
> $arg2, etc.
> 
> The $$ to me would be either the bash pid of current, or perhaps it would
> be just to use a dollar sign. I don't see the precedence of $$args being a
> "full expand".

OK, I just thought it required a bit special prefix because it will be
expanded to several arguments (it is different from other $-params) and,
internally, it should be handled in the different path from the other
$-params. But the latter is internal reason, we should not care about that.
(of course I will leave a comment it.)

Thank you!

> 
> -- Steve
> 
> 
> > will be expanded to the all arguments of the function and the tracepoint
> > using BTF function argument information.
> > 
> > e.g.
> >  #  echo 'p vfs_read $$args' >> dynamic_events
> >  #  echo 'f vfs_write $$args' >> dynamic_events
> >  #  echo 't sched_overutilized_tp $$args' >> dynamic_events
> >  # cat dynamic_events
> > p:kprobes/p_vfs_read_0 vfs_read file=file buf=buf count=count pos=pos
> > f:fprobes/vfs_write__entry vfs_write file=file buf=buf count=count pos=pos
> > t:tracepoints/sched_overutilized_tp sched_overutilized_tp rd=rd overutilized=overutilized
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

