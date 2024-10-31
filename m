Return-Path: <bpf+bounces-43650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05DD9B7E46
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 16:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB311C21998
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA1B1AC435;
	Thu, 31 Oct 2024 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="q7RzlL20"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EEA19EEC0;
	Thu, 31 Oct 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388161; cv=none; b=cS6sIS8a5xN+iFWls+lq9r2utvyDYwD+ZeNr/vRiLfboO6sU6v/cVckigLR2kEAfYahAqE/OHJAqb4DOJvMG44FsBhgGaPrLd6oaFNjsKI6iVvv4GBoJ43s7oejVATZ5igPZbZ95KD5yUGWLQWKyM1fakI7vvcQ2LZnvwSUCHEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388161; c=relaxed/simple;
	bh=1JG3SedAvu6H20LverMfft7wKhK0l6XRFxFKT0bDtNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QxW+Usryr+u43y/MpUY6d67xsJ5KiSWSDHrtTQaEiSGETAdUDP352Tl00YMqwUoF2jy3Zk/ih9HAb8XQVRfrLy+0e2SReYe5+oOb5r0u1p5yCcwJZXH9fR3SEsaDATbV90CQ6Pxr7gQTEvm7EskjrIPeYDk29ckzGgUCIjX31E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=q7RzlL20; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730388158;
	bh=1JG3SedAvu6H20LverMfft7wKhK0l6XRFxFKT0bDtNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7RzlL20hK5IMI78YT99IFbNkuxbPnWE61ntFTjEAZ9zUs2WIdTrBSDp03Mlgrm0k
	 5/LXPja03k1+FSHzGv1YyXAPHZsxdhXi2fWPqR+oRvxjSjBjp45KDHhm5dmS5YgddB
	 RzosnGeIoePA9VPEld3MMAdW9PCNsNwq2EVxAwEQGisow1Sw+HGZkr2H3Ae4x/lq5h
	 lM6/nkavFjVm05w7dSRRPJfIrQOapbmRiO0AM41zPWBWnZ8JoOmyRYMQVshxYT9tEL
	 SjDl8vcvApISIUQ+G0gQVtKqNMtzx+VUjYTHkKdhLiIw1E2TBx7GxX24qbHxdyD/EZ
	 wKIvYXfTNolGA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XfSRL0KgbzYlN;
	Thu, 31 Oct 2024 11:22:38 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: [PATCH v5 resend 4/4] tracing: Add might_fault() check in __DECLARE_TRACE_SYSCALL
Date: Thu, 31 Oct 2024 11:20:56 -0400
Message-Id: <20241031152056.744137-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031152056.744137-1-mathieu.desnoyers@efficios.com>
References: <20241031152056.744137-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Catch incorrect use of syscall tracepoints even if no probes are
registered by adding a might_fault() check in trace_##name()
emitted by __DECLARE_TRACE_SYSCALL.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jordan Rife <jrife@google.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
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
Cc: Jordan Rife <jrife@google.com>
Cc: linux-trace-kernel@vger.kernel.org
---
Changes since v4:
- Move might_fault() to trace_##name() emitted by __DECLARE_TRACE_SYSCALL
  so it is validated even when the tracepoint is disabled.
---
 include/linux/tracepoint.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 906f3091d23d..425123e921ac 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -301,6 +301,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
 	static inline void trace_##name(proto)				\
 	{								\
+		might_fault();						\
 		if (static_branch_unlikely(&__tracepoint_##name.key))	\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
-- 
2.39.5


