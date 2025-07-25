Return-Path: <bpf+bounces-64406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EE0B12486
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 20:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0129217CDD6
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 18:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9C025D20F;
	Fri, 25 Jul 2025 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk+s5a+4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098625A646;
	Fri, 25 Jul 2025 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469855; cv=none; b=pAdGpecnYMXfwkmIKVVN4yZ/5hMKPhaCoaWwQlcatrJ9/9OcP8O6tv6YHVzuNny0vRNEAb2FtZQ+OSwPNt+u11xKZS2Xm4PMA8M2vGsdDCk62KqEj1q3K/T8FHtoIzHVavWf2p0fF0ng1FTak5ODYeiL6Cg+l+WiE3U6FQPRH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469855; c=relaxed/simple;
	bh=yP5vORM2KBmYRwfhcpa2pP/ppHXLVEurCzyq34xBP5s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pBqF2wNh3PXQlqk84VN6DRJf3ruMxVgGaZ9yLtMva1LRBsJ4Yei/JzVlkAMC12bDF6KXNZ5LjApXIh0WpBQeUQcmXb8uKn9kYfyr2s6UF1BK6CXj4TJDyRlKFS+1DuXQQ1+wmlc0oXtb+wESJn0EObY5XImKBMd3JuR5KdFj0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk+s5a+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F74C4AF09;
	Fri, 25 Jul 2025 18:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753469854;
	bh=yP5vORM2KBmYRwfhcpa2pP/ppHXLVEurCzyq34xBP5s=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Jk+s5a+4jFgLFWrrAL+8mke+c0XqWoB164dSK8VoAtb/6YfjQYJW14QJo6UTB23O0
	 dUyuAZt25zEkFoP+w01vkyhcC29hVd8cUwFTn0vAEvW9w7+7GI4iAePP8RlxXBCGE0
	 UKMxXJvDWtxSPqK+ukRz6g9qeHM38iD17PBkaOf0SPQI0wtB4EYny8NdRZDo+lo0nN
	 hJaWsZrLBD4Yk9wxv1PbNSNIGLggiQ4uk2PsuXZv4ORrg4VH5gaIGXCst9UNedUR4O
	 A6LpYf06aYcsrAG1fNsjAGywXrF3/p1aV8fzuSm2GrAbjh426xrAynWZJYdoV3XTxp
	 tYQ2p2LiGuuZg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufNbw-00000001N7R-33Kg;
	Fri, 25 Jul 2025 14:57:40 -0400
Message-ID: <20250725185740.581435592@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 14:55:21 -0400
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
 Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: [PATCH v15 09/10] unwind deferred: Use SRCU unwind_deferred_task_work()
References: <20250725185512.673587297@kernel.org>
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

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v14: https://lore.kernel.org/20250717004957.918908732@kernel.org

- Use normal SRCU instead of srcu_lite as srcu_lite is being deprecated.
  May later replace the normal SRCU with src_fast. (Paul McKenney)

 kernel/unwind/deferred.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 2311b725d691..a5ef1c1f915e 100644
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
+	guard(srcu)(&unwind_srcu);
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



