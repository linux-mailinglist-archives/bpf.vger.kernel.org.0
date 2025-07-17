Return-Path: <bpf+bounces-63515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0F6B081DE
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B006567BD3
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 00:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0571E8322;
	Thu, 17 Jul 2025 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZfbefVy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CED1DE3DC;
	Thu, 17 Jul 2025 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752713378; cv=none; b=qJfcQ8SxdQS4IGhhxUlPbQVHGc3Pgxk6BX6G8vd1N9uZpG9vb7p2t5o6lWO+fzqBgNu9dLfjM9UByVPYqJMRHF4rWsSa9qFK8fi05K7AHCwy/r9ItfE6grT/bkAgK3b/nrLYj1qyrKYNL3HRMG+J9tif4Lk7hfzig4duXU+4hJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752713378; c=relaxed/simple;
	bh=tJGl0mjPqHIyEHnwWkr8MujbKwHy0jxF2lfUs2W46m8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OwUBRSTIhF+LYtqyViVGy4MPFOYL9jkN0kdGY9J0P+qvScbAypGqfkOA4yrmDu8lPR/7+hIR21hqsWc1R6w07wyObvDmTr490022FqnY1pv10AdETQDh9IoG3RoJBqb/aG9X/VwH+xo7vIYzHt0O5hzYTSqFKfRlvpMElbzkrxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZfbefVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E65EC4CEF8;
	Thu, 17 Jul 2025 00:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752713378;
	bh=tJGl0mjPqHIyEHnwWkr8MujbKwHy0jxF2lfUs2W46m8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=gZfbefVyRdbRLaRUXuw2rwswwCdjS/bjVN5KGpjTsDwe/ehtVBc9h9MQcX+GVFf/w
	 uTEQvYccmBo3gaHTpT81riLT1egHfceop/FL5LYYALnUKhb20tluhItlH4wIpV7DSR
	 QxOiFp9IUM2xN/gZJwbwLrJZrTmPV1fhEdrGBUN4Cd2SIcc3CyenSecm96bUn2FSOX
	 2Q1IkzPKxRuJrMyIiqjyuPUp/XFxwUAvqbikKJLuH9fkcJYNvjvEBIyfm+CZaFwrZK
	 nmRM+0ToalrBSQiREuMrs8Ozd1aWvGVfTJKFfSzt30Fw5lUQRzscuzv6NM0PYK0FU9
	 dn44UrmXSa+kw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucCow-000000067XW-2QXj;
	Wed, 16 Jul 2025 20:49:58 -0400
Message-ID: <20250717004958.432327787@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 16 Jul 2025 20:49:22 -0400
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
Subject: [PATCH v14 12/12] unwind deferred/x86: Do not defer stack tracing for compat tasks
References: <20250717004910.297898999@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently compat tasks are not supported. If a deferred user space stack
trace is requested on a compat task, it should fail and return an error so
that the profiler can use an alternative approach (whatever it uses
today).

Add a arch_unwind_can_defer() macro that is called in
unwind_deferred_request(). Have x86 define it to a function that makes
sure that the current task is running in 64bit mode, and if it is not, it
returns false. This will cause unwind_deferred_request() to error out and
the caller can use the current method of user space stack tracing.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/include/asm/unwind_user.h | 11 +++++++++++
 include/linux/unwind_deferred.h    |  5 +++++
 kernel/unwind/deferred.c           |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 8597857bf896..220fd0a6e175 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,6 +2,17 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
 
+#ifdef CONFIG_IA32_EMULATION
+/* Currently compat mode is not supported for deferred stack trace */
+static inline bool arch_unwind_can_defer(void)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+
+	return user_64bit_mode(regs);
+}
+# define arch_unwind_can_defer	arch_unwind_can_defer
+#endif /* CONFIG_IA32_EMULATION */
+
 #define ARCH_INIT_USER_FP_FRAME							\
 	.cfa_off	= (s32)sizeof(long) *  2,				\
 	.ra_off		= (s32)sizeof(long) * -1,				\
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 26122d00708a..0124865aaab4 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -16,6 +16,11 @@ struct unwind_work {
 	int				bit;
 };
 
+/* Architectures can add a test to not defer unwinding */
+#ifndef arch_unwind_can_defer
+# define arch_unwind_can_defer()	(true)
+#endif
+
 #ifdef CONFIG_UNWIND_USER
 
 enum {
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 53a75f8f9b7e..9972096e93e8 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -237,6 +237,9 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 
 	*cookie = 0;
 
+	if (!arch_unwind_can_defer())
+		return -EINVAL;
+
 	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
-- 
2.47.2



