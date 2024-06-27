Return-Path: <bpf+bounces-33267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4155391AB21
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 17:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D51287F95
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCC4199E88;
	Thu, 27 Jun 2024 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kQZZotTt"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0B1991BF;
	Thu, 27 Jun 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501795; cv=none; b=p7ulKJGYZ6X7WXiiz2+10BrUfLvVIMVGgU14lFzqM8amo9jxlRnkSkYryGKRAxRPoZM3iwHjJY9wWAXrjX6UUO+bCACOb9fTh6NZaF3ofvb+u74tJuw7ZgDHPyIUEWXyKwivbeCoKB2hE0xohgPq/kwlvKtqqNMR4trIVaWeLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501795; c=relaxed/simple;
	bh=PLilsDQe1SB8Sc5yvuTGO9LSAXut9VnHgr6OZBAMHIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mCJy0W+82IgW8s9e2t4ruvMquy5xFunWDydQWbg1bfqQyh9TvrHBD5z/nrTI1p4h3lKFyrtQXtp/SVqfZGzZwJadppcN7YqHr6uY6nJLTRqrgawK5toNCjoQES9EFa5bW9u1YUgF4FkZqWSa/KBlOESQz7V3ah2H96F2+lpafzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=kQZZotTt; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1719501791;
	bh=PLilsDQe1SB8Sc5yvuTGO9LSAXut9VnHgr6OZBAMHIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQZZotTt80CS23lVbz/NKG52CokcfXwTj2G36q6EMRK6UBSmCQgotDi85CSPFrUNK
	 uHt+nJMW+fsmLhK4cSiOFLfrKSFVShWZD/o0IvWB23kgkhg55J7wFM/STm8hLNG8vH
	 ZlLq/mdaxuGhe0de28Qauc0WF80T2G6zZHVmNt4lT3iun5C9JxCRM1sx5scF92j+0H
	 dfIr//Sfn8GB4KFQVAKoy4Q1FzHSildV+MoA+/Yn00fGp59bglijBGdCxS1wvIi3DW
	 Q7hTaT9OSDKoDKzpFf+/+QRMavG/IurJbESaEuqUzpCDqZGCvWgq7WvEWSStqc4AFj
	 mdxoN/Svv2ZeA==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4W92Q66Ddcz17gH;
	Thu, 27 Jun 2024 11:23:10 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	Joel Fernandes <joel@joelfernandes.org>,
	Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH v5 7/8] tracing/perf: Add support for faultable tracepoints
Date: Thu, 27 Jun 2024 11:23:39 -0400
Message-Id: <20240627152340.82413-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240627152340.82413-1-mathieu.desnoyers@efficios.com>
References: <20240627152340.82413-1-mathieu.desnoyers@efficios.com>
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
Cc: Jiri Olsa <jolsa@redhat.com>
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


