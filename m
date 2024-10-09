Return-Path: <bpf+bounces-41323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739CA995CAA
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 03:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3194F285E37
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9EB1F5EA;
	Wed,  9 Oct 2024 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BehcG5d7"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B910417C61;
	Wed,  9 Oct 2024 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728436168; cv=none; b=gy5YrAveLh2XirZSsKmov8lkatTHDNotm+wotTNVyt/C0sSGKVOOyUpJjwvgVZQWEScBAplIJfFQVtnpir7jyw1Od43pZOQmGcaSpVhUYBRMfaLVZeBywdFElRV/ZSWiL+OTfIn7ZMyIvr9eUARqavrVN5nPgPvGIAk6rIXH36g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728436168; c=relaxed/simple;
	bh=9GSgJUiuUUyJLkUUQnuNrpGIyn0mhnN05LAJ0S/rlTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tJ9Y3EPW5lB8wA7ucbGjVxM8NWwLONUSw3c0cue+Zs/HDcUWjsChS6Bm8ziM5frFRnSYDaE1zUjeyHVQPssC1NWSt3QtQEvMlbDTonFAq8E9jvcD1g6IGSSqZ6Un95k4xaqvpiUP7rEWv3ZzzOQo2GT9TyoQUC1ynAnjuiXECg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BehcG5d7; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728436164;
	bh=9GSgJUiuUUyJLkUUQnuNrpGIyn0mhnN05LAJ0S/rlTM=;
	h=From:To:Cc:Subject:Date:From;
	b=BehcG5d7wYRsBvNCQvyTZMLiPJtGjG/toVnu0rjx7DQrLy6dUrD6L+G0YkscmTkXM
	 xSAJxccuGz/W+LtR4nl6qYHL+dCCNb9o7AV2tWSrYtESSYRh/KbJGcue018xOd3azU
	 g5bM2wemAJ6dkNWQMr7dapknP5z0UfRJjVgKbxf6aVxWDZqP3EPWOzMmB0BxcnT5IH
	 ALx4eWV+Ufl4NJ8zoyNPW0+TH/82y3CWx1+Li1HvKg7uqIE/SKhFJ1uzBF9VuqBdag
	 Z6oV2SbE7ih22NiJZC1s8fX8XEYi8Z24+S8HbARYRxET7dsHMKRGQOt/TfZuH/Ihw4
	 1LY/PBu7BTbag==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XNZY01CsyzS7R;
	Tue,  8 Oct 2024 21:09:24 -0400 (EDT)
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
Subject: [PATCH v4 0/8] tracing: Allow system call tracepoints to handle page faults
Date: Tue,  8 Oct 2024 21:07:10 -0400
Message-Id: <20241009010718.2050182-1-mathieu.desnoyers@efficios.com>
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

This has been rebased on trace/core commit:

1537519062e2 (trace/core) tracepoint: Remove SRCU protection

The changes since v3 take care of feedback from Steven.

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
  tracing/ftrace: disable preemption in syscall probe
  tracing/perf: disable preemption in syscall probe
  tracing/bpf: disable preemption in syscall probe
  tracing: Allow system call tracepoints to handle page faults
  tracing/ftrace: Add might_fault check to syscall probes
  tracing/perf: Add might_fault check to syscall probes
  tracing/bpf: Add might_fault check to syscall probes

 include/linux/tracepoint.h      | 71 ++++++++++++++++++++++++++-------
 include/trace/bpf_probe.h       | 14 +++++++
 include/trace/define_trace.h    |  5 +++
 include/trace/events/syscalls.h |  4 +-
 include/trace/perf.h            | 44 ++++++++++++++++++--
 include/trace/trace_events.h    | 62 ++++++++++++++++++++++++++--
 init/Kconfig                    |  1 +
 kernel/trace/trace_syscalls.c   | 28 +++++++++++++
 8 files changed, 205 insertions(+), 24 deletions(-)

-- 
2.39.2

