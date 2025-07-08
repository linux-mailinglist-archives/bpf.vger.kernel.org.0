Return-Path: <bpf+bounces-62592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B109CAFBFDA
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 03:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8BF4A24C0
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62CF21CFEF;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXe3hgfs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F047C2036F3;
	Tue,  8 Jul 2025 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937839; cv=none; b=f8BSzxlIWDGiWyxdUCn1fAwZtfB+Ec+OHHw23WtcQBIzCkinJ27wjq/xcJXkzNrXGSm7i+H/ssVBXMm/gKadgeAk0iTvtjqJ1FaUqNqL/1FT4/MSHu1p7lrtlwvBnO3Z8eeypeidjuZb3TcmT6I1XjFkHH1KlJD7XM3Y54/o2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937839; c=relaxed/simple;
	bh=1P09LovKWNhVgieil2hCUmwed+xCsnmLZJ1706E9lA0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iy7576OZfzVUifJnhvUqOcIoDIf605S8ObBwoQmsTw1QGR03LPljjH8WPA6v/30NC3VPxeBGcIF1k9kZ3dNQ5h6wAEr36xX9z8hKQtAOe7wrEbMcNnnxzYJsI7ZUIfmrg0SvLzsZUw58DoFci0eMsWNVkGIrFLsQ+NV9CZNFER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXe3hgfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDB3C4CEE3;
	Tue,  8 Jul 2025 01:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937838;
	bh=1P09LovKWNhVgieil2hCUmwed+xCsnmLZJ1706E9lA0=;
	h=Date:From:To:Cc:Subject:References:From;
	b=OXe3hgfsZuvdhnassHMoJ1T7gTSmihxgY1mXwtOwqq4q90sWndpex5yibsJPr9MNY
	 /b1RH0Jbx0aK8Mbm+ZUIOgQ1djhS4kmloi86boN+YGEJsFti8Pi9/TfwB2OXAoU95Y
	 2Nz+6FrLQAmwxZersLr1I08LmIUR2u0PdqA5HhSmDB/luKbGaICknEwskzrDiur+yR
	 9iR7n2yvhfPKVfKq5vh4PZelz2fW42jz6oLeymqGKV5h7pQZJGvfMpAwODRrhriBN9
	 t5OW+f/Wtl3Gui0QXOwovLhR1byyTFRM0DbxK3+H7tpS49/UhDTeY95zgKjZulW6Jb
	 u5X1OjJOuiIBQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYx3u-00000000BsQ-47OV;
	Mon, 07 Jul 2025 21:23:58 -0400
Message-ID: <20250708012358.831631671@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 21:22:46 -0400
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
Subject: [PATCH v13 07/14] unwind_user/deferred: Make unwind deferral requests NMI-safe
References: <20250708012239.268642741@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Make unwind_deferred_request() NMI-safe so tracers in NMI context can
call it and safely request a user space stacktrace when the task exits.

Note, this is only allowed for architectures that implement a safe
cmpxchg. If an architecture requests a deferred stack trace from NMI
context that does not support a safe NMI cmpxchg, it will get an -EINVAL.
For those architectures, they would need another method (perhaps an
irqwork), to request a deferred user space stack trace. That can be dealt
with later if one of theses architectures require this feature.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v12: https://lore.kernel.org/20250701005451.737614486@goodmis.org

- Now that the timestamp has been replaced by a cookie that uses only a 32
  bit cmpxchg(), this code just checks if the architecture has a safe
  cmpxchg that can be used in NMI and doesn't do the 64 bit check.
  Only the pending value is converted to local_t.

 include/linux/unwind_deferred_types.h |  4 +-
 kernel/unwind/deferred.c              | 56 ++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 79b4f8cece53..cd95ed1c8610 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
+#include <asm/local.h>
+
 struct unwind_cache {
 	unsigned int		nr_entries;
 	unsigned long		entries[];
@@ -20,7 +22,7 @@ struct unwind_task_info {
 	struct unwind_cache	*cache;
 	struct callback_head	work;
 	union unwind_task_id	id;
-	int			pending;
+	local_t			pending;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index b1faaa55e5d5..2417e4ebbc82 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -12,6 +12,31 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 
+/*
+ * For requesting a deferred user space stack trace from NMI context
+ * the architecture must support a safe cmpxchg in NMI context.
+ * For those architectures that do not have that, then it cannot ask
+ * for a deferred user space stack trace from an NMI context. If it
+ * does, then it will get -EINVAL.
+ */
+#if defined(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG)
+# define CAN_USE_IN_NMI		1
+static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
+{
+	u32 old = 0;
+
+	return try_cmpxchg(&info->id.cnt, &old, cnt);
+}
+#else
+# define CAN_USE_IN_NMI		0
+/* When NMIs are not allowed, this always succeeds */
+static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
+{
+	info->id.cnt = cnt;
+	return true;
+}
+#endif
+
 /* Make the cache fit in a 4K page */
 #define UNWIND_MAX_ENTRIES					\
 	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
@@ -43,7 +68,6 @@ static u64 get_cookie(struct unwind_task_info *info)
 {
 	u32 cpu_cnt;
 	u32 cnt;
-	u32 old = 0;
 
 	if (info->id.cpu)
 		return info->id.id;
@@ -52,7 +76,7 @@ static u64 get_cookie(struct unwind_task_info *info)
 	cpu_cnt += 2;
 	cnt = cpu_cnt | 1; /* Always make non zero */
 
-	if (try_cmpxchg(&info->id.cnt, &old, cnt)) {
+	if (try_assign_cnt(info, cnt)) {
 		/* Update the per cpu counter */
 		__this_cpu_write(unwind_ctx_ctr, cpu_cnt);
 	}
@@ -119,11 +143,11 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct unwind_work *work;
 	u64 cookie;
 
-	if (WARN_ON_ONCE(!info->pending))
+	if (WARN_ON_ONCE(!local_read(&info->pending)))
 		return;
 
 	/* Allow work to come in again */
-	WRITE_ONCE(info->pending, 0);
+	local_set(&info->pending, 0);
 
 	/*
 	 * From here on out, the callback must always be called, even if it's
@@ -170,31 +194,43 @@ static void unwind_deferred_task_work(struct callback_head *head)
 int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
+	long pending;
 	int ret;
 
 	*cookie = 0;
 
-	if (WARN_ON_ONCE(in_nmi()))
-		return -EINVAL;
-
 	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
+	/* NMI requires having safe cmpxchg operations */
+	if (!CAN_USE_IN_NMI && in_nmi())
+		return -EINVAL;
+
 	guard(irqsave)();
 
 	*cookie = get_cookie(info);
 
 	/* callback already pending? */
-	if (info->pending)
+	pending = local_read(&info->pending);
+	if (pending)
 		return 1;
 
+	if (CAN_USE_IN_NMI) {
+		/* Claim the work unless an NMI just now swooped in to do so. */
+		if (!local_try_cmpxchg(&info->pending, &pending, 1))
+			return 1;
+	} else {
+		local_set(&info->pending, 1);
+	}
+
 	/* The work has been claimed, now schedule it. */
 	ret = task_work_add(current, &info->work, TWA_RESUME);
-	if (WARN_ON_ONCE(ret))
+	if (WARN_ON_ONCE(ret)) {
+		local_set(&info->pending, 0);
 		return ret;
+	}
 
-	info->pending = 1;
 	return 0;
 }
 
-- 
2.47.2



