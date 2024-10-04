Return-Path: <bpf+bounces-40903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0357198FBDF
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 03:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2771F213C3
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 01:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B7C49624;
	Fri,  4 Oct 2024 01:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="C8mWsPng"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07E182B3;
	Fri,  4 Oct 2024 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728004452; cv=none; b=pjth4aC+UHJ7G9hbCr/1OjWw5cqAgCf3kTzCFFXVXVqXJfDbs8mI7XMsT79EwkgK9eiXbewyuO2P9fHeDeurOFOIxM6TKwI1l+s45Ds0R6yFRmTOBSVw5cQhNMYbcGTpQvaW1OBiHN8lVT1UnUHz18QvpNuaLlVbYTwdX4nX/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728004452; c=relaxed/simple;
	bh=Lii3pZqSuFPJyMdWMDiDKTX8jZ8Szv5keXbzZp3BAq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rfG9sqNr8K5eDbcEYs6T7biyB6bjR8XYQJNiJohsjIqSAI/3MnozuRVMSe4PMSEjv+aSUUT0BnVJ0hV06OT207ldJhoohoEKrZrLMOb3S089UqzVtckTzqaZgGhX5zgfJeyLQ5EHjGsQ92H9b5mWlC/rliu1tCTUIf6RncPgv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=C8mWsPng; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728004448;
	bh=Lii3pZqSuFPJyMdWMDiDKTX8jZ8Szv5keXbzZp3BAq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C8mWsPngVJ7FLIb87cn9Tm1JpdpqaNTtJ91TJ2cxFXYIlD/TxH+wnkYxQGFZJ9Ezr
	 i70PVHUT6rfbDqSckzuKEjVBY24V5WnKg3O1NQimla8wZ5GCOzzLun0LNEmZFRTYAe
	 IjU1zQvNZuVGIrz+taOtK/e5R/oOeviqQcWTJgBq2JZhtLRPNkNOLL4FtSy3vje9qw
	 4O5wfe8pJeg7DYrozZgJ9tcbl4SaDXXl0V5ThGaAjC7Tf8Vc/GbIG/FMlvSXDeKGjh
	 wF9W3qiUXnOQfS3SM6zzWPEo5+x8wdv3kHqPNAIAJzL4DMLDxHKLTysEFsGxK6ViJD
	 F74E501jmoQOQ==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKVtm39NyzBwR;
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
Subject: [PATCH v2 6/7] tracing/perf: Add might_fault check to syscall probes
Date: Thu,  3 Oct 2024 21:12:00 -0400
Message-Id: <20241004011201.1681962-7-mathieu.desnoyers@efficios.com>
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
index 89d7e4c57b5b..0d42d6f293d6 100644
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


