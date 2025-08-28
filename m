Return-Path: <bpf+bounces-66872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D36B3A977
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE1BA04789
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3916F2701CB;
	Thu, 28 Aug 2025 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvQg9Z8D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99221265281;
	Thu, 28 Aug 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404216; cv=none; b=GasdygCQrQwD4j1y8S4IqcOfNGXr5axsq8pxIhRBJCnjukl5PUKmaVojo7b6eacbld6YPFMhng5NFc17dZ8U27flFVbiEW4ZIj4DOqHRnn5RtPmx5F7KLpkJsuQ5I6splfosko0PZcnTvRNYEi25uKSyiQEkfmvicftstpVwbXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404216; c=relaxed/simple;
	bh=sla6hrT5B1o2zSr6cxHddWYwxQpQ0gR9p6xSsoo1ILs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OphbGUm3E6vm+PA13XXwEB3F+yWsBUoeFcfrFxH7EBlxxj0G9/RVOd0f8FaES8dGF1bRCc6AxDl1qCYtkFAfqDBBZX34q187ROEnJWT11b+IDjw7StyLKy7EmS6RyOLUWf3QoPNgXk/YuR2xKZftHBX0xLsLGzKRpOyrLHMrlcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvQg9Z8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED03C4CEFC;
	Thu, 28 Aug 2025 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756404216;
	bh=sla6hrT5B1o2zSr6cxHddWYwxQpQ0gR9p6xSsoo1ILs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=gvQg9Z8DET3z9HDTcIblVdaupGDvMaULGsKaGfdv3bsCKE7JkpwHDooylvvMtL6mP
	 1l7uEheIzMQAe9oN3E09+Y7Dj65Yg0z+aS3I+AWBsbLYHajUpzQVxzi9mJwsCBGGle
	 fO1n6UxcR4HG7gm2Y1LXqsj1e9h/lXWNo+jeJGgrpbruaFiIv/6Ikg8IepiJRguoNO
	 udASwa34ablTdILzOigw4KujWRU3QBX38ZdE3S8cerX4ULeVDXi0LXvJYZH5i0KijO
	 1xU5AuzfkblcYmeF+tU0Q2pfuiWE2vM3l+bOpozvUFbVdS8U/KLAd7matII++/GCvE
	 +sY0+7e2qgdOg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urgyb-00000004GCI-08QY;
	Thu, 28 Aug 2025 14:03:57 -0400
Message-ID: <20250828180356.882470556@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 28 Aug 2025 14:03:03 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>,
 "Carlos O'Donell" <codonell@redhat.com>
Subject: [PATCH v6 3/6] tracing: Implement deferred user space stacktracing
References: <20250828180300.591225320@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Use the unwind_deferred_*() interface to be able to trace deferred user
space stacks. This creates two new ftrace events:

  user_unwind_cookie
  user_unwind_stack

The user_unwind_cookie will record into the ring buffer the cookie given
from unwind_deferred_request(), and the user_unwind_stack will record into
the ring buffer the user space stack as well as the cookie associated with
it.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v5: https://lore.kernel.org/20250424192613.356969984@goodmis.org

- Have the userstacktrace_delay option not depend on the userstacktrace
  option.

- Do not expose the userstacktrace_delay option if it's not supported.

 kernel/trace/trace.c         | 91 ++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.h         | 20 ++++++++
 kernel/trace/trace_entries.h | 24 ++++++++++
 kernel/trace/trace_export.c  | 23 +++++++++
 kernel/trace/trace_output.c  | 72 ++++++++++++++++++++++++++++
 5 files changed, 227 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2cca29c9863d..e5b7db19aa53 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3128,6 +3128,66 @@ EXPORT_SYMBOL_GPL(trace_dump_stack);
 #ifdef CONFIG_USER_STACKTRACE_SUPPORT
 static DEFINE_PER_CPU(int, user_stack_count);
 
+static void trace_user_unwind_callback(struct unwind_work *unwind,
+				       struct unwind_stacktrace *trace,
+				       u64 ctx_cookie)
+{
+	struct trace_array *tr = container_of(unwind, struct trace_array, unwinder);
+	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	struct userunwind_stack_entry *entry;
+	struct ring_buffer_event *event;
+	unsigned int trace_ctx;
+	unsigned long *caller;
+	unsigned int offset;
+	int len;
+	int i;
+
+	if (!(tr->trace_flags & TRACE_ITER_USERSTACKTRACE_DELAY))
+		return;
+
+	len = trace->nr * sizeof(unsigned long) + sizeof(*entry);
+
+	trace_ctx = tracing_gen_ctx();
+	event = __trace_buffer_lock_reserve(buffer, TRACE_USER_UNWIND_STACK,
+					    len, trace_ctx);
+	if (!event)
+		return;
+
+	entry	= ring_buffer_event_data(event);
+
+	entry->cookie = ctx_cookie;
+
+	offset = sizeof(*entry);
+	len = sizeof(unsigned long) * trace->nr;
+
+	entry->__data_loc_stack = offset | (len << 16);
+	caller = (void *)entry + offset;
+
+	for (i = 0; i < trace->nr; i++) {
+		caller[i] = trace->entries[i];
+	}
+
+	__buffer_unlock_commit(buffer, event);
+}
+
+static void
+ftrace_trace_userstack_delay(struct trace_array *tr,
+			     struct trace_buffer *buffer, unsigned int trace_ctx)
+{
+	struct userunwind_cookie_entry *entry;
+	struct ring_buffer_event *event;
+
+	event = __trace_buffer_lock_reserve(buffer, TRACE_USER_UNWIND_COOKIE,
+					    sizeof(*entry), trace_ctx);
+	if (!event)
+		return;
+	entry	= ring_buffer_event_data(event);
+
+	unwind_deferred_request(&tr->unwinder, &entry->cookie);
+
+	__buffer_unlock_commit(buffer, event);
+}
+
 static void
 ftrace_trace_userstack(struct trace_array *tr,
 		       struct trace_buffer *buffer, unsigned int trace_ctx)
@@ -3135,13 +3195,18 @@ ftrace_trace_userstack(struct trace_array *tr,
 	struct ring_buffer_event *event;
 	struct userstack_entry *entry;
 
-	if (!(tr->trace_flags & TRACE_ITER_USERSTACKTRACE))
-		return;
-
 	/* No point doing user space stacktraces on kernel threads */
 	if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
 		return;
 
+	if (tr->trace_flags & TRACE_ITER_USERSTACKTRACE_DELAY) {
+		ftrace_trace_userstack_delay(tr, buffer, trace_ctx);
+		return;
+	}
+
+	if (!(tr->trace_flags & TRACE_ITER_USERSTACKTRACE))
+		return;
+
 	/*
 	 * NMIs can not handle page faults, even with fix ups.
 	 * The save user stack can (and often does) fault.
@@ -5215,6 +5280,17 @@ int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
 	return 0;
 }
 
+static int update_unwind_deferred(struct trace_array *tr, int enabled)
+{
+	if (enabled) {
+		return unwind_deferred_init(&tr->unwinder,
+					    trace_user_unwind_callback);
+	} else {
+		unwind_deferred_cancel(&tr->unwinder);
+		return 0;
+	}
+}
+
 int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 {
 	if ((mask == TRACE_ITER_RECORD_TGID) ||
@@ -5251,6 +5327,12 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 		}
 	}
 
+	if (mask == TRACE_ITER_USERSTACKTRACE_DELAY) {
+		int ret = update_unwind_deferred(tr, enabled);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (mask == TRACE_ITER_COPY_MARKER)
 		update_marker_trace(tr, enabled);
 
@@ -10002,6 +10084,9 @@ static int __remove_instance(struct trace_array *tr)
 	if (tr->ref > 1 || (tr->current_trace && tr->trace_ref))
 		return -EBUSY;
 
+	if ((tr->flags & TRACE_ITER_USERSTACKTRACE_DELAY))
+		unwind_deferred_cancel(&tr->unwinder);
+
 	list_del(&tr->list);
 
 	/* Disable all the flags that were enabled coming in */
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0fd2559ff119..940107ba618a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/clocksource.h>
 #include <linux/ring_buffer.h>
+#include <linux/unwind_deferred.h>
 #include <linux/mmiotrace.h>
 #include <linux/tracepoint.h>
 #include <linux/ftrace.h>
@@ -49,7 +50,10 @@ enum trace_type {
 	TRACE_GRAPH_ENT,
 	TRACE_GRAPH_RETADDR_ENT,
 	TRACE_USER_STACK,
+	/* trace-cmd manually adds blktrace after USER_STACK */
 	TRACE_BLK,
+	TRACE_USER_UNWIND_STACK,
+	TRACE_USER_UNWIND_COOKIE,
 	TRACE_BPUTS,
 	TRACE_HWLAT,
 	TRACE_OSNOISE,
@@ -92,6 +96,9 @@ enum trace_type {
 #undef __array_desc
 #define __array_desc(type, container, item, size)
 
+#undef __dynamic_array
+#define __dynamic_array(type, item)	u32	__data_loc_##item;
+
 #undef __dynamic_field
 #define __dynamic_field(type, item)	type	item[];
 
@@ -435,6 +442,7 @@ struct trace_array {
 	struct cond_snapshot	*cond_snapshot;
 #endif
 	struct trace_func_repeats	__percpu *last_func_repeats;
+	struct unwind_work	unwinder;
 	/*
 	 * On boot up, the ring buffer is set to the minimum size, so that
 	 * we do not waste memory on systems that are not using tracing.
@@ -526,6 +534,9 @@ extern void __ftrace_bad_type(void);
 		IF_ASSIGN(var, ent, struct ctx_switch_entry, 0);	\
 		IF_ASSIGN(var, ent, struct stack_entry, TRACE_STACK);	\
 		IF_ASSIGN(var, ent, struct userstack_entry, TRACE_USER_STACK);\
+		IF_ASSIGN(var, ent, struct userunwind_stack_entry, TRACE_USER_UNWIND_STACK);\
+		IF_ASSIGN(var, ent, struct userunwind_cookie_entry, TRACE_USER_UNWIND_COOKIE);\
+		IF_ASSIGN(var, ent, struct userstack_entry, TRACE_USER_STACK);\
 		IF_ASSIGN(var, ent, struct print_entry, TRACE_PRINT);	\
 		IF_ASSIGN(var, ent, struct bprint_entry, TRACE_BPRINT);	\
 		IF_ASSIGN(var, ent, struct bputs_entry, TRACE_BPUTS);	\
@@ -1359,6 +1370,14 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 # define STACK_FLAGS
 #endif
 
+#ifdef CONFIG_UNWIND_USER
+# define USERSTACK_DELAY					\
+	C(USERSTACKTRACE_DELAY,	"userstacktrace_delay"),
+#else
+# define USERSTACK_DELAY
+# define TRACE_ITER_USERSTACKTRACE_DELAY		0
+#endif
+
 /*
  * trace_iterator_flags is an enumeration that defines bit
  * positions into trace_flags that controls the output.
@@ -1379,6 +1398,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(PRINTK,		"trace_printk"),	\
 		C(ANNOTATE,		"annotate"),		\
 		C(USERSTACKTRACE,	"userstacktrace"),	\
+		USERSTACK_DELAY					\
 		C(SYM_USEROBJ,		"sym-userobj"),		\
 		C(PRINTK_MSGONLY,	"printk-msg-only"),	\
 		C(CONTEXT_INFO,		"context-info"),   /* Print pid/cpu/time */ \
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 5cf80f6c704a..40dc53ead0a8 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -249,6 +249,30 @@ FTRACE_ENTRY(user_stack, userstack_entry,
 		 (void *)__entry->caller[6], (void *)__entry->caller[7])
 );
 
+FTRACE_ENTRY(user_unwind_stack, userunwind_stack_entry,
+
+	TRACE_USER_UNWIND_STACK,
+
+	F_STRUCT(
+		__field(		u64,		cookie	)
+		__dynamic_array(	unsigned long,	stack	)
+	),
+
+	F_printk("cookie=%lld\n%s", __entry->cookie,
+		 __print_dynamic_array(stack, sizeof(unsigned long)))
+);
+
+FTRACE_ENTRY(user_unwind_cookie, userunwind_cookie_entry,
+
+	TRACE_USER_UNWIND_COOKIE,
+
+	F_STRUCT(
+		__field(		u64,		cookie	)
+	),
+
+	F_printk("cookie=%lld", __entry->cookie)
+);
+
 /*
  * trace_printk entry:
  */
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index d9d41e3ba379..831999f84e2c 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -57,6 +57,9 @@ static int ftrace_event_register(struct trace_event_call *call,
 #undef __array_desc
 #define __array_desc(type, container, item, size)	type item[size];
 
+#undef __dynamic_array
+#define __dynamic_array(type, item)			u32 __data_loc_##item;
+
 #undef __dynamic_field
 #define __dynamic_field(type, item)			type item[];
 
@@ -66,6 +69,16 @@ static int ftrace_event_register(struct trace_event_call *call,
 #undef F_printk
 #define F_printk(fmt, args...) fmt, args
 
+/* Only used for ftrace event format output */
+static inline char * __print_dynamic_array(int array, size_t size)
+{
+	return NULL;
+}
+
+#undef __print_dynamic_array
+#define __print_dynamic_array(array, el_size)				\
+	__print_dynamic_array(__entry->__data_loc_##array, el_size)
+
 #undef FTRACE_ENTRY
 #define FTRACE_ENTRY(name, struct_name, id, tstruct, print)		\
 struct ____ftrace_##name {						\
@@ -74,6 +87,7 @@ struct ____ftrace_##name {						\
 static void __always_unused ____ftrace_check_##name(void)		\
 {									\
 	struct ____ftrace_##name *__entry = NULL;			\
+	struct trace_seq __maybe_unused *p = NULL;			\
 									\
 	/* force compile-time check on F_printk() */			\
 	printk(print);							\
@@ -123,6 +137,12 @@ static void __always_unused ____ftrace_check_##name(void)		\
 #undef __array_desc
 #define __array_desc(_type, _container, _item, _len) __array(_type, _item, _len)
 
+#undef __dynamic_array
+#define __dynamic_array(_type, _item) {					\
+	.type = "__data_loc " #_type "[]", .name = #_item,		\
+	.size = 4, .align = __alignof__(4),				\
+	is_signed_type(_type), .filter_type = FILTER_OTHER },
+
 #undef __dynamic_field
 #define __dynamic_field(_type, _item) {					\
 	.type = #_type "[]", .name = #_item,				\
@@ -161,6 +181,9 @@ static struct trace_event_fields ftrace_event_fields_##name[] = {	\
 #undef __array_desc
 #define __array_desc(type, container, item, len)
 
+#undef __dynamic_array
+#define __dynamic_array(type, item)
+
 #undef __dynamic_field
 #define __dynamic_field(type, item)
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 97db0b0ccf3e..9489537533f7 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1404,6 +1404,58 @@ static struct trace_event trace_stack_event = {
 };
 
 /* TRACE_USER_STACK */
+static enum print_line_t trace_user_unwind_stack_print(struct trace_iterator *iter,
+						int flags, struct trace_event *event)
+{
+	struct userunwind_stack_entry *field;
+	struct trace_seq *s = &iter->seq;
+	unsigned long *caller;
+	unsigned int offset;
+	unsigned int len;
+	unsigned int caller_cnt;
+	unsigned int i;
+
+	trace_assign_type(field, iter->ent);
+
+	trace_seq_puts(s, "<user stack unwind>\n");
+
+	trace_seq_printf(s, "cookie=%llx\n", field->cookie);
+
+	/* The stack field is a dynamic pointer */
+	offset = field->__data_loc_stack;
+	len = offset >> 16;
+	offset = offset & 0xffff;
+	caller_cnt = len / sizeof(*caller);
+
+	caller = (void *)iter->ent + offset;
+
+	for (i = 0; i < caller_cnt; i++) {
+		unsigned long ip = caller[i];
+
+		if (!ip || trace_seq_has_overflowed(s))
+			break;
+
+		trace_seq_puts(s, " => ");
+		seq_print_user_ip(s, NULL, ip, flags);
+		trace_seq_putc(s, '\n');
+	}
+
+	return trace_handle_return(s);
+}
+
+static enum print_line_t trace_user_unwind_cookie_print(struct trace_iterator *iter,
+						 int flags, struct trace_event *event)
+{
+	struct userunwind_cookie_entry *field;
+	struct trace_seq *s = &iter->seq;
+
+	trace_assign_type(field, iter->ent);
+
+	trace_seq_printf(s, "cookie=%llx\n", field->cookie);
+
+	return trace_handle_return(s);
+}
+
 static enum print_line_t trace_user_stack_print(struct trace_iterator *iter,
 						int flags, struct trace_event *event)
 {
@@ -1447,6 +1499,24 @@ static enum print_line_t trace_user_stack_print(struct trace_iterator *iter,
 	return trace_handle_return(s);
 }
 
+static struct trace_event_functions trace_userunwind_stack_funcs = {
+	.trace		= trace_user_unwind_stack_print,
+};
+
+static struct trace_event trace_userunwind_stack_event = {
+	.type		= TRACE_USER_UNWIND_STACK,
+	.funcs		= &trace_userunwind_stack_funcs,
+};
+
+static struct trace_event_functions trace_userunwind_cookie_funcs = {
+	.trace		= trace_user_unwind_cookie_print,
+};
+
+static struct trace_event trace_userunwind_cookie_event = {
+	.type		= TRACE_USER_UNWIND_COOKIE,
+	.funcs		= &trace_userunwind_cookie_funcs,
+};
+
 static struct trace_event_functions trace_user_stack_funcs = {
 	.trace		= trace_user_stack_print,
 };
@@ -1846,6 +1916,8 @@ static struct trace_event *events[] __initdata = {
 	&trace_ctx_event,
 	&trace_wake_event,
 	&trace_stack_event,
+	&trace_userunwind_cookie_event,
+	&trace_userunwind_stack_event,
 	&trace_user_stack_event,
 	&trace_bputs_event,
 	&trace_bprint_event,
-- 
2.50.1



