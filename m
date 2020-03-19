Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30FC718C3AC
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 00:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgCSX1t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Mar 2020 19:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbgCSX1e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Mar 2020 19:27:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92CDF20CC7;
        Thu, 19 Mar 2020 23:27:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jF4ZY-000h7z-GA; Thu, 19 Mar 2020 19:27:32 -0400
Message-Id: <20200319232732.379985473@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Mar 2020 19:22:25 -0400
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
Subject: [PATCH 06/12 v2] ring-buffer: Have rb_iter_head_event() handle concurrent writer
References: <20200319232219.446480829@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Have the ring_buffer_iter structure have a place to store an event, such
that it can not be overwritten by a writer, and load it in such a way via
rb_iter_head_event() that it will return NULL and reset the iter to the
start of the current page if a writer updated the page.

Link: http://lkml.kernel.org/r/20200317213416.306959216@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 106 ++++++++++++++++++++++++++-----------
 1 file changed, 75 insertions(+), 31 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e689bdcb53e8..3d718add73c1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -503,11 +503,13 @@ struct trace_buffer {
 struct ring_buffer_iter {
 	struct ring_buffer_per_cpu	*cpu_buffer;
 	unsigned long			head;
+	unsigned long			next_event;
 	struct buffer_page		*head_page;
 	struct buffer_page		*cache_reader_page;
 	unsigned long			cache_read;
 	u64				read_stamp;
 	u64				page_stamp;
+	struct ring_buffer_event	*event;
 };
 
 /**
@@ -1914,15 +1916,59 @@ rb_reader_event(struct ring_buffer_per_cpu *cpu_buffer)
 			       cpu_buffer->reader_page->read);
 }
 
-static __always_inline struct ring_buffer_event *
-rb_iter_head_event(struct ring_buffer_iter *iter)
+static __always_inline unsigned rb_page_commit(struct buffer_page *bpage)
 {
-	return __rb_page_index(iter->head_page, iter->head);
+	return local_read(&bpage->page->commit);
 }
 
-static __always_inline unsigned rb_page_commit(struct buffer_page *bpage)
+static struct ring_buffer_event *
+rb_iter_head_event(struct ring_buffer_iter *iter)
 {
-	return local_read(&bpage->page->commit);
+	struct ring_buffer_event *event;
+	struct buffer_page *iter_head_page = iter->head_page;
+	unsigned long commit;
+	unsigned length;
+
+	/*
+	 * When the writer goes across pages, it issues a cmpxchg which
+	 * is a mb(), which will synchronize with the rmb here.
+	 * (see rb_tail_page_update() and __rb_reserve_next())
+	 */
+	commit = rb_page_commit(iter_head_page);
+	smp_rmb();
+	event = __rb_page_index(iter_head_page, iter->head);
+	length = rb_event_length(event);
+
+	/*
+	 * READ_ONCE() doesn't work on functions and we don't want the
+	 * compiler doing any crazy optimizations with length.
+	 */
+	barrier();
+
+	if ((iter->head + length) > commit || length > BUF_MAX_DATA_SIZE)
+		/* Writer corrupted the read? */
+		goto reset;
+
+	memcpy(iter->event, event, length);
+	/*
+	 * If the page stamp is still the same after this rmb() then the
+	 * event was safely copied without the writer entering the page.
+	 */
+	smp_rmb();
+
+	/* Make sure the page didn't change since we read this */
+	if (iter->page_stamp != iter_head_page->page->time_stamp ||
+	    commit > rb_page_commit(iter_head_page))
+		goto reset;
+
+	iter->next_event = iter->head + length;
+	return iter->event;
+ reset:
+	/* Reset to the beginning */
+	iter->page_stamp = iter->read_stamp = iter->head_page->page->time_stamp;
+	iter->head = 0;
+	iter->next_event = 0;
+	return NULL;
 }
 
 /* Size is determined by what has been committed */
@@ -1962,6 +2008,7 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
 
 	iter->page_stamp = iter->read_stamp = iter->head_page->page->time_stamp;
 	iter->head = 0;
+	iter->next_event = 0;
 }
 
 /*
@@ -3548,6 +3595,7 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 	/* Iterator usage is expected to have record disabled */
 	iter->head_page = cpu_buffer->reader_page;
 	iter->head = cpu_buffer->reader_page->read;
+	iter->next_event = iter->head;
 
 	iter->cache_reader_page = iter->head_page;
 	iter->cache_read = cpu_buffer->read;
@@ -3625,7 +3673,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 		return 0;
 
 	/* Still racy, as it may return a false positive, but that's OK */
-	return ((iter->head_page == commit_page && iter->head == commit) ||
+	return ((iter->head_page == commit_page && iter->head >= commit) ||
 		(iter->head_page == reader && commit_page == head_page &&
 		 head_page->read == commit &&
 		 iter->head == rb_page_commit(cpu_buffer->reader_page)));
@@ -3853,15 +3901,22 @@ static void rb_advance_reader(struct ring_buffer_per_cpu *cpu_buffer)
 static void rb_advance_iter(struct ring_buffer_iter *iter)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct ring_buffer_event *event;
-	unsigned length;
 
 	cpu_buffer = iter->cpu_buffer;
 
+	/* If head == next_event then we need to jump to the next event */
+	if (iter->head == iter->next_event) {
+		/* If the event gets overwritten again, there's nothing to do */
+		if (rb_iter_head_event(iter) == NULL)
+			return;
+	}
+
+	iter->head = iter->next_event;
+
 	/*
 	 * Check if we are at the end of the buffer.
 	 */
-	if (iter->head >= rb_page_size(iter->head_page)) {
+	if (iter->next_event >= rb_page_size(iter->head_page)) {
 		/* discarded commits can make the page empty */
 		if (iter->head_page == cpu_buffer->commit_page)
 			return;
@@ -3869,27 +3924,7 @@ static void rb_advance_iter(struct ring_buffer_iter *iter)
 		return;
 	}
 
-	event = rb_iter_head_event(iter);
-
-	length = rb_event_length(event);
-
-	/*
-	 * This should not be called to advance the header if we are
-	 * at the tail of the buffer.
-	 */
-	if (RB_WARN_ON(cpu_buffer,
-		       (iter->head_page == cpu_buffer->commit_page) &&
-		       (iter->head + length > rb_commit_index(cpu_buffer))))
-		return;
-
-	rb_update_iter_read_stamp(iter, event);
-
-	iter->head += length;
-
-	/* check for end of page padding */
-	if ((iter->head >= rb_page_size(iter->head_page)) &&
-	    (iter->head_page != cpu_buffer->commit_page))
-		rb_inc_iter(iter);
+	rb_update_iter_read_stamp(iter, iter->event);
 }
 
 static int rb_lost_events(struct ring_buffer_per_cpu *cpu_buffer)
@@ -4017,6 +4052,8 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	}
 
 	event = rb_iter_head_event(iter);
+	if (!event)
+		goto again;
 
 	switch (event->type_len) {
 	case RINGBUF_TYPE_PADDING:
@@ -4233,10 +4270,16 @@ ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return NULL;
 
-	iter = kmalloc(sizeof(*iter), flags);
+	iter = kzalloc(sizeof(*iter), flags);
 	if (!iter)
 		return NULL;
 
+	iter->event = kmalloc(BUF_MAX_DATA_SIZE, flags);
+	if (!iter->event) {
+		kfree(iter);
+		return NULL;
+	}
+
 	cpu_buffer = buffer->buffers[cpu];
 
 	iter->cpu_buffer = cpu_buffer;
@@ -4317,6 +4360,7 @@ ring_buffer_read_finish(struct ring_buffer_iter *iter)
 
 	atomic_dec(&cpu_buffer->record_disabled);
 	atomic_dec(&cpu_buffer->buffer->resize_disabled);
+	kfree(iter->event);
 	kfree(iter);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_finish);
-- 
2.25.1


