Return-Path: <bpf+bounces-11225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FE27B5BF8
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 22:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A42BA282511
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 20:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D4920312;
	Mon,  2 Oct 2023 20:25:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF86200DE
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 20:25:44 +0000 (UTC)
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A17D3;
	Mon,  2 Oct 2023 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1696278340;
	bh=vYAU4AeTLnE8I/bDRtRMZDB+30vSLOM6ErZFA9kFrHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JnGRudYxxav/ozwajmmRrIDkAbC1i2iLjSuXV5BXpqr91oHOJl8sYJWFLHvLD6gAy
	 pMkra1snzoS5vm0q3+m+dLOpoWioI/8zB2jYmeDrT8O+vTl2ybEnLwBa/znFQkCjGz
	 rIw5Ek5gokFbJMSzK4shMWM/0sb/yASsfGTgW8FOt6bePmBMgd1T6eC/uI6wi2MHb/
	 zaXOlZegkRvZktIgrmXoDy596wPgGrSRf+J9/So2jngZbXVjYtMPlV0PVeV/ZEcP0s
	 hcyopxZFGkgv/0ak9TLRUOfp7Bv6r2BP7GtrF1954aaF2T397aQbqxiP3A2LHpg9Yf
	 p0q9tr9571qJw==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4RzssH6JPHz1Vwc;
	Mon,  2 Oct 2023 16:25:39 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [RFC PATCH v3 3/5] tracing/bpf-trace: add support for faultable tracepoints
Date: Mon,  2 Oct 2023 16:25:29 -0400
Message-Id: <20231002202531.3160-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
References: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In preparation for converting system call enter/exit instrumentation
into faultable tracepoints, make sure that bpf can handle registering to
such tracepoints by explicitly disabling preemption within the bpf
tracepoint probes to respect the current expectations within bpf tracing
code.

This change does not yet allow bpf to take page faults per se within its
probe, but allows its existing probes to connect to faultable
tracepoints.

Co-developed-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/trace/bpf_probe.h | 21 +++++++++++++++++----
 kernel/trace/bpf_trace.c  | 11 ++++++++---
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 1f7fc1fc590c..03cb4045a046 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -40,17 +40,30 @@
 /* tracepoints with more than 12 arguments will hit build error */
 #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
 
-#define __BPF_DECLARE_TRACE(call, proto, args)				\
+#define __BPF_DECLARE_TRACE(call, proto, args, tp_flags)		\
 static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
 	struct bpf_prog *prog = __data;					\
+									\
+	if ((tp_flags) & TRACEPOINT_MAY_FAULT) {			\
+		might_fault();						\
+		preempt_disable_notrace();				\
+	}								\
+									\
 	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));	\
+									\
+	if ((tp_flags) & TRACEPOINT_MAY_FAULT)				\
+		preempt_enable_notrace();				\
 }
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
-	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0)
+
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), TRACEPOINT_MAY_FAULT)
 
 /*
  * This part is compiled out, it is only here as a build time check
@@ -104,13 +117,13 @@ static inline void bpf_test_buffer_##call(void)				\
 
 #undef DECLARE_TRACE
 #define DECLARE_TRACE(call, proto, args)				\
-	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))		\
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0)	\
 	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), 0)
 
 #undef DECLARE_TRACE_WRITABLE
 #define DECLARE_TRACE_WRITABLE(call, proto, args, size) \
 	__CHECK_WRITABLE_BUF_SIZE(call, PARAMS(proto), PARAMS(args), size) \
-	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args)) \
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args), 0) \
 	__DEFINE_EVENT(call, call, PARAMS(proto), PARAMS(args), size)
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4accf2f138b8..e9942f8e5c66 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2327,9 +2327,14 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
 	if (prog->aux->max_tp_access > btp->writable_size)
 		return -EINVAL;
 
-	return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
-						    prog, TRACEPOINT_DEFAULT_PRIO,
-						    TRACEPOINT_MAY_EXIST);
+	if (tp->flags & TRACEPOINT_MAY_FAULT)
+		return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
+							    prog, TRACEPOINT_DEFAULT_PRIO,
+							    TRACEPOINT_MAY_EXIST | TRACEPOINT_MAY_FAULT);
+	else
+		return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
+							    prog, TRACEPOINT_DEFAULT_PRIO,
+							    TRACEPOINT_MAY_EXIST);
 }
 
 int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog)
-- 
2.25.1


