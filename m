Return-Path: <bpf+bounces-40594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C0298ACD0
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51ED11C20F2D
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 19:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E366199FAD;
	Mon, 30 Sep 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dJUROlr4"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E19199958;
	Mon, 30 Sep 2024 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724393; cv=none; b=urX6L+L8YHrtt9l83UFWoDoE9ZyJWtFdzt+H9KK8EPv0gLRnr/P5kMauSR/MI2vAI7zT4CBWBNNlE0lkl8FhsNfKkVNknXVkYohG0mYOPe+1gJvEZxNpKp5dCs8gs8JfKtTzeBc9kjNJrnet180h9dxMDMGuB4QqlX1hzgoOwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724393; c=relaxed/simple;
	bh=Tm4OTWwkc5oRA+KD89Y73K8phozgTHCOkq6JpA1oLUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fv3YG8+SRK7mcL/hGSwdTiy45isxfOgvW+upv60V3K2X6wCJJfM6P0HhOgo2KtgyXrRxFB7sALkwTqUNHWcciy1OxSBxx1D0CmauRKIeCr/h0bRoBj+2V1AnUwSqVZGvWf50QXI+7hbx9BCaBo+zEMeH7LLnpejLzMsquLNpOho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=dJUROlr4; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727724390;
	bh=Tm4OTWwkc5oRA+KD89Y73K8phozgTHCOkq6JpA1oLUo=;
	h=From:To:Cc:Subject:Date:From;
	b=dJUROlr4te6U5eUZ5LWrej5l6X+WWFQyrKMMh74umyVLCzZPqVEx99Sa+1+Wc/FDC
	 0wjBoMiQlw9Dij61B3RQNL1IswF1qie8ZVDuqakggaJcXrzveRF4mc/zPYK90ffMYy
	 P0ccf7lk+u17uHyrW4lVbjAB1TwwB+qY1uaVKBDYMdTUDGbd9AFKEtXrbs21r2Pamk
	 43pf5FhuEf5PaiG6CHVODtfHNKmFRVW69Qg3PY0Un7ZoKjgMj8SUOJuH2FkqBul3IU
	 9kpRzv3Yr7IATusRk+AfZ+NjdozpXPY3zzw4NfQNbO7t3A8QQ40QecBZnso4l0aQed
	 LJxlAmCxpPZ5A==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XHWK22gtBzQdD;
	Mon, 30 Sep 2024 15:26:30 -0400 (EDT)
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
Subject: [PATCH resend 0/8] tracing: Allow system call tracepoints to handle page faults
Date: Mon, 30 Sep 2024 15:23:49 -0400
Message-Id: <20240930192357.1154417-1-mathieu.desnoyers@efficios.com>
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

This has been rebased on v6.11.1, without any conflicts. I've added the
Acked-by and Tested-by tags to relevant commits.

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

 include/linux/tracepoint.h      | 87 +++++++++++++++++++++++++--------
 include/trace/bpf_probe.h       | 13 +++++
 include/trace/define_trace.h    |  5 ++
 include/trace/events/syscalls.h |  4 +-
 include/trace/perf.h            | 43 ++++++++++++++--
 include/trace/trace_events.h    | 61 +++++++++++++++++++++--
 init/Kconfig                    |  1 +
 kernel/entry/common.c           |  4 +-
 kernel/trace/trace_syscalls.c   | 36 ++++++++++++--
 9 files changed, 218 insertions(+), 36 deletions(-)

-- 
2.39.2

