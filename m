Return-Path: <bpf+bounces-61605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1830BAE9173
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12D41C27FD2
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9BC2FA652;
	Wed, 25 Jun 2025 22:57:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F82F49FE;
	Wed, 25 Jun 2025 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892226; cv=none; b=U5Ohnq2xS2jjV5eHLfo7QX2bxOJHXJlRnaXpCbCqGqNR1ltJ66I1qrq3iTQS1aJeK9HF0KA5tD5xoS8kxz2yt04Rii9aY3SVvTNCNmE/8YpAanmd73eMs2hFFax00Ww2g61g5psPXvqvr9tWAtSLMJEtfKbY0NkEnfp++3DeB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892226; c=relaxed/simple;
	bh=uYzLlKGWblacbxMMABukG9sy0D8H42q4VV0h96KLAWE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Fg7cL9KsPpl3BcSAEHie3rnb14Pj4eZWo5cICt2Tdxoiq0QaO1lf+Qu3r7ZhILq1WzvWecpMAAdvpBg9AgKcJbb3uC1Bo6MOOwWilngtXdlrkgRG9ovQeANABDvf0ibqv4iUD3T561aCklWEKkS8BfpDB7JqVSe6jYmVCoTTpPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 5756EBB736;
	Wed, 25 Jun 2025 22:56:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 1E18D20013;
	Wed, 25 Jun 2025 22:56:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZ3M-000000043gl-1LGJ;
	Wed, 25 Jun 2025 18:57:16 -0400
Message-ID: <20250625225716.174989731@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 18:56:08 -0400
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
Subject: [PATCH v11 08/14] unwind deferred: Use bitmask to determine which callbacks to call
References: <20250625225600.555017347@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 1E18D20013
X-Stat-Signature: dtjk1wqzfcna54gm4wjjjc6opydye1sf
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18YZVTtsSLeaPghF0DMX7eHxvTkJDn2iJ4=
X-HE-Tag: 1750892211-63473
X-HE-Meta: U2FsdGVkX1+yhB9oRcmdC6jvv6ORwcmipkFCREO0YdAQmFELm0K8tSxiAy9qHc+VR47cWzdZLFsDzDA4RyjgVghzbwi8Z3Kw+09mqDkAI3lzi93RoSECX/rDKGAVNG2M6LmWr1rgGb5eyHC2Ei0jMunw8J6opbUDnJyEc0onLInvHfJVW64sR6JZ6ypYp3oD7TP3s/2rrrhbLuoaVbjbYn7xN2EnUEbL9k6B+ZMQ7DblzclMFXm812IgPiTFchJOEFlF735TbtnIIlunmzituAeBdX1+C0rCv1I5QBjOdz+denfHzQ1ZzWr+3deOfUh4Oo0n45geMw1mDQUIfg5nfcvXR+ogDZdVKq5MrWufZP9MUiJ8jWFPAnlbPqRKS1X9qXn/GwBFI97sYwjJoNUHILxRRzdTqRDK7cLv5WbXrps=

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
Changes since v10: https://lore.kernel.org/20250611010429.105907436@goodmis.org

- Use __clear_bit() and __set_bit() consistently with the global variable
  unwind_mask.  (Peter Zijlstra)

- Use clear_bit() and set_bit() consistently with the task unwind_mask,
  as it can race with NMIs.

 include/linux/unwind_deferred.h       |  1 +
 include/linux/unwind_deferred_types.h |  1 +
 kernel/unwind/deferred.c              | 36 ++++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 718637777649..00656e903375 100644
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
index 0d722e877473..5863bf4eb436 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -13,6 +13,7 @@ struct unwind_cache {
 struct unwind_task_info {
 	struct unwind_cache	*cache;
 	struct callback_head	work;
+	unsigned long		unwind_mask;
 	local64_t		timestamp;
 	local_t			pending;
 };
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index dd36e58c8cad..6c558d00ff41 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -48,6 +48,7 @@ static inline u64 assign_timestamp(struct unwind_task_info *info,
 /* Guards adding to and reading the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
+static unsigned long unwind_mask;
 
 /*
  * Read the task context timestamp, if this is the first caller then
@@ -153,7 +154,10 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	guard(mutex)(&callback_mutex);
 	list_for_each_entry(work, &callbacks, list) {
-		work->func(work, &trace, timestamp);
+		if (test_bit(work->bit, &info->unwind_mask)) {
+			work->func(work, &trace, timestamp);
+			clear_bit(work->bit, &info->unwind_mask);
+		}
 	}
 }
 
@@ -205,15 +209,19 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 
 	*timestamp = get_timestamp(info);
 
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
@@ -225,16 +233,27 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
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
@@ -242,6 +261,14 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
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
@@ -253,6 +280,7 @@ void unwind_task_init(struct task_struct *task)
 
 	memset(info, 0, sizeof(*info));
 	init_task_work(&info->work, unwind_deferred_task_work);
+	info->unwind_mask = 0;
 }
 
 void unwind_task_free(struct task_struct *task)
-- 
2.47.2



