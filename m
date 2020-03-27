Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B4C194E96
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 02:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgC0BqV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 26 Mar 2020 21:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgC0BqV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 21:46:21 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 212C62070A;
        Fri, 27 Mar 2020 01:46:19 +0000 (UTC)
Date:   Thu, 26 Mar 2020 21:46:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/12 v2] ring-buffer/tracing: Remove disabling of ring
 buffer while reading trace file
Message-ID: <20200326214617.697634f3@oasis.local.home>
In-Reply-To: <2a7f96545945457cade216aa3c736bcc@AcuMS.aculab.com>
References: <20200319232219.446480829@goodmis.org>
        <2a7f96545945457cade216aa3c736bcc@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 21 Mar 2020 19:13:51 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Steven Rostedt
> > Sent: 19 March 2020 23:22  
> ...
> > 
> > This patch series attempts to satisfy that request, by creating a
> > temporary buffer in each of the per cpu iterators to place the
> > read event into, such that it can be passed to users without worrying
> > about a writer to corrupt the event while it was being written out.
> > It also uses the fact that the ring buffer is broken up into pages,
> > where each page has its own timestamp that gets updated when a
> > writer crosses over to it. By copying it to the temp buffer, and
> > doing a "before and after" test of the time stamp with memory barriers,
> > can allow the events to be saved.  
> 
> Does this mean the you will no longer be able to look at a snapshot
> of the trace by running 'less trace' (and typically going to the end
> to get info for all cpus).

I changed patch 9 to be this:

It adds an option "pause-on-trace" that when set, will bring back the
old behavior of pausing recording to the ring buffer when the trace
file is open.

If needed, I can add a kernel command line option and a Kconfig that
makes this set to true by default.

-- Steve

From 71f44d604e5b16cc239d6276b447a515448f582f Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Tue, 17 Mar 2020 17:32:31 -0400
Subject: [PATCH] tracing: Do not disable tracing when reading the trace file

When opening the "trace" file, it is no longer necessary to disable tracing.

Note, a new option is created called "pause-on-trace", when set, will cause
the trace file to emulate its original behavior.

Link: http://lkml.kernel.org/r/20200317213416.903351225@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst | 6 ++++++
 kernel/trace/trace.c           | 9 ++++++---
 kernel/trace/trace.h           | 1 +
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 99a0890e20ec..c33950a35d65 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1125,6 +1125,12 @@ Here are the available options:
 	the trace displays additional information about the
 	latency, as described in "Latency trace format".
 
+  pause-on-trace
+	When set, opening the trace file for read, will pause
+	writing to the ring buffer (as if tracing_on was set to zero).
+	This simulates the original behavior of the trace file.
+	When the file is closed, tracing will be enabled again.
+
   record-cmd
 	When any event or tracer is enabled, a hook is enabled
 	in the sched_switch trace point to fill comm cache
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 47889123be7f..650fa81fffe8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4273,8 +4273,11 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	if (trace_clocks[tr->clock_id].in_ns)
 		iter->iter_flags |= TRACE_FILE_TIME_IN_NS;
 
-	/* stop the trace while dumping if we are not opening "snapshot" */
-	if (!iter->snapshot)
+	/*
+	 * If pause-on-trace is enabled, then stop the trace while
+	 * dumping, unless this is the "snapshot" file
+	 */
+	if (!iter->snapshot && (tr->trace_flags & TRACE_ITER_PAUSE_ON_TRACE))
 		tracing_stop_tr(tr);
 
 	if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
@@ -4371,7 +4374,7 @@ static int tracing_release(struct inode *inode, struct file *file)
 	if (iter->trace && iter->trace->close)
 		iter->trace->close(iter);
 
-	if (!iter->snapshot)
+	if (!iter->snapshot && tr->stop_count)
 		/* reenable tracing if it was previously enabled */
 		tracing_start_tr(tr);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index c61e1b1c85a6..f37e05135986 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1302,6 +1302,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(IRQ_INFO,		"irq-info"),		\
 		C(MARKERS,		"markers"),		\
 		C(EVENT_FORK,		"event-fork"),		\
+		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
-- 
2.20.1

