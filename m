Return-Path: <bpf+bounces-66422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 481D9B349C2
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 20:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DD71B2520A
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 18:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B0B30DED4;
	Mon, 25 Aug 2025 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ3pXdrA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B64309DAA;
	Mon, 25 Aug 2025 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145268; cv=none; b=RiG91+9nYiWhJ9XhGkttx5QnzW7ZjmbY3mEOqf37Xtm13Rdvx6Sae4G7Dqh6jwvZ40XPvWu9G/jq2HhZCPVq02WBdTqIlan+2V0GnJE4h9SI6MR3vqZcjfbXW13fJ3KTD4UtKof08fvnWcWtLisS9SdfOicwJqVFGDiNKv28Xsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145268; c=relaxed/simple;
	bh=CaWPYtnuxMn+9lxdbGHUKRlw7zTyxsoiVJ8Bkz7tB84=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DmmDr7jBselrJHbR+1soRrjw4+6S38ktJALsYsoSvgBjvmRwstbmQ8OSUwnMUnYCUwV6VeVoWECJboYj4JIfUzzEhHV526e8aHlwx48Z4OT2HSHH8SkuCsstg5/N2RfoOxXCZrBt/Q7T5jydo+tWbUKJ80hYpufNUnmphJB0wmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ3pXdrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A727BC4CEF1;
	Mon, 25 Aug 2025 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145267;
	bh=CaWPYtnuxMn+9lxdbGHUKRlw7zTyxsoiVJ8Bkz7tB84=;
	h=Date:From:To:Cc:Subject:References:From;
	b=QJ3pXdrA1g0P26dYpdpCkGOBj7R/aw8HHUZZzaLSsuaK6vPKLMx6UAzNx2Q0PX22R
	 Kmm+3gDzn8nsmhERG5zgiTUioqYlGtIzfvmEiLEuO062s+JtcDWq8FyChpmbZa7tjs
	 HXDKSKDhuY9xXa1tmoJiTjQNw7tup8FiiM/wYTcYuS1UgtHzE0jPN7SQ1HnOxzUEiX
	 rLgjWxtYCV49Fx4zeH5Ul6/J6TIq+Ew/LCDn/wElFw2bJpPv5kJ2fSqqbXknbd/mBK
	 /EiyKoyDLbfliSeR2/kZfLeb80vW5uRsGSI3TH8zskUVmAS388qiEDyAgB79JuyTwm
	 3y1L6t82U3IOw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uqbbt-00000002n3A-2xbJ;
	Mon, 25 Aug 2025 14:08:01 -0400
Message-ID: <20250825180801.557674656@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 25 Aug 2025 14:06:39 -0400
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
Subject: [PATCH v15 1/8] unwind deferred: Add unwind_user_get_cookie() API
References: <20250825180638.877627656@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add the function unwind_user_get_cookie() API that allows a subsystem to
retrieve the current context cookie. This can be used by perf to attach a
cookie to its task deferred unwinding code that doesn't use the deferred
unwind logic.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/unwind_deferred.h |  5 +++++
 kernel/unwind/deferred.c        | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 26122d00708a..ce507495972c 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -41,6 +41,8 @@ void unwind_deferred_cancel(struct unwind_work *work);
 
 void unwind_deferred_task_exit(struct task_struct *task);
 
+u64 unwind_user_get_cookie(void);
+
 static __always_inline void unwind_reset_info(void)
 {
 	struct unwind_task_info *info = &current->unwind_info;
@@ -76,6 +78,9 @@ static inline void unwind_deferred_cancel(struct unwind_work *work) {}
 static inline void unwind_deferred_task_exit(struct task_struct *task) {}
 static inline void unwind_reset_info(void) {}
 
+/* Must be non-zero */
+static inline u64 unwind_user_get_cookie(void) { return (u64)-1; }
+
 #endif /* !CONFIG_UNWIND_USER */
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index dc6040aae3ee..90f90e30000a 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -94,6 +94,27 @@ static u64 get_cookie(struct unwind_task_info *info)
 	return info->id.id;
 }
 
+/**
+ * unwind_user_get_cookie - Get the current user context cookie
+ *
+ * This is used to get a unique context cookie for the current task.
+ * Every time a task enters the kernel it has a new context. If
+ * a subsystem needs to have a unique identifier for that context for
+ * the current task, it can call this function to retrieve a unique
+ * cookie for that task context.
+ *
+ * Returns: A unque identifier for the current task user context.
+ */
+u64 unwind_user_get_cookie(void)
+{
+	struct unwind_task_info *info = &current->unwind_info;
+
+	guard(irqsave)();
+	/* Make sure to clear the info->id.id when exiting the kernel */
+	set_bit(UNWIND_USED_BIT, &info->unwind_mask);
+	return get_cookie(info);
+}
+
 /**
  * unwind_user_faultable - Produce a user stacktrace in faultable context
  * @trace: The descriptor that will store the user stacktrace
-- 
2.50.1



