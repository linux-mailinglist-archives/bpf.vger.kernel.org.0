Return-Path: <bpf+bounces-31335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B7D8FB5FA
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F411C24D5A
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2039214AD24;
	Tue,  4 Jun 2024 14:42:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7C414A633;
	Tue,  4 Jun 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512139; cv=none; b=fLRG1SLSRgd7RDoe6wygd012KF7rLk8W0SNEkKJzAoJF4tdLueLVdUpk7XXwAX+yknjjbfD1yRLS9nZPOFl/m8n3YHyw1bgPx+iJEg/65SB/BQrUHXWGrAvgexmXyQIMALGqTemofm1Bv2Xe48LJSKmLyFiP480P/5b3kKoYVLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512139; c=relaxed/simple;
	bh=72PZE7jo4rhH6rkropdR1LoNIVfrBlRAv33/Lvh0aFw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=g360FhPNeouxj7qJnUqsO0nVu5HwjHjcFWkABQFPsM4COUN6qRzzV7jQ3BSVPmFNkCPZkgWEy4u/2OfdlcnfH5OhKnKlThwneoU8E/w75lIVkUny8qprHILSjUbKlj+oe7NXU8ABR1q62B9kW2gX4zNzrgtsW7qDvB142BNDQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8829CC32786;
	Tue,  4 Jun 2024 14:42:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEVMg-00000000Z6V-1wl4;
	Tue, 04 Jun 2024 10:42:18 -0400
Message-ID: <20240604144218.325348498@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 10:41:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>
Subject: [for-next][PATCH 27/27] selftests/ftrace: Add fgraph-multi.tc test
References: <20240604144103.293353991@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add a test that creates 3 instances and enables function_graph tracer in
each as well as the top instance, where each will enable a filter (but one
that traces all functions) and check that they are filtering properly.

Link: https://lore.kernel.org/linux-trace-kernel/20240603190825.252845939@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Guo Ren <guoren@kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../ftrace/test.d/ftrace/fgraph-multi.tc      | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc
new file mode 100644
index 000000000000..ff88f97e41fb
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc
@@ -0,0 +1,103 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - function graph filters
+# requires: set_ftrace_filter function_graph:tracer
+
+# Make sure that function graph filtering works
+
+INSTANCE1="instances/test1_$$"
+INSTANCE2="instances/test2_$$"
+INSTANCE3="instances/test3_$$"
+
+WD=`pwd`
+
+do_reset() {
+    cd $WD
+    if [ -d $INSTANCE1 ]; then
+	echo nop > $INSTANCE1/current_tracer
+	rmdir $INSTANCE1
+    fi
+    if [ -d $INSTANCE2 ]; then
+	echo nop > $INSTANCE2/current_tracer
+	rmdir $INSTANCE2
+    fi
+    if [ -d $INSTANCE3 ]; then
+	echo nop > $INSTANCE3/current_tracer
+	rmdir $INSTANCE3
+    fi
+}
+
+mkdir $INSTANCE1
+if ! grep -q function_graph $INSTANCE1/available_tracers; then
+    echo "function_graph not allowed with instances"
+    rmdir $INSTANCE1
+    exit_unsupported
+fi
+
+mkdir $INSTANCE2
+mkdir $INSTANCE3
+
+fail() { # msg
+    do_reset
+    echo $1
+    exit_fail
+}
+
+disable_tracing
+clear_trace
+
+do_test() {
+    REGEX=$1
+    TEST=$2
+
+    # filter something, schedule is always good
+    if ! echo "$REGEX" > set_ftrace_filter; then
+	fail "can not enable filter $REGEX"
+    fi
+
+    echo > trace
+    echo function_graph > current_tracer
+    enable_tracing
+    sleep 1
+    # search for functions (has "{" or ";" on the line)
+    echo 0 > tracing_on
+    count=`cat trace | grep -v '^#' | grep -e '{' -e ';' | grep -v "$TEST" | wc -l`
+    echo 1 > tracing_on
+    if [ $count -ne 0 ]; then
+	fail "Graph filtering not working by itself against $TEST?"
+    fi
+
+    # Make sure we did find something
+    echo 0 > tracing_on
+    count=`cat trace | grep -v '^#' | grep -e '{' -e ';' | grep "$TEST" | wc -l`
+    echo 1 > tracing_on
+    if [ $count -eq 0 ]; then
+	fail "No traces found with $TEST?"
+    fi
+}
+
+do_test '*sched*' 'sched'
+cd $INSTANCE1
+do_test '*lock*' 'lock'
+cd $WD
+cd $INSTANCE2
+do_test '*rcu*' 'rcu'
+cd $WD
+cd $INSTANCE3
+echo function_graph > current_tracer
+
+sleep 1
+count=`cat trace | grep -v '^#' | grep -e '{' -e ';' | grep "$TEST" | wc -l`
+if [ $count -eq 0 ]; then
+    fail "No traces found with all tracing?"
+fi
+
+cd $WD
+echo nop > current_tracer
+echo nop > $INSTANCE1/current_tracer
+echo nop > $INSTANCE2/current_tracer
+echo nop > $INSTANCE3/current_tracer
+
+do_reset
+
+exit 0
-- 
2.43.0



