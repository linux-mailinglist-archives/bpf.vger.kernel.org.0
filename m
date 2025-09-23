Return-Path: <bpf+bounces-69467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9496CB97093
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 19:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D79189DDA2
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297A127F74C;
	Tue, 23 Sep 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oZUT18DM"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F22189;
	Tue, 23 Sep 2025 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648743; cv=none; b=PT2VxCxog7M7lzvNm2bR8j4/orlABfzuIaKxfDIfr7in6p4wwc56uRGEwG/R30MMTv1a6bWeF907awc+7pa05703J+9XCOz+VSlvaOPPPfRUC5GjiuPxUxmzX/JAiDAu2BqrrQ2eTgES5oy9dyzNfMVULVvP3LO94afx4ujeyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648743; c=relaxed/simple;
	bh=qDfwgoffu2EeFB9AZbmHrdtAcXU1sHnw0HMH4EM3IgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4J0O4g9No70WL/vUUs4/HOyCwHEk6Xst5rUyagXTpLG2NQYUi//nHh6oETfXsWzzUslFpXyzZaVWGjSB0DYJL9UMJKsdHmVDYE2piaY5HaBeCEghfamvMUvf9qTMlaQek+idv8+6iYWLmzQf109MCPfgKFlNr7F7d5Op7mYoMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oZUT18DM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VWa7qC5SSeQMnGbOf5FkOuUwpXg+L6IZkiID9iWP6KM=; b=oZUT18DMWbRT0tC8FhEqRwIDag
	TuOyaeEpOj8Mvma54Eqh16HkyYOu5VH0B0Idq8L/BB5TRKsekePSU6SnnocOqVe7AqZpy6iiGZxM7
	pG/4aSragiKLe6fzCIdb2MldnHcEBZDavDHGXJ/JH8sHxJ5tVv0BKex/eckcxKdAZSQHx1Fzr7uFr
	ZsxwCAu+UpOGgpq1fFEm7Zu7k/70Xgsh2TSqYkJmYK2GYDg4AE7+0KSSgsyEK10ihE6r8vHLosUau
	nOj9bHuZmO0A0UOk9ay7aKTpOUi/a6EYEjCZyMMAlwNHSlk98sRn6eANg8lIO8brDq/E0+okl32wl
	BpIkQLRg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v16sD-00000008XDu-1xhP;
	Tue, 23 Sep 2025 17:32:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 52C4E3001F7; Tue, 23 Sep 2025 19:32:16 +0200 (CEST)
Date: Tue, 23 Sep 2025 19:32:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 15/34] rcu: Add noinstr-fast
 rcu_read_{,un}lock_tasks_trace() APIs
Message-ID: <20250923173216.GU3245006@noisy.programming.kicks-ass.net>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
 <20250923142036.112290-15-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923142036.112290-15-paulmck@kernel.org>

On Tue, Sep 23, 2025 at 07:20:17AM -0700, Paul E. McKenney wrote:
> When expressing RCU Tasks Trace in terms of SRCU-fast, it was
> necessary to keep a nesting count and per-CPU srcu_ctr structure
> pointer in the task_struct structure, which is slow to access.
> But an alternative is to instead make rcu_read_lock_tasks_trace() and
> rcu_read_unlock_tasks_trace(), which match the underlying SRCU-fast
> semantics, avoiding the task_struct accesses.
> 
> When all callers have switched to the new API, the previous
> rcu_read_lock_trace() and rcu_read_unlock_trace() APIs will be removed.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: <bpf@vger.kernel.org>
> ---
>  include/linux/rcupdate_trace.h | 37 ++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
> index 0bd47f12ecd17b..b87151e6b23881 100644
> --- a/include/linux/rcupdate_trace.h
> +++ b/include/linux/rcupdate_trace.h
> @@ -34,6 +34,43 @@ static inline int rcu_read_lock_trace_held(void)
>  
>  #ifdef CONFIG_TASKS_TRACE_RCU
>  
> +/**
> + * rcu_read_lock_tasks_trace - mark beginning of RCU-trace read-side critical section
> + *
> + * When synchronize_rcu_tasks_trace() is invoked by one task, then that
> + * task is guaranteed to block until all other tasks exit their read-side
> + * critical sections.  Similarly, if call_rcu_trace() is invoked on one
> + * task while other tasks are within RCU read-side critical sections,
> + * invocation of the corresponding RCU callback is deferred until after
> + * the all the other tasks exit their critical sections.
> + *
> + * For more details, please see the documentation for srcu_read_lock_fast().
> + */
> +static inline struct srcu_ctr __percpu *rcu_read_lock_tasks_trace(void)
> +{
> +	struct srcu_ctr __percpu *ret = srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
> +
> +	if (IS_ENABLED(CONFIG_ARCH_WANTS_NO_INSTR))
> +		smp_mb();

I am somewhat confused by the relation between noinstr and smp_mb()
here. Subject mentions is, but Changelog is awfully silent again.

Furthermore I note that this is a positive while unlock is a negative
relation between the two. Which adds even more confusion.

> +	return ret;
> +}
> +
> +/**
> + * rcu_read_unlock_tasks_trace - mark end of RCU-trace read-side critical section
> + * @scp: return value from corresponding rcu_read_lock_tasks_trace().
> + *
> + * Pairs with the preceding call to rcu_read_lock_tasks_trace() that
> + * returned the value passed in via scp.
> + *
> + * For more details, please see the documentation for rcu_read_unlock().
> + */
> +static inline void rcu_read_unlock_tasks_trace(struct srcu_ctr __percpu *scp)
> +{
> +	if (!IS_ENABLED(CONFIG_ARCH_WANTS_NO_INSTR))
> +		smp_mb();
> +	srcu_read_unlock_fast(&rcu_tasks_trace_srcu_struct, scp);
> +}
> +
>  /**
>   * rcu_read_lock_trace - mark beginning of RCU-trace read-side critical section
>   *
> -- 
> 2.40.1
> 

