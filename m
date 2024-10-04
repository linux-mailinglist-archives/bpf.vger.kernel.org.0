Return-Path: <bpf+bounces-40959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5E39906FC
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 17:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3322328C723
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 15:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99941C878A;
	Fri,  4 Oct 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XhoaZy8j"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7509D1C3026;
	Fri,  4 Oct 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054030; cv=none; b=W8vbcu77nPqAeV+7YyOFIPEN1PxvXPWFZJQXQZUvx8ljS7ZudhUH9G7zqcaP2m3fzQFFCbw4NPFEV/a8x4hMTldkU9aucj0d/Hv/nmWgLij1gAPwW4a/ZIU8KIjPgr0LgFmI38VS7KzqCL+OYvhuF4W8pzyxA0pgO0Ftu68T4sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054030; c=relaxed/simple;
	bh=iV8BNOEUAlVnHaxKIKuldZvcuyZQrIw4r05iL6v8clg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UjovsuDvrRAPHAbt56qLMrv0E+TRG1nTw1KFEN1ePomyhCAHxs+7goLnbr55lUaFpgemvR61TqCZTn73qNPAWOYimKNWRJF/zleA2uPNt5gLNwJXEGp1C4QO7UnCiOqAgt6JLUXRthBBNNHm3Vv8klWiPRQV359HRfxuqm5a0ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XhoaZy8j; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728054026;
	bh=iV8BNOEUAlVnHaxKIKuldZvcuyZQrIw4r05iL6v8clg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XhoaZy8jP0c1jWvwuyvi+10iEuwvdnL1B606gVLa7VF1xV49UTrLpgQK+ITIRzgNm
	 U9s/W+zcH9Nsl7tc8lhEHgqXCCbxbCLE6XOwW+OmGGDC12fq4512bmA/zUDQILnchB
	 xvikTBICwXGsFAjQdcD0Gk2AWWp7taEGFQ9z0NHcGS2nLM6fRHiwJd50TM6zyqmvwL
	 XKeIOv/+b1lcBJlmHO6tsTYQn77lKrms/poelVzmtYrf8jfE/VNtJs8/H0/XquVa2c
	 SvoBtdY0bQxYFHncxIM1+juz9B0ybLkGrlUnqvbOKzgGEijJGeIHzpKtfzv/3QKX+2
	 Bo21v5pQUBEgA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKsD97579zLN6;
	Fri,  4 Oct 2024 11:00:25 -0400 (EDT)
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
Subject: [PATCH v3 8/8] tracing/bpf: Add might_fault check to syscall probes
Date: Fri,  4 Oct 2024 10:58:18 -0400
Message-Id: <20241004145818.1726671-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241004145818.1726671-1-mathieu.desnoyers@efficios.com>
References: <20241004145818.1726671-1-mathieu.desnoyers@efficios.com>
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


