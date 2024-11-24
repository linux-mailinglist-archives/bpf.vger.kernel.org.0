Return-Path: <bpf+bounces-45553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F094A9D7932
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 00:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67BF2825E2
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 23:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CFE18BC26;
	Sun, 24 Nov 2024 23:49:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF21607A4;
	Sun, 24 Nov 2024 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492173; cv=none; b=TP7GonF3cLvSDGk0n+Hg6Bb0j3GvTQ3kWc7wWpdgYHntMWNjvOpVCuKVyqvS3Eh2w7vA66wOMYfLv5XQrbxwXxYRiA8qbfUKi8z8cDc3CmyypqQS5Oy737hTpGgyKmJ3SbkZ474PhFmMxrhW81brL5+7kaEANQJDFR9A/+cY6dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492173; c=relaxed/simple;
	bh=yCUNkk6yShU8TZGlAY96O7m0lA5Zg/DBQJ7E8YVPT4w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kObRDymY3cxIfjPz4RSQ/f1nSpajimhmP0aiHcjM6ICu1uY7nPO9Dpb39A2W6YYEZM6byA5gv2SXTwIqbWUqaU6QFpqUHGRChh918pxUrsxMSpsLc+FzM74qh/ZJ1KvNmL+jKcIBlBjt9Kdd2YzVjFxvnND247xaH4JVLg8uweQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB8CC4CED3;
	Sun, 24 Nov 2024 23:49:33 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tFMMt-00000006vke-140A;
	Sun, 24 Nov 2024 18:50:19 -0500
Message-ID: <20241124235019.106333158@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 24 Nov 2024 18:49:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
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
 Jordan Rife <jrife@google.com>,
 linux-trace-kernel@vger.kernel.org
Subject: [for-next][PATCH 4/6] rcupdate_trace: Define rcu_tasks_trace lock guard
References: <20241124234940.017394686@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Define a rcu_tasks_trace lock guard for use by the syscall enter/exit
tracepoints.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
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
Cc: Jordan Rife <jrife@google.com>
Cc: linux-trace-kernel@vger.kernel.org
Link: https://lore.kernel.org/20241123153031.2884933-4-mathieu.desnoyers@efficios.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/rcupdate_trace.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index eda493200663..e6c44eb428ab 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -10,6 +10,7 @@
 
 #include <linux/sched.h>
 #include <linux/rcupdate.h>
+#include <linux/cleanup.h>
 
 extern struct lockdep_map rcu_trace_lock_map;
 
@@ -98,4 +99,8 @@ static inline void rcu_read_lock_trace(void) { BUG(); }
 static inline void rcu_read_unlock_trace(void) { BUG(); }
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
+DEFINE_LOCK_GUARD_0(rcu_tasks_trace,
+	rcu_read_lock_trace(),
+	rcu_read_unlock_trace())
+
 #endif /* __LINUX_RCUPDATE_TRACE_H */
-- 
2.45.2



