Return-Path: <bpf+bounces-67735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CE1B496C4
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5628116F1C7
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DEB3128C0;
	Mon,  8 Sep 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwsWxK1U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1EC31280C;
	Mon,  8 Sep 2025 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351679; cv=none; b=ZteQTSgCMLcneHIAOFFmSXaLTcrlhcNEIzsUZM+pzFzpHHU76EnBElibluB8L1J4IiouLlFGl2qY3e30qT/gkZDc93Z/nwK+brChyzJXSYz59sCu0bQ3gJNUW50TWoN7mBr9pUcOz6NcBYm24kqoRMGuD3IT7cRX4+BZT1Glogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351679; c=relaxed/simple;
	bh=CaWPYtnuxMn+9lxdbGHUKRlw7zTyxsoiVJ8Bkz7tB84=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qIb3U7uZNVL5CCAP2rMyFDC6SBvM8jUThCR1qFT9LVUfXShshv09SbsAzcIVI4qA4i8NeJlM9aiz8YoPgsMcru50FTmmvYKk8jYcHsrBSdgI7xMcBLamummtkq2hi34UIJ4TRFqIvSqyybAiOIQRMlXw6lfgNv/95b2uoBvR+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwsWxK1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99734C4CEF9;
	Mon,  8 Sep 2025 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757351678;
	bh=CaWPYtnuxMn+9lxdbGHUKRlw7zTyxsoiVJ8Bkz7tB84=;
	h=Date:From:To:Cc:Subject:References:From;
	b=qwsWxK1U9faOxydz4T6nvPdMcK3dkWrhoWIAdvkhmSAHqHrTFKtuNOFhzYtY2ydCy
	 v8dDKz1fz7gHto0yC8KUlCh19Wk56mDilp+T8/vSeuGdo8SAr7Gq+VRWACzOaGRkOd
	 CZ5ba5BV5FKZvE/R/wkXnkcx7twKFStRAWezoP0nPmlIf/WIYCq4cNTpJZyCfdiyep
	 LlxBOsRs2KyYTdJNwXE8OgHaSPINSQWN+0xihYXsHr6PSW1kJzhzLx+RGljGNc9ccH
	 C2YyGAX4Ph1h5n1+kSL94o7bQNOsWC/RopYDX2nTBfBrnhsXHmVzc+mukAxciTdDmO
	 q16gyzZ08nTFQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uvfSe-000000075OU-2S6q;
	Mon, 08 Sep 2025 13:15:24 -0400
Message-ID: <20250908171524.435994255@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 08 Sep 2025 13:14:13 -0400
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
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>,
 "Carlos O'Donell" <codonell@redhat.com>
Subject: [RESEND][PATCH v15 1/4] unwind deferred: Add unwind_user_get_cookie() API
References: <20250908171412.268168931@kernel.org>
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



