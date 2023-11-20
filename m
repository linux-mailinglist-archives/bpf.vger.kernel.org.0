Return-Path: <bpf+bounces-15418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505287F2005
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBFE1C216AC
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC7339859;
	Mon, 20 Nov 2023 22:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ARBByAla"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B16A95;
	Mon, 20 Nov 2023 14:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ehyNbtccEyuiP5WfqLLu6Y34ZLscOD6ayJpKfYE4Hq4=; b=ARBByAlakJqeG1dXnTzUeMfV3Y
	AQYTdTV2t07UNGlF40JG3PLAzprQMPWyy4DSqxXE5NLEBquu5M7ZTXcSAFTJIwWZZ4rgsYQ6zksPa
	V+xjwgeZhyyzs3+evnrKYdGtm1LdiBX50zU0qlW+MpFDb3PMfYn6TtxMV4rpmRca+62zErYMnTsBS
	2HD9VQ7biIxLzIkjd8lvxZZejWSZ5CFqw50zgdD04p/17sosZk46V20nEiyjiOIfFFJxiqxiVcsuN
	YXSo4VNv9wmLsR2KAvhWiIy1KVionaF6GOP2GrqFUGcj+pHXxHnLXuEoKnmqcJUBxNJcS3FIEZ28D
	tJby6OyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r5CY9-0052af-OM; Mon, 20 Nov 2023 22:15:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A99B53004E3; Mon, 20 Nov 2023 23:15:24 +0100 (CET)
Date: Mon, 20 Nov 2023 23:15:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Jeanson <mjeanson@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 2/5] tracing/ftrace: Add support for faultable
 tracepoints
Message-ID: <20231120221524.GD8262@noisy.programming.kicks-ass.net>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-3-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120205418.334172-3-mathieu.desnoyers@efficios.com>

On Mon, Nov 20, 2023 at 03:54:15PM -0500, Mathieu Desnoyers wrote:
> @@ -380,8 +415,8 @@ static inline notrace int trace_event_get_offsets_##call(		\
>  
>  #include "stages/stage6_event_callback.h"
>  
> -#undef DECLARE_EVENT_CLASS
> -#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
> +#undef _DECLARE_EVENT_CLASS
> +#define _DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print, tp_flags) \
>  									\
>  static notrace void							\
>  trace_event_raw_event_##call(void *__data, proto)			\
> @@ -392,8 +427,13 @@ trace_event_raw_event_##call(void *__data, proto)			\
>  	struct trace_event_raw_##call *entry;				\
>  	int __data_size;						\
>  									\
> +	if ((tp_flags) & TRACEPOINT_MAY_FAULT) {			\
> +		might_fault();						\
> +		preempt_disable_notrace();				\
> +	}								\
> +									\
>  	if (trace_trigger_soft_disabled(trace_file))			\
> -		return;							\
> +		goto end;						\
>  									\
>  	__data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
>  									\
> @@ -401,14 +441,28 @@ trace_event_raw_event_##call(void *__data, proto)			\
>  				 sizeof(*entry) + __data_size);		\
>  									\
>  	if (!entry)							\
> -		return;							\
> +		goto end;						\
>  									\
>  	tstruct								\
>  									\
>  	{ assign; }							\
>  									\
>  	trace_event_buffer_commit(&fbuffer);				\
> +end:									\
> +	if ((tp_flags) & TRACEPOINT_MAY_FAULT)				\
> +		preempt_enable_notrace();				\
>  }

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 82cb22ad6d61..954f87515668 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -532,9 +532,16 @@ int trace_event_reg(struct trace_event_call *call,
>  	WARN_ON(!(call->flags & TRACE_EVENT_FL_TRACEPOINT));
>  	switch (type) {
>  	case TRACE_REG_REGISTER:
> -		return tracepoint_probe_register(call->tp,
> -						 call->class->probe,
> -						 file);
> +		if (call->tp->flags & TRACEPOINT_MAY_FAULT)
> +			return tracepoint_probe_register_prio_flags(call->tp,
> +								    call->class->probe,
> +								    file,
> +								    TRACEPOINT_DEFAULT_PRIO,
> +								    TRACEPOINT_MAY_FAULT);
> +		else
> +			return tracepoint_probe_register(call->tp,
> +							 call->class->probe,
> +							 file);
>  	case TRACE_REG_UNREGISTER:
>  		tracepoint_probe_unregister(call->tp,
>  					    call->class->probe,
> @@ -543,9 +550,16 @@ int trace_event_reg(struct trace_event_call *call,
>  
>  #ifdef CONFIG_PERF_EVENTS
>  	case TRACE_REG_PERF_REGISTER:
> -		return tracepoint_probe_register(call->tp,
> -						 call->class->perf_probe,
> -						 call);
> +		if (call->tp->flags & TRACEPOINT_MAY_FAULT)
> +			return tracepoint_probe_register_prio_flags(call->tp,
> +								    call->class->perf_probe,
> +								    call,
> +								    TRACEPOINT_DEFAULT_PRIO,
> +								    TRACEPOINT_MAY_FAULT);
> +		else
> +			return tracepoint_probe_register(call->tp,
> +							 call->class->perf_probe,
> +							 call);
>  	case TRACE_REG_PERF_UNREGISTER:
>  		tracepoint_probe_unregister(call->tp,
>  					    call->class->perf_probe,

I think something like the below (which is on top of the cleanup patch
in tip/locking/core) might just do...

---
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..37cbdb19d81d 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -151,7 +151,9 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
 	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
-	{ return *_T; }
+	{ return *_T; } \
+	static inline class_##_name##_t class_##_name##_null(void) \
+	{ return NULL; }
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
 	EXTEND_CLASS(_name, _ext, \
@@ -175,6 +177,17 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 		if (!__guard_ptr(_name)(&scope)) _fail; \
 		else
 
+
+#define __guard_if(_cond, _name, var) \
+	class_##_name##_t var __cleanup(class_##_name##_destructor) = \
+		class_##_name##_null();	\
+	if (_cond) \
+		var = class_##_name##_constructor
+
+#define guard_if(_cond, _name) \
+	__guard_if(_cond, _name, __UNIQUE_ID(guard))
+
+
 /*
  * Additional helper macros for generating lock guards with types, either for
  * locks that don't have a native type (eg. RCU, preempt) or those that need a
@@ -209,6 +222,12 @@ static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
 {									\
 	return _T->lock;						\
+}									\
+									\
+static inline class_##_name##_t class_##_name##_null(void)		\
+{									\
+	class_##_name##_t _t = { };					\
+	return _t;							\
 }
 
 
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 558af4960157..8e063c9846e0 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -427,13 +427,10 @@ trace_event_raw_event_##call(void *__data, proto)			\
 	struct trace_event_raw_##call *entry;				\
 	int __data_size;						\
 									\
-	if ((tp_flags) & TRACEPOINT_MAY_FAULT) {			\
-		might_fault();						\
-		preempt_disable_notrace();				\
-	}								\
+	guard_if((tp_flags) & TRACEPOINT_MAY_FAULT, preempt_notrace)();	\
 									\
 	if (trace_trigger_soft_disabled(trace_file))			\
-		goto end;						\
+		return;							\
 									\
 	__data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
 									\
@@ -441,16 +438,13 @@ trace_event_raw_event_##call(void *__data, proto)			\
 				 sizeof(*entry) + __data_size);		\
 									\
 	if (!entry)							\
-		goto end;						\
+		return;							\
 									\
 	tstruct								\
 									\
 	{ assign; }							\
 									\
 	trace_event_buffer_commit(&fbuffer);				\
-end:									\
-	if ((tp_flags) & TRACEPOINT_MAY_FAULT)				\
-		preempt_enable_notrace();				\
 }
 
 #undef DECLARE_EVENT_CLASS
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index bf53d0d3eef9..09aec5db2e74 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -532,16 +532,11 @@ int trace_event_reg(struct trace_event_call *call,
 	WARN_ON(!(call->flags & TRACE_EVENT_FL_TRACEPOINT));
 	switch (type) {
 	case TRACE_REG_REGISTER:
-		if (call->tp->flags & TRACEPOINT_MAY_FAULT)
-			return tracepoint_probe_register_prio_flags(call->tp,
-								    call->class->probe,
-								    file,
-								    TRACEPOINT_DEFAULT_PRIO,
-								    TRACEPOINT_MAY_FAULT);
-		else
-			return tracepoint_probe_register(call->tp,
-							 call->class->probe,
-							 file);
+		return tracepoint_probe_register_prio_flags(call->tp,
+							    call->class->probe,
+							    file,
+							    TRACEPOINT_DEFAULT_PRIO,
+							    call->tp->flags & TRACEPOINT_MAY_FAULT);
 	case TRACE_REG_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->probe,
@@ -550,16 +545,11 @@ int trace_event_reg(struct trace_event_call *call,
 
 #ifdef CONFIG_PERF_EVENTS
 	case TRACE_REG_PERF_REGISTER:
-		if (call->tp->flags & TRACEPOINT_MAY_FAULT)
-			return tracepoint_probe_register_prio_flags(call->tp,
-								    call->class->perf_probe,
-								    call,
-								    TRACEPOINT_DEFAULT_PRIO,
-								    TRACEPOINT_MAY_FAULT);
-		else
-			return tracepoint_probe_register(call->tp,
-							 call->class->perf_probe,
-							 call);
+		return tracepoint_probe_register_prio_flags(call->tp,
+							    call->class->perf_probe,
+							    call,
+							    TRACEPOINT_DEFAULT_PRIO,
+							    call->tp->flags & TRACEPOINT_MAY_FAULT);
 	case TRACE_REG_PERF_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->perf_probe,

