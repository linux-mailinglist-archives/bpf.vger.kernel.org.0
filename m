Return-Path: <bpf+bounces-510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBBD702C05
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1F4281214
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 11:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC948C2FA;
	Mon, 15 May 2023 11:57:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23794C2DD
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 11:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2534C433D2;
	Mon, 15 May 2023 11:57:03 +0000 (UTC)
Date: Mon, 15 May 2023 07:57:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florent Revest <revest@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v10 07/11] tracing/probes: Add $args meta argument for
 all function args
Message-ID: <20230515075701.6f49b3e7@gandalf.local.home>
In-Reply-To: <168407353144.941486.592643565749157905.stgit@mhiramat.roam.corp.google.com>
References: <168407346448.941486.15681419068846125595.stgit@mhiramat.roam.corp.google.com>
	<168407353144.941486.592643565749157905.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 May 2023 23:12:11 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add the '$args' meta fetch argument for function-entry probe events. This
> will be expanded to the all arguments of the function and the tracepoint
> using BTF function argument information.
> 
> e.g.
>  #  echo 'p vfs_read $args' >> dynamic_events
>  #  echo 'f vfs_write $args' >> dynamic_events
>  #  echo 't sched_overutilized_tp $args' >> dynamic_events
>  # cat dynamic_events
> p:kprobes/p_vfs_read_0 vfs_read file=file buf=buf count=count pos=pos
> f:fprobes/vfs_write__entry vfs_write file=file buf=buf count=count pos=pos
> t:tracepoints/sched_overutilized_tp sched_overutilized_tp rd=rd overutilized=overutilized
> 
> NOTE: This is not like other $-vars, you can not use this $args as a
> part of fetch args, e.g. specifying name "foo=$args" and using it in
> dereferences "+0($args)" will lead a parse error.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v10:
>  - Change $$args to $args so that user can use $$ for current task's pid.

I hate coming up with new apis, because you never know if what you pick is
correct ;-) And then you are stuck with whatever you decided on. :-/

I know I suggested $args, but since it is special, should we call it
 "$arg*" ?

That way it follows bash wildcard semantics?

 #  echo 'p vfs_read $arg*' >> dynamic_events

I think that is more along the lines of what people would expect.

What do you think?

-- Steve


> Changes in v6:
>  - update patch description.
> ---
>  kernel/trace/trace_fprobe.c |   21 ++++++++-
>  kernel/trace/trace_kprobe.c |   23 ++++++++--
>  kernel/trace/trace_probe.c  |   98 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_probe.h  |   10 ++++
>  4 files changed, 144 insertions(+), 8 deletions(-)
> 
>

