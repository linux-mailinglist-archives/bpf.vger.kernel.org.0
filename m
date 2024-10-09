Return-Path: <bpf+bounces-41326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4822A995CB0
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 03:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715621C21692
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A3939FD9;
	Wed,  9 Oct 2024 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="P1lucqym"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD141362;
	Wed,  9 Oct 2024 01:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728436169; cv=none; b=pCYbet1IXJrx8AKW04gfdt3LNuKpYbedqCyf+PqpkghJfjEe3n5LFe4fCGznwlnG9M1IMNAvW8fUPqH5kLRY9zvbMw/D/2UXWXlMwo0qOnklLq998ucvLejB2ZXWMxKycxK9TjkSesXLGmm3dVyi1Jx/ekfYR1D8jUNCAc3ZNCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728436169; c=relaxed/simple;
	bh=iSSllkHBWxAJbk0upmkSgPfW8LWMvGyMz70ZbLXtUEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aKpjvXKsxnEtgsg9QfP+5vCokEi7es+4WqqkNRcC+QBGw/EZKawQH9yvZLOojbXAlRt11+5A+bnOtLEjijrOhRgwtks1Gd/Qeo6VXJw7fgtBCS8fjikfnuJvAS2jyyW2ygTsG93ixHzHuOrEy3bhcWIZnduwVESZzj8DHHztxe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=P1lucqym; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728436167;
	bh=iSSllkHBWxAJbk0upmkSgPfW8LWMvGyMz70ZbLXtUEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1lucqym3aeFu9FresiOdQlEFtsYuePOYNw9jqXVwZE4mLsWG4XMgtz8tfaGfjEJH
	 Ho1pvTPieUMG1wAKRlx2QcnNXAKGyv/G/nbkiipDjva8c52yijvc5CWDqkyMTEOUCR
	 UWcd9KPsGgIWBATA+/ZqTNVk19YHOS/66kqOJkLCfFHTak/M+Su/MS5MhcvZe7h0jO
	 rmBbcgTum7h2nAo8zU3erW857Ds0saIUMYigNNdRJ1qQrJgv5rMKHnoZxfIbwdvKI+
	 IPsv0so3SdH/bFy3FEWnsXLfyIyhFsB8OUlAw8+SLZ2DuIIX1aV3luvKrq4PFksPYm
	 KOK0n50mtMouQ==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XNZY24gkpzS0Q;
	Tue,  8 Oct 2024 21:09:26 -0400 (EDT)
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
	Andrii Nakryiko <andrii@kernel.org>,
	Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH v4 4/8] tracing/bpf: disable preemption in syscall probe
Date: Tue,  8 Oct 2024 21:07:14 -0400
Message-Id: <20241009010718.2050182-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241009010718.2050182-1-mathieu.desnoyers@efficios.com>
References: <20241009010718.2050182-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for allowing system call enter/exit instrumentation to
handle page faults, make sure that bpf can handle this change by
explicitly disabling preemption within the bpf system call tracepoint
probes to respect the current expectations within bpf tracing code.

This change does not yet allow bpf to take page faults per se within its
probe, but allows its existing probes to adapt to the upcoming change.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org> # BPF parts
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
Changes since v3:
- Do not use guard() for single line function, based on feedback from
  Steven.
---
 include/trace/bpf_probe.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index c85bbce5aaa5..fec97c93e1c9 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -53,8 +53,18 @@ __bpf_trace_##call(void *__data, proto)					\
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
 
+#define __BPF_DECLARE_TRACE_SYSCALL(call, proto, args)			\
+static notrace void							\
+__bpf_trace_##call(void *__data, proto)					\
+{									\
+	preempt_disable_notrace();					\
+	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
+	preempt_enable_notrace();					\
+}
+
 #undef DECLARE_EVENT_SYSCALL_CLASS
-#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
+#define DECLARE_EVENT_SYSCALL_CLASS(call, proto, args, tstruct, assign, print)	\
+	__BPF_DECLARE_TRACE_SYSCALL(call, PARAMS(proto), PARAMS(args))
 
 /*
  * This part is compiled out, it is only here as a build time check
-- 
2.39.2


