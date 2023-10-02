Return-Path: <bpf+bounces-11224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740B07B5BF6
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 22:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E0EAC282097
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 20:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F142030C;
	Mon,  2 Oct 2023 20:25:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79829200D8
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 20:25:44 +0000 (UTC)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F2CE0;
	Mon,  2 Oct 2023 13:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1696278338;
	bh=3b0xY900x5Ga7B1Di/fAn9zUiD76TyAJd3fltNUcrkE=;
	h=From:To:Cc:Subject:Date:From;
	b=diM2fCE6voKFZTAhGB8J6dK6Lg7Ie3GlgN99Ma25jYPl4CdsZgwlVt0JqlWrsFEz4
	 uopRIz1U2p1e2J/FVKg5fDh8yJ61bPWG576Pb3dRD5N+IPwpqcXBzTAlYlr8NEZSA4
	 iukPfzwImQPPQhDlrYr6pDySh23oojfyi18F65zNQChaD/XZ+/U9WMAA0bo6kCg4nw
	 eURkrWFA6t3GYt9BcgA46Xwk6Lktw2MFQsa0BfxctiZGz3rl1vd+sUnKb/yHf2ect/
	 CGBs63RpmiWrWD7FcSR6jkPUDi2YljOhZSwVhwG07LMVkOwrM9uM/cGj7pU6YPmX3V
	 0tx763L50jR7w==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4RzssG4vbhz1V7n;
	Mon,  2 Oct 2023 16:25:38 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Jeanson <mjeanson@efficios.com>,
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
Subject: [RFC PATCH v3 0/5] Faultable Tracepoints
Date: Mon,  2 Oct 2023 16:25:26 -0400
Message-Id: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wire up the system call tracepoints with Tasks Trace RCU to allow
the ftrace, perf, and eBPF tracers to handle page faults.

This series does the initial wire-up allowing tracers to handle page
faults, but leaves out the actual handling of said page faults as future
work.

This series is based on kernel v6.5.5.

Feedback is welcome!

Thanks,

Mathieu

Cc: Michael Jeanson <mjeanson@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
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

Mathieu Desnoyers (5):
  tracing: Introduce faultable tracepoints (v3)
  tracing/ftrace: Add support for faultable tracepoints
  tracing/bpf-trace: add support for faultable tracepoints
  tracing/perf: add support for faultable tracepoints
  tracing: convert sys_enter/exit to faultable tracepoints

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


