Return-Path: <bpf+bounces-40898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFDA98FBD5
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 03:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26CE1F222C1
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 01:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8614F11CBD;
	Fri,  4 Oct 2024 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cra/Vffb"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B4479E5;
	Fri,  4 Oct 2024 01:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728004450; cv=none; b=ay9KQ9sqcpY1JluEitpEcf4AuLLkMJW1pPBTVvUnt6pdJT6G26BEZz74nFFeDdAQEWfwKByDJTm2CQFkITCXG1oNPyyTOYEjK5Bw5BdmuSyNsK8kJ2FEwfreCJQoQMYalGwU9QbHbh/KhtDD9C66lUKDDSXe2NgxHnaDnUJH4u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728004450; c=relaxed/simple;
	bh=k6kMgX0hVkDhByV+E0NWNaA9K9fsGsrPdkDSm9yWatg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OprPdcvc0X3uLcmqLRq81X9V7ZWu8Elh3AwwnW9R67rYZIdceOE2ND+aQw5c/11fWlxAVS1hRiJKkjrth2p7hF1HcSx+X8tvmOKob+UKh1LWKNP1mEPWEPaWKuIHtR1Jd2FS6ixnriYmfvmjt2sx42Ccb7rZS8WF+MUiPFoNPLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cra/Vffb; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728004447;
	bh=k6kMgX0hVkDhByV+E0NWNaA9K9fsGsrPdkDSm9yWatg=;
	h=From:To:Cc:Subject:Date:From;
	b=cra/Vffb6DNGwISzrVq1nLkS77p21mVVG/YohglWvCk/zmmqNsiHlbiDybY7glKej
	 mQcuyWM8Xeb6cQwDxiLrI2hV9Od+6jZYbkFhBlkhr2TyWYlwsdmXMk02ZgkoFj9wkx
	 XE+vxf9OpEj8fRayUNj4MpEHFpPWl4GkNIxTNbG7/mvAQddoXhMmWlpHioERLwoP9n
	 dfLXXLgk+dn0fGs/vJMg3nkJDZmSdlG/MiB1LB6mr2M8HIL0YV1aSpLKaFyCdN0jOJ
	 O92e5/7sJzTlrWjqa6eo7p5Fi3vMbjMUptuFJDmNOMZy+eSrKy4A4OO3RcgDNER145
	 v9jpc4+ypy+hg==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKVtl0nLrzC3r;
	Thu,  3 Oct 2024 21:14:07 -0400 (EDT)
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
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] tracing: Allow system call tracepoints to handle page faults
Date: Thu,  3 Oct 2024 21:11:54 -0400
Message-Id: <20241004011201.1681962-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire up the system call tracepoints with Tasks Trace RCU to allow
the ftrace, perf, and eBPF tracers to handle page faults.

This series does the initial wire-up allowing tracers to handle page
faults, but leaves out the actual handling of said page faults as future
work.

This series was compile and runtime tested with ftrace and perf syscall
tracing and raw syscall tracing, adding a WARN_ON_ONCE() in the
generated code to validate that the intended probes are used for raw
syscall tracing. The might_fault() added within those probes validate
that they are called from a context where handling a page fault is OK.

This series replaces the "Faultable Tracepoints v6" series found at [1].

This has been rebased on v6.12-rc1 on top of two patches from Steven:

tracing: Remove definition of trace_*_rcuidle()
tracepoint: Remove SRCU protection

Thanks,

Mathieu

Link: https://lore.kernel.org/lkml/20240828144153.829582-1-mathieu.desnoyers@efficios.com/ # [1]
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
Cc: linux-trace-kernel@vger.kernel.org

Mathieu Desnoyers (7):
  tracing/ftrace: guard syscall probe with preempt_notrace
  tracing/perf: guard syscall probe with preempt_notrace
  tracing/bpf: guard syscall probe with preempt_notrace
  tracing: Allow system call tracepoints to handle page faults
  tracing/ftrace: Add might_fault check to syscall probes
  tracing/perf: Add might_fault check to syscall probes
  tracing/bpf: Add might_fault check to syscall probes

 include/linux/tracepoint.h    | 18 ++++++++++-----
 include/trace/bpf_probe.h     | 12 +++++++++-
 include/trace/perf.h          | 42 +++++++++++++++++++++++++++++++----
 include/trace/trace_events.h  | 39 ++++++++++++++++++++++++++------
 init/Kconfig                  |  1 +
 kernel/trace/trace_syscalls.c | 28 +++++++++++++++++++++++
 6 files changed, 123 insertions(+), 17 deletions(-)

-- 
2.39.2

