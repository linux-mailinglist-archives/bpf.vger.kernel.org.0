Return-Path: <bpf+bounces-38282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF950962A88
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 16:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05541C21F61
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC57B19D08C;
	Wed, 28 Aug 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ouVGMtD7"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896618786F;
	Wed, 28 Aug 2024 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856150; cv=none; b=XXcH0aoTwXclaOyEAAzDrORcy9mwfx6WdNTSk67fIih20cJ3iKIGphp7FRaoOACIrZ4jqmFR2ucnuhozm+6Fl+4olhmCw0Jhruke5yZlBTZlI2CiTKJoFgcFV2KNQQIj3H1S8DjOwo5KeUmPR3X85Y+/HK+SmH93dT6/dUzwU7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856150; c=relaxed/simple;
	bh=+3+DWaEDqmmaEh+Zny+00XB30SJi68htny0cIv7HGC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iDbNSVAGU3IJbcT/pmt/5K5zHIKw3gWkLmTvgxKa1frWySAZIBN8EAY66BcJf+tU0BohhHznCtTwp4EL7woQNZUBu1y0o6SVtIVeQmKWUA44kaDsT3SUYhR4Vi3N02HVzV26sg7zR03fBt6jEPIsYbzCZkwTqX9QAOSFhnCL46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ouVGMtD7; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724856147;
	bh=+3+DWaEDqmmaEh+Zny+00XB30SJi68htny0cIv7HGC0=;
	h=From:To:Cc:Subject:Date:From;
	b=ouVGMtD7X5z9b/B8LyI4Bud+iG/OmV+UL0lWV4euzbIr40oBeEwjQyIuAwxTX9DTL
	 Ve3smH1dBwewfS48SQfeesmj2KgyEaB6TDnNxxP25HHPuMPUgJxidfh2Pv0KSP0wNM
	 2DgCCkogj9cx/jlSPYCsJ/mTWG9T1huS2AS4GBFZp6Ka3CZYYI9H32mFgJeTIOJdkJ
	 oWC3NbliPLFXw13rlYrPBFpTGg2sspPq889tqm1Thyp1nxewMkaqj1XtLXNqIq8DsR
	 2U8xS0LjaPisfLSKB1tkYZfNqSEpvguVBxOSjWn1QjtLjlD9RbHHzwISuPZP+fBNKB
	 DaKZd+B3H58wg==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wv6ZW2svfz1JFQ;
	Wed, 28 Aug 2024 10:42:27 -0400 (EDT)
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
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 0/5] Faultable Tracepoints
Date: Wed, 28 Aug 2024 10:41:47 -0400
Message-Id: <20240828144153.829582-1-mathieu.desnoyers@efficios.com>
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

I have tested this against a feature branch of lttng-modules which
implements handling of page faults for the filename argument of the
openat(2) system call.

This v6 rebases v5 on top of v6.11-rc5. It requires the "cleanup.h:
Introduce DEFINE_INACTIVE_GUARD()/activate_guard()" series.

Thanks,

Mathieu

Link: https://lore.kernel.org/lkml/20240828143719.828968-1-mathieu.desnoyers@efficios.com/ # cleanup.h dependency
Link: https://lore.kernel.org/lkml/20240627152340.82413-1-mathieu.desnoyers@efficios.com/ # v5
Link: https://lore.kernel.org/lkml/20231120205418.334172-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/e4e9a2bc-1776-4b51-aba4-a147795a5de1@efficios.com/
Link: https://lore.kernel.org/lkml/a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com/
Link: https://lore.kernel.org/lkml/ba543d44-9302-4115-ac4f-d4e9f8d98a90@paulmck-laptop/
Link: https://lore.kernel.org/lkml/20231120221524.GD8262@noisy.programming.kicks-ass.net/
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-trace-kernel@vger.kernel.org

Mathieu Desnoyers (5):
  tracing: Introduce faultable tracepoints
  tracing/ftrace: Add support for faultable tracepoints
  tracing/bpf-trace: Add support for faultable tracepoints
  tracing/perf: Add support for faultable tracepoints
  tracing: Convert sys_enter/exit to faultable tracepoints

 include/linux/tracepoint-defs.h | 14 ++++++
 include/linux/tracepoint.h      | 88 +++++++++++++++++++++++----------
 include/trace/bpf_probe.h       | 21 ++++++--
 include/trace/define_trace.h    |  7 +++
 include/trace/events/syscalls.h |  4 +-
 include/trace/perf.h            | 22 ++++++++-
 include/trace/trace_events.h    | 68 ++++++++++++++++++++++++-
 init/Kconfig                    |  1 +
 kernel/trace/bpf_trace.c        |  4 +-
 kernel/trace/trace_events.c     | 16 +++---
 kernel/trace/trace_fprobe.c     |  5 +-
 kernel/trace/trace_syscalls.c   | 52 ++++++++++++++++---
 kernel/tracepoint.c             | 65 ++++++++++++++----------
 13 files changed, 288 insertions(+), 79 deletions(-)

-- 
2.39.2

