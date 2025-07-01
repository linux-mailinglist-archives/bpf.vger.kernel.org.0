Return-Path: <bpf+bounces-61920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40689AEEB79
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0591BC418A
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36944200112;
	Tue,  1 Jul 2025 00:54:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B18A1DE4FC;
	Tue,  1 Jul 2025 00:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331268; cv=none; b=IkeCXDEux2IVpwPxHYbgQooUOMKoRnzc0r8ucHM0yV7ShHFfv8kQyWax6sHvu4bKhZgE4ekR7YM6WmGJswTX7pjqO8bQ9i3Q07oKIMp7s4NWP12Fyd7H6GKUeYIhT1IJZ+MWSV3VYcbMvuuHuCf9ffLZrRUogLr9xC61Sss79gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331268; c=relaxed/simple;
	bh=zFlV6PkJW7QtFFFgn9LhTnGdVPMu4vYQ8ztUb+m2Ubc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VlWVKn/ua6uVlPx8ywsDmrl1Hfc/rEtFR6EZkSfGZkF/QloDuzHyU61nGgU3y86leQOohfvRCnr/8iqJ3VqOCfC9RcYR/O4wWLGTXttG5YMgMb5kAbLHs4JtOlTYOjsPvreN86u/UM7EOwCPDK8FItDHs/CyZoQlM6WfVRG//jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id AD09D122C9C;
	Tue,  1 Jul 2025 00:54:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 4E2543D;
	Tue,  1 Jul 2025 00:54:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWPGu-00000007Nig-0w2H;
	Mon, 30 Jun 2025 20:54:52 -0400
Message-ID: <20250701005452.075382262@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 30 Jun 2025 20:53:30 -0400
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
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v12 09/14] unwind deferred: Use SRCU unwind_deferred_task_work()
References: <20250701005321.942306427@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: wwho8yoafpus59qp7dg4f3wg1h4iknsm
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4E2543D
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Aa1oLHTzRf4GBtDkSVWEHGm/YjUmMFMs=
X-HE-Tag: 1751331255-91572
X-HE-Meta: U2FsdGVkX19sgRL/WSoCwR8lln+Bf5cmaeBSAN8Xk7y5jPTP4z22qLzMivV+soSoTw1cvSKifMWGn1DbTq3TA+TGi5WiYWegirzQj1h29L+jwqT6TRB2P67LDQp7B6E/UUgofXPs/cIIoQSo4XpzEl7pB+cq+6AfldpPpiRvViv3/+ASwN5IDV/AmrGBfzS4Fbhyx4ZJRYkJIQvv6lzJYUuca4Qp3SXftxNF77LO+CwTbc1exaN9grZuZuMWlIw2abqmQy7aCUB1Caar1NoiEQuxQOtOcOK9ikStjd/4/LVjlkp5RrvnDA8RVDSmLNUKO7c9HJ8GEXreTOTb9sHDu6r9er7Fri8Ll59WOdLXuyzlD1hpNZe/p9xtfEgnlQbXvRhRpRzhDh4d0A669JwNp8JYzki8n5V43HezS527OToHh87eM14Oo3fdriL2gnW80N5nQRbTh0+iRxIKUzNhAGsz6qFJDPKMcsglsMM9vFc=

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



