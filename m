Return-Path: <bpf+bounces-57984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0252FAB253B
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 22:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7168917F7D9
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 20:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1244D22F397;
	Sat, 10 May 2025 20:37:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F911712;
	Sat, 10 May 2025 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746909434; cv=none; b=k7SlbBfJ7iEn6TCPVeKwXsQFf7VutG/LF+MAg3jG4Z6DECRzoDRT8mnWCAr2ETsr19TO8j6gxxrcCCnQRwkPxvllHEVMS/pti04WrAiOtSzAR/Wy5GBTXbRGax8Q9dHc13oX0HYoqaWh6hGTUkSN6KpAPTLMTcHyZZR9qNlEUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746909434; c=relaxed/simple;
	bh=O+SlaKdtZp79RC5iriXxoc3snbcV8rCFYzStpKSUxck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XhiFYlNThtldQXe+ZLEJZ5fu61qHLpfAftXzEKcM+Kdsit4RCAP9ZVe96W9xffi6U91W69ZhOHEGd+W0f1D/PZUrE/O1Mtv4f6z5+/fSkFaMTcKB2+MxpTsiszquxytm2Ix+62gNnZyDFIHloQklBwqMa2V5hFIgDMqK7bImqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B876C4CEE2;
	Sat, 10 May 2025 20:37:12 +0000 (UTC)
Date: Sat, 10 May 2025 16:37:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, netdev
 <netdev@vger.kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 David Ahern <dsahern@kernel.org>, Juri Lelli <juri.lelli@gmail.com>, Breno
 Leitao <leitao@debian.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Gabriele Monaco <gmonaco@redhat.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4] tracepoint: Have tracepoints created with
 DECLARE_TRACE() have _tp suffix
Message-ID: <20250510163730.092fad5b@gandalf.local.home>
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
(meaning it can only be accessed inside the kernel, either directly by the
kernel or indirectly via modules and BPF programs) and is not exposed to
user space.

Instead of making this only a process to add "_tp", enforce it by making
the DECLARE_TRACE() append the "_tp" suffix to the tracepoint. This
requires adding DECLARE_TRACE_EVENT() macros for the TRACE_EVENT() macro
to use that keeps the original name.

Link: https://lore.kernel.org/all/20250418083351.20a60e64@gandalf.local.home/

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v3: https://lore.kernel.org/20250510092342.77371990@gandalf.local.home

- Added "_tp" suffix in bpf tests to:

  tp_btf/bpf_testmod_test_raw_tp_null in raw_tp_null.c
  tp_btf/bpf_testmod_test_raw_tp_null in raw_tp_null_fail.c
  raw_tp.w/bpf_testmod_test_writable_bare in test_module_attach.c

  Hopefully this passes the bpf verifier tests.

 Documentation/trace/tracepoints.rst           | 17 ++++++---
 include/linux/tracepoint.h                    | 38 +++++++++++++------
 include/trace/bpf_probe.h                     |  8 ++--
 include/trace/define_trace.h                  | 17 ++++++++-
 include/trace/events/sched.h                  | 30 +++++++--------
 include/trace/events/tcp.h                    |  2 +-
 .../testing/selftests/bpf/progs/raw_tp_null.c |  2 +-
 .../selftests/bpf/progs/raw_tp_null_fail.c    |  2 +-
 .../selftests/bpf/progs/test_module_attach.c  |  4 +-
 .../bpf/progs/test_tp_btf_nullable.c          |  4 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  8 ++--
 11 files changed, 83 insertions(+), 49 deletions(-)

diff --git a/Documentation/trace/tracepoints.rst b/Documentation/trace/tracepoints.rst
index decabcc77b56..b35c40e3abbe 100644
--- a/Documentation/trace/tracepoints.rst
+++ b/Documentation/trace/tracepoints.rst
@@ -71,7 +71,7 @@ In subsys/file.c (where the tracing statement must be added)::
 	void somefct(void)
 	{
 		...
-		trace_subsys_eventname(arg, task);
+		trace_subsys_eventname_tp(arg, task);
 		...
 	}
 
@@ -129,12 +129,12 @@ within an if statement with the following::
 		for (i = 0; i < count; i++)
 			tot += calculate_nuggets();
 
-		trace_foo_bar(tot);
+		trace_foo_bar_tp(tot);
 	}
 
-All trace_<tracepoint>() calls have a matching trace_<tracepoint>_enabled()
+All trace_<tracepoint>_tp() calls have a matching trace_<tracepoint>_enabled()
 function defined that returns true if the tracepoint is enabled and
-false otherwise. The trace_<tracepoint>() should always be within the
+false otherwise. The trace_<tracepoint>_tp() should always be within the
 block of the if (trace_<tracepoint>_enabled()) to prevent races between
 the tracepoint being enabled and the check being seen.
 
@@ -143,7 +143,10 @@ the static_key of the tracepoint to allow the if statement to be implemented
 with jump labels and avoid conditional branches.
 
 .. note:: The convenience macro TRACE_EVENT provides an alternative way to
-      define tracepoints. Check http://lwn.net/Articles/379903,
+      define tracepoints. Note, DECLARE_TRACE(foo) creates a function
+      "trace_foo_tp()" whereas TRACE_EVENT(foo) creates a function
+      "trace_foo()", and also exposes the tracepoint as a trace event in
+      /sys/kernel/tracing/events directory.  Check http://lwn.net/Articles/379903,
       http://lwn.net/Articles/381064 and http://lwn.net/Articles/383362
       for a series of articles with more details.
 
@@ -159,7 +162,9 @@ In a C file::
 
 	void do_trace_foo_bar_wrapper(args)
 	{
-		trace_foo_bar(args);
+		trace_foo_bar_tp(args); // for tracepoints created via DECLARE_TRACE
+					//   or
+		trace_foo_bar(args);    // for tracepoints created via TRACE_EVENT
 	}
 
 In the header file::
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
index 183fa2aa2935..9391d54d3f12 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -119,14 +119,14 @@ static inline void bpf_test_buffer_##call(void)				\
 
 #undef DECLARE_TRACE
 #define DECLARE_TRACE(call, proto, args)				\
-	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))		\
-	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0)
+	__BPF_DECLARE_TRACE(call##_tp, PARAMS(proto), PARAMS(args))		\
+	__DEFINE_EVENT(call##_tp, call##_tp, PARAMS(proto), PARAMS(args), 0)
 
 #undef DECLARE_TRACE_WRITABLE
 #define DECLARE_TRACE_WRITABLE(call, proto, args, size) \
 	__CHECK_WRITABLE_BUF_SIZE(call, PARAMS(proto), PARAMS(args), size) \
-	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args)) \
-	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), size)
+	__BPF_DECLARE_TRACE(call##_tp, PARAMS(proto), PARAMS(args)) \
+	__DEFINE_EVENT(call##_tp, call##_tp, PARAMS(proto), PARAMS(args), size)
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
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
diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null.c b/tools/testing/selftests/bpf/progs/raw_tp_null.c
index 5927054b6dd9..efa416f53968 100644
--- a/tools/testing/selftests/bpf/progs/raw_tp_null.c
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null.c
@@ -10,7 +10,7 @@ char _license[] SEC("license") = "GPL";
 int tid;
 int i;
 
-SEC("tp_btf/bpf_testmod_test_raw_tp_null")
+SEC("tp_btf/bpf_testmod_test_raw_tp_null_tp")
 int BPF_PROG(test_raw_tp_null, struct sk_buff *skb)
 {
 	struct task_struct *task = bpf_get_current_task_btf();
diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
index 38d669957bf1..0d58114a4955 100644
--- a/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null_fail.c
@@ -8,7 +8,7 @@
 char _license[] SEC("license") = "GPL";
 
 /* Ensure module parameter has PTR_MAYBE_NULL */
-SEC("tp_btf/bpf_testmod_test_raw_tp_null")
+SEC("tp_btf/bpf_testmod_test_raw_tp_null_tp")
 __failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
 int test_raw_tp_null_bpf_testmod_test_raw_tp_null_arg_1(void *ctx) {
     asm volatile("r1 = *(u64 *)(r1 +0); r1 = *(u64 *)(r1 +0);" ::: __clobber_all);
diff --git a/tools/testing/selftests/bpf/progs/test_module_attach.c b/tools/testing/selftests/bpf/progs/test_module_attach.c
index 7f3c233943b3..03d7f89787a1 100644
--- a/tools/testing/selftests/bpf/progs/test_module_attach.c
+++ b/tools/testing/selftests/bpf/progs/test_module_attach.c
@@ -19,7 +19,7 @@ int BPF_PROG(handle_raw_tp,
 
 __u32 raw_tp_bare_write_sz = 0;
 
-SEC("raw_tp/bpf_testmod_test_write_bare")
+SEC("raw_tp/bpf_testmod_test_write_bare_tp")
 int BPF_PROG(handle_raw_tp_bare,
 	     struct task_struct *task, struct bpf_testmod_test_write_ctx *write_ctx)
 {
@@ -31,7 +31,7 @@ int raw_tp_writable_bare_in_val = 0;
 int raw_tp_writable_bare_early_ret = 0;
 int raw_tp_writable_bare_out_val = 0;
 
-SEC("raw_tp.w/bpf_testmod_test_writable_bare")
+SEC("raw_tp.w/bpf_testmod_test_writable_bare_tp")
 int BPF_PROG(handle_raw_tp_writable_bare,
 	     struct bpf_testmod_test_writable_ctx *writable)
 {
diff --git a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
index 39ff06f2c834..cf0547a613ff 100644
--- a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
+++ b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
@@ -6,14 +6,14 @@
 #include "../test_kmods/bpf_testmod.h"
 #include "bpf_misc.h"
 
-SEC("tp_btf/bpf_testmod_test_nullable_bare")
+SEC("tp_btf/bpf_testmod_test_nullable_bare_tp")
 __failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
 int BPF_PROG(handle_tp_btf_nullable_bare1, struct bpf_testmod_test_read_ctx *nullable_ctx)
 {
 	return nullable_ctx->len;
 }
 
-SEC("tp_btf/bpf_testmod_test_nullable_bare")
+SEC("tp_btf/bpf_testmod_test_nullable_bare_tp")
 int BPF_PROG(handle_tp_btf_nullable_bare2, struct bpf_testmod_test_read_ctx *nullable_ctx)
 {
 	if (nullable_ctx)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 3220f1d28697..18eded4d1d15 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -413,7 +413,7 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 
 	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
 
-	(void)trace_bpf_testmod_test_raw_tp_null(NULL);
+	(void)trace_bpf_testmod_test_raw_tp_null_tp(NULL);
 
 	bpf_testmod_test_struct_ops3();
 
@@ -431,14 +431,14 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	if (bpf_testmod_loop_test(101) > 100)
 		trace_bpf_testmod_test_read(current, &ctx);
 
-	trace_bpf_testmod_test_nullable_bare(NULL);
+	trace_bpf_testmod_test_nullable_bare_tp(NULL);
 
 	/* Magic number to enable writable tp */
 	if (len == 64) {
 		struct bpf_testmod_test_writable_ctx writable = {
 			.val = 1024,
 		};
-		trace_bpf_testmod_test_writable_bare(&writable);
+		trace_bpf_testmod_test_writable_bare_tp(&writable);
 		if (writable.early_ret)
 			return snprintf(buf, len, "%d\n", writable.val);
 	}
@@ -470,7 +470,7 @@ bpf_testmod_test_write(struct file *file, struct kobject *kobj,
 		.len = len,
 	};
 
-	trace_bpf_testmod_test_write_bare(current, &ctx);
+	trace_bpf_testmod_test_write_bare_tp(current, &ctx);
 
 	return -EIO; /* always fail */
 }
-- 
2.47.2


