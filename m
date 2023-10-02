Return-Path: <bpf+bounces-11234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA43A7B5D8D
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 01:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D18F12815E0
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 23:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F5C208C1;
	Mon,  2 Oct 2023 23:09:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C02208B1
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 23:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17546C433C7;
	Mon,  2 Oct 2023 23:09:19 +0000 (UTC)
Date: Mon, 2 Oct 2023 19:10:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org, Joel Fernandes
 <joel@joelfernandes.org>
Subject: Re: [RFC PATCH v3 1/5] tracing: Introduce faultable tracepoints
 (v3)
Message-ID: <20231002191023.6175294d@gandalf.local.home>
In-Reply-To: <20231002202531.3160-2-mathieu.desnoyers@efficios.com>
References: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
	<20231002202531.3160-2-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Oct 2023 16:25:27 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> @@ -202,8 +198,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		if (WARN_ON_ONCE(RCUIDLE_COND(rcuidle)))		\
>  			return;						\
>  									\
> -		/* keep srcu and sched-rcu usage consistent */		\
> -		preempt_disable_notrace();				\
> +		if (mayfault) {						\
> +			rcu_read_lock_trace();				\

I thought rcu_trace was for the case that a task can not voluntarily call
schedule. If this tracepoint tries to read user space memory that isn't
paged in, and faults, can't the faulting logic call schedule and break this
requirement?

-- Steve


> +		} else {						\
> +			/* keep srcu and sched-rcu usage consistent */	\
> +			preempt_disable_notrace();			\
> +		}							\
>  									\
>  		/*							\
>  		 * For rcuidle callers, use srcu since sched-rcu	\

