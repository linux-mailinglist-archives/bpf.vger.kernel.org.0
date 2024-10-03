Return-Path: <bpf+bounces-40834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FF498F256
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 17:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B22D1F232A8
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDA81A0AF8;
	Thu,  3 Oct 2024 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JwBf4ywS"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC4F8286A;
	Thu,  3 Oct 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968728; cv=none; b=ssvwvB4bFZb2Ni7g+ZFAaxJTkapKeSsMeduA027Se43XmqEu1HU9nCVNVNFRGvUud4NDwnEe9fa05X4tIPIwZLrNUwoO9ED89/1+CG2zXsGygDLdo9+kAmA90kCTAkbNxotswzDqLAwEaR2ZidPrbUFhIgzf1ekxE7+MydX4oU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968728; c=relaxed/simple;
	bh=WwB3VDOeGHvQJGcXKLuEG8OTMh8msNB+Csvq2kbvg0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=udY0je9ld2T2Q6PV4MocAmFOI1wUxdA5O9Lvl+2vEu/xxxyU9sFrMqZAbSS+Zri4UT6Vtf1sZuB1JmVVjbhzOIsKrMLq7AZdvTH6R3d1svgWMUdtpjpDm5DyhE8uoem3kJs0HlKThr2qmdb0GjPhqQDFdtY2WAvA00QOwe7y7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=JwBf4ywS; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727968723;
	bh=WwB3VDOeGHvQJGcXKLuEG8OTMh8msNB+Csvq2kbvg0o=;
	h=From:To:Cc:Subject:Date:From;
	b=JwBf4ywSwMXPPg+Ha3ITARTCo+8eqctYd6vXVEyimvz+a5FUgPFoD5RlLwL09HFu+
	 zIFbHFbOYad/7PrQJlmaa4Iw3OWjI+ZWpguBaL2EUVzTXCE4h4fx5jP+aMiST6sG/q
	 /cOkz9cyrwb2uDV5xa2go95JKa2Wl2NgNJvjg5Ry8hiO+nNHn5Pd+zH99xhT+TGQhp
	 +Rz3wyEcPJNqtxlIoIodfscDm8FOEOUctA49Y+1Cf+W9BTm86JnmLLb6rQO30fPK5n
	 BZwUwUfv0Jti8YAGNjsWQV+XxqM4qeBjFPm0CE9Fp6mq1wHBfeIaK3C0iMxxBk8KzU
	 ZPBnGrMiG9TMw==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKFgk5wXjz5t1;
	Thu,  3 Oct 2024 11:18:42 -0400 (EDT)
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
Subject: [PATCH v1 0/8] tracing: Allow system call tracepoints to handle page faults
Date: Thu,  3 Oct 2024 11:16:30 -0400
Message-Id: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
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

This has been rebased on v6.12-rc1, without any conflicts. I have fixed
the build bot warnings, those were caused by build error with
CONFIG_TRACING=n. I've added the Acked-by and Tested-by tags to relevant
commits.

Steven, can you merge it through the tracing tree ?

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

Mathieu Desnoyers (8):
  tracing: Declare system call tracepoints with TRACE_EVENT_SYSCALL
  tracing/ftrace: guard syscall probe with preempt_notrace
  tracing/perf: guard syscall probe with preempt_notrace
  tracing/bpf: guard syscall probe with preempt_notrace
  tracing: Allow system call tracepoints to handle page faults
  tracing/ftrace: Add might_fault check to syscall probes
  tracing/perf: Add might_fault check to syscall probes
  tracing/bpf: Add might_fault check to syscall probes

 include/linux/tracepoint.h      | 104 ++++++++++++++++++++++++++++----
 include/trace/bpf_probe.h       |  13 ++++
 include/trace/define_trace.h    |   5 ++
 include/trace/events/syscalls.h |   4 +-
 include/trace/perf.h            |  43 ++++++++++++-
 include/trace/trace_events.h    |  61 +++++++++++++++++--
 init/Kconfig                    |   1 +
 kernel/entry/common.c           |   4 +-
 kernel/trace/trace_syscalls.c   |  44 +++++++++++---
 9 files changed, 247 insertions(+), 32 deletions(-)

-- 
2.39.2

