Return-Path: <bpf+bounces-40905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DBF98FBE3
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 03:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FF41C22CFA
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 01:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4DD71739;
	Fri,  4 Oct 2024 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KInjYqoE"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04417C6C;
	Fri,  4 Oct 2024 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728004453; cv=none; b=H5mNe/jf+uPVoRzBG8n6edyXixws1d/ZO9oJU9QJA2eK1fDAcRCoeQCsuRT9HFTrbC0cdwqIiwU9/uiPPgiVS9KqIezRg0x0LldJWi71uoElNVeh6khYT3/yL7NNbBD/RjDz00tq+1MOp/Ud2KT0CfaWiMGo2ogKXj6jNnX985I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728004453; c=relaxed/simple;
	bh=mtMV15nwSgC24wpcl6rcJCStzDUXS/XjqRPiMOjRqhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RsQETUXor84VhA9aw1ivp3aZlGhzPBQ8KuORGV5oQdXvo/l2u7Hoscr31SG3QSFSZ8acPF6cajhJTMnb0/ITEiZbCLIiExJlRKcaIL9yGRPFWwew3MUN5Xg+tEFpjydodTTz9kCPpXqhoZ8iStS8zPUZ2SEjcAXeeL6fyPL1pRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=KInjYqoE; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728004448;
	bh=mtMV15nwSgC24wpcl6rcJCStzDUXS/XjqRPiMOjRqhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KInjYqoEsxc6nSt9+VBhaFNLAlinuiXvg9gCZTrpdI3rgffEt1nJdsuduf8O2D/Iz
	 HYDq9rHeSC3NpX4+2qKhMzoMvCeEPlnntSs/JHJgn26YGnDrDpmnTfyIt4FznB5zSO
	 Oh0j/KJFjtL28bfjE1wYFYPkpKXiGqn6R/p1WnkfsVUitt0vumsIH+TE21V2a3i+90
	 BKZINLvzDb61VqVUvi1VeZRF2TlUni8oTeLBEo/Mj81G5DL4Ery6PzIVylJogLLNCZ
	 1coElrWVmgoP3xnQlC1S3h2WPUmV1Xxx2KAchlDi0NyBE5TosD1lmGMJHtyTsO9kJk
	 oit7gQ8+wJo0Q==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKVtm1h1LzBfX;
	Thu,  3 Oct 2024 21:14:08 -0400 (EDT)
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
Subject: [PATCH v2 5/7] tracing/ftrace: Add might_fault check to syscall probes
Date: Thu,  3 Oct 2024 21:11:59 -0400
Message-Id: <20241004011201.1681962-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241004011201.1681962-1-mathieu.desnoyers@efficios.com>
References: <20241004011201.1681962-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a might_fault() check to validate that the ftrace sys_enter/sys_exit
probe callbacks are indeed called from a context where page faults can
be handled.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
 include/trace/trace_events.h  | 1 +
 kernel/trace/trace_syscalls.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 0228d9ed94a3..e0d4850b0d77 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -446,6 +446,7 @@ __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
 static notrace void							\
 trace_event_raw_event_##call(void *__data, proto)			\
 {									\
+	might_fault();							\
 	guard(preempt_notrace)();					\
 	do_trace_event_raw_event_##call(__data, args);			\
 }
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index edcfa47446c7..89d7e4c57b5b 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -303,6 +303,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	 * Syscall probe called with preemption enabled, but the ring
 	 * buffer and per-cpu data require preemption to be disabled.
 	 */
+	might_fault();
 	guard(preempt_notrace)();
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
@@ -348,6 +349,7 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 	 * Syscall probe called with preemption enabled, but the ring
 	 * buffer and per-cpu data require preemption to be disabled.
 	 */
+	might_fault();
 	guard(preempt_notrace)();
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
-- 
2.39.2


