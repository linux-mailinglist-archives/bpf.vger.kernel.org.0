Return-Path: <bpf+bounces-41330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8872995CB8
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 03:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C8FB24784
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E782488;
	Wed,  9 Oct 2024 01:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="t0lKLsnR"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064B0383B1;
	Wed,  9 Oct 2024 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728436171; cv=none; b=PiJRetNTpXzGf8BYTh/UvQckh2avzCBohGXIAfo3og3quZhsSaEEIv2aqheOuCbZg7w3eAe8BMg0+aZaxSSG4io1zMNNycW/2E10DHRvPTFdykuBkEQl2crQBkOfBGQwSLOUyI/IGi7f5Cdcbc8V32Pa2szZSLs/2jrv4Xu9E1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728436171; c=relaxed/simple;
	bh=ieiW2kYGqwsBuNVmGoUBbM2HLuyk7hfkKWRZ6NViJy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZuTyvp+doxsZIBOjuvqk/LZlTs5NuTWNDfJBYvtZLjFLgrN1ZvuBfG3miR6knF5o8r7UxTC0z+sCOX1/KARLRtukdjDAYGdncnjxUC/Avg5ylqaavSwu7e5A4qbYS7dWx82nur4NblVaZ/Hl3Dv1emORQgDXt8PJYUQl08X2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=t0lKLsnR; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728436168;
	bh=ieiW2kYGqwsBuNVmGoUBbM2HLuyk7hfkKWRZ6NViJy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t0lKLsnR5PjRVE0rV8J95kTGmugjuFnX82nnUotyy/l8Tb9gLPItOh79byMsWF3BN
	 4R2D7Z6Y9tGe7zzLq9f/dJBbUWUWdGa0ShEgWP1J7xeTkKWeqYFqUlsC+bu6mXvIVP
	 V6DTRECU1wRSxcpLUIyEWJ5qtAtZTJ0imSuJUzCPA8uRIDt9WfIRYs5VDJx+WfEe31
	 jq1ZLJRlWSIsCDmU32M2S7BRbSliiWTFMI54k/8qE/sam9hgWYOQ5kpJysOhmqDmwG
	 ZBOte3dwY1cd5h1J7B7Yl5/g5jnKbA6eJx9X/z+g0shU8cPl1lOK6cKX7hEP9pbKS2
	 VjsyGFK3DBEMA==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XNZY43Br3zS26;
	Tue,  8 Oct 2024 21:09:28 -0400 (EDT)
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
Subject: [PATCH v4 8/8] tracing/bpf: Add might_fault check to syscall probes
Date: Tue,  8 Oct 2024 21:07:18 -0400
Message-Id: <20241009010718.2050182-9-mathieu.desnoyers@efficios.com>
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
index fec97c93e1c9..183fa2aa2935 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -57,6 +57,7 @@ __bpf_trace_##call(void *__data, proto)					\
 static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
+	might_fault();							\
 	preempt_disable_notrace();					\
 	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
 	preempt_enable_notrace();					\
-- 
2.39.2


