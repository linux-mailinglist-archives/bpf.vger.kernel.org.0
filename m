Return-Path: <bpf+bounces-41577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8B799898F
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 16:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1DC1C2406E
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1989C1CF7A0;
	Thu, 10 Oct 2024 14:25:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14421CF299;
	Thu, 10 Oct 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570342; cv=none; b=UT0ztoCJ2zr+wIkU9XiWtrnf/hcJNiBse82LbA4X9Ar9AexEsoBPA82hPYKhGBy4NDc/DM0oZOtvw0LV/9VSMoQt53w4kr0CPQ0ukCW1k+6IOS5rw8nICaFjTWz0/0w3NjP+CuXAsSjU/UuxjDYBFyRVNealUmTp4Ihoyrqs/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570342; c=relaxed/simple;
	bh=2mNwbtAkP8msVSL3kNHjjldI8R8oA1kK+Zwp/K5MWzc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=a+D9h2RCaxsu2uhsNaY0EFgvX7mbJ2BYxgRsSR+G5BUbZUZWrryx/+3vkrnFe5aluglBw8bB7EADF8JiPPQSfZ6NAjPCve+PEbgmGorAIuBNKnbfib6FHj/Goy8aWcz6E2XROjhcBlrrD66vKg4wORCn8aLzXnzuKU4XCgzlw2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729CCC4CECE;
	Thu, 10 Oct 2024 14:25:42 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1syu6w-00000001HIK-1Okg;
	Thu, 10 Oct 2024 10:25:50 -0400
Message-ID: <20241010142550.191163490@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 10 Oct 2024 10:25:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>,
 Andrii Nakryiko <andrii@kernel.org>
Subject: [for-next][PATCH 04/10] tracing/bpf: disable preemption in syscall probe
References: <20241010142537.255433162@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

In preparation for allowing system call enter/exit instrumentation to
handle page faults, make sure that bpf can handle this change by
explicitly disabling preemption within the bpf system call tracepoint
probes to respect the current expectations within bpf tracing code.

This change does not yet allow bpf to take page faults per se within its
probe, but allows its existing probes to adapt to the upcoming change.

Cc: Michael Jeanson <mjeanson@efficios.com>
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
Link: https://lore.kernel.org/20241009010718.2050182-5-mathieu.desnoyers@efficios.com
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org> # BPF parts
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/bpf_probe.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index c85bbce5aaa5..fec97c93e1c9 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -53,8 +53,18 @@ __bpf_trace_##call(void *__data, proto)					\
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
 
+#define __BPF_DECLARE_TRACE_SYSCALL(call, proto, args)			\
+static notrace void							\
+__bpf_trace_##call(void *__data, proto)					\
+{									\
+	preempt_disable_notrace();					\
+	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
+	preempt_enable_notrace();					\
+}
+
 #undef DECLARE_EVENT_SYSCALL_CLASS
-#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_SYSCALL_CLASS(call, proto, args, tstruct, assign, print)	\
+	__BPF_DECLARE_TRACE_SYSCALL(call, PARAMS(proto), PARAMS(args))
 
 /*
  * This part is compiled out, it is only here as a build time check
-- 
2.45.2



