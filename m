Return-Path: <bpf+bounces-41331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B2B995CBA
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 03:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949752871BD
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5926B126C07;
	Wed,  9 Oct 2024 01:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rs6T9K0l"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF983B784;
	Wed,  9 Oct 2024 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728436171; cv=none; b=SmiBNfUg1CvfoppuR48Gtv9K1InUz/U0C9IrDyblvBBzWD0egkgCFBq+QzKpYWT4zSEFPikIYU1ZPYvogySGnWl1wnI/c+0MCG5ZM4R4uEpJaEhvNUFzbcKfa10cNQzHKTKtja+E/xDcU2sPz4uTzW2ZN1LG10awiiyJk1kDBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728436171; c=relaxed/simple;
	bh=Nz6l5GPgkpr6Cfo7qykznkJo1tIGMBS6YBtk78ruMYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5o4xuO0nraA+53kumpGZIvcmK4tG87LzXOk3MAQbOI00Pxn0/LVHzutfDCF2bSKmtrLBhnClKuAgvNBM5R3TY3l6atRHrw5qdM93HHQhG0fvD17zFJ1TZ/8Lr4UXivc1pxdKe+gQ15Ts9ubJgEhYGR2+z7YwRn1mwoPZs6zNRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rs6T9K0l; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728436168;
	bh=Nz6l5GPgkpr6Cfo7qykznkJo1tIGMBS6YBtk78ruMYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rs6T9K0lz/+X3Rfi74RpNqHZ9qwr/bjoaIALNIS/y8+zBGlEDPM+yIenRz9kjPp7n
	 rWLL3L2RuHTmaWnEneUCDM0UHNawBRYQU5eosPsgrcKXFhEOexEgq7xoDpULuKOCyV
	 xETUzreIUYhD0Am/4hrqfQ8VGu0XopXjmOrKavJkWhs9MMMVqxjfG1gwO4D+SMfUut
	 gx3QN1VftQGG3nhxBnK1+jDsTdmSUBlqcZKG9jZDsS+lKzZCB1lV8R1AoE0wmWzb43
	 CKR+1YaWnbyLW2aH1glTjodgumuexehjMMGc/xJ/7uo0Ud2RRYhlirotMowI9dGDPO
	 /w7dV2piTXuow==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XNZY40N1KzSJd;
	Tue,  8 Oct 2024 21:09:28 -0400 (EDT)
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
Subject: [PATCH v4 7/8] tracing/perf: Add might_fault check to syscall probes
Date: Tue,  8 Oct 2024 21:07:17 -0400
Message-Id: <20241009010718.2050182-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241009010718.2050182-1-mathieu.desnoyers@efficios.com>
References: <20241009010718.2050182-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a might_fault() check to validate that the perf sys_enter/sys_exit
probe callbacks are indeed called from a context where page faults can
be handled.

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
 include/trace/perf.h          | 1 +
 kernel/trace/trace_syscalls.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/trace/perf.h b/include/trace/perf.h
index 15cde7eac8b4..a1754b73a8f5 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -84,6 +84,7 @@ perf_trace_##call(void *__data, proto)					\
 	u64 __count __attribute__((unused));				\
 	struct task_struct *__task __attribute__((unused));		\
 									\
+	might_fault();							\
 	preempt_disable_notrace();					\
 	do_perf_trace_##call(__data, args);				\
 	preempt_enable_notrace();					\
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 6d6bbd56ed92..46aab0ab9350 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -602,6 +602,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	 * Syscall probe called with preemption enabled, but the ring
 	 * buffer and per-cpu data require preemption to be disabled.
 	 */
+	might_fault();
 	guard(preempt_notrace)();
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
@@ -710,6 +711,7 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 	 * Syscall probe called with preemption enabled, but the ring
 	 * buffer and per-cpu data require preemption to be disabled.
 	 */
+	might_fault();
 	guard(preempt_notrace)();
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
-- 
2.39.2


