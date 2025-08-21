Return-Path: <bpf+bounces-66205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28691B2F899
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9A5603FF4
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAFE32779C;
	Thu, 21 Aug 2025 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d7WUjo5s"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CAE320CCB;
	Thu, 21 Aug 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780172; cv=none; b=htKX7Tdjc/fqKWb/gKVUoABFiRTF3MUbYlxwat3ndkKUYztCofYK+LjXGPp+z1DUMInqByLhZw+47Ft0jecKwmSMF74VR7chvA23tSf3fU2fuwTokQpbhMoK9a8n90iql6DGJlImPzjzjT+3o04aTkJErKYCJOUq9U8jGjcHoYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780172; c=relaxed/simple;
	bh=oq/yG06XThH0TAVnnFJ3Ji2lCZ4WoreG3a3P5NttsvI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pyC1OjTZ95ACHYXHJHNljv0GTB3Z+294u168bzbTt/HQOooyFbKwo/MtswW3f+u767iEI2g3JSfd1gxBvBjY5fRR+t9D2BzUCMmFiRMruEteFehTjfharbCJXdg4ezHZKxSYFeZng5t+/YCLSJXq0LTKfksieNmIWd775hwMGXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d7WUjo5s; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=y+aSTnr9180YGHPj/X/hxIPUO484ST3otwkCN+epUbY=; b=d7WUjo5ssFzkM2anLj57PJ+D4R
	nPKY0rpzTP73PzrnZvFZHl8RAomTWYwmabHUXo4ACjKl8g3HC3HHa4ncKA6goIZ/lAYL+Q+IXr7p4
	wLQn6s69LZJz1HdOW+Ac5bb/gDeqmKRZOb+4HEjnS8VXxnw9pEmol3JqYAf/XuSs/GRpf/FmFVISD
	w5nWcz6KWVzWIOgMHUM70T/uFAZtHL0rTG1HN91PQAXt+62m8Vdtj8GG3JaddJaGbzCaX9tWqYXEf
	v2t5H3SUqaEBUkfJHn0Gcif2ln7gCIvtH6e/0GDp7NnlPvE01kZ/3rMAYuF5A3K3QQN/i+k0M7vqt
	dfavWUMw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up4co-00000000Y9O-1fjZ;
	Thu, 21 Aug 2025 12:42:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 95A5C302E7B; Thu, 21 Aug 2025 14:42:37 +0200 (CEST)
Message-ID: <20250821123657.055790090@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 21 Aug 2025 14:28:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jolsa@kernel.org,
 oleg@redhat.com,
 andrii@kernel.org,
 mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alx@kernel.org,
 eyal.birger@gmail.com,
 kees@kernel.org,
 bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 x86@kernel.org,
 songliubraving@fb.com,
 yhs@fb.com,
 john.fastabend@gmail.com,
 haoluo@google.com,
 rostedt@goodmis.org,
 alan.maguire@oracle.com,
 David.Laight@ACULAB.COM,
 thomas@t-8ch.de,
 mingo@kernel.org,
 rick.p.edgecombe@intel.com
Subject: [PATCH 4/6] uprobes/x86: Fix uprobe syscall vs shadow stack
References: <20250821122822.671515652@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The uprobe syscall stores and strips the trampoline stack frame from
the user context, to make it appear similar to an exception at the
original instruction. It then restores the trampoline stack when it
can exit using sysexit.

Make sure to match the regular stack manipulation with shadow stack
operations such that regular and shadow stack don't get out of sync
and causes trouble.

This enables using the optimization when shadow stack is in use.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/shstk.h |    4 ++++
 arch/x86/kernel/shstk.c      |   40 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/uprobes.c    |   17 ++++++++---------
 3 files changed, 52 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -23,6 +23,8 @@ int setup_signal_shadow_stack(struct ksi
 int restore_signal_shadow_stack(void);
 int shstk_update_last_frame(unsigned long val);
 bool shstk_is_enabled(void);
+int shstk_pop(u64 *val);
+int shstk_push(u64 val);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
@@ -35,6 +37,8 @@ static inline int setup_signal_shadow_st
 static inline int restore_signal_shadow_stack(void) { return 0; }
 static inline int shstk_update_last_frame(unsigned long val) { return 0; }
 static inline bool shstk_is_enabled(void) { return false; }
+static inline int shstk_pop(u64 *val) { return -ENOTSUPP; }
+static inline int shstk_push(u64 val) { return -ENOTSUPP; }
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
 #endif /* __ASSEMBLER__ */
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -246,6 +246,46 @@ static unsigned long get_user_shstk_addr
 	return ssp;
 }
 
+int shstk_pop(u64 *val)
+{
+	int ret = 0;
+	u64 ssp;
+
+	if (!features_enabled(ARCH_SHSTK_SHSTK))
+		return -ENOTSUPP;
+
+	fpregs_lock_and_load();
+
+	rdmsrq(MSR_IA32_PL3_SSP, ssp);
+	if (val && get_user(*val, (__user u64 *)ssp))
+		ret = -EFAULT;
+	else
+		wrmsrq(MSR_IA32_PL3_SSP, ssp + SS_FRAME_SIZE);
+	fpregs_unlock();
+
+	return ret;
+}
+
+int shstk_push(u64 val)
+{
+	u64 ssp;
+	int ret;
+
+	if (!features_enabled(ARCH_SHSTK_SHSTK))
+		return -ENOTSUPP;
+
+	fpregs_lock_and_load();
+
+	rdmsrq(MSR_IA32_PL3_SSP, ssp);
+	ssp -= SS_FRAME_SIZE;
+	ret = write_user_shstk_64((__user void *)ssp, val);
+	if (!ret)
+		wrmsrq(MSR_IA32_PL3_SSP, ssp);
+	fpregs_unlock();
+
+	return ret;
+}
+
 #define SHSTK_DATA_BIT BIT(63)
 
 static int put_shstk_data(u64 __user *addr, u64 data)
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -804,7 +804,7 @@ SYSCALL_DEFINE0(uprobe)
 {
 	struct pt_regs *regs = task_pt_regs(current);
 	struct uprobe_syscall_args args;
-	unsigned long ip, sp;
+	unsigned long ip, sp, sret;
 	int err;
 
 	/* Allow execution only from uprobe trampolines. */
@@ -831,6 +831,10 @@ SYSCALL_DEFINE0(uprobe)
 
 	sp = regs->sp;
 
+	err = shstk_pop((u64 *)&sret);
+	if (err == -EFAULT || (!err && sret != args.retaddr))
+		goto sigill;
+
 	handle_syscall_uprobe(regs, regs->ip);
 
 	/*
@@ -855,6 +859,9 @@ SYSCALL_DEFINE0(uprobe)
 	if (args.retaddr - 5 != regs->ip)
 		args.retaddr = regs->ip;
 
+	if (shstk_push(args.retaddr) == -EFAULT)
+		goto sigill;
+
 	regs->ip = ip;
 
 	err = copy_to_user((void __user *)regs->sp, &args, sizeof(args));
@@ -1124,14 +1131,6 @@ void arch_uprobe_optimize(struct arch_up
 	struct mm_struct *mm = current->mm;
 	uprobe_opcode_t insn[5];
 
-	/*
-	 * Do not optimize if shadow stack is enabled, the return address hijack
-	 * code in arch_uretprobe_hijack_return_addr updates wrong frame when
-	 * the entry uprobe is optimized and the shadow stack crashes the app.
-	 */
-	if (shstk_is_enabled())
-		return;
-
 	if (!should_optimize(auprobe))
 		return;
 



