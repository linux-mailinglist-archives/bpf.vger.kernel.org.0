Return-Path: <bpf+bounces-40951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5053C9906EA
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 17:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AD42882C0
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 15:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476AB1AA78C;
	Fri,  4 Oct 2024 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="aTk35wM2"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6AF1D9A6A;
	Fri,  4 Oct 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054025; cv=none; b=EFTdD2pnES4GT1/guzrtLDiiy7AM0ovm9d8gXnDl7UCrQQ9nkLCHQ36Ug4EW2+jM4LpNdAeeUPt1aglygsHkyHJ1dbkfrSrKME6R4EZ0lFo/vTtM5QXaRBo7sIJXCQyWYqXubRfOm4kf23K/rXfB0UMVgJb6txdKnrF4c0bTyBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054025; c=relaxed/simple;
	bh=A71N7w4ttbgd1OKM/ngOb0KcBP2Hxefy76twHOP7ne0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QgjfTK5xK8Fk9qK0O+F86ctofZD0k6HuxYw1GewSQ30ZNRlcUlfH21uP9t5wJzIK6Hh5ig5vCDVuwak9GEJwck95nNO0hJRJchvwG0T0YgZbHiF7byLH16lzjBdZH6SrLE1Z3UWmta18EN43UVbdB7zyZ0Z8Ho+cjfyUFOyc9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=aTk35wM2; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728054023;
	bh=A71N7w4ttbgd1OKM/ngOb0KcBP2Hxefy76twHOP7ne0=;
	h=From:To:Cc:Subject:Date:From;
	b=aTk35wM2fZfSE26Hc+dZNDwmGNuouMGcF86KNXS/DLLvIANBzy0iKle9Onw7a4CY/
	 mCSc7ZDP7S35PMyIttFP1rTGid1dx5Rxd5RMvj4idRzRLBzS4pfsTa5wa8XhazDScp
	 LZYXsN7lnD7PPZJl6/crsq1vdctgnXlVcrkkLsgws2qYUmFhIrkVDte5ZwLIExmjIq
	 38DcX3rzWXPAyLjsUmM0tWfEG78+ugUv1vwFz6tvbwoU5MeWSdRo8f0+HBDucRZro6
	 857rSpE0P814iXfBA0wqQGtEmgvm384zCOkiJyzyWU1w0K8+k4qKZdLov5MjlomQAJ
	 MTnDk8CGdK+aQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKsD70b38zLkR;
	Fri,  4 Oct 2024 11:00:23 -0400 (EDT)
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
Subject: [PATCH v3 0/8] tracing: Allow system call tracepoints to handle page faults
Date: Fri,  4 Oct 2024 10:58:10 -0400
Message-Id: <20241004145818.1726671-1-mathieu.desnoyers@efficios.com>
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

The eBPF people have been needing this feature for quite a while:
https://lore.kernel.org/lkml/c323bce9-a04e-b1c3-580a-783fde259d60@fb.com/

This series replaces the "Faultable Tracepoints v6" series found at [1].

This has been rebased on v6.12-rc1 on top of two patches from Steven:

tracing: Remove definition of trace_*_rcuidle()
tracepoint: Remove SRCU protection

The main change since v2 is removal of remapping from
trace_sys_enter/exit to trace_syscall_sys_enter/exit (likewise for
register/unregister), which caused arch-specific code churn needlessly.

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

 include/linux/tracepoint.h      | 65 +++++++++++++++++++++++++--------
 include/trace/bpf_probe.h       | 13 +++++++
 include/trace/define_trace.h    |  5 +++
 include/trace/events/syscalls.h |  4 +-
 include/trace/perf.h            | 43 ++++++++++++++++++++--
 include/trace/trace_events.h    | 61 +++++++++++++++++++++++++++++--
 init/Kconfig                    |  1 +
 kernel/trace/trace_syscalls.c   | 28 ++++++++++++++
 8 files changed, 196 insertions(+), 24 deletions(-)

-- 
2.39.2

