Return-Path: <bpf+bounces-68774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D15EB84662
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 13:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF31525FA2
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1643E27AC57;
	Thu, 18 Sep 2025 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OoXeXY3+"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6ADF59;
	Thu, 18 Sep 2025 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195985; cv=none; b=b4bLeSux9mlQ9rb7Zh8fua3fDK0nKIdLM0KT3/0Xs7uMEClXsDYkIikTY7xdl9mG6VwTu224/JMYGIEmQZCEk4G9c8f9844z5NsTinWapTlJX0pSYbPSu6+/b+Ne7UVavVELjNU1B9aaAohDsPoaARuGWa815asebfu7s7arHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195985; c=relaxed/simple;
	bh=lk/gD30p9245bDtKPpFHq/wfFDxZfYJTxi/Nrozu5AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNAgf9D9mChEyjq25PNsxMeTQeVfofnRvyrRpI0S9e4VYiIyrp0Y8J4k5oh9aO72R775LIa8zpbXSfNPpanyUhvw//+y2Cre6IApmf/EO4fpsnl/d97hLp/h8GJh+NscQ3wr/g3bhaDb0BDi3LigqM7QnVu8+Ppchv1hzAzWXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OoXeXY3+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mGG4aji83I7y9auBKZjs0jQLN5uTNuUh9F95womSCfY=; b=OoXeXY3+Xyq/iP/Hbclz8ylJv6
	5Qxc83RdICEvjIaf0rR+9JIp4GEPx7ABBJFkoZ7XnhSBjs6zef+PlcVsLALBWfMawU1HjtaCgZqhU
	Y0d8pC73msnkg3rpNSfuNhhbDpmmYLdXNyVAm6M5BI1y8l7zquiHvB8BwWx9S8HsZDKqA04xkAr1U
	6CWpQODZyX87moFoLOohmpwXK6zzhO97l3TV/K5H3mwQPANzLRFMu6062sP806Mnydn4UmTPwtV12
	VXrZTqFvgEBa9kz+TZfXTsF9E0ZQ9YB9p+O4WAU/vtjH/mNHPVHemzro437qc4BkVA8mrX5WQjRXS
	lD9vWstw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzD5Y-00000001g6e-1BAE;
	Thu, 18 Sep 2025 11:46:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C8DCB300125; Thu, 18 Sep 2025 13:46:10 +0200 (CEST)
Date: Thu, 18 Sep 2025 13:46:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
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
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
	Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: Re: [RESEND][PATCH v15 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20250918114610.GZ3419281@noisy.programming.kicks-ass.net>
References: <20250908171412.268168931@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908171412.268168931@kernel.org>



So I started looking at this, but given I never seen the deferred unwind
bits that got merged I have to look at that first.

Headers want something like so.. Let me read the rest.

---
 include/linux/unwind_deferred.h       | 38 +++++++++++++++++++----------------
 include/linux/unwind_deferred_types.h |  2 ++
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 26122d00708a..5d51a3f2f8ec 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -8,7 +8,8 @@
 
 struct unwind_work;
 
-typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stacktrace *trace, u64 cookie);
+typedef void (*unwind_callback_t)(struct unwind_work *work,
+				  struct unwind_stacktrace *trace, u64 cookie);
 
 struct unwind_work {
 	struct list_head		list;
@@ -44,22 +45,22 @@ void unwind_deferred_task_exit(struct task_struct *task);
 static __always_inline void unwind_reset_info(void)
 {
 	struct unwind_task_info *info = &current->unwind_info;
-	unsigned long bits;
+	unsigned long bits = info->unwind_mask;
 
 	/* Was there any unwinding? */
-	if (unlikely(info->unwind_mask)) {
-		bits = info->unwind_mask;
-		do {
-			/* Is a task_work going to run again before going back */
-			if (bits & UNWIND_PENDING)
-				return;
-		} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
-		current->unwind_info.id.id = 0;
+	if (likely(!bits))
+		return;
 
-		if (unlikely(info->cache)) {
-			info->cache->nr_entries = 0;
-			info->cache->unwind_completed = 0;
-		}
+	do {
+		/* Is a task_work going to run again before going back */
+		if (bits & UNWIND_PENDING)
+			return;
+	} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
+	current->unwind_info.id.id = 0;
+
+	if (unlikely(info->cache)) {
+		info->cache->nr_entries = 0;
+		info->cache->unwind_completed = 0;
 	}
 }
 
@@ -68,9 +69,12 @@ static __always_inline void unwind_reset_info(void)
 static inline void unwind_task_init(struct task_struct *task) {}
 static inline void unwind_task_free(struct task_struct *task) {}
 
-static inline int unwind_user_faultable(struct unwind_stacktrace *trace) { return -ENOSYS; }
-static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) { return -ENOSYS; }
-static inline int unwind_deferred_request(struct unwind_work *work, u64 *timestamp) { return -ENOSYS; }
+static inline int unwind_user_faultable(struct unwind_stacktrace *trace)
+{ return -ENOSYS; }
+static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
+{ return -ENOSYS; }
+static inline int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
+{ return -ENOSYS; }
 static inline void unwind_deferred_cancel(struct unwind_work *work) {}
 
 static inline void unwind_deferred_task_exit(struct task_struct *task) {}
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 33b62ac25c86..29452ff49859 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
+#include <linux/types.h>
+
 struct unwind_cache {
 	unsigned long		unwind_completed;
 	unsigned int		nr_entries;

