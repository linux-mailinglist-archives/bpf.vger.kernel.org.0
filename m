Return-Path: <bpf+bounces-45507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF799D69A8
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 16:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4991161A8F
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE43E13D246;
	Sat, 23 Nov 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="p2/tdYbG"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22FE4EB50;
	Sat, 23 Nov 2024 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732375877; cv=none; b=Ml4HA79Zz2AelVl6imTJOj72wIFMd6a8ZARbSS4c/bfPxqvf8zOyePesH5fY47ghs3EOLDph4jFgwwSLZZsLFDihOxwDZkJqJmtce8xLhW10L8d3mfzyvoaLgvf3KD11DsG0TQpe8BkFf/BwWWpttu++CuCVyF8VeB9GOpxRWu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732375877; c=relaxed/simple;
	bh=EOfxF3tLvF9HqHYQR7sA38ekMGr8Pg0SKECnutF9XlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGhJPqNg2RPqOhSQ6GGpDoR2apZCivYJxnlX05Fkb8S5yxady6O08aEp2IDalvQ/Ot3VE5s/oXVgzxOG9V1L2xali4Duz5LzfXvL8RcKJYBXS8xjdqNEXcLMNeNYIUaduDGSwnb003NQN10SgYKAuRH8ZSZDX1V2ZObBN/OsQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=p2/tdYbG; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1732375868;
	bh=EOfxF3tLvF9HqHYQR7sA38ekMGr8Pg0SKECnutF9XlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2/tdYbG/WIIKvyHcAAO59RV0zWO0TItfHCbTJ/cqz/QeUKY1aS+Ed5Admjj+aGkE
	 emMwRoX/QrHsr6JOZCxWcgckpBdoSBxCf9cr7UXshwFlP07ag1MnOaBKdWLVVmFei9
	 aCgo1K5R5r+tPQUj3U69YY1vdDMCh1m9snaJ6kM+TQysNspEiG7x2rOO+fcrFVFCUm
	 JgYN6ocZOWSCz40aSxizLjPsj+6jIrDe2hrBZsmYxqY9Lf7SCMYgU0taP/MQ3sXGoF
	 2rJ6okg3tM2i/GTnn9EWKk0TuJ9FpJBP/wGk1LUZx4kVUTi+Y3yQF3MJ5EFHObWP+3
	 Lkmpd5yBaJaNg==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2605:8d80:581:d239:b14d:eb44:5229:ce95])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XwbXW2Py7zWdP;
	Sat, 23 Nov 2024 10:31:07 -0500 (EST)
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
Subject: [RFC PATCH 2/5] tracing: Remove __idx variable from __DO_TRACE
Date: Sat, 23 Nov 2024 10:30:28 -0500
Message-Id: <20241123153031.2884933-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the removal of SRCU-protected tracepoints, the __idx variable in
__DO_TRACE is unused. Remove this variable.

Fixes: 48bcda684823 ("tracing: Remove definition of trace_*_rcuidle()")
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
 include/linux/tracepoint.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index d390e8cabf02..867f3c1ac7dc 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -218,8 +218,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  */
 #define __DO_TRACE(name, args, cond, syscall)				\
 	do {								\
-		int __maybe_unused __idx = 0;				\
-									\
 		if (!(cond))						\
 			return;						\
 									\
-- 
2.39.5


