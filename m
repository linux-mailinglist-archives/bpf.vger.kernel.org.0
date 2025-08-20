Return-Path: <bpf+bounces-66083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC7EB2DC7A
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 14:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75ECC16D854
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 12:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E028311C16;
	Wed, 20 Aug 2025 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wHs1OS+f"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C7C26C393;
	Wed, 20 Aug 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693047; cv=none; b=qfOuLq7S1m/jEDQBifwPNKP2IuonBsFZLNRSgDnB+dRUH3Vejgar+yIm+dLOwPe609qHUXlGWOyD0jS0Hyx69H96QwA52N5hFAOc/1MBMKqUVxU6GYggAU16bgxFZXzORvzaipsajCtjhoV5STVN02RTRKEP1SakhPSuSSO/RgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693047; c=relaxed/simple;
	bh=iajl7mfArNAEmnm3aATmdcWSzDO+chPuV+BrrilACv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arQQbAIpfED4b0ufjw9CLn8t+usd2kgRzQAu/kBEGspo4//fD6eh9VWySnC341nIVDmbhq3fIlmrEYB/pk2dy81HvF4q0OKAaWo9moFB1TiP7a+/nrZvwJgTqONMgmOn581q8LvRK5pHzaqMlUILTo2K5hKnU+auhAjPl0/ndGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wHs1OS+f; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=58JTF77EGayfO37z+tb0RsabPxGBRmG0Xhu63CihFNQ=; b=wHs1OS+f85BmfY+PWeW9faDU9d
	GtbM794eQZDH9cbdL69TUVegpfTCgx3t1OsaLNgOxBWeFNZVUKn+iPbM+5um53NbmCphyoU2Ibujk
	k3SPmH3zKGjEzZCB3rCxKLA92aC6e0sr+E5cK1UVjk9IosHqAuv3N8tvVfg8gndscpygJVy3VAJtD
	V5oeSEIwKJG38RykdIRgx3WG/j2yAWpU94GL/xxdngf2PKwfGP7Wil5932/612hZgHJCi42z0Nzoy
	dVGOdjMgdlJz3RrIxiehixx8e5DgPnxv7NzHjBCWjvscPLYdxhQjz9481cnd9Rv7lNikZ8Od93ScO
	IZQ15PHg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uohxZ-00000006KHM-260u;
	Wed, 20 Aug 2025 12:30:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B0335300385; Wed, 20 Aug 2025 14:30:33 +0200 (CEST)
Date: Wed, 20 Aug 2025 14:30:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>, rick.p.edgecombe@intel.com
Subject: Re: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <20250820123033.GL3245006@noisy.programming.kicks-ass.net>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-11-jolsa@kernel.org>
 <20250819191515.GM3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819191515.GM3289052@noisy.programming.kicks-ass.net>

On Tue, Aug 19, 2025 at 09:15:15PM +0200, Peter Zijlstra wrote:
> On Sun, Jul 20, 2025 at 01:21:20PM +0200, Jiri Olsa wrote:

> > +void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +	uprobe_opcode_t insn[5];
> > +
> > +	/*
> > +	 * Do not optimize if shadow stack is enabled, the return address hijack
> > +	 * code in arch_uretprobe_hijack_return_addr updates wrong frame when
> > +	 * the entry uprobe is optimized and the shadow stack crashes the app.
> > +	 */
> > +	if (shstk_is_enabled())
> > +		return;
> 
> Kernel should be able to fix up userspace shadow stack just fine.
> 
> > +	if (!should_optimize(auprobe))
> > +		return;
> > +
> > +	mmap_write_lock(mm);
> > +
> > +	/*
> > +	 * Check if some other thread already optimized the uprobe for us,
> > +	 * if it's the case just go away silently.
> > +	 */
> > +	if (copy_from_vaddr(mm, vaddr, &insn, 5))
> > +		goto unlock;
> > +	if (!is_swbp_insn((uprobe_opcode_t*) &insn))
> > +		goto unlock;
> > +
> > +	/*
> > +	 * If we fail to optimize the uprobe we set the fail bit so the
> > +	 * above should_optimize will fail from now on.
> > +	 */
> > +	if (__arch_uprobe_optimize(auprobe, mm, vaddr))
> > +		set_bit(ARCH_UPROBE_FLAG_OPTIMIZE_FAIL, &auprobe->flags);
> > +
> > +unlock:
> > +	mmap_write_unlock(mm);
> > +}

Something a little like this should do I suppose...

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
+	    ret = -EFAULT;
+	ssp += SS_FRAME_SIZE;
+	wrmsrq(MSR_IA32_PL3_SSP, ssp);
+
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
+	wrmsrq(MSR_IA32_PL3_SSP, ssp);
+	ret = write_user_shstk_64((__user void *)ssp, val);
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
@@ -831,6 +831,9 @@ SYSCALL_DEFINE0(uprobe)
 
 	sp = regs->sp;
 
+	if (shstk_pop(&sret) == 0 && sret != args.retaddr)
+		goto sigill;
+
 	handle_syscall_uprobe(regs, regs->ip);
 
 	/*
@@ -855,6 +858,9 @@ SYSCALL_DEFINE0(uprobe)
 	if (args.retaddr - 5 != regs->ip)
 		args.retaddr = regs->ip;
 
+	if (shstk_push(args.retaddr) == -EFAULT)
+		goto sigill;
+
 	regs->ip = ip;
 
 	err = copy_to_user((void __user *)regs->sp, &args, sizeof(args));
@@ -1124,14 +1130,6 @@ void arch_uprobe_optimize(struct arch_up
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
 

