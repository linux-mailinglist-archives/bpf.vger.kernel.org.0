Return-Path: <bpf+bounces-40841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4322098F265
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 17:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3417281863
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 15:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8E41A727D;
	Thu,  3 Oct 2024 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hbV7WCRK"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5851A2C05;
	Thu,  3 Oct 2024 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968732; cv=none; b=G1l4nigL8+3mqg9chPYfmZV5TDxBKqyOqknvKbzkKasAxi15gcJPQzKQ1Q/nbj6q2yO1vRwUV6XAuAHLj2vYPS7/NOGj54inSox8HAkAj/SY7jzU3rLD9dd2cRF96x2NxwRSf3K5SEg1Q/5K9mL09iuQ8Ol75CF3F3Dc97CwrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968732; c=relaxed/simple;
	bh=mtMV15nwSgC24wpcl6rcJCStzDUXS/XjqRPiMOjRqhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LiEFbYfCFTMASBgvwkwxbDs7f8YI2+QZutwZtP1tJdYeVipW3Wtw7yzH/7/BUCQ+D0qvLqeo/HPe9Lwek9f6GzW00MNA/pfZ3H59XpZzvmussc4hvYgwdI6A+hbhAYeTsHaEp3koKR75ziz8U6237ymwGrnXOQNa8f/Tn/l/64k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hbV7WCRK; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727968725;
	bh=mtMV15nwSgC24wpcl6rcJCStzDUXS/XjqRPiMOjRqhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbV7WCRKltuEdzVtpPFHreHAjf7XCF2DxigiVx4HVFO59+Xs8Po0FO+kKpPKC77PM
	 CF8FV3qm6HiFOse7/ZJHzexYFCXYErjX/9MFVKwWFmCRMsRWrB0zjlcP7cmZycsz4z
	 2uOOe/pe5nwPcuMtDVq3KyAW7VFuad4m/W89czZTYjIGPtJY30jBHrCIOxYrnM0D8K
	 pu6mMNdjuVkFl07TU6LQW0HZiywg3G+yCbXHDNmIiQNaWII1QvHLSfNzpzg0SzdOFT
	 0U43387P7QOocr3w586bS4vLBQbWgpJczOO8K5f5CJ+0p01dKDRxsbnOF33Ms87nfH
	 VFVeKJN4TcsVA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKFgn14Qkz640;
	Thu,  3 Oct 2024 11:18:45 -0400 (EDT)
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
Subject: [PATCH v1 6/8] tracing/ftrace: Add might_fault check to syscall probes
Date: Thu,  3 Oct 2024 11:16:36 -0400
Message-Id: <20241003151638.1608537-7-mathieu.desnoyers@efficios.com>
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


