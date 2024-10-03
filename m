Return-Path: <bpf+bounces-40877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C087A98F9D2
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83553285A46
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 22:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96F71CC883;
	Thu,  3 Oct 2024 22:25:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BDA824BD;
	Thu,  3 Oct 2024 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994312; cv=none; b=DBw1/afpEF1mz3tjQdZC5OfTmR8V/n5S57k6HWM6/HYjSjrhBJoMvhplEx1hhevvZ6kiY8lHehuFBzC/80WkchRCy4tb7x98ROiYlDzKWP1QUYor03UTfwm73P4o8uwEvRR/NKv1v/AhSJSkovYgMTB70Sw3bJzA7kg8s35anq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994312; c=relaxed/simple;
	bh=hAmj3kMsm7Vl70wIT+Y1n66dA9OGBd+UlgTvFwamrMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDPbkco/zrNo3AI+17Cd48/CRIELt7mtyQO+tsKc7BwOzLhdWV32C5n4NtHRT0O1DI7Qh2M6nAH3oXKKJs3Aw3C4wlimv+Je4+gjbZU8c5oR/vZ0ln4qIrnjJj7MHmfzGVqf+2jz7ePIXTwsEPsXUkwqNIDzNn/fspsih8Yf6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2DFC4CEC5;
	Thu,  3 Oct 2024 22:25:10 +0000 (UTC)
Date: Thu, 3 Oct 2024 18:26:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Michael Jeanson
 <mjeanson@efficios.com>
Subject: Re: [PATCH v1 4/8] tracing/bpf: guard syscall probe with
 preempt_notrace
Message-ID: <20241003182604.09e4851d@gandalf.local.home>
In-Reply-To: <20241003151638.1608537-5-mathieu.desnoyers@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
	<20241003151638.1608537-5-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 11:16:34 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> In preparation for allowing system call enter/exit instrumentation to
> handle page faults, make sure that bpf can handle this change by
> explicitly disabling preemption within the bpf system call tracepoint
> probes to respect the current expectations within bpf tracing code.
> 
> This change does not yet allow bpf to take page faults per se within its
> probe, but allows its existing probes to adapt to the upcoming change.
> 

I guess the BPF folks should state if this is needed or not?

Does the BPF hooks into the tracepoints expect preemption to be disabled
when called?

-- Steve


> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Tested-by: Andrii Nakryiko <andrii@kernel.org> # BPF parts
> Cc: Michael Jeanson <mjeanson@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: bpf@vger.kernel.org
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  include/trace/bpf_probe.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index c85bbce5aaa5..211b98d45fc6 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -53,8 +53,17 @@ __bpf_trace_##call(void *__data, proto)					\
>  #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
>  	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
>  
> +#define __BPF_DECLARE_TRACE_SYSCALL(call, proto, args)			\
> +static notrace void							\
> +__bpf_trace_##call(void *__data, proto)					\
> +{									\
> +	guard(preempt_notrace)();					\
> +	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
> +}
> +
>  #undef DECLARE_EVENT_SYSCALL_CLASS
> -#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
> +#define DECLARE_EVENT_SYSCALL_CLASS(call, proto, args, tstruct, assign, print)	\
> +	__BPF_DECLARE_TRACE_SYSCALL(call, PARAMS(proto), PARAMS(args))
>  
>  /*
>   * This part is compiled out, it is only here as a build time check


