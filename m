Return-Path: <bpf+bounces-40840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF598F262
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 17:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6211C211F6
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17CD1A7250;
	Thu,  3 Oct 2024 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="p4BRDEib"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012319EECD;
	Thu,  3 Oct 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968732; cv=none; b=VyMtj+qgXPtUCcCQfwfHF9fAP7ncGip7s35Y1NpRkymn4gvvp2zG2MPkKyk4ZD76Br+t6QmwQcDF1LJBLfryZBwMwoyHmjU1gikTsdRrZMB4d9D8/OyMhl3klSd0tcTzf8qlgdRcEprGiOiraupnchCzajptyY9DDP9QXTd9bI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968732; c=relaxed/simple;
	bh=iV8BNOEUAlVnHaxKIKuldZvcuyZQrIw4r05iL6v8clg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGixRWpNp9OvqC9TB0Dc4aoJ+z3n7iD+FTAXIIcYQdnU94iejxcL9yLWHRd0UAC6Z7iTmC+dWfUxiBd/3b+keVKmxXoNLXsmo9N7QVMFEsCk/IG8lf/76Q/p4KNj4LR109fzkiESgFCUsHLRXwjGAWu24hOBgSikxvADrhYr2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=p4BRDEib; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727968726;
	bh=iV8BNOEUAlVnHaxKIKuldZvcuyZQrIw4r05iL6v8clg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p4BRDEibEFUrShfp4oo5FOB2ZXFQ/6+zGl80lZBPupnfK9PBU6VtoFe0cOPyGtQ0x
	 P/XF1NaRyDifYVq/vKFoePTlsCxt8nxL7J1Vt3Q+5I2KL/gMSOnA5521p6TS+X9KDO
	 LDPGZxlm1reC4mguEwMaNhhuGWsZVFkLAXpAibjCzKkuiDSAfT12ROUwZbJBpA6+Yr
	 RGS3g6MtJlQ6hvChtYmBJ+d/kQL7+GazLYyhP/flAE5Bnk5E0Zw1X+lJ+XF6HdtDjA
	 DHmGRjdAsvrRUsNO8sJwx+fE/rGfBSdUHDDiuyLGSpIA4B7l8stXnKrWQ8ZLIfMxnk
	 5YJbpwO3FUFew==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKFgn6Jqyz6Dp;
	Thu,  3 Oct 2024 11:18:45 -0400 (EDT)
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
Subject: [PATCH v1 8/8] tracing/bpf: Add might_fault check to syscall probes
Date: Thu,  3 Oct 2024 11:16:38 -0400
Message-Id: <20241003151638.1608537-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a might_fault() check to validate that the bpf sys_enter/sys_exit
probe callbacks are indeed called from a context where page faults can
be handled.

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
 include/trace/bpf_probe.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 211b98d45fc6..099df5c3e38a 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -57,6 +57,7 @@ __bpf_trace_##call(void *__data, proto)					\
 static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
+	might_fault();							\
 	guard(preempt_notrace)();					\
 	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
 }
-- 
2.39.2


