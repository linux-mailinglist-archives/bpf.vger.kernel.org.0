Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9872B2977DD
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 21:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755012AbgJWTyT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 15:54:19 -0400
Received: from mail.efficios.com ([167.114.26.124]:45578 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463594AbgJWTyT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 15:54:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D9049279803;
        Fri, 23 Oct 2020 15:54:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MiMvdgLqwa2p; Fri, 23 Oct 2020 15:54:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7C40B279621;
        Fri, 23 Oct 2020 15:54:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7C40B279621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603482857;
        bh=72FXe7XbiRUBCbyjx8FqEitIcCm0DjJMktXzOLswNDc=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=l5qwzvrOP577xDYZuFZl1MkQkVFTuzub1PK8l2tVRASmHNJ/B4hUyjMSUSRa4D3e2
         0oPrsjcrD/4+L8CkmQnskNSa2XQiFfdPrQ5i2soumpK/Oh8RhTQUjYZbeN24Rzw/AC
         Xex7vYpDDBiZ6FzPTBAKKIEmx0rUILBsSjcSqT0HduKbND9Erk5C8InTWhgNJPKN/C
         XtC6Cev8nwEV3mmsYZlmb1KQF/TKvuDZ9oTMDcos6dJrfJJ1rz9WxJWdYZL4vGR7CL
         l+0GcMURUiy7/aJCbEbfGkn0bc4aWY6kw4dt0us4jNA7qQ9eTWqfi/uIU+FLX7KcNa
         iG+HjzMiI1XgA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tt-dha39xSFv; Fri, 23 Oct 2020 15:54:17 -0400 (EDT)
Received: from localhost.localdomain (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
        by mail.efficios.com (Postfix) with ESMTPSA id 6E196279561;
        Fri, 23 Oct 2020 15:54:14 -0400 (EDT)
From:   Michael Jeanson <mjeanson@efficios.com>
To:     linux-kernel@vger.kernel.org
Cc:     mathieu.desnoyers@efficios.com,
        Michael Jeanson <mjeanson@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Joel Fernandes <joel@joelfernandes.org>, bpf@vger.kernel.org
Subject: [RFC PATCH 0/6] Sleepable tracepoints
Date:   Fri, 23 Oct 2020 15:53:46 -0400
Message-Id: <20201023195352.26269-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When invoked from system call enter/exit instrumentation, accessing
user-space data is a common use-case for tracers. However, tracepoints
currently disable preemption around iteration on the registered
tracepoint probes and invocation of the probe callbacks, which prevents
tracers from handling page faults.

Extend the tracepoint and trace event APIs to allow specific tracer
probes to take page faults. Adapt ftrace, perf, and ebpf to allow being
called from sleepable context, and convert the system call enter/exit
instrumentation to sleepable tracepoints.

This series only implements the tracepoint infrastructure required to
allow tracers to handle page faults. Modifying each tracer to handle
those page faults would be a next step after we all agree on this piece
of instrumentation infrastructure.

This patchset is base on v5.9.1.

Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: bpf@vger.kernel.org

Mathieu Desnoyers (1):
  tracing: use sched-RCU instead of SRCU for rcuidle tracepoints

Michael Jeanson (5):
  tracing: introduce sleepable tracepoints
  tracing: ftrace: add support for sleepable tracepoints
  tracing: bpf-trace: add support for sleepable tracepoints
  tracing: perf: add support for sleepable tracepoints
  tracing: convert sys_enter/exit to sleepable tracepoints

 include/linux/tracepoint-defs.h |  11 ++++
 include/linux/tracepoint.h      | 104 +++++++++++++++++++++-----------
 include/trace/bpf_probe.h       |  23 ++++++-
 include/trace/define_trace.h    |   7 +++
 include/trace/events/syscalls.h |   4 +-
 include/trace/perf.h            |  26 ++++++--
 include/trace/trace_events.h    |  79 ++++++++++++++++++++++--
 init/Kconfig                    |   1 +
 kernel/trace/bpf_trace.c        |   5 +-
 kernel/trace/trace_events.c     |  15 ++++-
 kernel/trace/trace_syscalls.c   |  68 +++++++++++++--------
 kernel/tracepoint.c             | 104 +++++++++++++++++++++++++-------
 12 files changed, 351 insertions(+), 96 deletions(-)

--=20
2.25.1

