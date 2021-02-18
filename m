Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBEC31F23D
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 23:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBRWW1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 17:22:27 -0500
Received: from mail.efficios.com ([167.114.26.124]:43664 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhBRWWX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Feb 2021 17:22:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 730B229EE93;
        Thu, 18 Feb 2021 17:21:42 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0dygWqtl4m2z; Thu, 18 Feb 2021 17:21:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 172C329EE92;
        Thu, 18 Feb 2021 17:21:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 172C329EE92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1613686902;
        bh=Prp/o0hMXlghJPW/8Znwk7bWZiEUnBxyhrqePmcHN3s=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=oT6sdBamOM4EC9ag7nzAsKH6zwxddw+eqyGlIpwApu2+X+Z8gRkdgxdqjQv8qWfP4
         B/AFfm9EYGHQ7nWnmjDrPJFYVC00atCAEmaG8PI5yqy2MAdFHa6jucvBCpvxeFsF3R
         BzCSV+mJTpUyNXXOr1pNoNWlatKdj1E2bU1DqfYfGXW/x3eGVDrUqR8C/O6a0TwJYv
         L7Cbgg61Pi+d06mM4DpsB4AaWviq5F47cBipsL/K2MpTrrA38C1PhiSjuHmavLYzHL
         /Kpwyc/FN/pqCPCxjhXueXOqZYsUc/JgXC3eqe4Rip+t7V9oukF5UR4V2amCmq3oE3
         uHJ2E4Bt1ooUQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6t5Bc0FdIgng; Thu, 18 Feb 2021 17:21:42 -0500 (EST)
Received: from localhost.localdomain (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
        by mail.efficios.com (Postfix) with ESMTPSA id BD6C529F086;
        Thu, 18 Feb 2021 17:21:41 -0500 (EST)
From:   Michael Jeanson <mjeanson@efficios.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [RFC PATCH 3/6] tracing: bpf-trace: add support for faultable tracepoints
Date:   Thu, 18 Feb 2021 17:21:22 -0500
Message-Id: <20210218222125.46565-4-mjeanson@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218222125.46565-1-mjeanson@efficios.com>
References: <20210218222125.46565-1-mjeanson@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for converting system call enter/exit instrumentation
into faultable tracepoints, make sure that bpf can handle registering to
such tracepoints by explicitly disabling preemption within the bpf
tracepoint probes to respect the current expectations within bpf tracing
code.

This change does not yet allow bpf to take page faults per se within its
probe, but allows its existing probes to connect to faultable
tracepoints.

Co-developed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
 include/trace/bpf_probe.h | 23 +++++++++++++++++++++--
 kernel/trace/bpf_trace.c  |  5 ++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index cd74bffed5c6..1fc3afc49f37 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -55,15 +55,34 @@
 /* tracepoints with more than 12 arguments will hit build error */
 #define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__=
VA_ARGS__)
=20
-#undef DECLARE_EVENT_CLASS
-#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+#undef _DECLARE_EVENT_CLASS
+#define _DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print, =
tp_flags)	\
 static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
 	struct bpf_prog *prog =3D __data;					\
+									\
+	if ((tp_flags) & TRACEPOINT_MAYFAULT)				\
+		preempt_disable_notrace();				\
+									\
 	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));	=
\
+									\
+	if ((tp_flags) & TRACEPOINT_MAYFAULT)				\
+		preempt_enable_notrace();				\
 }
=20
+#undef DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print),	0)
+
+#undef DECLARE_EVENT_CLASS_MAYFAULT
+#define DECLARE_EVENT_CLASS_MAYFAULT(call, proto, args, tstruct,	\
+		assign, print)						\
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print),		\
+		TRACEPOINT_MAYFAULT)
+
 /*
  * This part is compiled out, it is only here as a build time check
  * to make sure that if the tracepoint handling changes, the
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0dde84b9d29f..eeeb3dafb01e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2117,7 +2117,10 @@ static int __bpf_probe_register(struct bpf_raw_eve=
nt_map *btp, struct bpf_prog *
 	if (prog->aux->max_tp_access > btp->writable_size)
 		return -EINVAL;
=20
-	return tracepoint_probe_register(tp, (void *)btp->bpf_func, prog);
+	if (tp->flags & TRACEPOINT_MAYFAULT)
+		return tracepoint_probe_register_mayfault(tp, (void *)btp->bpf_func, p=
rog);
+	else
+		return tracepoint_probe_register(tp, (void *)btp->bpf_func, prog);
 }
=20
 int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *p=
rog)
--=20
2.25.1

