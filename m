Return-Path: <bpf+bounces-43558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE099B6664
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 15:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634272822D6
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F211F4FD7;
	Wed, 30 Oct 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="X1xVI4KX"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FE61F427F;
	Wed, 30 Oct 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299700; cv=none; b=mmtDhJbvSAydyOwA0ZffmaL7DNGisj23qIeiSuuPgKHGWneUd/VVdMtCBQTY0jwC+1CXGeGBS2BDhbSOx4RXOGeKxAt5hwQHU/+fuSYWlO2quSyNIKnvp5mc8WQzi8wv1GWW6bStdqMClsWkiUUp0/d6V+Ex5FYAYwmmAl0FKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299700; c=relaxed/simple;
	bh=fZ4aXsvx9pf6rtAgOnrIQ2yOSxwJ5B0XGke7hbnZHrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F4sa2RB/LK2RIACZQzhgwiHU71PW43L2qfS8mPpCUZ6q0/ghn0Q5rD+FWN5ZBFIUMN7RbfVDVznavFOWmKjUsF+8edBOZdBrU7XVOLMVVzT9EcbFZtv7QB4otGh/asB9F2YTVK9KYD9CMzuqwmbLHvbbQJDe1YaEdc+14sWKv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=X1xVI4KX; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730299697;
	bh=fZ4aXsvx9pf6rtAgOnrIQ2yOSxwJ5B0XGke7hbnZHrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1xVI4KXD5WGCrUqrtHtzsSmRw7bZlyK/DVPDejOoaFqVc6mjCyIHq2l2rhQ9JMx2
	 ikYEPrdOpApryDWpVMrlFApAbudYJWmgvY8CIWF905Hl63o+m7guPatxoPDzT1DXLp
	 nikxWQkGqfRx4zIOuSV2anayN3TjnePiTAZPOYo/9W5R5tgnJHvrcPEpfl3uJ1O2yv
	 2Z9WWSD38e1VWpUvkn5TJJmZ9IO0Q2upOtnF2/PnuO7LIsmMtndehfYOHa/y0n1MSV
	 ZOKtM6IFBMOclefZXb7kMooK7n5AJG+CZlpPj5mdLM9Qhj463zr6KaOgVSTWdLDfs9
	 VuYnP28by7IiA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Xdqk86zmpzL6D;
	Wed, 30 Oct 2024 10:48:16 -0400 (EDT)
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
Subject: [PATCH v5 4/4] tracing: Add might_fault() check in __DECLARE_TRACE_SYSCALL
Date: Wed, 30 Oct 2024 10:46:34 -0400
Message-Id: <20241030144634.721630-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241030144634.721630-1-mathieu.desnoyers@efficios.com>
References: <20241030144634.721630-1-mathieu.desnoyers@efficios.com>
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


