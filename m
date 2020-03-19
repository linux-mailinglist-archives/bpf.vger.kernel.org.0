Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5DB18C3B6
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 00:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgCSX2R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Mar 2020 19:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgCSX1d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Mar 2020 19:27:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0730220789;
        Thu, 19 Mar 2020 23:27:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jF4ZX-000h5v-Th; Thu, 19 Mar 2020 19:27:31 -0400
Message-Id: <20200319232731.799117803@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Mar 2020 19:22:21 -0400
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
Subject: [PATCH 02/12 v2] tracing: Save off entry when peeking at next entry
References: <20200319232219.446480829@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In order to have the iterator read the buffer even when it's still updating,
it requires that the ring buffer iterator saves each event in a separate
location outside the ring buffer such that its use is immutable.

There's one use case that saves off the event returned from the ring buffer
interator and calls it again to look at the next event, before going back to
use the first event. As the ring buffer iterator will only have a single
copy, this use case will no longer be supported.

Instead, have the one use case create its own buffer to store the first
event when looking at the next event. This way, when looking at the first
event again, it wont be corrupted by the second read.

Link: http://lkml.kernel.org/r/20200317213415.722539921@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h |  2 ++
 kernel/trace/trace.c         | 40 +++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_output.c  | 15 ++++++--------
 3 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 6c7a10a6d71e..5c6943354049 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -85,6 +85,8 @@ struct trace_iterator {
 	struct mutex		mutex;
 	struct ring_buffer_iter	**buffer_iter;
 	unsigned long		iter_flags;
+	void			*temp;	/* temp holder */
+	unsigned int		temp_size;
 
 	/* trace_seq for __print_flags() and __print_symbolic() etc. */
 	struct trace_seq	tmp_seq;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 02be4ddd4ad5..819e31d0d66c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3466,7 +3466,31 @@ __find_next_entry(struct trace_iterator *iter, int *ent_cpu,
 struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
 					  int *ent_cpu, u64 *ent_ts)
 {
-	return __find_next_entry(iter, ent_cpu, NULL, ent_ts);
+	/* __find_next_entry will reset ent_size */
+	int ent_size = iter->ent_size;
+	struct trace_entry *entry;
+
+	/*
+	 * The __find_next_entry() may call peek_next_entry(), which may
+	 * call ring_buffer_peek() that may make the contents of iter->ent
+	 * undefined. Need to copy iter->ent now.
+	 */
+	if (iter->ent && iter->ent != iter->temp) {
+		if (!iter->temp || iter->temp_size < iter->ent_size) {
+			kfree(iter->temp);
+			iter->temp = kmalloc(iter->ent_size, GFP_KERNEL);
+			if (!iter->temp)
+				return NULL;
+		}
+		memcpy(iter->temp, iter->ent, iter->ent_size);
+		iter->temp_size = iter->ent_size;
+		iter->ent = iter->temp;
+	}
+	entry = __find_next_entry(iter, ent_cpu, NULL, ent_ts);
+	/* Put back the original ent_size */
+	iter->ent_size = ent_size;
+
+	return entry;
 }
 
 /* Find the next real entry, and increment the iterator to the next entry */
@@ -4197,6 +4221,18 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	if (!iter->buffer_iter)
 		goto release;
 
+	/*
+	 * trace_find_next_entry() may need to save off iter->ent.
+	 * It will place it into the iter->temp buffer. As most
+	 * events are less than 128, allocate a buffer of that size.
+	 * If one is greater, then trace_find_next_entry() will
+	 * allocate a new buffer to adjust for the bigger iter->ent.
+	 * It's not critical if it fails to get allocated here.
+	 */
+	iter->temp = kmalloc(128, GFP_KERNEL);
+	if (iter->temp)
+		iter->temp_size = 128;
+
 	/*
 	 * We make a copy of the current tracer to avoid concurrent
 	 * changes on it while we are reading.
@@ -4269,6 +4305,7 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
  fail:
 	mutex_unlock(&trace_types_lock);
 	kfree(iter->trace);
+	kfree(iter->temp);
 	kfree(iter->buffer_iter);
 release:
 	seq_release_private(inode, file);
@@ -4344,6 +4381,7 @@ static int tracing_release(struct inode *inode, struct file *file)
 
 	mutex_destroy(&iter->mutex);
 	free_cpumask_var(iter->started);
+	kfree(iter->temp);
 	kfree(iter->trace);
 	kfree(iter->buffer_iter);
 	seq_release_private(inode, file);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index e25a7da79c6b..9a121e147102 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -617,22 +617,19 @@ int trace_print_context(struct trace_iterator *iter)
 
 int trace_print_lat_context(struct trace_iterator *iter)
 {
+	struct trace_entry *entry, *next_entry;
 	struct trace_array *tr = iter->tr;
-	/* trace_find_next_entry will reset ent_size */
-	int ent_size = iter->ent_size;
 	struct trace_seq *s = &iter->seq;
-	u64 next_ts;
-	struct trace_entry *entry = iter->ent,
-			   *next_entry = trace_find_next_entry(iter, NULL,
-							       &next_ts);
 	unsigned long verbose = (tr->trace_flags & TRACE_ITER_VERBOSE);
+	u64 next_ts;
 
-	/* Restore the original ent_size */
-	iter->ent_size = ent_size;
-
+	next_entry = trace_find_next_entry(iter, NULL, &next_ts);
 	if (!next_entry)
 		next_ts = iter->ts;
 
+	/* trace_find_next_entry() may change iter->ent */
+	entry = iter->ent;
+
 	if (verbose) {
 		char comm[TASK_COMM_LEN];
 
-- 
2.25.1


