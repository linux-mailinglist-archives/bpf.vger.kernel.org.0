Return-Path: <bpf+bounces-43720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC1D9B8F63
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 11:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B30B23426
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 10:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441C21AAE18;
	Fri,  1 Nov 2024 10:36:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD911AA782;
	Fri,  1 Nov 2024 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457370; cv=none; b=N4FFp5xIfpXMWn5GbmNN4IkVMo4Ok4WCXV5BLRqNuqY6QrFaJn4A/r5sqKFomrSStQMtbC6bRzpcJDNxfqPgsaJuYcbBU/fjDLC7qWxSEqOtLJwlgx2TbURxQK8UIYv3scFb3ryXiBZOpQ3doYuDfV/TtfGuGp8RN4mpaRsSdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457370; c=relaxed/simple;
	bh=E5aIvIh/79Y8klDUzv69R95Ek4HDw81gwTgCQmUzMWU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rhL+055zV6Vrbq2OHUx7KZpC9pfuaf6Acg5YvqC/cAr9bpKN70kLE+vYV8NmIeRJ/elwkZ2nwehAaDkMnHKNATFEH8lu9F95avE1GD4+vt/VvBPDEt0AjzSnalBIySBup2IvY2hSiSIOnH4ab9pl9lVaAOIL1T/Q5WSvJ6/7ndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4689CC4CED2;
	Fri,  1 Nov 2024 10:36:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t6p1g-00000005S92-2L6K;
	Fri, 01 Nov 2024 06:37:08 -0400
Message-ID: <20241101103708.417405830@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 06:36:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Jordan Rife <jrife@google.com>,
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
 linux-trace-kernel@vger.kernel.org
Subject: [for-next][PATCH 10/11] tracing: Add might_fault() check in __DECLARE_TRACE_SYSCALL
References: <20241101103647.011707614@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Catch incorrect use of syscall tracepoints even if no probes are
registered by adding a might_fault() check in trace_##name()
emitted by __DECLARE_TRACE_SYSCALL.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jordan Rife <jrife@google.com>
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
Link: https://lore.kernel.org/20241031152056.744137-5-mathieu.desnoyers@efficios.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.45.2



