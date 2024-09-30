Return-Path: <bpf+bounces-40597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B328398ACD6
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA571F24235
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 19:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE1C1991B2;
	Mon, 30 Sep 2024 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="FqR0hWKG"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E4199E8B;
	Mon, 30 Sep 2024 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724394; cv=none; b=LbgQ/BOYvQaZbrqB1D/VxQ6tPzwJikG755ExkTldDIs0FE5ASwx+sRhJMYiTUC1wbiGKg8ox27nDaNXnMetw13wfRO39dreuDtgaIe4mrc6qVxjCYkiwovkpVflWkzqzNLbx8BEYIjf4OqeO2s6MPIv5Z1Q8PowUORyek5YB4ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724394; c=relaxed/simple;
	bh=uQvGGRjFBg81/CMoacZvVtIn7AY3sce+G3Hk/Qjw2wU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMDfbFrTdn9Z1MAIarMbAGLf+hiDFxKc3ocr1iBwbMCH9rEbpey83588mUW3lhJ7erTMzZQrcTTlMEkzG4iQOTSb99cvdIZfMnfnUQ0tUU6waTQvLg9gTh2GRBWBHOoY8qRWcmlZq6m9jCEFqsdwTGeSCOIuGNG0SeFdF6SEp1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=FqR0hWKG; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727724392;
	bh=uQvGGRjFBg81/CMoacZvVtIn7AY3sce+G3Hk/Qjw2wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FqR0hWKG0kr5XJzMo2Jfeb7KmZjhMfJFpUg5zW8DW474CA9bJGBICnOoGwK8ePETB
	 PcNmwPWAWSUNZlOl0QaJ6JagTTRhNp5MYjn7DNVVGqTTd+xMkhThx15GLYcxS5nQXv
	 9iigsrup3zLAaNXazmDxRPIuLDsFVkZQZXZEZAcdFWHiMmZDq1FjSZu9iA9UDzdyOr
	 nHconsWJe0gZCC4ej5KSIvtf70w9iUHVcpWSFszC4MK4oDUpxBufowWnYpUqWN9ZgC
	 01T/r0CnXN+/NjqKxyzFXhkBDqdvwlc+V0/GeAlkJrsHKod00S6s7MgeSyJ8lcTN4U
	 7HmlcJFjhZ+BQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XHWK364vfzQXq;
	Mon, 30 Sep 2024 15:26:31 -0400 (EDT)
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
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH resend 4/8] tracing/bpf: guard syscall probe with preempt_notrace
Date: Mon, 30 Sep 2024 15:23:53 -0400
Message-Id: <20240930192357.1154417-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240930192357.1154417-1-mathieu.desnoyers@efficios.com>
References: <20240930192357.1154417-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for allowing system call enter/exit instrumentation to
handle page faults, make sure that bpf can handle this change by
explicitly disabling preemption within the bpf system call tracepoint
probes to respect the current expectations within bpf tracing code.

This change does not yet allow bpf to take page faults per se within its
probe, but allows its existing probes to adapt to the upcoming change.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org> # BPF parts
Cc: Michael Jeanson <mjeanson@efficios.com>
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
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/trace/bpf_probe.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index c85bbce5aaa5..211b98d45fc6 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -53,8 +53,17 @@ __bpf_trace_##call(void *__data, proto)					\
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
 
+#define __BPF_DECLARE_TRACE_SYSCALL(call, proto, args)			\
+static notrace void							\
+__bpf_trace_##call(void *__data, proto)					\
+{									\
+	guard(preempt_notrace)();					\
+	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
+}
+
 #undef DECLARE_EVENT_SYSCALL_CLASS
-#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_SYSCALL_CLASS(call, proto, args, tstruct, assign, print)	\
+	__BPF_DECLARE_TRACE_SYSCALL(call, PARAMS(proto), PARAMS(args))
 
 /*
  * This part is compiled out, it is only here as a build time check
-- 
2.39.2


