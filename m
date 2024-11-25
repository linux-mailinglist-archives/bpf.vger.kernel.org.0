Return-Path: <bpf+bounces-45573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E1A9D88C7
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 16:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118BBB2CA96
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 14:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EFD1AF0C7;
	Mon, 25 Nov 2024 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="aDsUgCir"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C7B184520;
	Mon, 25 Nov 2024 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544749; cv=none; b=MLzpFGtetlHmhfr3h8kBDMZSvS9KyyAaI8xaNl1Y8z7RmiFS+lgglZs57IU489KGrAJDrSEbJS85lvYmjUIA/HZN+Kg4cdcJZEk8AJWppWoNVDTToXX7tPkN93VVWUS082mGK42MZzkSNEYkIyd3EisXjCIwi9lHmsOzYy4iWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544749; c=relaxed/simple;
	bh=Fanz13Kja57GOc7eZ2x1CqPMImX3rbniUPwrJUCJ2kQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zlh0xpb4C+26Y8ClqP1A2Jw8mD5q+Ogp7VmENQWrqvBi20gx8cCHbv7m2uGJ4vTWfr6LAApmBIKTuWkhgdKAqS8Hr31WKpK/87k5ppYO2NTd+ExFE+fubKLNC1ZMkLeVZgwUjoxfeYZVzgvBUr7L9ebrIjOvojQstPbInMDFhgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=aDsUgCir; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1732544746;
	bh=Fanz13Kja57GOc7eZ2x1CqPMImX3rbniUPwrJUCJ2kQ=;
	h=From:To:Cc:Subject:Date:From;
	b=aDsUgCiriQ/Cp3QWecHUoNIz8qb1ss9Csd0HPWiT7RuZt0o83YSXnWQ9tNuwoV/jQ
	 wURBthsd3Ho4KE5O+kxmWhpjrvQYnN9dbC+qyIlp6uFCRYsmRabigUM6526FOGpMqN
	 i2Nzt4hERmqgvmQEua5ai+ThpJ9owOil2ZnEUPzGg2I0mu73ois36ylEYqPNOfaTJE
	 Ymv+e43iC1gXTAqmWlKk+dcCbM+2OOGZpXVclT/z/QEBoPWKPJgrri+nMaTE6IqNqL
	 Jbbg7ehfuknrPMAv27Ez8j+TfohrbZnsmsQuLsUtMvRU1H9ic6BvT+rJIBlQ9rDSNT
	 OSy5FRx3xWKcA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Xxp096vG0zyXW;
	Mon, 25 Nov 2024 09:25:45 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Jeanson <mjeanson@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
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
	Jordan Rife <jrife@google.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] tracing: Use guard() rather than scoped_guard()
Date: Mon, 25 Nov 2024 09:25:14 -0500
Message-Id: <20241125142514.2897143-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using scoped_guard() in the implementation of trace_##name() adds an
unnecessary level of indentation.

[ This is based on the series "tracing: Remove conditional locking from
  tracepoint". ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
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
---
 include/linux/tracepoint.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index b2633a72e871..e398f6e43f61 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -259,8 +259,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	{								\
 		if (static_branch_unlikely(&__tracepoint_##name.key)) { \
 			if (cond) {					\
-				scoped_guard(preempt_notrace)		\
-					__DO_TRACE_CALL(name, TP_ARGS(args)); \
+				guard(preempt_notrace)();		\
+				__DO_TRACE_CALL(name, TP_ARGS(args));	\
 			}						\
 		}							\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
@@ -275,8 +275,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	{								\
 		might_fault();						\
 		if (static_branch_unlikely(&__tracepoint_##name.key)) {	\
-			scoped_guard(rcu_tasks_trace)			\
-				__DO_TRACE_CALL(name, TP_ARGS(args));	\
+			guard(rcu_tasks_trace)();			\
+			__DO_TRACE_CALL(name, TP_ARGS(args));		\
 		}							\
 		if (IS_ENABLED(CONFIG_LOCKDEP)) {			\
 			WARN_ONCE(!rcu_is_watching(),			\
-- 
2.39.5


