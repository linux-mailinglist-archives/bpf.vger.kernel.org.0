Return-Path: <bpf+bounces-58156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F1EAB5F8A
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 00:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434273AED9F
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 22:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B5621FF5E;
	Tue, 13 May 2025 22:35:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EBC21CC41;
	Tue, 13 May 2025 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747175727; cv=none; b=o9YZA52Wxs9NUyDcFVyxoBc7qCk1Fv00DdYSohPl5yFsp8DLu2uK0QvbhKQHFrMqNph7W+SEgTfaugTEsmDayYzgSyHLtNx4TPuDcjejvKR8AOS2mFkDGhc31EqZIERXOQdawteVJZ4Ml9IFZ9Zl2ds0xDZun0Yn2NYeu8ZHBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747175727; c=relaxed/simple;
	bh=8wIrQLCzy/WCwv1KoHFeyBM230ZOJ5A3BIstJAMapOk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=V+Ph+bNX1BlxiDngDcLzxlxz1l/nwQcgvubd8Q956XvmKz6mypc5eIaLO5QPUz4JKdploBBzoNF2MdKbVyzCWheSeXhdYnqRvlBciVLWrUcAeGWqHU55+CuDAYvTUmFOHKcNQuSwZI72zNoui7q2GpA02HnRbuQ1c3OMwYDt/mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349C9C4CEF7;
	Tue, 13 May 2025 22:35:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uEyE5-00000004sf4-0VRi;
	Tue, 13 May 2025 18:35:53 -0400
Message-ID: <20250513223552.971405502@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 13 May 2025 18:34:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v9 12/13] unwind deferred: Use SRCU unwind_deferred_task_work()
References: <20250513223435.636200356@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Instead of using the callback_mutex to protect the link list of callbacks
in unwind_deferred_task_work(), use SRCU instead. This gets called every
time a task exits that has to record a stack trace that was requested.
This can happen for many tasks on several CPUs at the same time. A mutex
is a bottleneck and can cause a bit of contention and slow down performance.

As the callbacks themselves are allowed to sleep, regular RCU can not be
used to protect the list. Instead use SRCU, as that still allows the
callbacks to sleep and the list can be read without needing to hold the
callback_mutex.

Link: https://lore.kernel.org/all/ca9bd83a-6c80-4ee0-a83c-224b9d60b755@efficios.com/

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Discussion about using guard for SRCU:
   https://lore.kernel.org/20250509165155.628873521@goodmis.org

   Andrii Nakryiko brought up using guard for SRCU around the
   list iteration, but it was decided that just using the normal
   methods were fine for this use case.

 kernel/unwind/deferred.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 7ae0bec5b36a..5d6976ee648f 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -13,10 +13,11 @@
 
 #define UNWIND_MAX_ENTRIES 512
 
-/* Guards adding to and reading the list of callbacks */
+/* Guards adding to or removing from the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
 static unsigned long unwind_mask;
+DEFINE_STATIC_SRCU(unwind_srcu);
 
 /*
  * Read the task context timestamp, if this is the first caller then
@@ -108,6 +109,7 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct unwind_work *work;
 	u64 timestamp;
 	struct task_struct *task = current;
+	int idx;
 
 	if (WARN_ON_ONCE(!info->pending))
 		return;
@@ -133,13 +135,15 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	timestamp = info->timestamp;
 
-	guard(mutex)(&callback_mutex);
-	list_for_each_entry(work, &callbacks, list) {
+	idx = srcu_read_lock(&unwind_srcu);
+	list_for_each_entry_srcu(work, &callbacks, list,
+				 srcu_read_lock_held(&unwind_srcu)) {
 		if (task->unwind_mask & (1UL << work->bit)) {
 			work->func(work, &trace, timestamp);
 			clear_bit(work->bit, &current->unwind_mask);
 		}
 	}
+	srcu_read_unlock(&unwind_srcu, idx);
 }
 
 static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
@@ -216,6 +220,7 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 {
 	struct unwind_task_info *info = &current->unwind_info;
 	int pending;
+	int bit;
 	int ret;
 
 	*timestamp = 0;
@@ -227,12 +232,17 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 	if (in_nmi())
 		return unwind_deferred_request_nmi(work, timestamp);
 
+	/* Do not allow cancelled works to request again */
+	bit = READ_ONCE(work->bit);
+	if (WARN_ON_ONCE(bit < 0))
+		return -EINVAL;
+
 	guard(irqsave)();
 
 	*timestamp = get_timestamp(info);
 
 	/* This is already queued */
-	if (current->unwind_mask & (1UL << work->bit))
+	if (current->unwind_mask & (1UL << bit))
 		return 1;
 
 	/* callback already pending? */
@@ -258,19 +268,26 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 void unwind_deferred_cancel(struct unwind_work *work)
 {
 	struct task_struct *g, *t;
+	int bit;
 
 	if (!work)
 		return;
 
 	guard(mutex)(&callback_mutex);
-	list_del(&work->list);
+	list_del_rcu(&work->list);
+	bit = work->bit;
+
+	/* Do not allow any more requests and prevent callbacks */
+	work->bit = -1;
+
+	clear_bit(bit, &unwind_mask);
 
-	clear_bit(work->bit, &unwind_mask);
+	synchronize_srcu(&unwind_srcu);
 
 	guard(rcu)();
 	/* Clear this bit from all threads */
 	for_each_process_thread(g, t) {
-		clear_bit(work->bit, &t->unwind_mask);
+		clear_bit(bit, &t->unwind_mask);
 	}
 }
 
@@ -287,7 +304,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	work->bit = ffz(unwind_mask);
 	unwind_mask |= 1UL << work->bit;
 
-	list_add(&work->list, &callbacks);
+	list_add_rcu(&work->list, &callbacks);
 	work->func = func;
 	return 0;
 }
-- 
2.47.2



