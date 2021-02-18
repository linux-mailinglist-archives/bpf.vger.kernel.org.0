Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F097531F239
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 23:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhBRWWW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 17:22:22 -0500
Received: from mail.efficios.com ([167.114.26.124]:43544 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBRWWS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Feb 2021 17:22:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7867E29F10D;
        Thu, 18 Feb 2021 17:21:37 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aaGXVWSXXUP0; Thu, 18 Feb 2021 17:21:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1E36B29F10C;
        Thu, 18 Feb 2021 17:21:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1E36B29F10C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1613686897;
        bh=qg+TOHYRBNNDpBiTul3hZoTe6Z8G1k6/yFumHOX/SkI=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=tsMcr1ksM6lxPWFKSJBC/YDUG1Etvl/SrUUqR+ZlHGXlPg7R1mBI8WDkvH1Z6xZFO
         1HYPesZe1VUMBQUppkZBpWKIR2e9g827DqjN8aR9q731+7+6sIoQ99Rjl7iOdmWZS0
         R3AItFeuYtzfqQqYB0h5rTaD98OJx3bQ9VLN/IIg5lTxRPeav1h8AGEbyOlrWmcwue
         gnKXiQgvckqgAeJeLNzoJHHNdWYLvSDYtf4yfGnfAy017RdeRL34RYh5L541DnSEYJ
         2LtAEBI8AWO9392fZMktohorDKBZ4J/KECLjFAv1zoE/JsQIHHJqV/meLf8kIYKcy4
         Q5IJPqnmfnHpQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id f2nIccwc5G74; Thu, 18 Feb 2021 17:21:37 -0500 (EST)
Received: from localhost.localdomain (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
        by mail.efficios.com (Postfix) with ESMTPSA id B03C929EB59;
        Thu, 18 Feb 2021 17:21:36 -0500 (EST)
From:   Michael Jeanson <mjeanson@efficios.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jeanson <mjeanson@efficios.com>,
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
Subject: [RFC PATCH 0/6] [RFC] Faultable tracepoints (v2)
Date:   Thu, 18 Feb 2021 17:21:19 -0500
Message-Id: <20210218222125.46565-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Formerly known as =E2=80=9CSleepable tracepoints=E2=80=9D.

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

This patchset is based on v5.10.15.

Changes since v1 RFC:

  - Rename "sleepable tracepoints" to "faultable tracepoints", MAYSLEEP t=
o
    MAYFAULT, and use might_fault() rather than might_sleep(), to properl=
y
    convey that the tracepoints are meant to be able to take a page fault=
,
    which requires to be able to sleep *and* to hold the mmap_sem.

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
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: bpf@vger.kernel.org

Mathieu Desnoyers (1):
  tracing: use Tasks Trace RCU instead of SRCU for rcuidle tracepoints

Michael Jeanson (5):
  tracing: introduce faultable tracepoints (v2)
  tracing: ftrace: add support for faultable tracepoints
  tracing: bpf-trace: add support for faultable tracepoints
  tracing: perf: add support for faultable tracepoints
  tracing: convert sys_enter/exit to faultable tracepoints

 include/linux/tracepoint-defs.h |  11 ++++
 include/linux/tracepoint.h      | 111 +++++++++++++++++++++-----------
 include/trace/bpf_probe.h       |  23 ++++++-
 include/trace/define_trace.h    |   8 +++
 include/trace/events/syscalls.h |   4 +-
 include/trace/perf.h            |  26 ++++++--
 include/trace/trace_events.h    |  79 +++++++++++++++++++++--
 init/Kconfig                    |   1 +
 kernel/trace/bpf_trace.c        |   5 +-
 kernel/trace/trace_events.c     |  15 ++++-
 kernel/trace/trace_syscalls.c   |  84 ++++++++++++++++--------
 kernel/tracepoint.c             | 104 ++++++++++++++++++++++++------
 12 files changed, 373 insertions(+), 98 deletions(-)

--=20
2.25.1

