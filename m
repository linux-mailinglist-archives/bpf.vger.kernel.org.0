Return-Path: <bpf+bounces-62982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D66C8B00D68
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 22:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F507B7490
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 20:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033B52FC3D3;
	Thu, 10 Jul 2025 20:52:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A118FDAF;
	Thu, 10 Jul 2025 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180730; cv=none; b=l+8CVal4X9iN8zpmbr6qgQd2kRS5tTa+Yw0MNps3LSRx8nCNCHP7XHDroP4dELs1Y4pXj6cHmadN7Niq3GJ4yMsw0gFUlA+CQ66v0DC/CCNnyekiSgSysSG5NngG4ma+l6H1kxoV0Mj5XdSiNgwQ24Iu5r58xKQ2aIOgbnlhCDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180730; c=relaxed/simple;
	bh=rdpdVgXpSuN5GUouenqoitYbhNcxEsDckDUzI/BHjH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqbisRhXb2wc4ScyYNhDN6s9q/u/4+rjhV/21Ma4ZhPe7ygBGquNPP0x+tlLNesMkCAjCNAa6mLqWo5lcFvSfcW/8azSbP0SXg/nFAsDBo/prMUfUG48VrW7jBHqJBoaiXcCikqNvuvgjEDQgiy0qouh2um6FByEiiPoesU2FBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 8DE67141589;
	Thu, 10 Jul 2025 20:52:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 3D0368000F;
	Thu, 10 Jul 2025 20:51:58 +0000 (UTC)
Date: Thu, 10 Jul 2025 16:51:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt
 <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v8 06/12] unwind_user/sframe: Wire up unwind_user to
 sframe
Message-ID: <20250710165157.6e0936e9@batman.local.home>
In-Reply-To: <20250710113039.04a431d9@batman.local.home>
References: <20250708021115.894007410@kernel.org>
	<20250708021159.386608979@kernel.org>
	<d7d840f6-dc79-471e-9390-a58da20b6721@efficios.com>
	<20250708161124.23d775f4@gandalf.local.home>
	<a52c508c-2596-49d1-bbe8-8a92599714f6@linux.ibm.com>
	<20250710113039.04a431d9@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: wg7qym5dhdouejzwatqiqc4e5qk7187g
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 3D0368000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+mONFfQ6muWwYwXRfXDA3phF2+Buj9aKA=
X-HE-Tag: 1752180718-389422
X-HE-Meta: U2FsdGVkX1/zGKDFsZIgwyfki/04YelAXL/CFwu3MtOfXh6MZ5lRKF3ALBt+23EQkFXrhZX0apSeNji5UwtoDJEzfKleuVKUoeIUEpmmx2Dlr3nTJZQUIC7wtAKnLGNevwpoWajqHSworsX4u4xTiO9CSxpHAafYXbo54zws1+uq5puNSaw2s1yeVIDomuFBka9UcQ9N3a7CG1BN5G4LGrVjXPAyhKWZiEUyatNITEWgz17DDP/EigFdcbeejGG+XfCA8GJUcI1aesPTBZaVnU66ZKu5DfSMywjJFYa6Vkh87K6Is6hn6NoDiAKU5NorPOCHMNKDEPz+ARMuHInYoUsixw9PqYUm/SQkeY4zX0j042jsxMHAIVsLG4OuFRQb

On Thu, 10 Jul 2025 11:30:39 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'm not too comfortable with the compat patches at this stage. I'm
> thinking of separating out the compat patches, and just reject the
> deferred unwind if the task is in compat mode (forcing perf or other
> tracers to use whatever it uses today).
> 
> I'll take Mathieu's patches and merge them with Josh's, but make them a
> separate series.

So I'm removing the two compat patches from the series for now and plan
to replace it with this:

-- Steve


From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] unwind deferred/x86: Do not defer stack tracing for compat
 tasks

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
index a9d5b100d6b2..6ba4fff066dd 100644
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
 
 #define UNWIND_PENDING_BIT	(BITS_PER_LONG - 1)
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 039e12700d49..745144e4717c 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -236,6 +236,9 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 
 	*cookie = 0;
 
+	if (!arch_unwind_can_defer())
+		return -EINVAL;
+
 	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
-- 
2.47.2


