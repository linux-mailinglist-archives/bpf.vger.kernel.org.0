Return-Path: <bpf+bounces-58157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9532DAB5F86
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 00:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B0F46844D
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 22:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D418821FF50;
	Tue, 13 May 2025 22:35:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791FA21CC4D;
	Tue, 13 May 2025 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747175727; cv=none; b=WeVzaJM97sl9cCpSckErSoXzsmXWWoErI6BkTXTk99DxrS1lGqF9g5Ng8MBu2o2NJmaCfs7JNhY9kXarGpA7e5yqsGF2TxoGwjKoLYkpTcQTqVJJyOcKN61D7O7OBC7D1K+p7sRIlx3TIxOGgpK6N2ehg6QWDLFhvtcvBB9lNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747175727; c=relaxed/simple;
	bh=nFgF+ACnRcNWWOr1gv5eFabQhi240pk46GZke2cBQLU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=j7C5qLvVjDH3b4kP9zSObisLrjkbNGJXjgLwtvXi0e1icXcfRGLQ/QYRn1vW5HMJNom1CTfiOEMetg+ORt6uHEL2/bmksRSa65V9Vkup6cFK6njaTfwQVbc9rHakDWLA9uPn7WzEjfvVVZhTBvId/R2kLr8CUcLUawDCO7YFFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A202C4AF09;
	Tue, 13 May 2025 22:35:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uEyE4-00000004seZ-3zQK;
	Tue, 13 May 2025 18:35:52 -0400
Message-ID: <20250513223552.804390728@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 13 May 2025 18:34:46 -0400
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
Subject: [PATCH v9 11/13] unwind deferred: Use bitmask to determine which callbacks to call
References: <20250513223435.636200356@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In order to know which registered callback requested a stacktrace for when
the task goes back to user space, add a bitmask for all registered
tracers. The bitmask is the size of log, which means that on a 32 bit
machine, it can have at most 32 registered tracers, and on 64 bit, it can
have at most 64 registered tracers. This should not be an issue as there
should not be more than 10 (unless BPF can abuse this?).

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
 include/linux/sched.h           |  1 +
 include/linux/unwind_deferred.h |  1 +
 kernel/unwind/deferred.c        | 46 ++++++++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a1e1c07cadfb..d3ee0c5405d6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1649,6 +1649,7 @@ struct task_struct {
 
 #ifdef CONFIG_UNWIND_USER
 	struct unwind_task_info		unwind_info;
+	unsigned long			unwind_mask;
 #endif
 
 	/* CPU-specific state of this task: */
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index a384eef719a3..1789c3624723 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -13,6 +13,7 @@ typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stackt
 struct unwind_work {
 	struct list_head		list;
 	unwind_callback_t		func;
+	int				bit;
 };
 
 #ifdef CONFIG_UNWIND_USER
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 238cd97079ec..7ae0bec5b36a 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -16,6 +16,7 @@
 /* Guards adding to and reading the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
+static unsigned long unwind_mask;
 
 /*
  * Read the task context timestamp, if this is the first caller then
@@ -106,6 +107,7 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct unwind_stacktrace trace;
 	struct unwind_work *work;
 	u64 timestamp;
+	struct task_struct *task = current;
 
 	if (WARN_ON_ONCE(!info->pending))
 		return;
@@ -133,7 +135,10 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	guard(mutex)(&callback_mutex);
 	list_for_each_entry(work, &callbacks, list) {
-		work->func(work, &trace, timestamp);
+		if (task->unwind_mask & (1UL << work->bit)) {
+			work->func(work, &trace, timestamp);
+			clear_bit(work->bit, &current->unwind_mask);
+		}
 	}
 }
 
@@ -159,9 +164,12 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
 		inited_timestamp = true;
 	}
 
-	if (info->pending)
+	if (current->unwind_mask & (1UL << work->bit))
 		return 1;
 
+	if (info->pending)
+		goto out;
+
 	ret = task_work_add(current, &info->work, TWA_NMI_CURRENT);
 	if (ret) {
 		/*
@@ -175,8 +183,8 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
 	}
 
 	info->pending = 1;
-
-	return 0;
+out:
+	return test_and_set_bit(work->bit, &current->unwind_mask);
 }
 
 /**
@@ -223,14 +231,18 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 
 	*timestamp = get_timestamp(info);
 
+	/* This is already queued */
+	if (current->unwind_mask & (1UL << work->bit))
+		return 1;
+
 	/* callback already pending? */
 	pending = READ_ONCE(info->pending);
 	if (pending)
-		return 1;
+		goto out;
 
 	/* Claim the work unless an NMI just now swooped in to do so. */
 	if (!try_cmpxchg(&info->pending, &pending, 1))
-		return 1;
+		goto out;
 
 	/* The work has been claimed, now schedule it. */
 	ret = task_work_add(current, &info->work, TWA_RESUME);
@@ -239,16 +251,27 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 		return ret;
 	}
 
-	return 0;
+ out:
+	return test_and_set_bit(work->bit, &current->unwind_mask);
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
+	clear_bit(work->bit, &unwind_mask);
+
+	guard(rcu)();
+	/* Clear this bit from all threads */
+	for_each_process_thread(g, t) {
+		clear_bit(work->bit, &t->unwind_mask);
+	}
 }
 
 int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
@@ -256,6 +279,14 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	memset(work, 0, sizeof(*work));
 
 	guard(mutex)(&callback_mutex);
+
+	/* See if there's a bit in the mask available */
+	if (unwind_mask == ~0UL)
+		return -EBUSY;
+
+	work->bit = ffz(unwind_mask);
+	unwind_mask |= 1UL << work->bit;
+
 	list_add(&work->list, &callbacks);
 	work->func = func;
 	return 0;
@@ -267,6 +298,7 @@ void unwind_task_init(struct task_struct *task)
 
 	memset(info, 0, sizeof(*info));
 	init_task_work(&info->work, unwind_deferred_task_work);
+	task->unwind_mask = 0;
 }
 
 void unwind_task_free(struct task_struct *task)
-- 
2.47.2



