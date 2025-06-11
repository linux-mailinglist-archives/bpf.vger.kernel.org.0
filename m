Return-Path: <bpf+bounces-60272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C93AD47AD
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DB33A97A6
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF1A1A08B1;
	Wed, 11 Jun 2025 01:03:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7D18DF89;
	Wed, 11 Jun 2025 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603790; cv=none; b=eHQzLugOLxh5UkbdX4PO2dqZg5Xhega0AHLMkoo6O6KJurxsWj0iVt9YcyIIMrByQ14/mAAqdUqLRMhv3dzhpwdhlqhet9w7PLnzJNjp+r58vUzo4kd7BFGZVzfip0ug//DCZuAv/bf0Eiy2Sz8neozsj/lY8B161p5vS83RDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603790; c=relaxed/simple;
	bh=NHVnbwkzh7GFRR5baZ3ij4wNo4wbf13vG+/fcMqC+yM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YFeDLutEW8PXjIGC9SdQAZJJO29xPO40HCPQ+q77asWEWh1Nt1s0IFG5bLZcgULuD9MlEbdvPcCmu+P8shrbo1hIqtah4UPDI6GMpzRyfg7Ro98dgENqbYGdqgWGZjpzcDfWLdMd0Mhx21OXHzGa6uLkOmEQaU/taTYkNkol0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id C3F511012D8;
	Wed, 11 Jun 2025 01:02:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 965C32000D;
	Wed, 11 Jun 2025 01:02:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uP9tE-00000000v9j-38fn;
	Tue, 10 Jun 2025 21:04:28 -0400
Message-ID: <20250611010428.603778772@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 20:54:26 -0400
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
Subject: [PATCH v10 05/14] unwind_user/deferred: Add unwind cache
References: <20250611005421.144238328@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 965C32000D
X-Stat-Signature: 3saap8xhb9ht7aqm6fxm5qhxfj85y3ds
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Ok2o1cxfxVsuZmgzG49KIB60ysAb0rSk=
X-HE-Tag: 1749603776-372355
X-HE-Meta: U2FsdGVkX19PEX1xacieGEJ04oubI975S3Sm/XxALQIdvppjm5f/tBi/PPu+W7cRK8n7lC3ghbtB+ZuyuFz9yF44vtHWxBNXIes1SyH/AHSfeXc+1AUiBQGImKAvqjh8Mk7RENAXQtiVA+tmeMuYuYc3H2Et0CHGxF8//I+h2SwuMgRwaLA0ID50JSOAFTaKBFO1pZZ6qtmJmtOlpyg0qVUU6XdoMETxLJYNNhRL6gM/NtrKOkTPvSimxXq2hcQRC1aKqf3Jn3IcUCfTJG25MgUyjOYOcgyTpdy/UzDjI6JqeYu7pSb9+9KUByPWqMc6al727XpVZhQqbVZnKZYU7YT0QkFJnI4NhBArID4PJwDJLDqu19AbBZBioT6IxwyIg7jb8NQFespL06vF8r4dhuEQ/ir+xus2Ya0Zuw2WVhk=

From: Josh Poimboeuf <jpoimboe@kernel.org>

Cache the results of the unwind to ensure the unwind is only performed
once, even when called by multiple tracers.

The cache nr_entries gets cleared every time the task exits the kernel.
When a stacktrace is requested, nr_entries gets set to the number of
entries in the stacktrace. If another stacktrace is requested, if
nr_entries is not zero, then it contains the same stacktrace that would be
retrieved so it is not processed again and the entries is given to the
caller.

Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/entry-common.h          |  2 ++
 include/linux/unwind_deferred.h       |  8 ++++++++
 include/linux/unwind_deferred_types.h |  7 ++++++-
 kernel/unwind/deferred.c              | 26 ++++++++++++++++++++------
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index f94f3fdf15fc..6e850c9d3f0c 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -12,6 +12,7 @@
 #include <linux/resume_user_mode.h>
 #include <linux/tick.h>
 #include <linux/kmsan.h>
+#include <linux/unwind_deferred.h>
 
 #include <asm/entry-common.h>
 #include <asm/syscall.h>
@@ -362,6 +363,7 @@ static __always_inline void exit_to_user_mode(void)
 	lockdep_hardirqs_on_prepare();
 	instrumentation_end();
 
+	unwind_exit_to_user_mode();
 	user_enter_irqoff();
 	arch_exit_to_user_mode();
 	lockdep_hardirqs_on(CALLER_ADDR0);
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 5064ebe38c4f..7d6cb2ffd084 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -12,6 +12,12 @@ void unwind_task_free(struct task_struct *task);
 
 int unwind_deferred_trace(struct unwind_stacktrace *trace);
 
+static __always_inline void unwind_exit_to_user_mode(void)
+{
+	if (unlikely(current->unwind_info.cache))
+		current->unwind_info.cache->nr_entries = 0;
+}
+
 #else /* !CONFIG_UNWIND_USER */
 
 static inline void unwind_task_init(struct task_struct *task) {}
@@ -19,6 +25,8 @@ static inline void unwind_task_free(struct task_struct *task) {}
 
 static inline int unwind_deferred_trace(struct unwind_stacktrace *trace) { return -ENOSYS; }
 
+static inline void unwind_exit_to_user_mode(void) {}
+
 #endif /* !CONFIG_UNWIND_USER */
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_H */
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index aa32db574e43..db5b54b18828 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -2,8 +2,13 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
+struct unwind_cache {
+	unsigned int		nr_entries;
+	unsigned long		entries[];
+};
+
 struct unwind_task_info {
-	unsigned long		*entries;
+	struct unwind_cache	*cache;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 0bafb95e6336..e3913781c8c6 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -24,6 +24,7 @@
 int unwind_deferred_trace(struct unwind_stacktrace *trace)
 {
 	struct unwind_task_info *info = &current->unwind_info;
+	struct unwind_cache *cache;
 
 	/* Should always be called from faultable context */
 	might_fault();
@@ -31,17 +32,30 @@ int unwind_deferred_trace(struct unwind_stacktrace *trace)
 	if (current->flags & PF_EXITING)
 		return -EINVAL;
 
-	if (!info->entries) {
-		info->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
-					      GFP_KERNEL);
-		if (!info->entries)
+	if (!info->cache) {
+		info->cache = kzalloc(struct_size(cache, entries, UNWIND_MAX_ENTRIES),
+				      GFP_KERNEL);
+		if (!info->cache)
 			return -ENOMEM;
 	}
 
+	cache = info->cache;
+	trace->entries = cache->entries;
+
+	if (cache->nr_entries) {
+		/*
+		 * The user stack has already been previously unwound in this
+		 * entry context.  Skip the unwind and use the cache.
+		 */
+		trace->nr = cache->nr_entries;
+		return 0;
+	}
+
 	trace->nr = 0;
-	trace->entries = info->entries;
 	unwind_user(trace, UNWIND_MAX_ENTRIES);
 
+	cache->nr_entries = trace->nr;
+
 	return 0;
 }
 
@@ -56,5 +70,5 @@ void unwind_task_free(struct task_struct *task)
 {
 	struct unwind_task_info *info = &task->unwind_info;
 
-	kfree(info->entries);
+	kfree(info->cache);
 }
-- 
2.47.2



