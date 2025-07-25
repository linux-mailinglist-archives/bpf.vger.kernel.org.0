Return-Path: <bpf+bounces-64400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77952B1247D
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 20:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC9AAE1038
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 18:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B6D25A34B;
	Fri, 25 Jul 2025 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM59CbeH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC92571C2;
	Fri, 25 Jul 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469854; cv=none; b=ftAJH/eymnaOUjrABzlPMPinQHBw5OXtY7TJZ0zZAsHsTbcTuFghLDid47dVyVL5Fm2OWY1XXFGxb6MTUyj4YhrtgdgWhx2RySOzexGsx2ytiF0G9LAYque+HujCj5LQegM+BVzug20bnF1NClTwL6ldShNjeV8aAc49OzhbnUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469854; c=relaxed/simple;
	bh=khOhKXtWFZeIJYQHz9mkKupo2UshQTC5+3EPNwqv7Gk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RS89mhxam2KzG7EI0KzpVLg80TjWZpUpX+LfDECStHSW52dvzedhiw9hyyu8yGCtvw2keEbMcKK7Fu0iz/zMKlJYhGpasOplOMi6EEpqEgX2cRlRPVublC9+2vJ6aUMqY6qNbgNDze50Nk3rNbnrga5uk9FQdxWXHTGZlXPfjGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM59CbeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8181C4CEF7;
	Fri, 25 Jul 2025 18:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753469853;
	bh=khOhKXtWFZeIJYQHz9mkKupo2UshQTC5+3EPNwqv7Gk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=BM59CbeHMhC+5j7YI/JHOPiZsUIZPrXax/bBOksPsiRDnp/XaxSYHpk3uMGJuV+8F
	 6TO6bivnCDgqGoR53apKY/rgl6nsW6rOoQ4KVaVt+KC4XBOUIEXA7Ph9eT4KxQlccO
	 +A9Te0976+98py5X0HbYG8Xmvx6GrBysxTCrIuUqBmI4RLWb/K2Th3ZSIIZf2as1X4
	 y7al7I1L4eGD+zL6q95MWmHE2kV0UfDrKq9AstWnk19BSFXNbn3SIbGv/xkqw5jddP
	 cqR735Sdx3HBCn/bHJ3/r4fYudsOIR0temlCQIjhYH6CN/VZpp/lPNugVB1ZVKsjvN
	 /5x/5H64PGiAQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufNbv-00000001N4U-2zTl;
	Fri, 25 Jul 2025 14:57:39 -0400
Message-ID: <20250725185739.573388765@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 14:55:15 -0400
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
 Sam James <sam@gentoo.org>
Subject: [PATCH v15 03/10] unwind_user/deferred: Add unwind cache
References: <20250725185512.673587297@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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



