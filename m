Return-Path: <bpf+bounces-63510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DACDB081D8
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299A04E6F89
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 00:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7670D1DE3C3;
	Thu, 17 Jul 2025 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUsxwkWC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBF21B0F1E;
	Thu, 17 Jul 2025 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752713377; cv=none; b=EUE3gT3vFjzEoDKknyZXfW4QxwKa6UfPNFvtvA9GqcDbf7Fj7FkZ/6t43eMHVLpy2yk20Rbsmy8fAiVtHHQMcKRQqXMDFD4WIewkbZw8qqUhu4+aduQ50XNqNoIctLQd/xsDldmuKff0AjPdonld0NkM02tZRH11kxo7tyakMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752713377; c=relaxed/simple;
	bh=Wq6u8PYGkAyQl/xVgbmkj6KCcF4ZvUyT5Z2nnZPFToQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=upn+xzrz3aKrgNhehgtLWDdPq8zlXaGQ00IajvtJLdNNnil/xmleI0ekV5LKdZRCz6FMN7l5im0KMxxsZc6fNJOfcp7NWmlK4DOzEN0rCBc/qWTbvPXCvyjnlFvN/VmF5RXi0iniV8iM6y9hXB0aEhB3VkKvdVhng+J7iTziu9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUsxwkWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B054C4CEE7;
	Thu, 17 Jul 2025 00:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752713377;
	bh=Wq6u8PYGkAyQl/xVgbmkj6KCcF4ZvUyT5Z2nnZPFToQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=lUsxwkWCcEyrjWOszLLXvOUm4HSGY21eHRxTc4MwDI71GyA4Uup7RZHIlJEHiRnKA
	 bTPaHugWSLoaMvE79Tt8h5nvlBowIVt/0VA6iuYe2pFxS56Mn507tG3+AW/u+ruryz
	 YuSqC7oNt9ChAALmrWbMNi/vz+w3sFdY/qOOO1997GSSy2v0uWSNTKDbwugqVEjOMH
	 WRgFsd6azTYsI/Pos8xBd2UyZdgqbcyvP6MO3UdwH7fIym9zPeO1JR5K9kKC6XPr1m
	 3zBQ4BIJpW1hTfUiE79OOEjzgJxyRgDPCdQTEr3RyRvygI9Hc8HN2McVu+7oCCPaaz
	 y0624NTBi98FQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucCov-000000067Uv-333V;
	Wed, 16 Jul 2025 20:49:57 -0400
Message-ID: <20250717004957.580552530@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 16 Jul 2025 20:49:17 -0400
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
 Sam James <sam@gentoo.org>
Subject: [PATCH v14 07/12] unwind deferred: Add unwind_completed mask to stop spurious callbacks
References: <20250717004910.297898999@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

If there's more than one registered tracer to the unwind deferred
infrastructure, it is currently possible that one tracer could cause extra
callbacks to happen for another tracer if the former requests a deferred
stacktrace after the latter's callback was executed and before the task
went back to user space.

Here's an example of how this could occur:

  [Task enters kernel]
    tracer 1 request -> add cookie to its buffer
    tracer 1 request -> add cookie to its buffer
    <..>
    [ task work executes ]
    tracer 1 callback -> add trace + cookie to its buffer

    [tracer 2 requests and triggers the task work again]
    [ task work executes again ]
    tracer 1 callback -> add trace + cookie to its buffer
    tracer 2 callback -> add trace + cookie to its buffer
 [Task exits back to user space]

This is because the bit for tracer 1 gets set in the task's unwind_mask
when it did its request and does not get cleared until the task returns
back to user space. But if another tracer were to request another deferred
stacktrace, then the next task work will executed all tracer's callbacks
that have their bits set in the task's unwind_mask.

To fix this issue, add another mask called unwind_completed and place it
into the task's info->cache structure. The cache structure is allocated
on the first occurrence of a deferred stacktrace and this unwind_completed
mask is not needed until then. It's better to have it in the cache than to
permanently waste space in the task_struct.

After a tracer's callback is executed, it's bit gets set in this
unwind_completed mask. When the task_work enters, it will AND the task's
unwind_mask with the inverse of the unwind_completed which will eliminate
any work that already had its callback executed since the task entered the
kernel.

When the task leaves the kernel, it will reset this unwind_completed mask
just like it resets the other values as it enters user space.

Link: https://lore.kernel.org/all/20250716142609.47f0e4a5@batman.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/unwind_deferred.h       |  4 +++-
 include/linux/unwind_deferred_types.h |  1 +
 kernel/unwind/deferred.c              | 19 +++++++++++++++----
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 337ead927d4d..b9ec4c8515c7 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -55,8 +55,10 @@ static __always_inline void unwind_reset_info(void)
 	 * depends on nr_entries being cleared on exit to user,
 	 * this needs to be a separate conditional.
 	 */
-	if (unlikely(info->cache))
+	if (unlikely(info->cache)) {
 		info->cache->nr_entries = 0;
+		info->cache->unwind_completed = 0;
+	}
 }
 
 #else /* !CONFIG_UNWIND_USER */
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 5dc9cda141ff..33b62ac25c86 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -3,6 +3,7 @@
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
 struct unwind_cache {
+	unsigned long		unwind_completed;
 	unsigned int		nr_entries;
 	unsigned long		entries[];
 };
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index e19f02ef416d..a3d26014a2e6 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -166,12 +166,18 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	unwind_user_faultable(&trace);
 
+	if (info->cache)
+		bits &= ~(info->cache->unwind_completed);
+
 	cookie = info->id.id;
 
 	guard(mutex)(&callback_mutex);
 	list_for_each_entry(work, &callbacks, list) {
-		if (test_bit(work->bit, &bits))
+		if (test_bit(work->bit, &bits)) {
 			work->func(work, &trace, cookie);
+			if (info->cache)
+				info->cache->unwind_completed |= BIT(work->bit);
+		}
 	}
 }
 
@@ -260,23 +266,28 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 void unwind_deferred_cancel(struct unwind_work *work)
 {
 	struct task_struct *g, *t;
+	int bit;
 
 	if (!work)
 		return;
 
+	bit = work->bit;
+
 	/* No work should be using a reserved bit */
-	if (WARN_ON_ONCE(BIT(work->bit) & RESERVED_BITS))
+	if (WARN_ON_ONCE(BIT(bit) & RESERVED_BITS))
 		return;
 
 	guard(mutex)(&callback_mutex);
 	list_del(&work->list);
 
-	__clear_bit(work->bit, &unwind_mask);
+	__clear_bit(bit, &unwind_mask);
 
 	guard(rcu)();
 	/* Clear this bit from all threads */
 	for_each_process_thread(g, t) {
-		clear_bit(work->bit, &t->unwind_info.unwind_mask);
+		clear_bit(bit, &t->unwind_info.unwind_mask);
+		if (t->unwind_info.cache)
+			clear_bit(bit, &t->unwind_info.cache->unwind_completed);
 	}
 }
 
-- 
2.47.2



