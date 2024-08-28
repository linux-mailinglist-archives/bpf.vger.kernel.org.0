Return-Path: <bpf+bounces-38286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DFA962A8E
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 16:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3631282F90
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 14:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68C91A255E;
	Wed, 28 Aug 2024 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="wbV0pGII"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB319AD4F;
	Wed, 28 Aug 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856152; cv=none; b=qP1d/C0aAGadWyXQJUGk9b46ozs7aWaaLAhAQ5CskuYUQkUFybhoictb1LJJaX0pq5z3ViMco6npIF4LNexaZLhDY844f7ssro8I4kkL6kIcc6n6WeNTL/Za1sYkMl8OfEsBM5N2x/okgAxTBs9tgd0jxBOi37GjAj1O1ZRpM2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856152; c=relaxed/simple;
	bh=149pMzz+KOT6+tFcYaXWQmFtg/yrorXY4zzPknm/1HE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rnBnx9Mbdi3Dz/Fx+CGlRFiqnKCPkJliPRgkIJzP1aczXmvV3/H3jcVMGPikyvV84CmZXZKlR1/4CuXWWl8zc7jNv7ITAUy64mlnvXUeMZe8JX6jv8yFKhplAuN5bwrK1CIV210NsvRKeNWi5waB+uTH1xluZpN/oVZK8t9bK6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=wbV0pGII; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724856149;
	bh=149pMzz+KOT6+tFcYaXWQmFtg/yrorXY4zzPknm/1HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wbV0pGII5I7qz0otuIFcz3nTR8o1MzQGb/BAdLduX/0kHxGI3+p6bsFDn/FkZrjrG
	 m+HKZ+WhxOtuL/l0Mu0wI60nKh/Yn2DHaYxxcZSPkXAsMzzWWJO4T0pIdclSEKUdNC
	 S+zc1Im0vSVlVhtXjT/4egm7y8ko/SehrnU3VNo9JQrFcSapFQqibo5XBcMC4mOlVP
	 d0z11zZY1CmFLHjWShdCF/anaX9KPmsdFy9+R1h0isBiv1ZRNOIYWN4geGHuCvrojo
	 AcMx+ah2aE0lDBngq1N8dGacKnHHXzg55SHCWem6Mp9N1PgdwUQFlygtD3tZHuva8b
	 YEj3eHA9A132Q==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wv6ZY2lhWz1JFT;
	Wed, 28 Aug 2024 10:42:29 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-trace-kernel@vger.kernel.org,
	Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH v6 4/5] tracing/perf: Add support for faultable tracepoints
Date: Wed, 28 Aug 2024 10:41:51 -0400
Message-Id: <20240828144153.829582-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828144153.829582-1-mathieu.desnoyers@efficios.com>
References: <20240828144153.829582-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for converting system call enter/exit instrumentation
into faultable tracepoints, make sure that perf can handle registering
to such tracepoints by explicitly disabling preemption within the perf
tracepoint probes to respect the current expectations within perf ring
buffer code.

This change does not yet allow perf to take page faults per se within
its probe, but allows its existing probes to connect to faultable
tracepoints.

Link: https://lore.kernel.org/lkml/20231002202531.3160-1-mathieu.desnoyers@efficios.com/
Co-developed-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
---
Changes since v4:
- Use DEFINE_INACTIVE_GUARD.
---
 include/trace/perf.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/trace/perf.h b/include/trace/perf.h
index 2c11181c82e0..161e1655b953 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -12,8 +12,8 @@
 #undef __perf_task
 #define __perf_task(t)	(__task = (t))
 
-#undef DECLARE_EVENT_CLASS
-#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+#undef _DECLARE_EVENT_CLASS
+#define _DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print, tp_flags) \
 static notrace void							\
 perf_trace_##call(void *__data, proto)					\
 {									\
@@ -28,6 +28,13 @@ perf_trace_##call(void *__data, proto)					\
 	int __data_size;						\
 	int rctx;							\
 									\
+	DEFINE_INACTIVE_GUARD(preempt_notrace, trace_event_guard);	\
+									\
+	if ((tp_flags) & TRACEPOINT_MAY_FAULT) {			\
+		might_fault();						\
+		activate_guard(preempt_notrace, trace_event_guard)();	\
+	}								\
+									\
 	__data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
 									\
 	head = this_cpu_ptr(event_call->perf_events);			\
@@ -55,6 +62,17 @@ perf_trace_##call(void *__data, proto)					\
 				  head, __task);			\
 }
 
+#undef DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			     PARAMS(tstruct), PARAMS(assign), PARAMS(print), 0)
+
+#undef DECLARE_EVENT_CLASS_MAY_FAULT
+#define DECLARE_EVENT_CLASS_MAY_FAULT(call, proto, args, tstruct, assign, print) \
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+			     PARAMS(tstruct), PARAMS(assign), PARAMS(print), \
+			     TRACEPOINT_MAY_FAULT)
+
 /*
  * This part is compiled out, it is only here as a build time check
  * to make sure that if the tracepoint handling changes, the
-- 
2.39.2


