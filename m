Return-Path: <bpf+bounces-38868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E7096B236
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 08:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A51283ECD
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 06:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A988E1465B1;
	Wed,  4 Sep 2024 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I1E/80Sb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2BD13B2A4;
	Wed,  4 Sep 2024 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433174; cv=none; b=OeqsXK1X/RxywbBcEZzJbJVNiB1V98x0WVaWy9bHd8pAxW4u1xGC5m7ncaePhrTuqrQH3ckVT/fBP6WmHhjK8pm6Lc7JBiyH/sNHoar6+wu5H9UHFP4aaKsdl05hNZF7Amv1y+rMlfw1s3DF2i+nn3oGHUzQPbfwpqTifzJT2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433174; c=relaxed/simple;
	bh=hC58jLJTDlCLylqz/wSbPfuzxRAozU8IZy2jXQXM3mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhqDQvPp4x4BBdGXN9oC99THdziaFjMIBn8+NuT/75U2b4SmztEbAAMJylT28yEmgy7SPu9bV3kLGtHE/zBh2kJ88dyJNj9cU3BMosjwQp9rLNW9CzeVBTyYPp91KtABb8XAzpUbcTtbqNdGM6h74qqMikHGbfPCXjtXCFG76IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I1E/80Sb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483L8dLS006681;
	Wed, 4 Sep 2024 06:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=uMWX5RTeccU/C
	cqEWQfzKGoIsIuNyNyKITEFnOwaNc0=; b=I1E/80SbtDrptLdKRhoLCmXl9/pnM
	kjKedt5+FAud60GteKwOEKRxvlrjX+NYrFmb3Q/0loXkGjNiM6vKz+p8yN2PjLkk
	Q3rW7dgjQZJnlWlZedOcChckyvIc86DiVdP+vfbRYIVk5Ru46qnl3uhl+cb4upZ5
	pPEpHHNEvCYSJxoiq93Nmj+R+YH9vrZzuwTcxiIHDOBOktr967iIdCP85KGnRpia
	Fxs+am5w6u6wusbuoO/iH1WI3pleXnA2zBCjHo/lFQ2Hgi3j4E+OJsC3QX0gwUeN
	IYhHLrh4TzNJ7lciCMeFJy3mpJAzLya3TCHEf+Cx06ArsmLb6S446QMHA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41bttyhmcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:59:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48456qES001535;
	Wed, 4 Sep 2024 06:59:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cf0mxcm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:59:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4846xKZS30933448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 06:59:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A36A2004B;
	Wed,  4 Sep 2024 06:59:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FE4420043;
	Wed,  4 Sep 2024 06:59:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Sep 2024 06:59:20 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 37F94E0297; Wed,  4 Sep 2024 08:59:20 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 6/7] tracing: add support for function argument to graph tracer
Date: Wed,  4 Sep 2024 08:59:00 +0200
Message-ID: <20240904065908.1009086-7-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904065908.1009086-1-svens@linux.ibm.com>
References: <20240904065908.1009086-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _o0R60wvuriQNIEKnoAy1BMXnXC4pMJ1
X-Proofpoint-ORIG-GUID: _o0R60wvuriQNIEKnoAy1BMXnXC4pMJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_04,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409040049

Wire up the code to print function arguments in the function graph
tracer. This functionality can be enabled/disabled during compile
time by setting CONFIG_FUNCTION_TRACE_ARGS and during runtime with
options/funcgraph-args.

Example usage:

6)              | dummy_xmit [dummy](skb = 0x8887c100, dev = 0x872ca000) {
6)              |   consume_skb(skb = 0x8887c100) {
6)              |     skb_release_head_state(skb = 0x8887c100) {
6)  0.178 us    |       sock_wfree(skb = 0x8887c100)
6)  0.627 us    |     }

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/linux/ftrace.h               |  1 +
 kernel/trace/fgraph.c                |  6 ++-
 kernel/trace/trace_functions_graph.c | 74 ++++++++++++++--------------
 3 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 56d91041ecd2..5d0ff66f8a70 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1010,6 +1010,7 @@ static inline void ftrace_init(void) { }
  * to remove extra padding at the end.
  */
 struct ftrace_graph_ent {
+	struct ftrace_regs regs;
 	unsigned long func; /* Current function */
 	int depth;
 } __packed;
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index fa62ebfa0711..f4bb10c0aa52 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -614,7 +614,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 /* If the caller does not use ftrace, call this function. */
 int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp,
-			struct ftrace_regs *fregs)
+			 struct ftrace_regs *fregs)
 {
 	struct ftrace_graph_ent trace;
 	unsigned long bitmap = 0;
@@ -623,6 +623,10 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
+	if (IS_ENABLED(CONFIG_FUNCTION_TRACE_ARGS) && fregs)
+		trace.regs = *fregs;
+	else
+		memset(&trace.regs, 0, sizeof(struct ftrace_regs));
 
 	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
 	if (offset < 0)
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 13d0387ac6a6..be0cee52944a 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -12,6 +12,8 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/btf.h>
+#include <linux/bpf.h>
 
 #include "trace.h"
 #include "trace_output.h"
@@ -63,6 +65,9 @@ static struct tracer_opt trace_opts[] = {
 	{ TRACER_OPT(funcgraph-retval, TRACE_GRAPH_PRINT_RETVAL) },
 	/* Display function return value in hexadecimal format ? */
 	{ TRACER_OPT(funcgraph-retval-hex, TRACE_GRAPH_PRINT_RETVAL_HEX) },
+#endif
+#ifdef CONFIG_FUNCTION_TRACE_ARGS
+	{ TRACER_OPT(funcgraph-args, TRACE_GRAPH_ARGS) },
 #endif
 	/* Include sleep time (scheduled out) between entry and return */
 	{ TRACER_OPT(sleep-time, TRACE_GRAPH_SLEEP_TIME) },
@@ -653,7 +658,7 @@ print_graph_duration(struct trace_array *tr, unsigned long long duration,
 #define __TRACE_GRAPH_PRINT_RETVAL TRACE_GRAPH_PRINT_RETVAL
 
 static void print_graph_retval(struct trace_seq *s, unsigned long retval,
-				bool leaf, void *func, bool hex_format)
+			       bool hex_format)
 {
 	unsigned long err_code = 0;
 
@@ -673,28 +678,17 @@ static void print_graph_retval(struct trace_seq *s, unsigned long retval,
 		err_code = 0;
 
 done:
-	if (leaf) {
-		if (hex_format || (err_code == 0))
-			trace_seq_printf(s, "%ps(); /* = 0x%lx */\n",
-					func, retval);
-		else
-			trace_seq_printf(s, "%ps(); /* = %ld */\n",
-					func, err_code);
-	} else {
-		if (hex_format || (err_code == 0))
-			trace_seq_printf(s, "} /* %ps = 0x%lx */\n",
-					func, retval);
-		else
-			trace_seq_printf(s, "} /* %ps = %ld */\n",
-					func, err_code);
-	}
+	if (hex_format || (err_code == 0))
+		trace_seq_printf(s, " /* = 0x%lx */", retval);
+	else
+		trace_seq_printf(s, " /* = %ld */", err_code);
 }
 
 #else
 
 #define __TRACE_GRAPH_PRINT_RETVAL 0
 
-#define print_graph_retval(_seq, _retval, _leaf, _func, _format) do {} while (0)
+#define print_graph_retval(_seq, _retval, _format) do {} while (0)
 
 #endif
 
@@ -741,16 +735,20 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 	/* Function */
 	for (i = 0; i < call->depth * TRACE_GRAPH_INDENT; i++)
 		trace_seq_putc(s, ' ');
+	trace_seq_printf(s, "%ps", (void *)graph_ret->func);
+	if (flags & TRACE_GRAPH_ARGS)
+		print_function_args(s, &call->regs, graph_ret->func);
+	else
+		trace_seq_puts(s, "();");
 
 	/*
 	 * Write out the function return value if the option function-retval is
 	 * enabled.
 	 */
 	if (flags & __TRACE_GRAPH_PRINT_RETVAL)
-		print_graph_retval(s, graph_ret->retval, true, (void *)call->func,
-				!!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX));
-	else
-		trace_seq_printf(s, "%ps();\n", (void *)call->func);
+		print_graph_retval(s, graph_ret->retval,
+				   !!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX));
+	trace_seq_printf(s, "\n");
 
 	print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
 			cpu, iter->ent->pid, flags);
@@ -788,7 +786,12 @@ print_graph_entry_nested(struct trace_iterator *iter,
 	for (i = 0; i < call->depth * TRACE_GRAPH_INDENT; i++)
 		trace_seq_putc(s, ' ');
 
-	trace_seq_printf(s, "%ps() {\n", (void *)call->func);
+	trace_seq_printf(s, "%ps", (void *)call->func);
+	if (flags & TRACE_GRAPH_ARGS)
+		print_function_args(s, &call->regs, call->func);
+	else
+		trace_seq_puts(s, "()");
+	trace_seq_printf(s, " {\n");
 
 	if (trace_seq_has_overflowed(s))
 		return TRACE_TYPE_PARTIAL_LINE;
@@ -1028,27 +1031,26 @@ print_graph_return(struct ftrace_graph_ret *trace, struct trace_seq *s,
 	for (i = 0; i < trace->depth * TRACE_GRAPH_INDENT; i++)
 		trace_seq_putc(s, ' ');
 
+	/*
+	 * If the return function does not have a matching entry,
+	 * then the entry was lost. Instead of just printing
+	 * the '}' and letting the user guess what function this
+	 * belongs to, write out the function name. Always do
+	 * that if the funcgraph-tail option is enabled.
+	 */
+	if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL))
+		trace_seq_puts(s, "}");
+	else
+		trace_seq_printf(s, "} /* %ps */", (void *)trace->func);
 	/*
 	 * Always write out the function name and its return value if the
 	 * function-retval option is enabled.
 	 */
 	if (flags & __TRACE_GRAPH_PRINT_RETVAL) {
-		print_graph_retval(s, trace->retval, false, (void *)trace->func,
+		print_graph_retval(s, trace->retval,
 			!!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX));
-	} else {
-		/*
-		 * If the return function does not have a matching entry,
-		 * then the entry was lost. Instead of just printing
-		 * the '}' and letting the user guess what function this
-		 * belongs to, write out the function name. Always do
-		 * that if the funcgraph-tail option is enabled.
-		 */
-		if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL))
-			trace_seq_puts(s, "}\n");
-		else
-			trace_seq_printf(s, "} /* %ps */\n", (void *)trace->func);
 	}
-
+	trace_seq_printf(s, "\n");
 	/* Overrun */
 	if (flags & TRACE_GRAPH_PRINT_OVERRUN)
 		trace_seq_printf(s, " (Overruns: %u)\n",
-- 
2.43.0


