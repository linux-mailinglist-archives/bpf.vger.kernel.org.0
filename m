Return-Path: <bpf+bounces-39355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE49D972379
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704C11F247B0
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 20:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B2218C03D;
	Mon,  9 Sep 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="D4qr8Bk+"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9F18A947;
	Mon,  9 Sep 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913041; cv=none; b=tkt/2uDooZdYSbBOwDRxV2/NROoe2gN/LmzgqkoJx9qOCuQNmk1KzReIeKQgQEHvCPioHZZjvxqCjhkv+29CEuoQH5cVhPqYudE2k1Pir/W9meHhec48czmm9EsQTEM8+TN9QvDEEIZO+ZCKU5XObhMP3Y+ZYlH9GVVRlq48ndY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913041; c=relaxed/simple;
	bh=GrNoMikzvtGlo0BfQyeaewle2MqoaAopJOxq5AmF0YI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=US9tShIQiTv7RMBGseapKtQ0bhf6/ze775F6LtuvqqNoDgjiYJadNJ4WXVGleAHTSY4LGYaYfabbfhBoQoKFYefXYqv/PIL7BN5IFi559V79hizO8k+kHQEL6i+OY+v+rqyvIKdozeiq69FKCxbwpavI9vkAEubMz49v4lcb+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=D4qr8Bk+; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725913037;
	bh=GrNoMikzvtGlo0BfQyeaewle2MqoaAopJOxq5AmF0YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4qr8Bk+vbOIpPGXW5mdB0P88jMAHQUFe+uiTBsb5v4y+AZGDB3BqAxrfhhvYn6GD
	 ts6a7LbN/sBH4D+1vVeSZztaVCoS37y6cUhh/ODJzzretmaynOc0DnU5hJbr8FclwI
	 0KX81przBZCj6NlyWMBa/JkJbzPBjjLT3j8uoCXN5jc9hzGQ7TcI75eLOGbL6NSRmW
	 pCgb9c40TJKYybJj6FJrRMH0Lz0XkeACHC1ujhgX0ALmFPM68LNagurXadZ3GlbsK7
	 75bYwNlNLlHPV4VMbLFGlqPRJe8qWwNgSo48ARVJSox+tzVouEZICo438ewVJkCZ1K
	 8PXGpYgbq3gww==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X2dRK2nhrz1Kfc;
	Mon,  9 Sep 2024 16:17:17 -0400 (EDT)
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
Subject: [PATCH 6/8] tracing/ftrace: Add might_fault check to syscall probes
Date: Mon,  9 Sep 2024 16:16:50 -0400
Message-Id: <20240909201652.319406-7-mathieu.desnoyers@efficios.com>
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

Add a might_fault() check to validate that the ftrace sys_enter/sys_exit
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
index a3d8ac00793e..0430890cbb42 100644
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


