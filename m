Return-Path: <bpf+bounces-31251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BECC08D8988
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79103285B75
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 19:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A76113D626;
	Mon,  3 Jun 2024 19:07:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC31413D533;
	Mon,  3 Jun 2024 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441634; cv=none; b=H7RmO7s9v6U9E3TfQzxqsvopvPEuD8lwynJCMbf8gCpyg0PBkHT+OX2nJmBT2R8193QzzIHGEfQUxtazcrCsBwN+wi3eyCCzk++mKkrdZ9xw82rKBkM3+eWuX5RljlC/OKMRswbmHH7XkO5TCSOWHiQ/7a2ogfvEFYzaotPSTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441634; c=relaxed/simple;
	bh=k1HP8hCmLs5gvyhDOaCFwFm3nHs+PuYGEdirt95Vwq8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IlETiHMohi+q3ig8Q4k1M2/E6vG+3evuC+I4sl0SFOMbjeMDsJ09vMzRQ4jfiUXk4xFiJKWHG0VmOM/ncjF5BRsKVVPkil58lcAac90rb757K42xzQJDAUXLe5krUtut3I8rTJ47JS3mYWxmK4IG6x6XG2XgDxb/2JO/B1cRJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590F4C4AF07;
	Mon,  3 Jun 2024 19:07:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sED2f-00000009TzS-1dXK;
	Mon, 03 Jun 2024 15:08:25 -0400
Message-ID: <20240603190825.252845939@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 03 Jun 2024 15:07:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
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
Subject: [PATCH v3 27/27] selftests/ftrace: Add fgraph-multi.tc test
References: <20240603190704.663840775@goodmis.org>
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



