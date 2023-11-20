Return-Path: <bpf+bounces-15400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10147F1E41
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 21:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3B8B21713
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 20:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B486C225CA;
	Mon, 20 Nov 2023 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oYwtD125"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E76D9;
	Mon, 20 Nov 2023 12:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1700513679;
	bh=Mwcrf7oCSr2SVBqlstcAk4xBZt9a0mnoM+Aqfdmqy4Y=;
	h=From:To:Cc:Subject:Date:From;
	b=oYwtD125nVYe+W0MB6r2XUkNf2OqQfo1fdqm1SiyZ1g8prH/T3lehBW6dvqWaJxLg
	 Ya4de9QXlqN5ZN+WKw7LNhiX+032moApXuo7G5jt7iCmg2H+STvj+x46s/uzM5nU6l
	 iWsX/oOQx1ud0tfJmObypf9XhvuWlh6l/vF9T6VCyUB8uxSV+vKc8SCD6TutnciQpR
	 /MVFp6Y7lVCQHd8SqoSBycvGvLrvk4pGX0xEU8d5ABjm77/Kw4hWtbCR7wN0DLZiXM
	 0ZNkIhsgmq5ImQSC4KMj3kgLGtjL6AX60svcEAQtnXU1clDXSJx239MljyUiIc+wZk
	 k9ro2z+tJWnjw==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4SZ0B7031Nz1cX5;
	Mon, 20 Nov 2023 15:54:38 -0500 (EST)
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
	Jiri Olsa <jolsa@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v4 0/5] Faultable Tracepoints
Date: Mon, 20 Nov 2023 15:54:13 -0500
Message-Id: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
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

This series is based on kernel v6.6.2.

Thanks,

Mathieu

Mathieu Desnoyers (5):
  tracing: Introduce faultable tracepoints (v4)
  tracing/ftrace: Add support for faultable tracepoints
  tracing/bpf-trace: add support for faultable tracepoints
  tracing/perf: add support for faultable tracepoints
  tracing: convert sys_enter/exit to faultable tracepoints

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
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>

 include/linux/tracepoint-defs.h | 14 +++++
 include/linux/tracepoint.h      | 88 ++++++++++++++++++++++---------
 include/trace/bpf_probe.h       | 21 ++++++--
 include/trace/define_trace.h    |  7 +++
 include/trace/events/syscalls.h |  4 +-
 include/trace/perf.h            | 27 ++++++++--
 include/trace/trace_events.h    | 73 ++++++++++++++++++++++++--
 init/Kconfig                    |  1 +
 kernel/trace/bpf_trace.c        | 10 +++-
 kernel/trace/trace_events.c     | 26 +++++++---
 kernel/trace/trace_fprobe.c     |  5 +-
 kernel/trace/trace_syscalls.c   | 92 +++++++++++++++++++++++----------
 kernel/tracepoint.c             | 58 +++++++++++----------
 13 files changed, 325 insertions(+), 101 deletions(-)

-- 
2.25.1


