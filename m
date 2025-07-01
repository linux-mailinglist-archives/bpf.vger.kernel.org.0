Return-Path: <bpf+bounces-61913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5E7AEEB69
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF1D44055E
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56821ADC83;
	Tue,  1 Jul 2025 00:54:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA41537A7;
	Tue,  1 Jul 2025 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331264; cv=none; b=I+dBLm9sjyFIyycfhIOqI3rkVeUUvfiKRqnkwu7PbWphIV3VZmdp/1x3xrSbBM+MnRMF4FpjE7nz3Q47y1OinJc/EBVqcxTAz6HHxtt1PC685xM6rpsbScdMzOV9sFfIyqLLkOmv+DzFvJ21/YF1Kxjwn9/vg51enUxCscD0UOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331264; c=relaxed/simple;
	bh=khOhKXtWFZeIJYQHz9mkKupo2UshQTC5+3EPNwqv7Gk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Szl3hC1BJHstYY1lgiN8Jc+5/MvzTjXJe+X2MBNk4TZ8BNvj1Y46RO+75ErepP1BZIywE1iduZWSVR2F2oGEJvVaQMgtsVO5ygpYXTsB5or8hNrx2PcOjdYw1InTW6PYPCbAQqZLRG25/RSMbGfcLVni5BD9AWmgjMMXBcKzFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 19BB71A01C0;
	Tue,  1 Jul 2025 00:54:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id B09472000D;
	Tue,  1 Jul 2025 00:54:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWPGt-00000007Ngj-2J5G;
	Mon, 30 Jun 2025 20:54:51 -0400
Message-ID: <20250701005451.398606540@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 30 Jun 2025 20:53:26 -0400
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
Subject: [PATCH v12 05/14] unwind_user/deferred: Add unwind cache
References: <20250701005321.942306427@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: 3fjxz643k3uxuhoibpjm7tum3k1oq9ej
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B09472000D
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19mDYCqy0cnuKrX8GU15TwsOgKu/j5SZVs=
X-HE-Tag: 1751331254-693368
X-HE-Meta: U2FsdGVkX1/RHFmfBJ/m6WptKh8HO2oo3RcT9iP35lzLtwG/sprPmsGKlZdcQ7oY5MtNKrS+atGVgY6YHEgqHsWcKxzMw2IYqqJu81M58mYv8k+QQWaOmdb2EEqkolZumZDHDmqxnsIVJsneyusq0YZsuGO/cpgL46Cvj/K2LiKy8ZCEWJOgN6o3sQSZhu1Ch7fJ7002oiwy0uATfxK48MCj8Kyz7Jo4nOkJVA4aRjSo/NX0FtwoLjcJ4fWxFR2P3UTRbvi1GnmHWvh+yoSKhiT7FeQox+XUHrJQlNcxLGqj5qjewqmYI30JaZ66KYMpcf3DVQZ8KKLj+bEyFKxF+e2txrDUdDe/S9OP48G/ESaS5c8ytEz+O1Jx7IRK16y5IckfXoS29Dy6ES8gK6iirKAi+BwZgiNeRGsji4LmwBk=

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
 include/linux/unwind_deferred.h       |  8 +++++++
 include/linux/unwind_deferred_types.h |  7 +++++-
 kernel/unwind/deferred.c              | 31 +++++++++++++++++++++------
 4 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index f94f3fdf15fc..8908b8eeb99b 100644
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
 
+	unwind_reset_info();
 	user_enter_irqoff();
 	arch_exit_to_user_mode();
 	lockdep_hardirqs_on(CALLER_ADDR0);
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index a5f6e8f8a1a2..baacf4a1eb4c 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -12,6 +12,12 @@ void unwind_task_free(struct task_struct *task);
 
 int unwind_user_faultable(struct unwind_stacktrace *trace);
 
+static __always_inline void unwind_reset_info(void)
+{
+	if (unlikely(current->unwind_info.cache))
+		current->unwind_info.cache->nr_entries = 0;
+}
+
 #else /* !CONFIG_UNWIND_USER */
 
 static inline void unwind_task_init(struct task_struct *task) {}
@@ -19,6 +25,8 @@ static inline void unwind_task_free(struct task_struct *task) {}
 
 static inline int unwind_user_faultable(struct unwind_stacktrace *trace) { return -ENOSYS; }
 
+static inline void unwind_reset_info(void) {}
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
index a0badbeb3cc1..96368a5aa522 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -4,10 +4,13 @@
  */
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/unwind_deferred.h>
 
-#define UNWIND_MAX_ENTRIES 512
+/* Make the cache fit in a 4K page */
+#define UNWIND_MAX_ENTRIES					\
+	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
 
 /**
  * unwind_user_faultable - Produce a user stacktrace in faultable context
@@ -24,6 +27,7 @@
 int unwind_user_faultable(struct unwind_stacktrace *trace)
 {
 	struct unwind_task_info *info = &current->unwind_info;
+	struct unwind_cache *cache;
 
 	/* Should always be called from faultable context */
 	might_fault();
@@ -31,17 +35,30 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
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
 
@@ -56,5 +73,5 @@ void unwind_task_free(struct task_struct *task)
 {
 	struct unwind_task_info *info = &task->unwind_info;
 
-	kfree(info->entries);
+	kfree(info->cache);
 }
-- 
2.47.2



