Return-Path: <bpf+bounces-62593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408D6AFBFDD
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 03:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629484257B9
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5FE21D3E2;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN+zutg0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE82066F7;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937839; cv=none; b=Ke7W5NozCX9k5xTuXqDpo3VgX+/WQQ26bYn8d2mrhbpHGI0Ebdh5uKnBiIh0sotwCDl8Q/Lc8jLP2mAwYE29vFOK8ua2/dBw77zHzT5j5jG8fl5TL9YcV0q4/WZhAsYF5Pn4mhngCT27Yinal0bLqoP/TqyrlT3QtGoJu8OQ1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937839; c=relaxed/simple;
	bh=1C7WGJCd3Lh5br7vs50VM2T6byvNqeNaV7iCdcxH4vs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=M8yK2gc6tAgAufVAlgnYOjfau0ZBfQsC0sGjLvWAbbwX0aVq9MN1o+Ygufe7vSxzjw+CtKKr8Z5zt7oH9SffyovM2ig5Q922Uc0mJzNLvMdMsDhswyXqdkhrjv3Q8mreU+diobCfUvLEx3PMu+L+m3IJTWbU5hxDS+a6Eue/Hkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN+zutg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0DEC4CEF4;
	Tue,  8 Jul 2025 01:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937839;
	bh=1C7WGJCd3Lh5br7vs50VM2T6byvNqeNaV7iCdcxH4vs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=EN+zutg03MMXCRdIKFYibE2GmhK48PIRjZXJWEjHbBUfreVUqIvtt1ySk8rPmzEPX
	 MBc/hbrIvt8LPNKtdI76CHIpR23GyYjW0k9goZ9qsVmlFlTltCMGAsQ9UXWveXyvTA
	 HNl1RcAuvldIrA30CRHiZ7WzVJ0nQPD8wtcWNW9nsYaasnBf5Yx5ocDQ2LAdElS9Jb
	 SVzCAngVcSa0xjS4H/ZwO9w7CQiv1GeS81GpEW8YcCrUmL7FZujHfDtAWosi3WHh5Z
	 8TvLM+Npl6WiwipoIhhTPZWWNlFUr2WbihpIgk+QiU9B9vjKdtfxlvIDmjzqTbbjcV
	 ftCCP8pXlchEQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYx3v-00000000Bsw-0dQn;
	Mon, 07 Jul 2025 21:23:59 -0400
Message-ID: <20250708012359.002924698@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 21:22:47 -0400
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
Subject: [PATCH v13 08/14] unwind deferred: Use bitmask to determine which callbacks to call
References: <20250708012239.268642741@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In order to know which registered callback requested a stacktrace for when
the task goes back to user space, add a bitmask to keep track of all
registered tracers. The bitmask is the size of long, which means that on a
32 bit machine, it can have at most 32 registered tracers, and on 64 bit,
it can have at most 64 registered tracers. This should not be an issue as
there should not be more than 10 (unless BPF can abuse this?).

When a tracer registers with unwind_deferred_init() it will get a bit
number assigned to it. When a tracer requests a stacktrace, it will have
its bit set within the task_struct. When the task returns back to user
space, it will call the callbacks for all the registered tracers where
their bits are set in the task's mask.

When a tracer is removed by the unwind_deferred_cancel() all current tasks
will clear the associated bit, just in case another tracer gets registered
immediately afterward and then gets their callback called unexpectedly.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/unwind_deferred.h       |  1 +
 include/linux/unwind_deferred_types.h |  1 +
 kernel/unwind/deferred.c              | 36 ++++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 14efd8c027aa..12bffdb0648e 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -13,6 +13,7 @@ typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stackt
 struct unwind_work {
 	struct list_head		list;
 	unwind_callback_t		func;
+	int				bit;
 };
 
 #ifdef CONFIG_UNWIND_USER
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index cd95ed1c8610..7a03a8672b0d 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -21,6 +21,7 @@ union unwind_task_id {
 struct unwind_task_info {
 	struct unwind_cache	*cache;
 	struct callback_head	work;
+	unsigned long		unwind_mask;
 	union unwind_task_id	id;
 	local_t			pending;
 };
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 2417e4ebbc82..5edb648b7de7 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -44,6 +44,7 @@ static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
 /* Guards adding to and reading the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
+static unsigned long unwind_mask;
 
 /*
  * This is a unique percpu identifier for a given task entry context.
@@ -162,7 +163,10 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	guard(mutex)(&callback_mutex);
 	list_for_each_entry(work, &callbacks, list) {
-		work->func(work, &trace, cookie);
+		if (test_bit(work->bit, &info->unwind_mask)) {
+			work->func(work, &trace, cookie);
+			clear_bit(work->bit, &info->unwind_mask);
+		}
 	}
 }
 
@@ -211,15 +215,19 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 
 	*cookie = get_cookie(info);
 
+	/* This is already queued */
+	if (test_bit(work->bit, &info->unwind_mask))
+		return 1;
+
 	/* callback already pending? */
 	pending = local_read(&info->pending);
 	if (pending)
-		return 1;
+		goto out;
 
 	if (CAN_USE_IN_NMI) {
 		/* Claim the work unless an NMI just now swooped in to do so. */
 		if (!local_try_cmpxchg(&info->pending, &pending, 1))
-			return 1;
+			goto out;
 	} else {
 		local_set(&info->pending, 1);
 	}
@@ -231,16 +239,27 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 		return ret;
 	}
 
-	return 0;
+ out:
+	return test_and_set_bit(work->bit, &info->unwind_mask);
 }
 
 void unwind_deferred_cancel(struct unwind_work *work)
 {
+	struct task_struct *g, *t;
+
 	if (!work)
 		return;
 
 	guard(mutex)(&callback_mutex);
 	list_del(&work->list);
+
+	__clear_bit(work->bit, &unwind_mask);
+
+	guard(rcu)();
+	/* Clear this bit from all threads */
+	for_each_process_thread(g, t) {
+		clear_bit(work->bit, &t->unwind_info.unwind_mask);
+	}
 }
 
 int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
@@ -248,6 +267,14 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	memset(work, 0, sizeof(*work));
 
 	guard(mutex)(&callback_mutex);
+
+	/* See if there's a bit in the mask available */
+	if (unwind_mask == ~0UL)
+		return -EBUSY;
+
+	work->bit = ffz(unwind_mask);
+	__set_bit(work->bit, &unwind_mask);
+
 	list_add(&work->list, &callbacks);
 	work->func = func;
 	return 0;
@@ -259,6 +286,7 @@ void unwind_task_init(struct task_struct *task)
 
 	memset(info, 0, sizeof(*info));
 	init_task_work(&info->work, unwind_deferred_task_work);
+	info->unwind_mask = 0;
 }
 
 void unwind_task_free(struct task_struct *task)
-- 
2.47.2



