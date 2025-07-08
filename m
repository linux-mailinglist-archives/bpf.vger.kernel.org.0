Return-Path: <bpf+bounces-62594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D7FAFBFE3
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 03:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FA61885875
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9AD21FF40;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8SuujCB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785220F091;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937839; cv=none; b=JrYzMkNlehyUWMuCVVInPgG64ZL0FfG0Ve5OEYA/WShKENzuR+ZZFgeesOlpiacBdknn9lXkKIxb/5dS0y8fL+oQpZvxs6XxnnGw5j6i/Ix6cIITxnF2sm/l6uFjWdEuqKiySfLxCtCsBhFTiC5D45P1Dt5JP2+0Q1od7K8HhNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937839; c=relaxed/simple;
	bh=Um70FQ+3UzUH2oUUSV3TA33BR6NtC+VENc9gr4wr3zk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dHNzLAG17EotwoSurO8oo8phHn0q/uA5x3HeDTNP6y+wAz96k3iQFEZcDhi04qyYNdVjKbOq26zs07Giqg4Ts9dEE1nKtvfBVsiVd3fbkGq7VNE6vdRgOZWE2bFnc9rNSts1AKhyxp0KoOysS6JmADCw/4QYK3z22o5O85jZvlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8SuujCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26033C4CEE3;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937839;
	bh=Um70FQ+3UzUH2oUUSV3TA33BR6NtC+VENc9gr4wr3zk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=A8SuujCBIQX79rW+cVjEiQLhiRl1La6FPT8ph/oNdB9tt+W7c54pmpuPKRigG1EWw
	 aPYWvex9K/xg7K24qOhF5wILQOHkSE7CE+L8Oz6EBZWD8GYbdpQWHqValsgVoq/E90
	 gu8VSmbIm0AtW/SC4d6gxFdJNFTAHjTcemvKMzuHmGMxcBGGdaxkaVL4J1Wf/1kT3E
	 Geqz0MGMdiLXZccMhgeWFduq6u57LuqYCVTY14XMsJBXmDkJ/WAVCdNL7D1eT2XNrR
	 0n2rl7bXayJJnb1CMJrCp7mYssFK4a7OxC4x8xEQMB56LtuOUaFcn66hncAGVTP9Ir
	 EbiW6Rh3oqMyQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYx3v-00000000BtR-1MET;
	Mon, 07 Jul 2025 21:23:59 -0400
Message-ID: <20250708012359.172959778@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 21:22:48 -0400
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
Subject: [PATCH v13 09/14] unwind deferred: Use SRCU unwind_deferred_task_work()
References: <20250708012239.268642741@kernel.org>
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

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/unwind/deferred.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 5edb648b7de7..9aed9866f460 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -41,10 +41,11 @@ static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
 #define UNWIND_MAX_ENTRIES					\
 	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
 
-/* Guards adding to and reading the list of callbacks */
+/* Guards adding to or removing from the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
 static unsigned long unwind_mask;
+DEFINE_STATIC_SRCU(unwind_srcu);
 
 /*
  * This is a unique percpu identifier for a given task entry context.
@@ -143,6 +144,7 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct unwind_stacktrace trace;
 	struct unwind_work *work;
 	u64 cookie;
+	int idx;
 
 	if (WARN_ON_ONCE(!local_read(&info->pending)))
 		return;
@@ -161,13 +163,15 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	cookie = info->id.id;
 
-	guard(mutex)(&callback_mutex);
-	list_for_each_entry(work, &callbacks, list) {
+	idx = srcu_read_lock(&unwind_srcu);
+	list_for_each_entry_srcu(work, &callbacks, list,
+				 srcu_read_lock_held(&unwind_srcu)) {
 		if (test_bit(work->bit, &info->unwind_mask)) {
 			work->func(work, &trace, cookie);
 			clear_bit(work->bit, &info->unwind_mask);
 		}
 	}
+	srcu_read_unlock(&unwind_srcu, idx);
 }
 
 /**
@@ -199,6 +203,7 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
 	long pending;
+	int bit;
 	int ret;
 
 	*cookie = 0;
@@ -211,12 +216,17 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 	if (!CAN_USE_IN_NMI && in_nmi())
 		return -EINVAL;
 
+	/* Do not allow cancelled works to request again */
+	bit = READ_ONCE(work->bit);
+	if (WARN_ON_ONCE(bit < 0))
+		return -EINVAL;
+
 	guard(irqsave)();
 
 	*cookie = get_cookie(info);
 
 	/* This is already queued */
-	if (test_bit(work->bit, &info->unwind_mask))
+	if (test_bit(bit, &info->unwind_mask))
 		return 1;
 
 	/* callback already pending? */
@@ -240,25 +250,32 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
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
 
@@ -275,7 +292,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	work->bit = ffz(unwind_mask);
 	__set_bit(work->bit, &unwind_mask);
 
-	list_add(&work->list, &callbacks);
+	list_add_rcu(&work->list, &callbacks);
 	work->func = func;
 	return 0;
 }
-- 
2.47.2



