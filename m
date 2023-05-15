Return-Path: <bpf+bounces-542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B8370312C
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4F11C20C0F
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD79D539;
	Mon, 15 May 2023 15:11:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A2DC2FD
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 15:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A98AC433EF;
	Mon, 15 May 2023 15:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684163501;
	bh=69oUJQL5OUtRdb5coch/yX/TGFy0xmcGPw/50IS/q1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hhXZz4pIDvUIX/NSgfMd1CuV/QZJUYHRLL32FVmdZ3JKb75V9iBbskZt+LneBd6RP
	 K+bZHkFCP11dGlXqzSK0p5UilgF0J9zkNrq07Ogu6CTAf8R6IHXKtUGW+MjMQRBx2G
	 yV+GelPNkVimnWy+q7HB2Kgasa+8vLlIgIt9RWURzRRnjOYq06PE4i2IbF0CjGWyAd
	 4+yrswtL4jYIgiUura7Pzpat+MDIaohrdG0QCbYKbXJd2Ji/BuaYQWfPQgS6NcIK17
	 fh+TbitzqGWfZ5bf+JZwb8gWblS8r6bcFTbLxvel7+40W1LjbDguVApGCBC7wXRuoF
	 ipO+UcoDx5QBg==
Date: Tue, 16 May 2023 00:11:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florent Revest <revest@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v10 07/11] tracing/probes: Add $args meta argument for
 all function args
Message-Id: <20230516001137.d5c2f16b89c26bfce31f1c2b@kernel.org>
In-Reply-To: <20230515075701.6f49b3e7@gandalf.local.home>
References: <168407346448.941486.15681419068846125595.stgit@mhiramat.roam.corp.google.com>
	<168407353144.941486.592643565749157905.stgit@mhiramat.roam.corp.google.com>
	<20230515075701.6f49b3e7@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 May 2023 07:57:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 14 May 2023 23:12:11 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add the '$args' meta fetch argument for function-entry probe events. This
> > will be expanded to the all arguments of the function and the tracepoint
> > using BTF function argument information.
> > 
> > e.g.
> >  #  echo 'p vfs_read $args' >> dynamic_events
> >  #  echo 'f vfs_write $args' >> dynamic_events
> >  #  echo 't sched_overutilized_tp $args' >> dynamic_events
> >  # cat dynamic_events
> > p:kprobes/p_vfs_read_0 vfs_read file=file buf=buf count=count pos=pos
> > f:fprobes/vfs_write__entry vfs_write file=file buf=buf count=count pos=pos
> > t:tracepoints/sched_overutilized_tp sched_overutilized_tp rd=rd overutilized=overutilized
> > 
> > NOTE: This is not like other $-vars, you can not use this $args as a
> > part of fetch args, e.g. specifying name "foo=$args" and using it in
> > dereferences "+0($args)" will lead a parse error.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> > Changes in v10:
> >  - Change $$args to $args so that user can use $$ for current task's pid.
> 
> I hate coming up with new apis, because you never know if what you pick is
> correct ;-) And then you are stuck with whatever you decided on. :-/
> 
> I know I suggested $args, but since it is special, should we call it
>  "$arg*" ?
> 
> That way it follows bash wildcard semantics?
> 
>  #  echo 'p vfs_read $arg*' >> dynamic_events
> 
> I think that is more along the lines of what people would expect.
> 
> What do you think?

Good idea!

BTW, user will expect that $arg* will be expanded to available "$argN".
But this $args does different thing at this point, it is expanded
to something equivalent to "<BTF-name>=$argN:<BTF-type>".
So, to give more consistency, I need one more step: when user gives
only "$argN" on BTF supported kernel, it will be translated to
"<BTF-name>=$argN:<BTF-type>". Then, I think it is natural to use '$arg*'.

Thank you,

> 
> -- Steve
> 
> 
> > Changes in v6:
> >  - update patch description.
> > ---
> >  kernel/trace/trace_fprobe.c |   21 ++++++++-
> >  kernel/trace/trace_kprobe.c |   23 ++++++++--
> >  kernel/trace/trace_probe.c  |   98 +++++++++++++++++++++++++++++++++++++++++++
> >  kernel/trace/trace_probe.h  |   10 ++++
> >  4 files changed, 144 insertions(+), 8 deletions(-)
> > 
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

