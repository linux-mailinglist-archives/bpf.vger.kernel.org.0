Return-Path: <bpf+bounces-39352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9570972374
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91766288494
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 20:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C9718B46C;
	Mon,  9 Sep 2024 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Vfow65t8"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBDA17D34D;
	Mon,  9 Sep 2024 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913039; cv=none; b=iJbL2us3F18EvzfrfyFV7QozJj1Mt+O5+8f4a/xIjn7hIu1r7bv4cB1P5bAxmx1sZOq/TZrWFY/dmZCEVijyCZUuFVbg/2EsP+VlpOlaO8RkkYkkgm5W326bZ9k+DC83tHIlYGwX43L9oRvpaG7MK8GpgoabU4BDcf371zVTlI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913039; c=relaxed/simple;
	bh=gZzsG8gL/ErZCAElJk9KWuSYSEgbv2rStlG0oF8Ol54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZUmNIDio2J2kgGs/hFIeDC8X0Jp4rU/AZwaOdkJ3jub+Noj7TJLaInml0LXGs1ZaN7OghLotsUQIFhQM+OEZMrsxCO/sHOWgjbcruL+yoWtGxhFdTltGABzqQq9F0dKuxYP1Hpsm2lSZbUO4z4rnzAvrxmvGzNrxAydEZdpUHCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Vfow65t8; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725913036;
	bh=gZzsG8gL/ErZCAElJk9KWuSYSEgbv2rStlG0oF8Ol54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vfow65t8A1jy2u7v7GVENaO55NLiN2wwLYGszpjfoA8lYMsJfPEV/1jVHoDptb7dX
	 OWHk/cEb1Q3AiCCqD1IT678F6wJ7rCQthZ7e+SblHGRabqb4wudu7yOJkq+ixC7PrW
	 A+oNy9yIPlCChhuRqGK89C1n6+L08wUp4q8gYqbpHpMkjuJQ90TsAIsGQFzNowrvr0
	 t8Q2k/X1PoOIsj862/vpd3JJIK7fT3EGhlQJqBglCRVyUKg/Bdn8NGw8Q8C5k/janp
	 Arav1oxzlIYPzyRs34q4iONXqDwUUq2L/5FBer155OKHqFwjKuRTSciXK97sJe0Wzo
	 wTdq9FHvXkMMw==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X2dRJ4kDHz1KQY;
	Mon,  9 Sep 2024 16:17:16 -0400 (EDT)
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
	Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH 4/8] tracing/bpf: guard syscall probe with preempt_notrace
Date: Mon,  9 Sep 2024 16:16:48 -0400
Message-Id: <20240909201652.319406-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
References: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
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


