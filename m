Return-Path: <bpf+bounces-56232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B60A93903
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 16:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7753BE74F
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F75B1D6DDD;
	Fri, 18 Apr 2025 14:59:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9E1D5165;
	Fri, 18 Apr 2025 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744988365; cv=none; b=RAKKz8sm3z/Z6DWFfYLMYem0LpxBQTnJPK3HF/mgdqKgc4L43DAflUOlOoErSJ7dSJlTb+4NSfdglk9SC/WOaMMACzD2Xqv3qGJmFd/WxJ467Haxz40zJOti6SBJ3mTWVweNkx4+H2Gy/xQGG1aH1qoAwvPovDBhyWOcnS5W9E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744988365; c=relaxed/simple;
	bh=zI4zgny698iLQgZdjN1Cqg7bZA8XtHJ4zrXxnFQdX+o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PgEFNASnqKQzMtDzpglMnohwRpks58TGb+057pX3ydbVld28AP8vNoU55ow0offIxwnAWBCD5E4xCD8pi2meMLI8llERto8uoOKXG8ZHmfif+SEAWGPXwEiFXi4Ew5YoyR7vYPsou2/SBFcqyA40DTVLMRXeNyZbJLTusC2hUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDA4C4CEE2;
	Fri, 18 Apr 2025 14:59:23 +0000 (UTC)
Date: Fri, 18 Apr 2025 11:01:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, David Ahern
 <dsahern@kernel.org>, Juri Lelli <juri.lelli@gmail.com>, Breno Leitao
 <leitao@debian.org>, netdev@vger.kernel.org, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Gabriele Monaco
 <gmonaco@redhat.com>
Subject: [RFC][PATCH] tracepoint: Have tracepoints created with
 DECLARE_TRACE() have _tp suffix
Message-ID: <20250418110104.12af6883@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

Most tracepoints in the kernel are created with TRACE_EVENT(). The
TRACE_EVENT() macro (and DECLARE_EVENT_CLASS() and DEFINE_EVENT() where in
reality, TRACE_EVENT() is just a helper macro that calls those other two
macros), will create not only a tracepoint (the function trace_<event>()
used in the kernel), it also exposes the tracepoint to user space along
with defining what fields will be saved by that tracepoint.

There are a few places that tracepoints are created in the kernel that are
not exposed to userspace via tracefs. They can only be accessed from code
within the kernel. These tracepoints are created with DEFINE_TRACE()

Most of these tracepoints end with "_tp". This is useful as when the
developer sees that, they know that the tracepoint is for in-kernel only
and is not exposed to user space.

Instead of making this only a process to add "_tp", enforce it by making
the DECLARE_TRACE() append the "_tp" suffix to the tracepoint. This
requires adding DECLARE_TRACE_EVENT() macros for the TRACE_EVENT() macro
to use that keeps the original name.

Link: https://lore.kernel.org/all/20250418083351.20a60e64@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h   | 38 ++++++++++++++++++++++++------------
 include/trace/bpf_probe.h    |  4 ++--
 include/trace/define_trace.h | 17 +++++++++++++++-
 include/trace/events/sched.h | 30 ++++++++++++++--------------
 include/trace/events/tcp.h   |  2 +-
 5 files changed, 60 insertions(+), 31 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index a351763e6965..826ce3f8e1f8 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -464,16 +464,30 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #endif
 
 #define DECLARE_TRACE(name, proto, args)				\
-	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
+	__DECLARE_TRACE(name##_tp, PARAMS(proto), PARAMS(args),		\
 			cpu_online(raw_smp_processor_id()),		\
 			PARAMS(void *__data, proto))
 
 #define DECLARE_TRACE_CONDITION(name, proto, args, cond)		\
-	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
+	__DECLARE_TRACE(name##_tp, PARAMS(proto), PARAMS(args),		\
 			cpu_online(raw_smp_processor_id()) && (PARAMS(cond)), \
 			PARAMS(void *__data, proto))
 
 #define DECLARE_TRACE_SYSCALL(name, proto, args)			\
+	__DECLARE_TRACE_SYSCALL(name##_tp, PARAMS(proto), PARAMS(args),	\
+				PARAMS(void *__data, proto))
+
+#define DECLARE_TRACE_EVENT(name, proto, args)				\
+	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
+			cpu_online(raw_smp_processor_id()),		\
+			PARAMS(void *__data, proto))
+
+#define DECLARE_TRACE_EVENT_CONDITION(name, proto, args, cond)		\
+	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
+			cpu_online(raw_smp_processor_id()) && (PARAMS(cond)), \
+			PARAMS(void *__data, proto))
+
+#define DECLARE_TRACE_EVENT_SYSCALL(name, proto, args)			\
 	__DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args),	\
 				PARAMS(void *__data, proto))
 
@@ -591,32 +605,32 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #define DECLARE_EVENT_CLASS(name, proto, args, tstruct, assign, print)
 #define DEFINE_EVENT(template, name, proto, args)		\
-	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
+	DECLARE_TRACE_EVENT(name, PARAMS(proto), PARAMS(args))
 #define DEFINE_EVENT_FN(template, name, proto, args, reg, unreg)\
-	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
+	DECLARE_TRACE_EVENT(name, PARAMS(proto), PARAMS(args))
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
-	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
+	DECLARE_TRACE_EVENT(name, PARAMS(proto), PARAMS(args))
 #define DEFINE_EVENT_CONDITION(template, name, proto,		\
 			       args, cond)			\
-	DECLARE_TRACE_CONDITION(name, PARAMS(proto),		\
+	DECLARE_TRACE_EVENT_CONDITION(name, PARAMS(proto),	\
 				PARAMS(args), PARAMS(cond))
 
 #define TRACE_EVENT(name, proto, args, struct, assign, print)	\
-	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
+	DECLARE_TRACE_EVENT(name, PARAMS(proto), PARAMS(args))
 #define TRACE_EVENT_FN(name, proto, args, struct,		\
 		assign, print, reg, unreg)			\
-	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
-#define TRACE_EVENT_FN_COND(name, proto, args, cond, struct,		\
+	DECLARE_TRACE_EVENT(name, PARAMS(proto), PARAMS(args))
+#define TRACE_EVENT_FN_COND(name, proto, args, cond, struct,	\
 		assign, print, reg, unreg)			\
-	DECLARE_TRACE_CONDITION(name, PARAMS(proto),	\
+	DECLARE_TRACE_EVENT_CONDITION(name, PARAMS(proto),	\
 			PARAMS(args), PARAMS(cond))
 #define TRACE_EVENT_CONDITION(name, proto, args, cond,		\
 			      struct, assign, print)		\
-	DECLARE_TRACE_CONDITION(name, PARAMS(proto),		\
+	DECLARE_TRACE_EVENT_CONDITION(name, PARAMS(proto),	\
 				PARAMS(args), PARAMS(cond))
 #define TRACE_EVENT_SYSCALL(name, proto, args, struct, assign,	\
 			    print, reg, unreg)			\
-	DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args))
+	DECLARE_TRACE_EVENT_SYSCALL(name, PARAMS(proto), PARAMS(args))
 
 #define TRACE_EVENT_FLAGS(event, flag)
 
diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 183fa2aa2935..fbfe83b939ac 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -119,8 +119,8 @@ static inline void bpf_test_buffer_##call(void)				\
 
 #undef DECLARE_TRACE
 #define DECLARE_TRACE(call, proto, args)				\
-	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))		\
-	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0)
+	__BPF_DECLARE_TRACE(call##_tp, PARAMS(proto), PARAMS(args))		\
+	__DEFINE_EVENT(call##_tp, call##_tp, PARAMS(proto), PARAMS(args), 0)
 
 #undef DECLARE_TRACE_WRITABLE
 #define DECLARE_TRACE_WRITABLE(call, proto, args, size) \
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index ed52d0506c69..b2ba5a80583f 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -74,10 +74,18 @@
 
 #undef DECLARE_TRACE
 #define DECLARE_TRACE(name, proto, args)	\
-	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
+	DEFINE_TRACE(name##_tp, PARAMS(proto), PARAMS(args))
 
 #undef DECLARE_TRACE_CONDITION
 #define DECLARE_TRACE_CONDITION(name, proto, args, cond)	\
+	DEFINE_TRACE(name##_tp, PARAMS(proto), PARAMS(args))
+
+#undef DECLARE_TRACE_EVENT
+#define DECLARE_TRACE_EVENT(name, proto, args)	\
+	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
+
+#undef DECLARE_TRACE_EVENT_CONDITION
+#define DECLARE_TRACE_EVENT_CONDITION(name, proto, args, cond)	\
 	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
 /* If requested, create helpers for calling these tracepoints from Rust. */
@@ -115,6 +123,11 @@
 #undef DECLARE_TRACE_CONDITION
 #define DECLARE_TRACE_CONDITION(name, proto, args, cond)
 
+#undef DECLARE_TRACE_EVENT
+#define DECLARE_TRACE_EVENT(name, proto, args)
+#undef DECLARE_TRACE_EVENT_CONDITION
+#define DECLARE_TRACE_EVENT_CONDITION(name, proto, args, cond)
+
 #ifdef TRACEPOINTS_ENABLED
 #include <trace/trace_events.h>
 #include <trace/perf.h>
@@ -136,6 +149,8 @@
 #undef TRACE_HEADER_MULTI_READ
 #undef DECLARE_TRACE
 #undef DECLARE_TRACE_CONDITION
+#undef DECLARE_TRACE_EVENT
+#undef DECLARE_TRACE_EVENT_CONDITION
 
 /* Only undef what we defined in this file */
 #ifdef UNDEF_TRACE_INCLUDE_FILE
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 8994e97d86c1..152fc8b37aa5 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -773,64 +773,64 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
  *
  * Postfixed with _tp to make them easily identifiable in the code.
  */
-DECLARE_TRACE(pelt_cfs_tp,
+DECLARE_TRACE(pelt_cfs,
 	TP_PROTO(struct cfs_rq *cfs_rq),
 	TP_ARGS(cfs_rq));
 
-DECLARE_TRACE(pelt_rt_tp,
+DECLARE_TRACE(pelt_rt,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
 
-DECLARE_TRACE(pelt_dl_tp,
+DECLARE_TRACE(pelt_dl,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
 
-DECLARE_TRACE(pelt_hw_tp,
+DECLARE_TRACE(pelt_hw,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
 
-DECLARE_TRACE(pelt_irq_tp,
+DECLARE_TRACE(pelt_irq,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
 
-DECLARE_TRACE(pelt_se_tp,
+DECLARE_TRACE(pelt_se,
 	TP_PROTO(struct sched_entity *se),
 	TP_ARGS(se));
 
-DECLARE_TRACE(sched_cpu_capacity_tp,
+DECLARE_TRACE(sched_cpu_capacity,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
 
-DECLARE_TRACE(sched_overutilized_tp,
+DECLARE_TRACE(sched_overutilized,
 	TP_PROTO(struct root_domain *rd, bool overutilized),
 	TP_ARGS(rd, overutilized));
 
-DECLARE_TRACE(sched_util_est_cfs_tp,
+DECLARE_TRACE(sched_util_est_cfs,
 	TP_PROTO(struct cfs_rq *cfs_rq),
 	TP_ARGS(cfs_rq));
 
-DECLARE_TRACE(sched_util_est_se_tp,
+DECLARE_TRACE(sched_util_est_se,
 	TP_PROTO(struct sched_entity *se),
 	TP_ARGS(se));
 
-DECLARE_TRACE(sched_update_nr_running_tp,
+DECLARE_TRACE(sched_update_nr_running,
 	TP_PROTO(struct rq *rq, int change),
 	TP_ARGS(rq, change));
 
-DECLARE_TRACE(sched_compute_energy_tp,
+DECLARE_TRACE(sched_compute_energy,
 	TP_PROTO(struct task_struct *p, int dst_cpu, unsigned long energy,
 		 unsigned long max_util, unsigned long busy_time),
 	TP_ARGS(p, dst_cpu, energy, max_util, busy_time));
 
-DECLARE_TRACE(sched_entry_tp,
+DECLARE_TRACE(sched_entry,
 	TP_PROTO(bool preempt, unsigned long ip),
 	TP_ARGS(preempt, ip));
 
-DECLARE_TRACE(sched_exit_tp,
+DECLARE_TRACE(sched_exit,
 	TP_PROTO(bool is_switch, unsigned long ip),
 	TP_ARGS(is_switch, ip));
 
-DECLARE_TRACE_CONDITION(sched_set_state_tp,
+DECLARE_TRACE_CONDITION(sched_set_state,
 	TP_PROTO(struct task_struct *tsk, int state),
 	TP_ARGS(tsk, state),
 	TP_CONDITION(!!(tsk->__state) != !!state));
diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 1a40c41ff8c3..4f9fa1b5b89b 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -259,7 +259,7 @@ TRACE_EVENT(tcp_retransmit_synack,
 		  __entry->saddr_v6, __entry->daddr_v6)
 );
 
-DECLARE_TRACE(tcp_cwnd_reduction_tp,
+DECLARE_TRACE(tcp_cwnd_reduction,
 	TP_PROTO(const struct sock *sk, int newly_acked_sacked,
 		 int newly_lost, int flag),
 	TP_ARGS(sk, newly_acked_sacked, newly_lost, flag)
-- 
2.47.2


