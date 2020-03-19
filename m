Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8574F18C3B3
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 00:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCSX2I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Mar 2020 19:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbgCSX1e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Mar 2020 19:27:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B793F2137B;
        Thu, 19 Mar 2020 23:27:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jF4ZY-000h8V-Ku; Thu, 19 Mar 2020 19:27:32 -0400
Message-Id: <20200319232732.526602365@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 19 Mar 2020 19:22:26 -0400
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
Subject: [PATCH 07/12 v2] ring-buffer: Do not die if rb_iter_peek() fails more than thrice
References: <20200319232219.446480829@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As the iterator will be reading a live buffer, and if the event being read
is on a page that a writer crosses, it will fail and try again, the
condition in rb_iter_peek() that only allows a retry to happen three times
is no longer valid. Allow rb_iter_peek() to retry more than three times
without killing the ring buffer, but only if rb_iter_head_event() had failed
at least once.

Link: http://lkml.kernel.org/r/20200317213416.452888193@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3d718add73c1..475338fda969 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4012,6 +4012,7 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
 	int nr_loops = 0;
+	bool failed = false;
 
 	if (ts)
 		*ts = 0;
@@ -4038,10 +4039,14 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	 * to a data event, we should never loop more than three times.
 	 * Once for going to next page, once on time extend, and
 	 * finally once to get the event.
-	 * (We never hit the following condition more than thrice).
+	 * We should never hit the following condition more than thrice,
+	 * unless the buffer is very small, and there's a writer
+	 * that is causing the reader to fail getting an event.
 	 */
-	if (RB_WARN_ON(cpu_buffer, ++nr_loops > 3))
+	if (++nr_loops > 3) {
+		RB_WARN_ON(cpu_buffer, !failed);
 		return NULL;
+	}
 
 	if (rb_per_cpu_empty(cpu_buffer))
 		return NULL;
@@ -4052,8 +4057,10 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	}
 
 	event = rb_iter_head_event(iter);
-	if (!event)
+	if (!event) {
+		failed = true;
 		goto again;
+	}
 
 	switch (event->type_len) {
 	case RINGBUF_TYPE_PADDING:
-- 
2.25.1


