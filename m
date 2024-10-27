Return-Path: <bpf+bounces-43251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F229B1B76
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 02:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E431C20CB2
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 00:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FC72905;
	Sun, 27 Oct 2024 00:08:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAEB1362;
	Sun, 27 Oct 2024 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729987727; cv=none; b=nHP5meIA3FL+qAr1NUvvQRX1GPcALsHkRQmzHZgU4Yqe/3CYTiWs8wAdS1tWsnQf/6rSn6GLcJGJocvMg3PC0AocDty+ieEAHdJ0GzGGWx3XCRKSeSKSWDj9QQhMRPDB+CfMPjShXgINvdBcWrtwHfoOr8SWi39WJY5vzHsLE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729987727; c=relaxed/simple;
	bh=n9VVzgV173OwhZ3rIcQyVRxgCSPlJWezIFmjI+NJO3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9bVWO5QUi3mu6R8BH+guSICov46GHTBPjrd7o/Sv9MAjKEa98MQLG521NuThKudCXPtbeyMuWoE5IvL63xjLrchfXyYaz/m9/CsxcAOkYsBGuA07k9EB9DKwY6+0D+MBQQejWLR8WiuA90DXD2kO7TAnl7TKl+IPaZySH/v49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF4EC4CEC6;
	Sun, 27 Oct 2024 00:08:44 +0000 (UTC)
Date: Sat, 26 Oct 2024 20:08:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song
 <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>
Subject: Re: [RFC PATCH v3 2/3] tracing: Introduce tracepoint_is_syscall()
Message-ID: <20241026200840.17171eb2@rorschach.local.home>
In-Reply-To: <20241026154629.593041-2-mathieu.desnoyers@efficios.com>
References: <20241026154629.593041-1-mathieu.desnoyers@efficios.com>
	<20241026154629.593041-2-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 11:46:28 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Introduce a "syscall" flag within the extended structure to know whether
> a tracepoint needs rcu tasks trace grace period before reclaim.
> This can be queried using tracepoint_is_syscall().
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
> Cc: Jordan Rife <jrife@google.com>
> ---
>  include/linux/tracepoint-defs.h |  2 ++
>  include/linux/tracepoint.h      | 24 ++++++++++++++++++++++++
>  include/trace/define_trace.h    |  2 +-
>  3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> index 967c08d9da84..53119e074c87 100644
> --- a/include/linux/tracepoint-defs.h
> +++ b/include/linux/tracepoint-defs.h
> @@ -32,6 +32,8 @@ struct tracepoint_func {
>  struct tracepoint_ext {
>  	int (*regfunc)(void);
>  	void (*unregfunc)(void);
> +	/* Flags. */
> +	unsigned int syscall:1;

I wonder if we should call it "sleepable" instead? For this patch set
do we really care if it's a system call or not? It's really if the
tracepoint is sleepable or not that's the issue. System calls are just
one user of it, there may be more in the future, and the changes to BPF
will still be needed.

Other than that, I think this could work.

-- Steve


>  };
>  
>  struct tracepoint {
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 83dc24ee8b13..93e70bc64533 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -104,6 +104,12 @@ void for_each_tracepoint_in_module(struct module *mod,
>   * tracepoint_synchronize_unregister must be called between the last tracepoint
>   * probe unregistration and the end of module exit to make sure there is no
>   * caller executing a probe when it is freed.
> + *
> + * An alternative is to use the following for batch reclaim associated
> + * with a given tracepoint:
> + *
> + * - tracepoint_is_syscall() == false: call_rcu()
> + * - tracepoint_is_syscall() == true:  call_rcu_tasks_trace()
>   */
>  #ifdef CONFIG_TRACEPOINTS
>  static inline void tracepoint_synchronize_unregister(void)
> @@ -111,9 +117,17 @@ static inline void tracepoint_synchronize_unregister(void)
>  	synchronize_rcu_tasks_trace();
>  	synchronize_rcu();
>  }
> +static inline bool tracepoint_is_syscall(struct tracepoint *tp)
> +{
> +	return tp->ext && tp->ext->syscall;
> +}
>  #else
>  static inline void tracepoint_synchronize_unregister(void)
>  { }
> +static inline bool tracepoint_is_syscall(struct tracepoint *tp)
> +{
> +	return false;
> +}
>  #endif
>  
>  #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
> @@ -345,6 +359,15 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	struct tracepoint_ext __tracepoint_ext_##_name = {		\
>  		.regfunc = _reg,					\
>  		.unregfunc = _unreg,					\
> +		.syscall = false,					\
> +	};								\
> +	__DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_proto), PARAMS(_args));
> +
> +#define DEFINE_TRACE_SYSCALL(_name, _reg, _unreg, _proto, _args)	\
> +	struct tracepoint_ext __tracepoint_ext_##_name = {		\
> +		.regfunc = _reg,					\
> +		.unregfunc = _unreg,					\
> +		.syscall = true,					\
>  	};								\
>  	__DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_proto), PARAMS(_args));
>  
> @@ -389,6 +412,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  #define __DECLARE_TRACE_SYSCALL	__DECLARE_TRACE
>  
>  #define DEFINE_TRACE_FN(name, reg, unreg, proto, args)
> +#define DEFINE_TRACE_SYSCALL(name, reg, unreg, proto, args)
>  #define DEFINE_TRACE(name, proto, args)
>  #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
>  #define EXPORT_TRACEPOINT_SYMBOL(name)
> diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
> index ff5fa17a6259..63fea2218afa 100644
> --- a/include/trace/define_trace.h
> +++ b/include/trace/define_trace.h
> @@ -48,7 +48,7 @@
>  
>  #undef TRACE_EVENT_SYSCALL
>  #define TRACE_EVENT_SYSCALL(name, proto, args, struct, assign, print, reg, unreg) \
> -	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
> +	DEFINE_TRACE_SYSCALL(name, reg, unreg, PARAMS(proto), PARAMS(args))
>  
>  #undef TRACE_EVENT_NOP
>  #define TRACE_EVENT_NOP(name, proto, args, struct, assign, print)


