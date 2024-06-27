Return-Path: <bpf+bounces-33262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5920E91AB17
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 17:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9131C22634
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C61991A1;
	Thu, 27 Jun 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="g0RRW0N3"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7048A197A61;
	Thu, 27 Jun 2024 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501792; cv=none; b=u3ch4BNX38rS/8jTmbRBb4BpLdSzvhG1zo4a5t2CLODze4qXDz9k1W7hBXIslSl2OTy11QkmLvcpDUx6pQ1/Gtp6vk7IeEMLLOU9RIp6t4V83MHUldmRdsjvBt+5hH/GjUP/2zUbwsk02zdu+5d+VNCB51nxHZg7yrNWmbZLnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501792; c=relaxed/simple;
	bh=5+b8aWZO+wYMW95/3/7a4Rw1GpZfUelw6aGT8D3zXCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DU6b6W4avCK9n7a3Gjku+ajoZvFs2cv6KOimKEwGhZkqkgg69WdQuLn+SNsOuXWrcKeXPHKBxQSAbRJEbhDqp3qI3TKinmR00XTmZLpUGFzp9NBXX4QX9E8kMKdHrfT/unKaZclahXRZfEHQ9fmKH5PgFgDFT1PSA6tsu0MCWJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=g0RRW0N3; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1719501788;
	bh=5+b8aWZO+wYMW95/3/7a4Rw1GpZfUelw6aGT8D3zXCs=;
	h=From:To:Cc:Subject:Date:From;
	b=g0RRW0N3BdfNu8vQOro/bv8Fe6N+IX4LhGcXzA47TDcFFvl8PNnwNycwZNlp42Rir
	 139sftB81/f13kcfbOXx1ofWfQ856h0wnZDpLKUpQBH1m8zCDlMEDZMZfaHRrco5wQ
	 ppxSTbWpmvpokoWGGBZVZyWiE0TxgtJo2L/XaRXjr8jcFsz1rGh6R/FBgfAQUh3kyU
	 Xggn4qOdIjql3OUHm7FDwKhYv++FGaRFhruwNAtAUpMUfeWJ1g/DetqSnVFZ0U30lX
	 230VMJB01LYJIo6HWNA0Pf+vDVu8Ye/Z/KTzUZqb4qUAskMrEqtB4jPRoR0yGJLuJM
	 cIl6KiuRKizKQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4W92Q35cD6z180Y;
	Thu, 27 Jun 2024 11:23:07 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v5 0/8] Faultable Tracepoints
Date: Thu, 27 Jun 2024 11:23:32 -0400
Message-Id: <20240627152340.82413-1-mathieu.desnoyers@efficios.com>
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

This v5 addresses comments from the previous round of review [1].

Steven Rostedt suggested separating tracepoints into two separate
sections. It is unclear how that approach would prove to be an
improvement over the currently proposed approach, so those changes were
not incorporated. See [2] for my detailed reply.

In the previous round, Peter Zijlstra suggested use of SRCU rather than
Tasks Trace RCU. See my reply about the distinction between SRCU and
Tasks Trace RCU [3] and this explanation from Paul E. McKenney about the
purpose of Tasks Trace RCU [4].

The macros DEFINE_INACTIVE_GUARD and activate_guard are added to
cleanup.h for use in the __DO_TRACE() macro. Those appear to be more
flexible than the guard_if() proposed by Peter Zijlstra in the previous
round of review [5].

This series is based on kernel v6.9.6.

Thanks,

Mathieu

Link: https://lore.kernel.org/lkml/20231120205418.334172-1-mathieu.desnoyers@efficios.com/ # [1]
Link: https://lore.kernel.org/lkml/e4e9a2bc-1776-4b51-aba4-a147795a5de1@efficios.com/ # [2]
Link: https://lore.kernel.org/lkml/a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com/ # [3]
Link: https://lore.kernel.org/lkml/ba543d44-9302-4115-ac4f-d4e9f8d98a90@paulmck-laptop/ # [4]
Link: https://lore.kernel.org/lkml/20231120221524.GD8262@noisy.programming.kicks-ass.net/ # [5]
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>

Mathieu Desnoyers (8):
  cleanup.h: Header include guard should match header name
  cleanup.h guard: Rename DEFINE_ prefix to DECLARE_
  cleanup.h: Introduce DEFINE_INACTIVE_GUARD and activate_guard
  tracing: Introduce faultable tracepoints
  tracing/ftrace: Add support for faultable tracepoints
  tracing/bpf-trace: Add support for faultable tracepoints
  tracing/perf: Add support for faultable tracepoints
  tracing: Convert sys_enter/exit to faultable tracepoints

 drivers/cxl/core/cdat.c                     |  2 +-
 drivers/cxl/cxl.h                           |  2 +-
 drivers/gpio/gpiolib.h                      |  2 +-
 drivers/platform/x86/intel/pmc/core_ssram.c |  2 +-
 fs/fuse/virtio_fs.c                         |  2 +-
 fs/pstore/inode.c                           |  4 +-
 include/linux/bitmap.h                      |  2 +-
 include/linux/cleanup.h                     | 85 ++++++++++++--------
 include/linux/cpu.h                         |  2 +-
 include/linux/cpumask.h                     |  2 +-
 include/linux/device.h                      |  6 +-
 include/linux/file.h                        |  4 +-
 include/linux/firmware.h                    |  2 +-
 include/linux/gpio/driver.h                 |  4 +-
 include/linux/iio/iio.h                     |  4 +-
 include/linux/irqflags.h                    |  4 +-
 include/linux/mutex.h                       |  6 +-
 include/linux/of.h                          |  2 +-
 include/linux/pci.h                         |  4 +-
 include/linux/percpu.h                      |  2 +-
 include/linux/preempt.h                     |  6 +-
 include/linux/rcupdate.h                    |  2 +-
 include/linux/rwsem.h                       | 10 +--
 include/linux/sched/task.h                  |  4 +-
 include/linux/slab.h                        |  4 +-
 include/linux/spinlock.h                    | 38 ++++-----
 include/linux/srcu.h                        |  2 +-
 include/linux/tracepoint-defs.h             | 14 ++++
 include/linux/tracepoint.h                  | 88 +++++++++++++++------
 include/sound/pcm.h                         |  6 +-
 include/trace/bpf_probe.h                   | 20 ++++-
 include/trace/define_trace.h                |  7 ++
 include/trace/events/syscalls.h             |  4 +-
 include/trace/perf.h                        | 22 +++++-
 include/trace/trace_events.h                | 68 +++++++++++++++-
 init/Kconfig                                |  1 +
 kernel/sched/core.c                         |  4 +-
 kernel/sched/sched.h                        | 16 ++--
 kernel/trace/bpf_trace.c                    | 11 ++-
 kernel/trace/trace_events.c                 | 28 +++++--
 kernel/trace/trace_fprobe.c                 |  5 +-
 kernel/trace/trace_syscalls.c               | 52 ++++++++++--
 kernel/tracepoint.c                         | 65 +++++++++------
 lib/locking-selftest.c                      | 12 +--
 sound/core/control_led.c                    |  2 +-
 45 files changed, 441 insertions(+), 193 deletions(-)

-- 
2.39.2

