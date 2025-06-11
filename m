Return-Path: <bpf+bounces-60269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A44C9AD47A7
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDA917D050
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11A2156F45;
	Wed, 11 Jun 2025 01:03:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8C818E20;
	Wed, 11 Jun 2025 01:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603786; cv=none; b=VPRehdx+6T/P9E2uexLYN4VTY13TJSnJi0+l572IRAe8z/sadHe5UP0R6cf8QqzFpf+GN4+/84VZcZC9kloOjp7EVNPIyoHTrphy1c5SFAoEJ4gaYeaNAh0H0X3GEb1+FF8AOblHuRJtQD3H9mYR+Ew8PyrAemR1OgRQNNM+t/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603786; c=relaxed/simple;
	bh=QnsSRmn2WHi5LOTKrQil6Z5vwZZvZho/DvjmUY+PnwE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NmlBWYiAaRj0S2unXYWPHExrxL0yyBk6cvjR/K6q9nq/abaZiv85ousD+Oxv+gHGm2eRQUuXzf7jaEAWWimg6zvTPZLpYZK54Rgfpw2v4TncS+CfbnjX2VqW2XDdzHnj/u/4sQgdh2ZESfRTOaf3Fho7ad+04VhLmXQUmbkiN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id F0E5E1A149C;
	Wed, 11 Jun 2025 01:02:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 10EFD1D;
	Wed, 11 Jun 2025 01:02:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uP9tF-00000000vBB-14C8;
	Tue, 10 Jun 2025 21:04:29 -0400
Message-ID: <20250611010429.105907436@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 20:54:29 -0400
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
Subject: [PATCH v10 08/14] unwind deferred: Use bitmask to determine which callbacks to call
References: <20250611005421.144238328@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: h7wmri5rexriqxq47a86b1istumgoxy1
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 10EFD1D
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18aBbMMIjCWoJgDKw4i0r3WCFIfSzFKqQc=
X-HE-Tag: 1749603777-742241
X-HE-Meta: U2FsdGVkX18GrfsI081FEYgMXf9It6xZ2Yf5/7PZM+e7MfteXmZA9KHXcfIEKVFS6cPVd2Ws8hZ8O+gZEgfqnr9CeHKaJj3GodUB5h4z49+AtufPmkNI7WbXClDNEf2JBvM4uPB+fWY5Xs4oMq3o/Y89lXZuRtV3aUkT7W9oWZYMqwk8IxhROxDXtCW9kmPFmhjQLGuoIHsoJYiPvMkRTRJNMlWiBYChLjZl+9tGJ7lPu5NGNWhw3ExJxJ9+0BiX3LWli8T8Aq4iZzpzMmXgkVvUrtH9jAHb1Rg4R0MQeBsrjbnIuc/uk6spiNU53NoTcLQLN1e4M0MBW4SuinzHVALkZINvH/ECrGoVkye5VIpBkA3vP18onPxJ8dcvVz1yvtly7L33s+MaZnXJb/qAXk4/mMhrfpsbu2vA61t9HBM=

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
Changes since v9: https://lore.kernel.org/linux-trace-kernel/20250513223552.804390728@goodmis.org/

- Use BIT() macro for bit setting and testing.

- Moved the "unwind_mask" from the task_struct into the task->unwind_info
  structure.

 include/linux/unwind_deferred.h       |  1 +
 include/linux/unwind_deferred_types.h |  1 +
 kernel/unwind/deferred.c              | 45 ++++++++++++++++++++++-----
 3 files changed, 40 insertions(+), 7 deletions(-)

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
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index ae27a02234b8..780b00c07208 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -10,6 +10,7 @@ struct unwind_cache {
 struct unwind_task_info {
 	struct unwind_cache	*cache;
 	struct callback_head	work;
+	unsigned long		unwind_mask;
 	u64			timestamp;
 	u64			nmi_timestamp;
 	int			pending;
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 88c867c32c01..268afae31ba4 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -16,6 +16,7 @@
 /* Guards adding to and reading the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
+static unsigned long unwind_mask;
 
 /*
  * Read the task context timestamp, if this is the first caller then
@@ -133,7 +134,10 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	guard(mutex)(&callback_mutex);
 	list_for_each_entry(work, &callbacks, list) {
-		work->func(work, &trace, timestamp);
+		if (info->unwind_mask & BIT(work->bit)) {
+			work->func(work, &trace, timestamp);
+			clear_bit(work->bit, &info->unwind_mask);
+		}
 	}
 }
 
@@ -159,9 +163,12 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
 		inited_timestamp = true;
 	}
 
-	if (info->pending)
+	if (info->unwind_mask & BIT(work->bit))
 		return 1;
 
+	if (info->pending)
+		goto out;
+
 	ret = task_work_add(current, &info->work, TWA_NMI_CURRENT);
 	if (ret < 0) {
 		/*
@@ -175,8 +182,8 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
 	}
 
 	info->pending = 1;
-
-	return 0;
+out:
+	return test_and_set_bit(work->bit, &info->unwind_mask);
 }
 
 /**
@@ -223,14 +230,18 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 
 	*timestamp = get_timestamp(info);
 
+	/* This is already queued */
+	if (info->unwind_mask & BIT(work->bit))
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
@@ -239,16 +250,27 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
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
+	clear_bit(work->bit, &unwind_mask);
+
+	guard(rcu)();
+	/* Clear this bit from all threads */
+	for_each_process_thread(g, t) {
+		clear_bit(work->bit, &t->unwind_info.unwind_mask);
+	}
 }
 
 int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
@@ -256,6 +278,14 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	memset(work, 0, sizeof(*work));
 
 	guard(mutex)(&callback_mutex);
+
+	/* See if there's a bit in the mask available */
+	if (unwind_mask == ~0UL)
+		return -EBUSY;
+
+	work->bit = ffz(unwind_mask);
+	unwind_mask |= BIT(work->bit);
+
 	list_add(&work->list, &callbacks);
 	work->func = func;
 	return 0;
@@ -267,6 +297,7 @@ void unwind_task_init(struct task_struct *task)
 
 	memset(info, 0, sizeof(*info));
 	init_task_work(&info->work, unwind_deferred_task_work);
+	info->unwind_mask = 0;
 }
 
 void unwind_task_free(struct task_struct *task)
-- 
2.47.2



