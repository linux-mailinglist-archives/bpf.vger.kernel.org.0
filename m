Return-Path: <bpf+bounces-63512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B838EB081DF
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D0AD7B7BFC
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 00:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42541E25FA;
	Thu, 17 Jul 2025 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLrQKjMG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010AB1C5F14;
	Thu, 17 Jul 2025 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752713378; cv=none; b=f4v1g2XmpQnix+KlTMyXVIan9BE5S1bG6Nu/knYuyrhSBQ1C2KJPyXKgkgn6+fAkY9vWNSJkqfIiztna7PcgAXDS4aTHwopEtPjtlpbQe1dVO2Ch46mw0H7gGiQuMWeA4cd2WGqM9prMQhfmoog8deII1ihon12b3i/HZF3+ZUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752713378; c=relaxed/simple;
	bh=dJy0RlrgubpV6rD6clb6uFiYqp1YYYGQ+bP34ejBXng=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kchq06OAdVIRG5GteI7yqLZHJ/xJS9YsuNg/890bMcpJ4bAhxg+OjRCc6PNon6F+bbLHGh/hxlqKD/ofV/hW505HXLompnMJnnRh2hlLyZKyp9y76qg1nl+TUD4mnCKuBsxLL5OmcG/CUXvaSLAvRMjpaQ7BszuB93niZYlG9D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLrQKjMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B2BC113CF;
	Thu, 17 Jul 2025 00:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752713377;
	bh=dJy0RlrgubpV6rD6clb6uFiYqp1YYYGQ+bP34ejBXng=;
	h=Date:From:To:Cc:Subject:References:From;
	b=sLrQKjMGaLpcdpbbMt+bKmSwFo/wqRJoIbliYw7Iavmmpl5QphqVUaStSnTt7XCiM
	 ZB0JFklmETqmG0fmhcoLiXCXQG6DN9CHwtRKP9YXev+nwvQVOIiRo953PvWFHsdaLB
	 3FlPQyUsROoBdDzdVMW5Drr6vHk8IxGLUl9fVBBr2nomQ0LfDcycK9ZyBzFYQDyOuJ
	 v78DTrBc3+URWsTas1ERHu0g2MJgPWMAcpxLwiA/+ICguB9rf5IIpMXnkOh8QFbkrD
	 T15JIq+2I4uTzFSJj8PySnFMVVxea8qSdUaz5magfCctyffOs1dPYEy8+7OvJIdwDN
	 1r4NMyl7wlfWw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucCow-000000067Vw-0HuY;
	Wed, 16 Jul 2025 20:49:58 -0400
Message-ID: <20250717004957.918908732@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 16 Jul 2025 20:49:19 -0400
From: Steven Rostedt <rostedt@kernel.org>
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
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v14 09/12] unwind deferred: Use SRCU unwind_deferred_task_work()
References: <20250717004910.297898999@kernel.org>
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

As the callbacks themselves are allowed to sleep, regular RCU cannot be
used to protect the list. Instead use SRCU, as that still allows the
callbacks to sleep and the list can be read without needing to hold the
callback_mutex.

Link: https://lore.kernel.org/all/ca9bd83a-6c80-4ee0-a83c-224b9d60b755@efficios.com/

Also added a new guard (srcu_lite) written by Peter Zilstra

Link: https://lore.kernel.org/all/20250715102912.GQ1613200@noisy.programming.kicks-ass.net/

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v13: https://lore.kernel.org/20250708012359.172959778@kernel.org

- Have the locking of the link list walk use guard(srcu_lite)
  (Peter Zijlstra)

- Fixed up due to the new atomic_long logic.

 include/linux/srcu.h     |  4 ++++
 kernel/unwind/deferred.c | 27 +++++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 900b0d5c05f5..879054b8bf87 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -524,4 +524,8 @@ DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
 		    srcu_read_unlock(_T->lock, _T->idx),
 		    int idx)
 
+DEFINE_LOCK_GUARD_1(srcu_lite, struct srcu_struct,
+		    _T->idx = srcu_read_lock_lite(_T->lock),
+		    srcu_read_unlock_lite(_T->lock, _T->idx),
+		    int idx)
 #endif
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 2311b725d691..353f7af610bf 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -41,7 +41,7 @@ static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
 #define UNWIND_MAX_ENTRIES					\
 	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
 
-/* Guards adding to and reading the list of callbacks */
+/* Guards adding to or removing from the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
 
@@ -49,6 +49,7 @@ static LIST_HEAD(callbacks);
 
 /* Zero'd bits are available for assigning callback users */
 static unsigned long unwind_mask = RESERVED_BITS;
+DEFINE_STATIC_SRCU(unwind_srcu);
 
 static inline bool unwind_pending(struct unwind_task_info *info)
 {
@@ -174,8 +175,9 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	cookie = info->id.id;
 
-	guard(mutex)(&callback_mutex);
-	list_for_each_entry(work, &callbacks, list) {
+	guard(srcu_lite)(&unwind_srcu);
+	list_for_each_entry_srcu(work, &callbacks, list,
+				 srcu_read_lock_held(&unwind_srcu)) {
 		if (test_bit(work->bit, &bits)) {
 			work->func(work, &trace, cookie);
 			if (info->cache)
@@ -213,7 +215,7 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
 	unsigned long old, bits;
-	unsigned long bit = BIT(work->bit);
+	unsigned long bit;
 	int ret;
 
 	*cookie = 0;
@@ -230,6 +232,14 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 	if (WARN_ON_ONCE(!CAN_USE_IN_NMI && in_nmi()))
 		return -EINVAL;
 
+	/* Do not allow cancelled works to request again */
+	bit = READ_ONCE(work->bit);
+	if (WARN_ON_ONCE(bit < 0))
+		return -EINVAL;
+
+	/* Only need the mask now */
+	bit = BIT(bit);
+
 	guard(irqsave)();
 
 	*cookie = get_cookie(info);
@@ -281,10 +291,15 @@ void unwind_deferred_cancel(struct unwind_work *work)
 		return;
 
 	guard(mutex)(&callback_mutex);
-	list_del(&work->list);
+	list_del_rcu(&work->list);
+
+	/* Do not allow any more requests and prevent callbacks */
+	work->bit = -1;
 
 	__clear_bit(bit, &unwind_mask);
 
+	synchronize_srcu(&unwind_srcu);
+
 	guard(rcu)();
 	/* Clear this bit from all threads */
 	for_each_process_thread(g, t) {
@@ -307,7 +322,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	work->bit = ffz(unwind_mask);
 	__set_bit(work->bit, &unwind_mask);
 
-	list_add(&work->list, &callbacks);
+	list_add_rcu(&work->list, &callbacks);
 	work->func = func;
 	return 0;
 }
-- 
2.47.2



