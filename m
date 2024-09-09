Return-Path: <bpf+bounces-39349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C42497236D
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD88F28850F
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 20:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695B618A6BA;
	Mon,  9 Sep 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="T2iMVpNL"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA28518C31;
	Mon,  9 Sep 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913039; cv=none; b=ruXUN84pBmtPmkzgeopTN5RHkRfvjCH5pEKjQy7cHV9kf02Olp0ZtMCXZ/dqfJDiP2wPjY3+GOUm0psT3/yyDJEXOOEVAP+SfjJxwcxwnylwwnyEcKRRTGoiJDr3HJsO75ebztkg+gcoMLTsWh0zLJC9ABHuQrqLUrhHA5h8tUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913039; c=relaxed/simple;
	bh=vMrOjt1iewbvL76IRGWP5yIysyYY7jVPJd/WeU5mMbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tk2TsKKH33wJZcx1/bT+HeQGuiZAeL4+t1IOpg9jZW2DmmkZ4fx9VjeIJuEGke8X9tyHJyOP+Ys4+yMYllwAiDM1tj3P+saMeQRrl0JbilUsW7tOJs43fafB1ifgRua9cHweneh3U71W7PkSBy+auAugSqHTYa2q397HgnLRnz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=T2iMVpNL; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725913035;
	bh=vMrOjt1iewbvL76IRGWP5yIysyYY7jVPJd/WeU5mMbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=T2iMVpNL1VmV6Qzksfb/JERgWciyGlitRX5NRf42IEmPY3ojdVZyMvDUoOC0jwx69
	 fG+kjtWDz1fFDJHuqPXkFl3298vTeswenoyRjiporHVvKTvvR3rY74CFoCWNOpm+Q9
	 Wza111hZb82sF5OpI5JrnbTBHZKY4C76q8BRh3AvkwbbJVrL9JgKQhqtM7P7xQ8RV5
	 7wmRgtbHbe5eDkgegtfityPcjLYayf4U3fmNBB0628N+9pyMpH86emxNdiUEI0QyVm
	 YsyZY/46sNaE9cV9hPqpVYC1LPkcLmHx+g3YRgPhTHSQaf7NZAkLDsyje9fA7/q0PQ
	 dlCukwQTsXU6w==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X2dRH17Jdz1Ksv;
	Mon,  9 Sep 2024 16:17:15 -0400 (EDT)
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
Subject: [PATCH 0/8] tracing: Allow system call tracepoints to handle page faults
Date: Mon,  9 Sep 2024 16:16:44 -0400
Message-Id: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
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

For ebpf, this series is compile-tested only.

This series replaces the "Faultable Tracepoints v6" series found at [1].

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

