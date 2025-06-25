Return-Path: <bpf+bounces-61599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC78AE9169
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD65E5A4581
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEA52F4A0D;
	Wed, 25 Jun 2025 22:57:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CC32F4337;
	Wed, 25 Jun 2025 22:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892223; cv=none; b=QSrZHV+DFsg22mCFpwWYjYae8L4R03cTyVahwi97Rc/uy2qFsJN4kzd6mQTLSPSvUE0OIeO9vFKjcwYqPFMB4oU6gy73VkYMo00Orj1KLpFhPsk9U1dH4frcCjr4drPs/F/nrZXS/V1RolxEl8IpZRB2Kr3pymR5CgjxDHXgNkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892223; c=relaxed/simple;
	bh=NwnED+TA/vpwr9GukLZVYoarbYddnU0lUgfvneRUW70=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uhGjIEUpp653fTo21QpH8nXe9LOY8cTmL9+6REkfmK50HbbEfnDgQ98N1umSYNeXngpBkQCDhWcsRs+o6mOi/xMe4aoQ7HmEwj+3rYoHiuSa/nbAyRy6pnYVR2xEYb+l0zXGsWXw5G/Q89FEI8A9XSsoxlnfNtf/a12TGjBg4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id C75B11D71FD;
	Wed, 25 Jun 2025 22:56:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 90AD432;
	Wed, 25 Jun 2025 22:56:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZ3L-000000043fJ-3NIP;
	Wed, 25 Jun 2025 18:57:15 -0400
Message-ID: <20250625225715.657143263@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 18:56:05 -0400
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
Subject: [PATCH v11 05/14] unwind_user/deferred: Add unwind cache
References: <20250625225600.555017347@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: ik8satqp9mcawhxaxahch9e7kzctx863
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 90AD432
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18fGZvW6I/Gqp6hh5IBiD8c8/I6/xsxIow=
X-HE-Tag: 1750892210-977922
X-HE-Meta: U2FsdGVkX1/8f7/qSFGYB6KPdso+c5TepLlSqiunSm8g/LjlBWY3vP8FaczXsgWy0oVhnAOZJ35E934LKUfPpyOqQWl3yWZe9rlgfpvrKSHaB9EIdrv0sJi6lPT4CP34Aotvzz3TyF2JaEY+lp8vCNuuJnyVLDA+O6LgjfZo8CTaEM3QzytCxHE+ofX3GILJNQr+GVVnSOTqlMpvyd2TceA+jG/2TAP8dZe7pZy2otcoJTVzoIBwZQCu6vma/5YyivrT0k6jddUmVN4qlYOBpZbJgqNWG9Lk5Jo0l6fZ56XKHPwlQezpELf0xmXqEu3z+cJPkmsTRqnWS7dD0d6mkD89aSjjd+LcP/yBycufjE/WjTsew1XsgFVSrr70dPrpbn37iaGBCM1tHXjvAhFpIUKYRzTodddnUckb/qRhul8=

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
Changes since v10: https://lore.kernel.org/20250611010428.603778772@goodmis.org

- Rename unwind_exit_to_user_mode() to unwind_reset_info() as it is called
  in a noinstr section and the current name looks like it does
  instrumentation (Peter Zijlstra)

- Make the allocated cache fit inside a 4K page. (Peter Zijlstra)

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



