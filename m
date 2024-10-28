Return-Path: <bpf+bounces-43326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 900489B3A3F
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CE91F22549
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 19:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047A81E0B80;
	Mon, 28 Oct 2024 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nHdTMwJX"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1287E1E0DB2;
	Mon, 28 Oct 2024 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142679; cv=none; b=cJWws71NPvnbC1HBuEhKFX+v9o+6isjfSq3uXQIjyF5G+BP8guTaz62VDHtRxe72jnsm1093ra03ExScPFv6o4y4LeV33gm8gbPfNiL7t+xmr+GB9lq1TvI4riYI4dIc2C5TqJedo9ig1WVGV0htU7RS4/5CGEba2+N4xw7LDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142679; c=relaxed/simple;
	bh=oe4SEYpQcTZHF0AxYZqODo9TxSAdD2NyXwBNnVcz1u0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=unX5GeQSF06/njLEcYxMuebrjCVOtgUxyNRe0FLe2IIYfNWmKcPq1E44XPnlC9AR2RDsvuwCWTKqK2blRgWCIFq4c0yHZBKIZ1KxQncaySeA809bFTR1Ye0Gl8BGzfWrD0rpE5MuKYa1aJFlTlPiZT3Q0lUpg8fyxOIreeGnGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=nHdTMwJX; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730142676;
	bh=oe4SEYpQcTZHF0AxYZqODo9TxSAdD2NyXwBNnVcz1u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHdTMwJXTbvmuXGKKeTxcGet3NeRKeaG41zIXPHPhwWibKhpHTCzvWNfTOjcz2ybW
	 pWaR7k1xxbPmj4oQD2W2PQ1O3gQwPPgG6soAhOD9biW/+p90IPVFPrP+qKxJW7WqvH
	 FMMsxM/RQ4pg+1rC++s0MGzdN1O86Na6ERsggzoD0q+iKPcVWwAsGbqZds/EOBQQG6
	 SnE7xV/DEjzlvlvd91333KyHh67ChHI4P80Z4bXBVBU+OVO+whqbz0OLpwmrKMvZFH
	 ykAb/8ng42EGPr9X8u0sDfh5pwRMWoKBMbs+fVqBMGk0g2c5H5HcHnY1vKLW1A2UG0
	 TwRRWVuXiiV4g==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XcjfW5Xtlzs8q;
	Mon, 28 Oct 2024 15:11:15 -0400 (EDT)
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
	Jordan Rife <jrife@google.com>
Subject: [RFC PATCH v4 4/4] tracing: Add might_fault() check in __DO_TRACE() for syscall
Date: Mon, 28 Oct 2024 15:09:27 -0400
Message-Id: <20241028190927.648953-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241028190927.648953-1-mathieu.desnoyers@efficios.com>
References: <20241028190927.648953-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Catch incorrect use of syscall tracepoints even if no probes are
registered by adding a might_fault() check in __DO_TRACE() when
syscall=1.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
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
---
 include/linux/tracepoint.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 259f0ab4ece6..7bed499b7055 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -226,10 +226,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		if (!(cond))						\
 			return;						\
 									\
-		if (syscall)						\
+		if (syscall) {						\
 			rcu_read_lock_trace();				\
-		else							\
+			might_fault();					\
+		} else {						\
 			preempt_disable_notrace();			\
+		}							\
 									\
 		__DO_TRACE_CALL(name, TP_ARGS(args));			\
 									\
-- 
2.39.5


