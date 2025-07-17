Return-Path: <bpf+bounces-63618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 383DEB0909C
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061F51C22C82
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A2A2F9481;
	Thu, 17 Jul 2025 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqmaGhu5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA992F8C24;
	Thu, 17 Jul 2025 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766201; cv=none; b=GvZq99IZGFGMUt8WvNafQvkLAfLEN62OYLyIIk5CB9+7UliW+fV2Yk7qLJRK5Yh6oyzozrMJ1kY48WRLRCnsvgRlWdjuoSE2g6E4No6XsMSDUSQehjVivtIB/uGjKEPrjNcuaTWG9nIGbGI8tKgRPCG2paD/iph98gheVSaY6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766201; c=relaxed/simple;
	bh=zsRvh33Hfe4ha6Y47+FeKskdt2kc8iwrWtoda/9Y9OQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc6QR3VEZiyXK3s89x/jvUaOvsoh9KmUmKMKY39UX+dD5P5kQpHb4TN+4EaDdqz6qCwMGibkfrBvg49vEzrUUgUTtktu+N7DU6ouMoINx6mT99dJ9AxRrtQn1JtPZnpFrpy67/ScTuAfKGszj7iEocB2jfpITs3JH3amnri1Hpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqmaGhu5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so2503336a12.1;
        Thu, 17 Jul 2025 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752766198; x=1753370998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xvkwjk21IxR9ZhjZd7V8IXd6x48w85oxTVIXyT3Yl+A=;
        b=GqmaGhu5a9dcDUIgK32JcdZkJ9Vo8scATl1uTurf1LEiLBF2f7MZFg3+VJHL+xg23J
         2x+KJssISpiCEEVLpyNPOwVHhxogO4TFLOaYJgcWj6lsLu4FuhuCcI+UokY9143rVDOk
         V4v3INvrpoYmF0W5L3qS3Znw/HmT26zlbSInapiYP9zyTYqW30WnGrQKKUjbpOx9ejBA
         T54BkAjoKkbB00/+xmphGJd7JunefAALVEyqDeeDpZFXHF0mrNXhj5CdFtXKo3iqSNLc
         EFGw77mg/P00cedO8FQMmOaQK05ZNaCtehRmuQ1h3Y6Xh+yQ7Dms/Sf4XK+WF3LklR3B
         R/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752766198; x=1753370998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvkwjk21IxR9ZhjZd7V8IXd6x48w85oxTVIXyT3Yl+A=;
        b=W8So8J9PxvXyVAlwyoQyP3/orwWEMhS6513B+jKmXbSBv4jEmgWVI3tNfz+YxNlm8m
         3a8qqQxInjKNpRy+EQkJ3VLKCVnLRXmTBHoOPjhOi3M6SuFCiqaEI9FAMVHkOyQfWp02
         0499Yz/MK6f+uMijhO4UK1lbygbuWWGzhIaePP9fTi84FRtCmGl69pTydF0nKW1DzzQy
         BvPdaYOMYzycKCwNS3JSU7GjMozRwm2+XdYefoXxeTmXKZMNnawDda3DBZQu1neeD+Lq
         6yJv1UOq3OI4xx18XTYEG63zkhp0bJQrRg260qnvTqPmcumWb8u/18WzoDOVggC6rNo4
         e6UA==
X-Forwarded-Encrypted: i=1; AJvYcCV0Z7/IvFcX5/9irQbhOZC49AVSfGDxoEQBHuKZg32uE3xBTlpVLEg+h7GAHekS7+jyDtW+r0Gh3Myji+xwpyRy/JXu@vger.kernel.org, AJvYcCVMAAkn+rMUY6C24YzJpvZzDHhFN13A80yT03MKAdbAhu/Db5NgXepvU3x0u5SxoHz6pfKd2emthdO1tnhp@vger.kernel.org, AJvYcCVdvphefFwyAkN91Pz0gybTXSH5ni584H9cAioE0Pkbd/Fj4Yu2YKHtCEuR1Njfh5DurAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXwmNSUjjorMEiiRT3dKQXbfeIVTbfj8/Fse1UTsuznsn1z04m
	WWSdTGa5poCXopN08PKUH6EphyIdoaMe80NYYZ0twgKsnJalKic2JciR
X-Gm-Gg: ASbGnctvWPWrdhB+0Uktl6TB6qY9lDUQC3HLig4eJgNf1DN8cu52HYj6aATFEx6vEok
	AsG3DSv28PDGedh0ABCD4C4cTs1eRrcIsdJOlY/E0BE27yuI6wYzaaZgv2aeZzN3zK31SpCWXFk
	LSEmvQYoT9KjP9J6CqV7ksamBNbBy9K8VlCPxsEx7eq/qDeKd6hDlmVbTGqM40YphtLB1RV1a1d
	wwSc2+4ZKACtHrgj38XA6oOxnOyjB1bNAs17vyQ4ari3kVUCNPWGC2iM9wjvQEEV0nEbj9zMvcY
	aAhoc1IUE0pgwsRRSDdwBPBFNvd0YS8hzt8SEXpJ2QDeH95Mdgevt+XHTLHhAe9dsEqIQZ2rouh
	nhOy9QLzBFQ==
X-Google-Smtp-Source: AGHT+IGbpik+tV6J9EpxwfWrwQ8tluBYo7OLDW8ZnSAErkQCO+bg7efOvwYdJ0rXX4WCCJnR5Ij4Ow==
X-Received: by 2002:aa7:d3d5:0:b0:601:d0ec:fea0 with SMTP id 4fb4d7f45d1cf-612a327f45dmr2544831a12.5.1752766197444;
        Thu, 17 Jul 2025 08:29:57 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612aa5e5e62sm949129a12.69.2025.07.17.08.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:29:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 17 Jul 2025 17:29:54 +0200
To: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>
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
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv5 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <aHkW8gS1eOTfGFA1@krava>
References: <20250711082931.3398027-1-jolsa@kernel.org>
 <20250711082931.3398027-11-jolsa@kernel.org>
 <20250714094824.GQ905792@noisy.programming.kicks-ass.net>
 <aHV2o4SXbnRZdQSu@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHV2o4SXbnRZdQSu@krava>

On Mon, Jul 14, 2025 at 11:29:07PM +0200, Jiri Olsa wrote:

SNIP

> > > +static int swbp_unoptimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> > > +			   unsigned long vaddr)
> > > +{
> > > +	uprobe_opcode_t int3 = UPROBE_SWBP_INSN;
> > > +	struct write_opcode_ctx ctx = {
> > > +		.base = vaddr,
> > > +	};
> > > +	int err;
> > > +
> > > +	/*
> > > +	 * We need to overwrite call instruction into nop5 instruction with
> > > +	 * breakpoint (int3) installed on top of its first byte. We will:
> > > +	 *
> > > +	 * - overwrite call opcode with breakpoint (int3)
> > > +	 * - sync cores
> > > +	 * - write last 4 bytes of the nop5 instruction
> > > +	 * - sync cores
> > > +	 */
> > > +
> > > +	ctx.update = UNOPT_INT3;
> > > +	err = write_insn(auprobe, vma, vaddr, &int3, 1, &ctx);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	smp_text_poke_sync_each_cpu();
> > > +
> > > +	ctx.update = UNOPT_PART;
> > > +	err = write_insn(auprobe, vma, vaddr + 1, (uprobe_opcode_t *) auprobe->insn + 1, 4, &ctx);
> > > +
> > > +	smp_text_poke_sync_each_cpu();
> > > +	return err;
> > > +}
> > 
> > Please unify these two functions; it makes absolutely no sense to have
> > two copies of this logic around.
> 
> will try to come up with something
> 

would the change below be ok? int3_update function

thanks,
jirka


---
diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index 678fb546f0a7..1ee2e5115955 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -20,6 +20,11 @@ typedef u8 uprobe_opcode_t;
 #define UPROBE_SWBP_INSN		0xcc
 #define UPROBE_SWBP_INSN_SIZE		   1
 
+enum {
+	ARCH_UPROBE_FLAG_CAN_OPTIMIZE   = 0,
+	ARCH_UPROBE_FLAG_OPTIMIZE_FAIL  = 1,
+};
+
 struct uprobe_xol_ops;
 
 struct arch_uprobe {
@@ -45,6 +50,8 @@ struct arch_uprobe {
 			u8	ilen;
 		}			push;
 	};
+
+	unsigned long flags;
 };
 
 struct arch_uprobe_task {
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index d18e1ae59901..9baf42723ec6 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -18,6 +18,7 @@
 #include <asm/processor.h>
 #include <asm/insn.h>
 #include <asm/mmu_context.h>
+#include <asm/nops.h>
 
 /* Post-execution fixups. */
 
@@ -702,7 +703,6 @@ static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
 	return tramp;
 }
 
-__maybe_unused
 static struct uprobe_trampoline *get_uprobe_trampoline(unsigned long vaddr, bool *new)
 {
 	struct uprobes_state *state = &current->mm->uprobes_state;
@@ -891,6 +891,277 @@ static int __init arch_uprobes_init(void)
 
 late_initcall(arch_uprobes_init);
 
+enum {
+	EXPECT_SWBP,
+	EXPECT_CALL,
+};
+
+struct write_opcode_ctx {
+	unsigned long base;
+	int expect;
+};
+
+static int is_call_insn(uprobe_opcode_t *insn)
+{
+	return *insn == CALL_INSN_OPCODE;
+}
+
+static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode,
+		       int nbytes, void *data)
+{
+	struct write_opcode_ctx *ctx = data;
+	uprobe_opcode_t old_opcode[5];
+
+	uprobe_copy_from_page(page, ctx->base, (uprobe_opcode_t *) &old_opcode, 5);
+
+	switch (ctx->expect) {
+	case EXPECT_SWBP:
+		if (is_swbp_insn(&old_opcode[0]))
+			return 1;
+		break;
+	case EXPECT_CALL:
+		if (is_call_insn(&old_opcode[0]))
+			return 1;
+		break;
+	}
+
+	return -1;
+}
+
+/*
+ * Stolen comment from smp_text_poke_batch_finish.
+ *
+ * Modify multi-byte instructions by using INT3 breakpoints on SMP.
+ * We completely avoid using stop_machine() here, and achieve the
+ * synchronization using INT3 breakpoints and SMP cross-calls.
+ *
+ * The way it is done:
+ *   - Add an INT3 trap to the address that will be patched
+ *   - SMP sync all CPUs
+ *   - Update all but the first byte of the patched range
+ *   - SMP sync all CPUs
+ *   - Replace the first byte (INT3) by the first byte of the replacing opcode
+ *   - SMP sync all CPUs
+ */
+static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+		       unsigned long vaddr, char *insn, bool optimize)
+{
+	uprobe_opcode_t int3 = UPROBE_SWBP_INSN;
+	struct write_opcode_ctx ctx = {
+		.base = vaddr,
+	};
+	int err;
+
+	/*
+	 * Write int3 trap.
+	 *
+	 * The swbp_optimize path comes with breakpoint already installed,
+	 * so we can skip this step for optimize == true.
+	 */
+	if (!optimize) {
+		ctx.expect = EXPECT_CALL;
+		err = uprobe_write(auprobe, vma, vaddr, &int3, 1, verify_insn,
+				   true /* is_register */, false /* do_update_ref_ctr */,
+				   &ctx);
+		if (err)
+			return err;
+	}
+
+	smp_text_poke_sync_each_cpu();
+
+	/* Write all but the first byte of the patched range. */
+	ctx.expect = EXPECT_SWBP;
+	err = uprobe_write(auprobe, vma, vaddr + 1, insn + 1, 4, verify_insn,
+			   true /* is_register */, false /* do_update_ref_ctr */,
+			   &ctx);
+	if (err)
+		return err;
+
+	smp_text_poke_sync_each_cpu();
+
+	/*
+	 * Write first byte.
+	 *
+	 * The swbp_unoptimize needs to finish uprobe removal together
+	 * with ref_ctr update, using uprobe_write with proper flags.
+	 */
+	err = uprobe_write(auprobe, vma, vaddr, insn, 1, verify_insn,
+			   optimize /* is_register */, !optimize /* do_update_ref_ctr */,
+			   &ctx);
+	if (err)
+		return err;
+
+	smp_text_poke_sync_each_cpu();
+	return 0;
+}
+
+static int swbp_optimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+			 unsigned long vaddr, unsigned long tramp)
+{
+	u8 call[5];
+
+	__text_gen_insn(call, CALL_INSN_OPCODE, (const void *) vaddr,
+			(const void *) tramp, CALL_INSN_SIZE);
+	return int3_update(auprobe, vma, vaddr, call, true /* optimize */);
+}
+
+static int swbp_unoptimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+			   unsigned long vaddr)
+{
+	return int3_update(auprobe, vma, vaddr, auprobe->insn, false /* optimize */);
+}
+
+static int copy_from_vaddr(struct mm_struct *mm, unsigned long vaddr, void *dst, int len)
+{
+	unsigned int gup_flags = FOLL_FORCE|FOLL_SPLIT_PMD;
+	struct vm_area_struct *vma;
+	struct page *page;
+
+	page = get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+	uprobe_copy_from_page(page, vaddr, dst, len);
+	put_page(page);
+	return 0;
+}
+
+static bool __is_optimized(uprobe_opcode_t *insn, unsigned long vaddr)
+{
+	struct __packed __arch_relative_insn {
+		u8 op;
+		s32 raddr;
+	} *call = (struct __arch_relative_insn *) insn;
+
+	if (!is_call_insn(insn))
+		return false;
+	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
+}
+
+static int is_optimized(struct mm_struct *mm, unsigned long vaddr, bool *optimized)
+{
+	uprobe_opcode_t insn[5];
+	int err;
+
+	err = copy_from_vaddr(mm, vaddr, &insn, 5);
+	if (err)
+		return err;
+	*optimized = __is_optimized((uprobe_opcode_t *)&insn, vaddr);
+	return 0;
+}
+
+static bool should_optimize(struct arch_uprobe *auprobe)
+{
+	return !test_bit(ARCH_UPROBE_FLAG_OPTIMIZE_FAIL, &auprobe->flags) &&
+		test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
+}
+
+int set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+	     unsigned long vaddr)
+{
+	if (should_optimize(auprobe)) {
+		bool optimized = false;
+		int err;
+
+		/*
+		 * We could race with another thread that already optimized the probe,
+		 * so let's not overwrite it with int3 again in this case.
+		 */
+		err = is_optimized(vma->vm_mm, vaddr, &optimized);
+		if (err)
+			return err;
+		if (optimized)
+			return 0;
+	}
+	return uprobe_write_opcode(auprobe, vma, vaddr, UPROBE_SWBP_INSN,
+				   true /* is_register */);
+}
+
+int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+		  unsigned long vaddr)
+{
+	if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags)) {
+		struct mm_struct *mm = vma->vm_mm;
+		bool optimized = false;
+		int err;
+
+		err = is_optimized(mm, vaddr, &optimized);
+		if (err)
+			return err;
+		if (optimized) {
+			err = swbp_unoptimize(auprobe, vma, vaddr);
+			WARN_ON_ONCE(err);
+			return err;
+		}
+	}
+	return uprobe_write_opcode(auprobe, vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn,
+				   false /* is_register */);
+}
+
+static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
+				  unsigned long vaddr)
+{
+	struct uprobe_trampoline *tramp;
+	struct vm_area_struct *vma;
+	bool new = false;
+	int err = 0;
+
+	vma = find_vma(mm, vaddr);
+	if (!vma)
+		return -EINVAL;
+	tramp = get_uprobe_trampoline(vaddr, &new);
+	if (!tramp)
+		return -EINVAL;
+	err = swbp_optimize(auprobe, vma, vaddr, tramp->vaddr);
+	if (WARN_ON_ONCE(err) && new)
+		destroy_uprobe_trampoline(tramp);
+	return err;
+}
+
+void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+	struct mm_struct *mm = current->mm;
+	uprobe_opcode_t insn[5];
+
+	/*
+	 * Do not optimize if shadow stack is enabled, the return address hijack
+	 * code in arch_uretprobe_hijack_return_addr updates wrong frame when
+	 * the entry uprobe is optimized and the shadow stack crashes the app.
+	 */
+	if (shstk_is_enabled())
+		return;
+
+	if (!should_optimize(auprobe))
+		return;
+
+	mmap_write_lock(mm);
+
+	/*
+	 * Check if some other thread already optimized the uprobe for us,
+	 * if it's the case just go away silently.
+	 */
+	if (copy_from_vaddr(mm, vaddr, &insn, 5))
+		goto unlock;
+	if (!is_swbp_insn((uprobe_opcode_t*) &insn))
+		goto unlock;
+
+	/*
+	 * If we fail to optimize the uprobe we set the fail bit so the
+	 * above should_optimize will fail from now on.
+	 */
+	if (__arch_uprobe_optimize(auprobe, mm, vaddr))
+		set_bit(ARCH_UPROBE_FLAG_OPTIMIZE_FAIL, &auprobe->flags);
+
+unlock:
+	mmap_write_unlock(mm);
+}
+
+static bool can_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+	if (memcmp(&auprobe->insn, x86_nops[5], 5))
+		return false;
+	/* We can't do cross page atomic writes yet. */
+	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >= 5;
+}
 #else /* 32-bit: */
 /*
  * No RIP-relative addressing on 32-bit
@@ -904,6 +1175,10 @@ static void riprel_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 }
+static bool can_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+	return false;
+}
 #endif /* CONFIG_X86_64 */
 
 struct uprobe_xol_ops {
@@ -1270,6 +1545,9 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret)
 		return ret;
 
+	if (can_optimize(auprobe, addr))
+		set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
+
 	ret = branch_setup_xol_ops(auprobe, &insn);
 	if (ret != -ENOSYS)
 		return ret;
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b6b077cc7d0f..08ef78439d0d 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -192,7 +192,7 @@ struct uprobes_state {
 };
 
 typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
-				     uprobe_opcode_t *insn, int nbytes);
+				     uprobe_opcode_t *insn, int nbytes, void *data);
 
 extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct vm_area_struct *vma, unsigned long vaddr);
@@ -204,7 +204,8 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t,
 			       bool is_register);
 extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma, const unsigned long opcode_vaddr,
-			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr);
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr,
+			void *data);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
@@ -240,6 +241,7 @@ extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *
 extern void arch_uprobe_clear_state(struct mm_struct *mm);
 extern void arch_uprobe_init_state(struct mm_struct *mm);
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
+extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index cbba31c0495f..e54081beeab9 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -192,7 +192,7 @@ static void copy_to_page(struct page *page, unsigned long vaddr, const void *src
 }
 
 static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *insn,
-			 int nbytes)
+			 int nbytes, void *data)
 {
 	uprobe_opcode_t old_opcode;
 	bool is_swbp;
@@ -492,12 +492,13 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		bool is_register)
 {
 	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE,
-			    verify_opcode, is_register, true /* do_update_ref_ctr */);
+			    verify_opcode, is_register, true /* do_update_ref_ctr */, NULL);
 }
 
 int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		 const unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
-		 uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr)
+		 uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr,
+		 void *data)
 {
 	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
 	struct mm_struct *mm = vma->vm_mm;
@@ -531,7 +532,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		goto out;
 	folio = page_folio(page);
 
-	ret = verify(page, insn_vaddr, insn, nbytes);
+	ret = verify(page, insn_vaddr, insn, nbytes, data);
 	if (ret <= 0) {
 		folio_put(folio);
 		goto out;
@@ -2697,6 +2698,10 @@ bool __weak arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check c
 	return true;
 }
 
+void __weak arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+}
+
 /*
  * Run handler and ask thread to singlestep.
  * Ensure all non-fatal signals cannot interrupt thread while it singlesteps.
@@ -2761,6 +2766,9 @@ static void handle_swbp(struct pt_regs *regs)
 
 	handler_chain(uprobe, regs);
 
+	/* Try to optimize after first hit. */
+	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
+
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
 

