Return-Path: <bpf+bounces-43259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1607F9B1E13
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 15:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388B51C20986
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFEF1684A5;
	Sun, 27 Oct 2024 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u996V+um"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A27CA5B;
	Sun, 27 Oct 2024 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730038777; cv=none; b=Jfm0kMNiJvAeMMHVDH1aimOk62WgNIl3VH8zMVL4so1bW4KSFPJGHdcJ6Yp0jnL9HPRAWbguc6dmOLlS2ZRnEjAT4+IcVlwxmHIVi5ptkWYG4/RbXiNlmTj5SoumwfpgX4J2vda7HLfsVhpoz8iRIwsflQjuKxk+t6M87of7OZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730038777; c=relaxed/simple;
	bh=dI104uvNNvmaRukXodYs325rFb0wx9MA1dx4I0upuqg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JS69UXIOF0WvulGS5l/H+jCyiRWbifB/9ujGyzq9rkBzRWVD0YjjGjZ4IOx2kHMVN5ulDhUPERKqLaXj0+7ygFmS5CTRa4A+G16vtOuzDrKIVZx3oY9gE5KMH4+LCUk/xaH19RtDM8Q+2I9ACFBsq1//9YsCrTZ3ERW6kXtjx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u996V+um; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DAAC4CEC3;
	Sun, 27 Oct 2024 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730038776;
	bh=dI104uvNNvmaRukXodYs325rFb0wx9MA1dx4I0upuqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u996V+umxZY9asluDqk92Nt6A6lGaI1JpN+AKfhq7lJrXIr/iHVxU7tsnUSp77bvm
	 Sgb6YH2tXquNZg0eIdnG6ocOGVwmUL1oeneLhzWPPh0yRt4lWT9YSeKuXOAyWfPlCw
	 8m/O+YAFtI/xA7BaHu+SIAwRgE+HLAHndMpWdejEV+a1hv65UONYJYz3kwbk5F6/es
	 47SNqYY6ejb90eTMKK73kvESVKTOxs1BZQ1PdjwGC21ZGLsKi4TQYu3myxOYSbppqb
	 e5r1WTMVoS+rJPMMXtxCs2MGBrteoNxE/dgdkxf2/yEyq/xYBTiNszNrBYAbrkxJcq
	 3F+75vZpy68sw==
Date: Sun, 27 Oct 2024 23:19:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song
 <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>
Subject: Re: [RFC PATCH v3 2/3] tracing: Introduce tracepoint_is_syscall()
Message-Id: <20241027231930.941d6c1f21e2b4668af44df8@kernel.org>
In-Reply-To: <20241026200840.17171eb2@rorschach.local.home>
References: <20241026154629.593041-1-mathieu.desnoyers@efficios.com>
	<20241026154629.593041-2-mathieu.desnoyers@efficios.com>
	<20241026200840.17171eb2@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 20:08:40 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 26 Oct 2024 11:46:28 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > Introduce a "syscall" flag within the extended structure to know whether
> > a tracepoint needs rcu tasks trace grace period before reclaim.
> > This can be queried using tracepoint_is_syscall().
> > 
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Michael Jeanson <mjeanson@efficios.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: bpf@vger.kernel.org
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Jordan Rife <jrife@google.com>
> > ---
> >  include/linux/tracepoint-defs.h |  2 ++
> >  include/linux/tracepoint.h      | 24 ++++++++++++++++++++++++
> >  include/trace/define_trace.h    |  2 +-
> >  3 files changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> > index 967c08d9da84..53119e074c87 100644
> > --- a/include/linux/tracepoint-defs.h
> > +++ b/include/linux/tracepoint-defs.h
> > @@ -32,6 +32,8 @@ struct tracepoint_func {
> >  struct tracepoint_ext {
> >  	int (*regfunc)(void);
> >  	void (*unregfunc)(void);
> > +	/* Flags. */
> > +	unsigned int syscall:1;
> 
> I wonder if we should call it "sleepable" instead? For this patch set
> do we really care if it's a system call or not? It's really if the
> tracepoint is sleepable or not that's the issue. System calls are just
> one user of it, there may be more in the future, and the changes to BPF
> will still be needed.

I agree with this. Even if currently we restrict only syscall events
can be sleep, "tracepoint_is_syscall()" requires to add comment to 
explain why on all call sites e.g.

 /*
  * The syscall event is only sleepable event, so we ensure it is
  * syscall event for checking sleepable or not.
  */

If it called tracepoint_is_sleepable(), we don't need such comment.

Thank you,

> 
> Other than that, I think this could work.
> 
> -- Steve
> 
> 
> >  };
> >  
> >  struct tracepoint {
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index 83dc24ee8b13..93e70bc64533 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -104,6 +104,12 @@ void for_each_tracepoint_in_module(struct module *mod,
> >   * tracepoint_synchronize_unregister must be called between the last tracepoint
> >   * probe unregistration and the end of module exit to make sure there is no
> >   * caller executing a probe when it is freed.
> > + *
> > + * An alternative is to use the following for batch reclaim associated
> > + * with a given tracepoint:
> > + *
> > + * - tracepoint_is_syscall() == false: call_rcu()
> > + * - tracepoint_is_syscall() == true:  call_rcu_tasks_trace()
> >   */
> >  #ifdef CONFIG_TRACEPOINTS
> >  static inline void tracepoint_synchronize_unregister(void)
> > @@ -111,9 +117,17 @@ static inline void tracepoint_synchronize_unregister(void)
> >  	synchronize_rcu_tasks_trace();
> >  	synchronize_rcu();
> >  }
> > +static inline bool tracepoint_is_syscall(struct tracepoint *tp)
> > +{
> > +	return tp->ext && tp->ext->syscall;
> > +}
> >  #else
> >  static inline void tracepoint_synchronize_unregister(void)
> >  { }
> > +static inline bool tracepoint_is_syscall(struct tracepoint *tp)
> > +{
> > +	return false;
> > +}
> >  #endif
> >  
> >  #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
> > @@ -345,6 +359,15 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >  	struct tracepoint_ext __tracepoint_ext_##_name = {		\
> >  		.regfunc = _reg,					\
> >  		.unregfunc = _unreg,					\
> > +		.syscall = false,					\
> > +	};								\
> > +	__DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_proto), PARAMS(_args));
> > +
> > +#define DEFINE_TRACE_SYSCALL(_name, _reg, _unreg, _proto, _args)	\
> > +	struct tracepoint_ext __tracepoint_ext_##_name = {		\
> > +		.regfunc = _reg,					\
> > +		.unregfunc = _unreg,					\
> > +		.syscall = true,					\
> >  	};								\
> >  	__DEFINE_TRACE_EXT(_name, &__tracepoint_ext_##_name, PARAMS(_proto), PARAMS(_args));
> >  
> > @@ -389,6 +412,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >  #define __DECLARE_TRACE_SYSCALL	__DECLARE_TRACE
> >  
> >  #define DEFINE_TRACE_FN(name, reg, unreg, proto, args)
> > +#define DEFINE_TRACE_SYSCALL(name, reg, unreg, proto, args)
> >  #define DEFINE_TRACE(name, proto, args)
> >  #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)
> >  #define EXPORT_TRACEPOINT_SYMBOL(name)
> > diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
> > index ff5fa17a6259..63fea2218afa 100644
> > --- a/include/trace/define_trace.h
> > +++ b/include/trace/define_trace.h
> > @@ -48,7 +48,7 @@
> >  
> >  #undef TRACE_EVENT_SYSCALL
> >  #define TRACE_EVENT_SYSCALL(name, proto, args, struct, assign, print, reg, unreg) \
> > -	DEFINE_TRACE_FN(name, reg, unreg, PARAMS(proto), PARAMS(args))
> > +	DEFINE_TRACE_SYSCALL(name, reg, unreg, PARAMS(proto), PARAMS(args))
> >  
> >  #undef TRACE_EVENT_NOP
> >  #define TRACE_EVENT_NOP(name, proto, args, struct, assign, print)
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

