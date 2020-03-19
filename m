Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB67E18C3A2
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 00:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCSX1g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Mar 2020 19:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbgCSX1f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Mar 2020 19:27:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BFEE208DB;
        Thu, 19 Mar 2020 23:27:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jF4ZZ-000hAZ-8W; Thu, 19 Mar 2020 19:27:33 -0400
Message-Id: <20200319232733.144575435@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Mar 2020 19:22:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: [PATCH 11/12 v2] ring-buffer/tracing: Have iterator acknowledge dropped events
References: <20200319232219.446480829@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Have the ring_buffer_iterator set a flag if events were dropped as it were
to go and peek at the next event. Have the trace file display this fact if
it happened with a "LOST EVENTS" message.

Link: http://lkml.kernel.org/r/20200317213417.045858900@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  1 +
 kernel/trace/ring_buffer.c  | 16 ++++++++++++++++
 kernel/trace/trace.c        | 16 ++++++++++++----
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 0ae603b79b0e..c76b2f3b3ac4 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -138,6 +138,7 @@ ring_buffer_iter_peek(struct ring_buffer_iter *iter, u64 *ts);
 void ring_buffer_iter_advance(struct ring_buffer_iter *iter);
 void ring_buffer_iter_reset(struct ring_buffer_iter *iter);
 int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
+bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
 
 unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8bafba674ec0..87bbb519505f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -510,6 +510,7 @@ struct ring_buffer_iter {
 	u64				read_stamp;
 	u64				page_stamp;
 	struct ring_buffer_event	*event;
+	int				missed_events;
 };
 
 /**
@@ -1971,6 +1972,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	iter->page_stamp = iter->read_stamp = iter->head_page->page->time_stamp;
 	iter->head = 0;
 	iter->next_event = 0;
+	iter->missed_events = 1;
 	return NULL;
 }
 
@@ -4174,6 +4176,20 @@ ring_buffer_peek(struct trace_buffer *buffer, int cpu, u64 *ts,
 	return event;
 }
 
+/** ring_buffer_iter_dropped - report if there are dropped events
+ * @iter: The ring buffer iterator
+ *
+ * Returns true if there was dropped events since the last peek.
+ */
+bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter)
+{
+	bool ret = iter->missed_events != 0;
+
+	iter->missed_events = 0;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_iter_dropped);
+
 /**
  * ring_buffer_iter_peek - peek at the next event to be read
  * @iter: The ring buffer iterator
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b7052ffb0211..ee0ff8175c03 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3388,11 +3388,15 @@ peek_next_entry(struct trace_iterator *iter, int cpu, u64 *ts,
 	struct ring_buffer_event *event;
 	struct ring_buffer_iter *buf_iter = trace_buffer_iter(iter, cpu);
 
-	if (buf_iter)
+	if (buf_iter) {
 		event = ring_buffer_iter_peek(buf_iter, ts);
-	else
+		if (lost_events)
+			*lost_events = ring_buffer_iter_dropped(buf_iter) ?
+				(unsigned long)-1 : 0;
+	} else {
 		event = ring_buffer_peek(iter->array_buffer->buffer, cpu, ts,
 					 lost_events);
+	}
 
 	if (event) {
 		iter->ent_size = ring_buffer_event_length(event);
@@ -4005,8 +4009,12 @@ enum print_line_t print_trace_line(struct trace_iterator *iter)
 	enum print_line_t ret;
 
 	if (iter->lost_events) {
-		trace_seq_printf(&iter->seq, "CPU:%d [LOST %lu EVENTS]\n",
-				 iter->cpu, iter->lost_events);
+		if (iter->lost_events == (unsigned long)-1)
+			trace_seq_printf(&iter->seq, "CPU:%d [LOST EVENTS]\n",
+					 iter->cpu);
+		else
+			trace_seq_printf(&iter->seq, "CPU:%d [LOST %lu EVENTS]\n",
+					 iter->cpu, iter->lost_events);
 		if (trace_seq_has_overflowed(&iter->seq))
 			return TRACE_TYPE_PARTIAL_LINE;
 	}
-- 
2.25.1


