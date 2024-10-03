Return-Path: <bpf+bounces-40837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C74298F25D
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 17:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB493281344
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E8C1A4F0F;
	Thu,  3 Oct 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mU85fo2b"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC971779A5;
	Thu,  3 Oct 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968730; cv=none; b=D18RH3qMXM690oRBjzE0e918zSAfZ28+wqZSRQG+sEaNNpMeSbSKdQxjy5JQ6PrOXECZvf44OYDQPPG/352OoG6BGFdWbWY/QJzM2IinwHqUqvTCA5t7FIqmBGdhm4m0XLLxTXtCa7lb+JUT2yjxIg5s1B5gqcZ6TjDRWSmmWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968730; c=relaxed/simple;
	bh=uQvGGRjFBg81/CMoacZvVtIn7AY3sce+G3Hk/Qjw2wU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tdRMwbZ6YyMfbuSyRY9jsyzgbW476TbdiTytjF545PrP5skLwpnLEpT+DEYDrC/2R18YLjIJnylbDcsIJ+4bUiKo6pbuLTYABWLDYcjYCIFVqZ6ukLVC51MT0e9OTxutbpQUkPWDNweeMVr3p8zlbzpm2iueUPKhBTRHFng6nDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mU85fo2b; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727968724;
	bh=uQvGGRjFBg81/CMoacZvVtIn7AY3sce+G3Hk/Qjw2wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mU85fo2bLIGDjHEQ16l7Q//TqPy25gR39Uz3iHNyh7HDSOk5kiZOw69UunjzQxabq
	 PruZ3Ulfkk3NrGM2bde5AvrYpb7venBKofxhMJbmY/6r89BUAkm7tlv6yzt/+FRUmJ
	 eTLjY1vgL591RUNznwCOq2JCTnocAjl85/5SBWhsONrXNxcE+6awzyR7XnCQXG2DBH
	 Lw1SebxTTOEULZw9oh7qDyqsSNwnkMmQH1jURAKSFfWXxcPFinvAl01eJEZH52rMb0
	 xOc6xYWkOHpS9OtP5KND58X5DMByHUJGYqVEcAh3LA/AP1gXdy5l8XbodLKxicds3J
	 9iem7qOXN8snQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKFgm2T3Cz62g;
	Thu,  3 Oct 2024 11:18:44 -0400 (EDT)
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
Subject: [PATCH v1 4/8] tracing/bpf: guard syscall probe with preempt_notrace
Date: Thu,  3 Oct 2024 11:16:34 -0400
Message-Id: <20241003151638.1608537-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
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


