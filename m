Return-Path: <bpf+bounces-40958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD1E9906F8
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 17:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5161C224BE
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E78C1C7610;
	Fri,  4 Oct 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="DJNW7AB9"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110C1C3025;
	Fri,  4 Oct 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054029; cv=none; b=q2qpoShb7F7sH6HUOjKXDuI4dqDRwkyVW1r+K8kxtclobiRTDuCR6WWjJ9PBvk7IgH6trR7Tt19tbqQDsCe7VPZ3/4UPlGLI+O9nl2tWF5SvukMgaYVIIc8NXRTSBZpjXiEW5MU+yW3kOVYXtl8gwPpF5oTP/Tqu2VZMw7vbfBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054029; c=relaxed/simple;
	bh=7eshE57AiYCnqGkT6/bFq4BldzMy33OIJNUycLV/lIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j2lRJDuWYFNFgqOUvz+7ol6MMJk4Xwu72bceM59gtfDs3jihAnpe+jXBhG2P6jc/DK9Q0GjPExnrjXaGUoW/yiePr1rHMPIdB/sxvCSxC9Q8xt9beVk+IIVWBVZaZ7U6uEjOrO+jjGRMmHzRsyu9NkeCG4VmTU1HJIbGZ21K3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=DJNW7AB9; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728054025;
	bh=7eshE57AiYCnqGkT6/bFq4BldzMy33OIJNUycLV/lIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJNW7AB9/ov/0qo/+tFxai1rcKDn6rtegp3wYwccEA/ZSyyqgmuWH6UDls4vhMko3
	 ztv8WPp5B2hvelMTYtsMm+T5RNzsSLWWmTo4wBQpkGC/mclHq2M5azDdEgHsyOwoD+
	 nUuV5bd3DYzHfQjx+Pe7wtQtOIF70oQ6ylSPihivq8mNUJbwEDEEC238Ka8JSBgyzV
	 5zVY5rhdgKNrCiuPxDn1N7pAJcNHZw88EvUkxE8y2+AULPFoIIDre7F6kXv8o2xawo
	 bb5vufGSFlOwBqx5r2evc3Msi1KPOI4x18a+PJ7kPKNAEXNE63NGmNZ1s5rO1DWN6A
	 aGFKF7K991Tkw==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKsD94Y6xzLJj;
	Fri,  4 Oct 2024 11:00:25 -0400 (EDT)
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
Subject: [PATCH v3 7/8] tracing/perf: Add might_fault check to syscall probes
Date: Fri,  4 Oct 2024 10:58:17 -0400
Message-Id: <20241004145818.1726671-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241004145818.1726671-1-mathieu.desnoyers@efficios.com>
References: <20241004145818.1726671-1-mathieu.desnoyers@efficios.com>
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
index 5650c1bad088..321bfd7919f6 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -84,6 +84,7 @@ perf_trace_##call(void *__data, proto)					\
 	u64 __count __attribute__((unused));				\
 	struct task_struct *__task __attribute__((unused));		\
 									\
+	might_fault();							\
 	guard(preempt_notrace)();					\
 	do_perf_trace_##call(__data, args);				\
 }
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


