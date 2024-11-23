Return-Path: <bpf+bounces-45505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C049D69A3
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 16:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E658161926
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A88C137932;
	Sat, 23 Nov 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PcmxkhQR"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD7633080;
	Sat, 23 Nov 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732375876; cv=none; b=grwSiTdr8/bF+s063taGo8lqMwRHqd1X+w/SXS9f+HeHBUaWtaG6HJwgtHrYj7nBgZH5YWdd2w/X/jv5w4Kh2IYSoDmsBZN5BikgZP5hqSAr72dwdybTGK8RzouVLLenNLVeSgkLNitoO8tp6cMV0n/3ApKsQbpZFn4h7nwZFvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732375876; c=relaxed/simple;
	bh=4yFMkGI4raQM06el/6CnWRJeiPzvsvqtwYjLIL9IY7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JU79f+vkld3oZtf/Gc9QSMADrLhD6M6ZlO9BIomJPRnRbubo9bJGUY8qKQCXTdpZhfbAX1pVzNUOCOM9c/zDWezwjGNEitNg23Q2pZmVfOQkKGKNjbKl9SaDytEddMUpXte5xFney4FQvcSyRSqrAdxufrXA9XuDuHS5K/lF/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=PcmxkhQR; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1732375867;
	bh=4yFMkGI4raQM06el/6CnWRJeiPzvsvqtwYjLIL9IY7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PcmxkhQRLL0fuh15nHiFdpNeE6cJ+eJ/A4AOyS44Qbg2e4VWxm6xmP3TKTe/71a8g
	 NyeDXpZTPAtQAhe+jpZf1pdgKABhV035m7Pyrsb41TAWmqqKovlZGAZnB8LYVaXq79
	 U5km0J85zz2VNUEJF4TziKJ/cgz37Ef5oEX0mTZ2kkWAF9lanZNW26vVSCaMQW84xC
	 KRbsITN1z+U9rp+Pf3FnjLKQ9wTurKv0FhGn8V4N08e4s4NnLCbjQXN9lVCbe5MzxL
	 U4+AiXIubLU2+vKDY271McCk56yi0i6ns/i+Wbfy1jVTMr5drmAUhmWKTJ7s7IJ700
	 yDayKhuIbWy6w==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2605:8d80:581:d239:b14d:eb44:5229:ce95])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XwbXT6cntzWdN;
	Sat, 23 Nov 2024 10:31:05 -0500 (EST)
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
Subject: [RFC PATCH 1/5] tracing: Move it_func[0] comment to the relevant context
Date: Sat, 23 Nov 2024 10:30:27 -0500
Message-Id: <20241123153031.2884933-2-mathieu.desnoyers@efficios.com>
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

When introducing __DO_TRACE_CALL(), the iteration over it_func moved
from __DO_TRACE() to __tracepoint_iter_##_name(), but the comment
relevant for this iterator was left in its original location.

Move the comment to the relevant context.

Fixes: d25e37d89dd2 ("tracepoint: Optimize using static_call()")
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
 include/linux/tracepoint.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 425123e921ac..d390e8cabf02 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -210,9 +210,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
 /*
- * it_func[0] is never NULL because there is at least one element in the array
- * when the array itself is non NULL.
- *
  * With @syscall=0, the tracepoint callback array dereference is
  * protected by disabling preemption.
  * With @syscall=1, the tracepoint callback array dereference is
@@ -316,6 +313,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * We have no guarantee that gcc and the linker won't up-align the tracepoint
  * structures, so we create an array of pointers that will be used for iteration
  * on the tracepoints.
+ *
+ * it_func[0] is never NULL because there is at least one element in the array
+ * when the array itself is non NULL.
  */
 #define __DEFINE_TRACE_EXT(_name, _ext, proto, args)			\
 	static const char __tpstrtab_##_name[]				\
-- 
2.39.5


