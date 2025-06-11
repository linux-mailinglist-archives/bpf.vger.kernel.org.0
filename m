Return-Path: <bpf+bounces-60267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F57EAD47A3
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DB33A8BFA
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDE2145A03;
	Wed, 11 Jun 2025 01:03:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2457C1B808;
	Wed, 11 Jun 2025 01:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603785; cv=none; b=tGo7y6Q0ybSNRWwk6L04Wri13135G2xZPVafPBsQ57AVx/op4bhJlSzwXdOANBULnB9Wjm9iUpM5j0zrXmJFbl/qme5mlW3ZrilJAv0GBkQPUUZGzhPuGsAf5lhhcSCoqndxebyaB/75M21crRaRmeOuPcYK/0wQntw8kilJTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603785; c=relaxed/simple;
	bh=FsBpRUG9mO01SDgziP1KqYDkNXwIMvIjJjcG/j181qo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jDXoAByvUkXai90Lp3s7T40EU6uvN3I0AC86JXgDuWFTTCW5cKzEfWQKAASSWXchFO46fy2YT0FnF249GIa4CiKxCVqJ5NCugxHj08IxevOYf5JREWwwwVy1BWuUPTBMC3yA5kkTFjjuHPTLMRXbhfhV96J6VafwTiz92zUErdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 5E672161483;
	Wed, 11 Jun 2025 01:03:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 6240060009;
	Wed, 11 Jun 2025 01:02:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uP9tF-00000000vBf-1mVG;
	Tue, 10 Jun 2025 21:04:29 -0400
Message-ID: <20250611010429.274682576@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 20:54:30 -0400
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
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v10 09/14] unwind deferred: Use SRCU unwind_deferred_task_work()
References: <20250611005421.144238328@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 6240060009
X-Stat-Signature: dt5tmn58ihicz5p8idskysj4amfx3z6y
X-Rspamd-Server: rspamout06
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/z9/lilI4oan58reBSJkvqzJyIm0ANZTc=
X-HE-Tag: 1749603777-714072
X-HE-Meta: U2FsdGVkX18F1GndJ4MsaZwcZTkiwymhcSzlC32dYaGbcH34MXUm3bsVx4aMVJySzo1QIUnjN7tSgIayhxT8qI9eD29p6HF+Gubz18a6STGzo+Bqj4DAn3ks5DtYjc3IaB4PUrQZSmO/F7q7wlR+UquGIMy2ZHMv2Ap8Y2mwu1UEX9vZ6mrjSHKxaBec45KJh+ZxPUd32zpH93KJi37jgiSt/ED9xrFZwCuNHfkh+bONFggIlGZu7Jo20EpQyPGVdY6cnEc/1K+pYmBwTQhLTeuisFE5dLGnXc3ioHMwR0Ql1eNwXXHZNMmvctL87Ydpxdg35CDSjCEc0tw46TUyh7umy3CSHj+jX22rUCmuLAUHwmssV9nU2JBI2qXnJrMuGYF8KiDWWbZ+DdUl2qU9MXVlkd56ijwaHSHNUePI0mfvIimmlms/QYrkH7ubJFir4Q5MbFgin8Iy/HDKeRi2cyoN0K8tG/YZHKgcsTD+zyk=

From: Steven Rostedt <rostedt@goodmis.org>

Instead of using the callback_mutex to protect the link list of callbacks
in unwind_deferred_task_work(), use SRCU instead. This gets called every
time a task exits that has to record a stack trace that was requested.
This can happen for many tasks on several CPUs at the same time. A mutex
is a bottleneck and can cause a bit of contention and slow down performance.

As the callbacks themselves are allowed to sleep, regular RCU cannot be
used to protect the list. Instead use SRCU, as that still allows the
callbacks to sleep and the list can be read without needing to hold the
callback_mutex.

Link: https://lore.kernel.org/all/ca9bd83a-6c80-4ee0-a83c-224b9d60b755@efficios.com/

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/unwind/deferred.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 268afae31ba4..e44538a2be6c 100644
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
@@ -107,6 +108,7 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct unwind_stacktrace trace;
 	struct unwind_work *work;
 	u64 timestamp;
+	int idx;
 
 	if (WARN_ON_ONCE(!info->pending))
 		return;
@@ -132,13 +134,15 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	timestamp = info->timestamp;
 
-	guard(mutex)(&callback_mutex);
-	list_for_each_entry(work, &callbacks, list) {
+	idx = srcu_read_lock(&unwind_srcu);
+	list_for_each_entry_srcu(work, &callbacks, list,
+				 srcu_read_lock_held(&unwind_srcu)) {
 		if (info->unwind_mask & BIT(work->bit)) {
 			work->func(work, &trace, timestamp);
 			clear_bit(work->bit, &info->unwind_mask);
 		}
 	}
+	srcu_read_unlock(&unwind_srcu, idx);
 }
 
 static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
@@ -215,6 +219,7 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 {
 	struct unwind_task_info *info = &current->unwind_info;
 	int pending;
+	int bit;
 	int ret;
 
 	*timestamp = 0;
@@ -226,12 +231,17 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
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
-	if (info->unwind_mask & BIT(work->bit))
+	if (info->unwind_mask & BIT(bit))
 		return 1;
 
 	/* callback already pending? */
@@ -257,19 +267,26 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
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
-		clear_bit(work->bit, &t->unwind_info.unwind_mask);
+		clear_bit(bit, &t->unwind_info.unwind_mask);
 	}
 }
 
@@ -286,7 +303,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	work->bit = ffz(unwind_mask);
 	unwind_mask |= BIT(work->bit);
 
-	list_add(&work->list, &callbacks);
+	list_add_rcu(&work->list, &callbacks);
 	work->func = func;
 	return 0;
 }
-- 
2.47.2



