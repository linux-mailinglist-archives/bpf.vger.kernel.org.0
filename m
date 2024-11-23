Return-Path: <bpf+bounces-45508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B3B9D69A9
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 16:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23411B22073
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024F51531E8;
	Sat, 23 Nov 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jXlfvbmd"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF770826;
	Sat, 23 Nov 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732375878; cv=none; b=rf65h1NUape1cn6XzSgBO7uWt2TZrsz76npDH7x3nIajIGjSJB2G6M9OieTqluhFwagQxbBZSHprdbi6bdwloowAwGMfa+xxulmwBa87vaq+kzlPt8vOKQiU7GZFQAMo2mwRMUQvVD6vMamU3K1F+wCYKgMzNw5a4Ew8h4+wTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732375878; c=relaxed/simple;
	bh=nsGIOY4b7iQFhOWQP1p8x1RRH9X+LeZzOKUnchZFZu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+5pl9t4MSoSO1Iowg0JIA1G02IVsi6dtZ+NaGg2Wr4a0kYQtI9xoFsVG23NOYimNqkoT6Xs+Yj2mToz2bqlYXjWEab0BuxIq+IJzm9pFSsLhx20Y83AIDBTi/DnQOZozLHtom98wIaThJE/l3MYnWcXHy1h9EDMkR5O6jkT2N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jXlfvbmd; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1732375870;
	bh=nsGIOY4b7iQFhOWQP1p8x1RRH9X+LeZzOKUnchZFZu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jXlfvbmdZ5lm9p5XjdpX6T0a2SeTk8gDIyDawyPK/ewL05hmYCP+k1KS38bbTF/Do
	 B5RntZ0LfA68mZPb3b3WpsIYmgkKHYIyTIT06YueNLmAeD4nztiLYDdB8PIUr+yZS7
	 74JD2t63SMk9/4+2n47HHDgo+a/z0x6gNP+tUy4b0pc6OL6tLn2JnlrGPR+pWDKqqZ
	 8uMlMothPxV8Hxbsftz09siGDpRm2jKDvlfsKyVOSKhCOOqOccuuB9DTawpvjsi4J7
	 RuDKPGZ8RrzeLGL9l0Tb/AnBaUAAME/MM7FraZ12LfVhmvwgWBj6F5+eigsxn0LVZC
	 5pxGvHWPgeC4Q==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2605:8d80:581:d239:b14d:eb44:5229:ce95])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XwbXY1KKFzWdQ;
	Sat, 23 Nov 2024 10:31:09 -0500 (EST)
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
Subject: [RFC PATCH 3/5] rcupdate_trace: Define rcu_tasks_trace lock guard
Date: Sat, 23 Nov 2024 10:30:29 -0500
Message-Id: <20241123153031.2884933-4-mathieu.desnoyers@efficios.com>
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

Define a rcu_tasks_trace lock guard for use by the syscall enter/exit
tracepoints.

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
2.39.5


