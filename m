Return-Path: <bpf+bounces-61598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24FBAE9165
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F173B965E
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB9A2F4307;
	Wed, 25 Jun 2025 22:57:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57942882AF;
	Wed, 25 Jun 2025 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892219; cv=none; b=f+GmGpDbGWIWc5rXY1Rd/bqdjq+T0rGn8pKgfMQMatq3+24nWVK0Fkcer5iiHvlbVQKTTHhBjcyx8a+vOA4csiyuwTYhKOVYXfbdq7ZZIxouxvgNubI586quufEu++fATcuJOOaXZbIE528bIRDUXWp6yKgdgMCKz1rBkMqkFhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892219; c=relaxed/simple;
	bh=HXvEkZi/97sKfqnOc6lpR0Efbe/WMhMWQLkPhKqFGuM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rB9eYKo6IbtfsPf3bD3uMYOW/BHbSJeRCbaceOEAweyhwGsi3oJm6prUhEsH9pxpXgJHgMwEJTBNF2r1qHTbkUb/ftEtMBrTi2cPJ3utWQ/BUs1jfigzdFz2Ar3//N3IRTIVamzqKXwvJw8QSNJwRzkLI0gDCzGGGiNKwEzu1Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 775118010C;
	Wed, 25 Jun 2025 22:56:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 4C5DF2002C;
	Wed, 25 Jun 2025 22:56:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZ3M-000000043hF-21rs;
	Wed, 25 Jun 2025 18:57:16 -0400
Message-ID: <20250625225716.341400245@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 18:56:09 -0400
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
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v11 09/14] unwind deferred: Use SRCU unwind_deferred_task_work()
References: <20250625225600.555017347@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: 39idxpzbtkcrztswnqrcu35rmtb4jysy
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 4C5DF2002C
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/gMXBM4G+9NArKOBUmCPwd4+hNKRlEev0=
X-HE-Tag: 1750892211-882373
X-HE-Meta: U2FsdGVkX18zrHOtnO+oITj5d/B9frk6jnyY9Qdz32NWkvm0sDFnuQPP6vNSLV3Yen+K7gc1Sq9TyaXpYpo6wCBUldCAkawyQViZCW3OtAOTAPmtXoYYNZM6XgSVTU/mlSenjQ/W13SdY/oyDbPbA4nOxgI+ygNH2QFuGG+rB3VrsopHI7JnjcERJQDYDsaKE+PWsgCgHqySkn3txDOL1PEqO7QoEY4O9H0gSJm66cp9l1JWQ9ZIWSi+XMM4cuYMOx6YDxy6Ji/WkqgwV7kYiZ3rPPyxcPXIupysYYq4PLtkunZd92Kv6kdR6HZa7YmkkxNt2RYut1giRTiaG1mrlzV3M8/nIxs03LpkDYEnGcmOvGRWN/kWm+j6VF31cNZbRHr81RkX+mt4i6pDw4WOgxOM1GIlnw5CKsN4x/3XYuVY6PnnzNLRyx3g7ecX4m8Nkay9t+7WWlkm5nPc6CTyuZ4eB1f049ZLa16EnR2OVE0=

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
Changes since v10: https://lore.kernel.org/20250611010429.274682576@goodmis.org

- Use "bit" that was acquired by READ_ONCE() in test_and_set_bit() in
  unwind_deferred_request() instead of reading work->bit again.

 kernel/unwind/deferred.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 6c558d00ff41..7309c9e0e57a 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -45,10 +45,11 @@ static inline u64 assign_timestamp(struct unwind_task_info *info,
 #define UNWIND_MAX_ENTRIES					\
 	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
 
-/* Guards adding to and reading the list of callbacks */
+/* Guards adding to or removing from the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
 static unsigned long unwind_mask;
+DEFINE_STATIC_SRCU(unwind_srcu);
 
 /*
  * Read the task context timestamp, if this is the first caller then
@@ -134,6 +135,7 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct unwind_stacktrace trace;
 	struct unwind_work *work;
 	u64 timestamp;
+	int idx;
 
 	if (WARN_ON_ONCE(!local_read(&info->pending)))
 		return;
@@ -152,13 +154,15 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	timestamp = local64_read(&info->timestamp);
 
-	guard(mutex)(&callback_mutex);
-	list_for_each_entry(work, &callbacks, list) {
+	idx = srcu_read_lock(&unwind_srcu);
+	list_for_each_entry_srcu(work, &callbacks, list,
+				 srcu_read_lock_held(&unwind_srcu)) {
 		if (test_bit(work->bit, &info->unwind_mask)) {
 			work->func(work, &trace, timestamp);
 			clear_bit(work->bit, &info->unwind_mask);
 		}
 	}
+	srcu_read_unlock(&unwind_srcu, idx);
 }
 
 /**
@@ -193,6 +197,7 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 {
 	struct unwind_task_info *info = &current->unwind_info;
 	long pending;
+	int bit;
 	int ret;
 
 	*timestamp = 0;
@@ -205,12 +210,17 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 	if (!CAN_USE_IN_NMI && in_nmi())
 		return -EINVAL;
 
+	/* Do not allow cancelled works to request again */
+	bit = READ_ONCE(work->bit);
+	if (WARN_ON_ONCE(bit < 0))
+		return -EINVAL;
+
 	guard(irqsave)();
 
 	*timestamp = get_timestamp(info);
 
 	/* This is already queued */
-	if (test_bit(work->bit, &info->unwind_mask))
+	if (test_bit(bit, &info->unwind_mask))
 		return 1;
 
 	/* callback already pending? */
@@ -234,25 +244,32 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 	}
 
  out:
-	return test_and_set_bit(work->bit, &info->unwind_mask);
+	return test_and_set_bit(bit, &info->unwind_mask);
 }
 
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
+	__clear_bit(bit, &unwind_mask);
 
-	__clear_bit(work->bit, &unwind_mask);
+	synchronize_srcu(&unwind_srcu);
 
 	guard(rcu)();
 	/* Clear this bit from all threads */
 	for_each_process_thread(g, t) {
-		clear_bit(work->bit, &t->unwind_info.unwind_mask);
+		clear_bit(bit, &t->unwind_info.unwind_mask);
 	}
 }
 
@@ -269,7 +286,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	work->bit = ffz(unwind_mask);
 	__set_bit(work->bit, &unwind_mask);
 
-	list_add(&work->list, &callbacks);
+	list_add_rcu(&work->list, &callbacks);
 	work->func = func;
 	return 0;
 }
-- 
2.47.2



