Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E03618C3A5
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 00:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgCSX1t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Mar 2020 19:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbgCSX1e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Mar 2020 19:27:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AE2B208E4;
        Thu, 19 Mar 2020 23:27:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jF4ZY-000h6x-6f; Thu, 19 Mar 2020 19:27:32 -0400
Message-Id: <20200319232732.087015327@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Mar 2020 19:22:23 -0400
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
Subject: [PATCH 04/12 v2] ring-buffer: Rename ring_buffer_read() to read_buffer_iter_advance()
References: <20200319232219.446480829@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When the ring buffer was first created, the iterator followed the normal
producer/consumer operations where it had both a peek() operation, that just
returned the event at the current location, and a read(), that would return
the event at the current location and also increment the iterator such that
the next peek() or read() will return the next event.

The only use of the ring_buffer_read() is currently to move the iterator to
the next location and nothing now actually reads the event it returns.
Rename this function to its actual use case to ring_buffer_iter_advance(),
which also adds the "iter" part to the name, which is more meaningful. As
the timestamp returned by ring_buffer_read() was never used, there's no
reason that this new version should bother having returning it. It will also
become a void function.

Link: http://lkml.kernel.org/r/20200317213416.018928618@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h          |  3 +--
 kernel/trace/ring_buffer.c           | 23 ++++++-----------------
 kernel/trace/trace.c                 |  4 ++--
 kernel/trace/trace_functions_graph.c |  2 +-
 4 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index df0124eabece..0ae603b79b0e 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -135,8 +135,7 @@ void ring_buffer_read_finish(struct ring_buffer_iter *iter);
 
 struct ring_buffer_event *
 ring_buffer_iter_peek(struct ring_buffer_iter *iter, u64 *ts);
-struct ring_buffer_event *
-ring_buffer_read(struct ring_buffer_iter *iter, u64 *ts);
+void ring_buffer_iter_advance(struct ring_buffer_iter *iter);
 void ring_buffer_iter_reset(struct ring_buffer_iter *iter);
 int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1718520a2809..f57eeaa80e3e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4318,35 +4318,24 @@ ring_buffer_read_finish(struct ring_buffer_iter *iter)
 EXPORT_SYMBOL_GPL(ring_buffer_read_finish);
 
 /**
- * ring_buffer_read - read the next item in the ring buffer by the iterator
+ * ring_buffer_iter_advance - advance the iterator to the next location
  * @iter: The ring buffer iterator
- * @ts: The time stamp of the event read.
  *
- * This reads the next event in the ring buffer and increments the iterator.
+ * Move the location of the iterator such that the next read will
+ * be the next location of the iterator.
  */
-struct ring_buffer_event *
-ring_buffer_read(struct ring_buffer_iter *iter, u64 *ts)
+void ring_buffer_iter_advance(struct ring_buffer_iter *iter)
 {
-	struct ring_buffer_event *event;
 	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
- again:
-	event = rb_iter_peek(iter, ts);
-	if (!event)
-		goto out;
-
-	if (event->type_len == RINGBUF_TYPE_PADDING)
-		goto again;
 
 	rb_advance_iter(iter);
- out:
-	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
-	return event;
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 }
-EXPORT_SYMBOL_GPL(ring_buffer_read);
+EXPORT_SYMBOL_GPL(ring_buffer_iter_advance);
 
 /**
  * ring_buffer_size - return the size of the ring buffer (in bytes)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 819e31d0d66c..47889123be7f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3378,7 +3378,7 @@ static void trace_iterator_increment(struct trace_iterator *iter)
 
 	iter->idx++;
 	if (buf_iter)
-		ring_buffer_read(buf_iter, NULL);
+		ring_buffer_iter_advance(buf_iter);
 }
 
 static struct trace_entry *
@@ -3562,7 +3562,7 @@ void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 		if (ts >= iter->array_buffer->time_start)
 			break;
 		entries++;
-		ring_buffer_read(buf_iter, NULL);
+		ring_buffer_iter_advance(buf_iter);
 	}
 
 	per_cpu_ptr(iter->array_buffer->data, cpu)->skipped_entries = entries;
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 7d71546ba00a..4a9c49c08ec9 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -482,7 +482,7 @@ get_return_for_leaf(struct trace_iterator *iter,
 
 	/* this is a leaf, now advance the iterator */
 	if (ring_iter)
-		ring_buffer_read(ring_iter, NULL);
+		ring_buffer_iter_advance(ring_iter);
 
 	return next;
 }
-- 
2.25.1


