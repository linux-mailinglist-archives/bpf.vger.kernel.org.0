Return-Path: <bpf+bounces-55224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A150A7A45F
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 15:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E030B1898BD3
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 13:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F7024E4D4;
	Thu,  3 Apr 2025 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4R2uHOn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE3F29408;
	Thu,  3 Apr 2025 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688469; cv=none; b=meO4chdVylIh+4t+2xW3f2c8WNkooUj4p1ejPcPnMNJtb5DYRC+AXFbhRkLBKsjMGp+7zu6ZsI/pJMKOGesMW3t4TRqo8Mrui6fBVKcZvDN5qxbjEIqosdF4zSHdFV1eOzc4dDi1y8uky8dc7B6iPLZtt9JcV3CVPDRDgMzZl70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688469; c=relaxed/simple;
	bh=lyNXz735Z2cTKcDUQuDQ893qwBJi5amYRPfXvdsMpwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrrAl1bKlo3uRFilk8z5F13rCzz7u29YhQiAM8Wfa1TqHogtuRQy4EetWkk5APGCTrZEI4lobLnsdC+WATULE+JtDzkf7pnfzkSIdboTgrL+aEo9tvOLFdP7cFjmGNYaxfO/rNxrtj5pGDNDXeuk1ux6VXWbTt7dLs2ZJCSHNBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4R2uHOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE2AC4CEE3;
	Thu,  3 Apr 2025 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743688468;
	bh=lyNXz735Z2cTKcDUQuDQ893qwBJi5amYRPfXvdsMpwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4R2uHOnSA+w0i5dCg4AB8+JL2u7dKOIXLE5xx2LjUYq/Qw49cqeVRKqbviu8I9ro
	 uzzMb1hZGQ16Rrew5uc2TA9u9w0vo4MzIVcsYmEPwtMLNWuFVoeleFvrwxjAG8OVnX
	 LbZ90j0P0jaxFWfNHKZvROWMafJlqr9KpuMZUsne2fFKyxA0T0Q5Kp3cpWmB3+gyck
	 NiUolxQ53qG5fzVwqIfsrpdX9IX8WZ9+RN5NvwPNAyU/EAvOTJD2C0CMMuL+4OBg18
	 JFI1sY6a4MHEDlkakmwfjJcwL3Rux2ZC+7G3ydjQIQGECEmKW2R0l7B7HB7EK/3M4H
	 uONVovjMtNU9Q==
Date: Thu, 3 Apr 2025 15:54:22 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mhocko@kernel.org, rostedt@goodmis.org,
	oleg@redhat.com, brauner@kernel.org, glider@google.com,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH v2] exit: move and extend sched_process_exit() tracepoint
Message-ID: <Z-6TDh1MUT49lvjk@gmail.com>
References: <20250402180925.90914-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402180925.90914-1-andrii@kernel.org>


* Andrii Nakryiko <andrii@kernel.org> wrote:

> It is useful to be able to access current->mm at task exit to, say,
> record a bunch of VMA information right before the task exits (e.g., for
> stack symbolization reasons when dealing with short-lived processes that
> exit in the middle of profiling session). Currently,
> trace_sched_process_exit() is triggered after exit_mm() which resets
> current->mm to NULL making this tracepoint unsuitable for inspecting
> and recording task's mm_struct-related data when tracing process
> lifetimes.
> 
> There is a particularly suitable place, though, right after
> taskstats_exit() is called, but before we do exit_mm() and other
> exit_*() resource teardowns. taskstats performs a similar kind of
> accounting that some applications do with BPF, and so co-locating them
> seems like a good fit. So that's where trace_sched_process_exit() is
> moved with this patch.
> 
> Also, existing trace_sched_process_exit() tracepoint is notoriously
> missing `group_dead` flag that is certainly useful in practice and some
> of our production applications have to work around this. So plumb
> `group_dead` through while at it, to have a richer and more complete
> tracepoint.
> 
> Note that we can't use sched_process_template anymore, and so we use
> TRACE_EVENT()-based tracepoint definition.

 But all the field names and
> order, as well as assign and output logic remain intact. We just add one
> extra field at the end in backwards-compatible way.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/trace/events/sched.h | 28 +++++++++++++++++++++++++---
>  kernel/exit.c                |  2 +-
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 8994e97d86c1..05a14f2b35c3 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -328,9 +328,31 @@ DEFINE_EVENT(sched_process_template, sched_process_free,
>  /*
>   * Tracepoint for a task exiting:
>   */
> -DEFINE_EVENT(sched_process_template, sched_process_exit,
> -	     TP_PROTO(struct task_struct *p),
> -	     TP_ARGS(p));
> +TRACE_EVENT(sched_process_exit,
> +
> +	TP_PROTO(struct task_struct *p, bool group_dead),
> +
> +	TP_ARGS(p, group_dead),
> +
> +	TP_STRUCT__entry(
> +		__array(	char,	comm,	TASK_COMM_LEN	)
> +		__field(	pid_t,	pid			)
> +		__field(	int,	prio			)
> +		__field(	bool,	group_dead		)
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
> +		__entry->pid		= p->pid;
> +		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
> +		__entry->group_dead	= group_dead;
> +	),
> +
> +	TP_printk("comm=%s pid=%d prio=%d group_dead=%s",
> +		  __entry->comm, __entry->pid, __entry->prio,
> +		  __entry->group_dead ? "true" : "false"
> +	)

This feels really fragile, could you please at least add a comment that 
points out that this is basically an extension of 
sched_process_template, and that it should remain a subset of it, or 
something to that end?

Thanks,

	Ingo

