Return-Path: <bpf+bounces-31334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0AD8FB608
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15305B28868
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60C414AD1B;
	Tue,  4 Jun 2024 14:42:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F95614A61B;
	Tue,  4 Jun 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512139; cv=none; b=QYsLX+38xDFKvZhM8E/piJxbzkVTj759c9YlmQdEQBlRiOiMp+88uI4f1Ee25NuBj3Mp3E1NBHQ0Qt6rwTLd4I5mugqbUuOJXfPJ+RDYS88Eqfw7QBmzexv9BnizFA1I5KUVPW/AME5WNFTfDGJdIOXPj8TQb1yHSI/zRRC2tWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512139; c=relaxed/simple;
	bh=bt/kGDzFunrncc+tGakDqJ1SDIrQ36rHNX8lhail/8g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=B2I6U5HbB09/Tiv3bL/3lxBop2FjiMSf7lZSGdoRfnyYRPvSYbCbXolb4pjPNDNaHjQlXTLc6HZrq60UYDgZHWzK2B7iXIFVATci2fuL8uhcEnjDw4KRREgXAa5W6HGYPFqw9acxv1qcWWD+y2rz7NlYOadeIT+vmG6Q0eTL0Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B7DC2BBFC;
	Tue,  4 Jun 2024 14:42:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEVMg-00000000Z60-1GtP;
	Tue, 04 Jun 2024 10:42:18 -0400
Message-ID: <20240604144218.160516951@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 10:41:29 -0400
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
Subject: [for-next][PATCH 26/27] selftests/ftrace: Add function_graph tracer to func-filter-pid test
References: <20240604144103.293353991@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The function tracer is tested to see if pid filtering works. Add a test to
test function_graph tracer as well, but only if the function_graph tracer
is enabled for the top level or instance.

Link: https://lore.kernel.org/linux-trace-kernel/20240603190825.083048115@goodmis.org

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
 .../ftrace/test.d/ftrace/func-filter-pid.tc   | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index 2f7211254529..c6fc9d31a496 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -14,6 +14,11 @@ if [ ! -f options/function-fork ]; then
     echo "no option for function-fork found. Option will not be tested."
 fi
 
+if [ ! -f options/funcgraph-proc ]; then
+    do_funcgraph_proc=0
+    echo "no option for function-fork found. Option will not be tested."
+fi
+
 read PID _ < /proc/self/stat
 
 if [ $do_function_fork -eq 1 ]; then
@@ -21,12 +26,18 @@ if [ $do_function_fork -eq 1 ]; then
     orig_value=`grep function-fork trace_options`
 fi
 
+if [ $do_funcgraph_proc -eq 1 ]; then
+    orig_value2=`cat options/funcgraph-proc`
+fi
+
 do_reset() {
-    if [ $do_function_fork -eq 0 ]; then
-	return
+    if [ $do_function_fork -eq 1 ]; then
+	echo $orig_value > trace_options
     fi
 
-    echo $orig_value > trace_options
+    if [ $do_funcgraph_proc -eq 1 ]; then
+	echo $orig_value2 > options/funcgraph-proc
+    fi
 }
 
 fail() { # msg
@@ -36,13 +47,15 @@ fail() { # msg
 }
 
 do_test() {
+    TRACER=$1
+
     disable_tracing
 
     echo do_execve* > set_ftrace_filter
     echo $FUNCTION_FORK >> set_ftrace_filter
 
     echo $PID > set_ftrace_pid
-    echo function > current_tracer
+    echo $TRACER > current_tracer
 
     if [ $do_function_fork -eq 1 ]; then
 	# don't allow children to be traced
@@ -82,7 +95,11 @@ do_test() {
     fi
 }
 
-do_test
+do_test function
+if grep -s function_graph available_tracers; then
+    do_test function_graph
+fi
+
 do_reset
 
 exit 0
-- 
2.43.0



