Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105E82977DE
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 21:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755026AbgJWTyU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 15:54:20 -0400
Received: from mail.efficios.com ([167.114.26.124]:45678 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755005AbgJWTyU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 15:54:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 11A83279718;
        Fri, 23 Oct 2020 15:54:19 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ax90esXAu1Sp; Fri, 23 Oct 2020 15:54:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B9EE9279632;
        Fri, 23 Oct 2020 15:54:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B9EE9279632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603482858;
        bh=SNCUKPYZ/Ab7zOMacK9FkCd4L9/ecQHTPUCkRH7Nkf0=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=QrvGlnntLyTtQFm4FzrzQnZoKkf74q6/rSkENH+dICVFxy6iQ/XNTuSxIME7OU/wj
         56vwfHepmQyn2cP4KZ4Eij7UkJYL5CcfxRqxSW4F8RlbSJwMC2749qLluIxlBTNGDU
         k6lWhF8mSq2OZXSGO9XobgTLFUU4of0qjyoRGBgG1F5sPdbakCLKEkHomWLbNpmJoT
         XexwJoWh29Wl10WfvoSuPJPsCvvWaKhdX5EGOZ7KnTfwDcwvh8mrqCuXeG5jdlNXH6
         vYgA6QU1lIVKhc9T1Zc/sAVS8H4YyYGLlMNY1oB6YZu6NdJrs948bKSQvB44wtWEqn
         bhWnlF1I0dVQA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7vH3c3nv-SzA; Fri, 23 Oct 2020 15:54:18 -0400 (EDT)
Received: from localhost.localdomain (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
        by mail.efficios.com (Postfix) with ESMTPSA id 3BDEC27933F;
        Fri, 23 Oct 2020 15:54:18 -0400 (EDT)
From:   Michael Jeanson <mjeanson@efficios.com>
To:     linux-kernel@vger.kernel.org
Cc:     mathieu.desnoyers@efficios.com,
        Michael Jeanson <mjeanson@efficios.com>,
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
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, bpf@vger.kernel.org
Subject: [RFC PATCH 3/6] tracing: bpf-trace: add support for sleepable tracepoints
Date:   Fri, 23 Oct 2020 15:53:49 -0400
Message-Id: <20201023195352.26269-4-mjeanson@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023195352.26269-1-mjeanson@efficios.com>
References: <20201023195352.26269-1-mjeanson@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for converting system call enter/exit instrumentation
into sleepable tracepoints, make sure that bpf can handle registering to
such tracepoints by explicitly disabling preemption within the bpf
tracepoint probes to respect the current expectations within bpf tracing
code.

This change does not yet allow bpf to take page faults per se within its
probe, but allows its existing probes to connect to sleepable
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
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: bpf@vger.kernel.org
---
 include/trace/bpf_probe.h | 23 +++++++++++++++++++++--
 kernel/trace/bpf_trace.c  |  5 ++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 1ce3be63add1..d688cb9b32fe 100644
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
+	if ((tp_flags) & TRACEPOINT_MAYSLEEP)				\
+		preempt_disable_notrace();				\
+									\
 	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));	=
\
+									\
+	if ((tp_flags) & TRACEPOINT_MAYSLEEP)				\
+		preempt_enable_notrace();				\
 }
=20
+#undef DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print),	0)
+
+#undef DECLARE_EVENT_CLASS_MAYSLEEP
+#define DECLARE_EVENT_CLASS_MAYSLEEP(call, proto, args, tstruct,	\
+		assign, print)						\
+	_DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args),		\
+		PARAMS(tstruct), PARAMS(assign), PARAMS(print),		\
+		TRACEPOINT_MAYSLEEP)
+
 /*
  * This part is compiled out, it is only here as a build time check
  * to make sure that if the tracepoint handling changes, the
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a8d4f253ed77..54f8b320fe2f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1947,7 +1947,10 @@ static int __bpf_probe_register(struct bpf_raw_eve=
nt_map *btp, struct bpf_prog *
 	if (prog->aux->max_tp_access > btp->writable_size)
 		return -EINVAL;
=20
-	return tracepoint_probe_register(tp, (void *)btp->bpf_func, prog);
+	if (tp->flags & TRACEPOINT_MAYSLEEP)
+		return tracepoint_probe_register_maysleep(tp, (void *)btp->bpf_func, p=
rog);
+	else
+		return tracepoint_probe_register(tp, (void *)btp->bpf_func, prog);
 }
=20
 int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *p=
rog)
--=20
2.25.1

