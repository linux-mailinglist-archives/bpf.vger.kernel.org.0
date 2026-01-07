Return-Path: <bpf+bounces-78122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DE0CFEB66
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 16:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9010F3022A80
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 15:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD853570AE;
	Wed,  7 Jan 2026 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JFg/7oO7"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3DF3559D1;
	Wed,  7 Jan 2026 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800169; cv=none; b=UxsiAnbN4faRMGzu+flRiLwh8+MIIdTzUANevehbOppwVsbPALpKv/WXjpYYH1JE1jhZqnEipEXpkyw8OW7fD8dvrZsOKmpH+7Syksw080QHWFhr46R0qviHHkmcO7S2Srn67z6w9sljvgArTFn2RCmm+klVmLD0BJp7tsFqmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800169; c=relaxed/simple;
	bh=npliYLcYC6iWJr/o72Y06Hs6Mk6kQExX+Xik6GNO28Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+2No5d3RQ9CTI/65fStwX3socsN4kaybWDl3Rlc+q9IL7M4TaCcRpJVjzxB07TayqDzxE4gNJkWi/mscZnJR+KcZdwKv6QYgSuHPCeGSH+zf6a3qnfBwwVoYU3JHz0RjupFZf/wCPI6/Frd6+UEc6PbE0k/WbClFuQrf8n//BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JFg/7oO7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L6eEGtWoG0RlchQ3StGx2B3PMR0vm5bRog9gcTfy2TM=; b=JFg/7oO7Od6HXvXzXQo7iS0ilv
	KHfOOYRKNmYQKhPUwZb6Vd6Di2gsfDYy6NOZfYnvjhPFYobu1Ia68aJeOkGjiAEmjo3yaLHjRaZGt
	NV0tvTw3c/cjAA6X61u8hPY49lspwUXEQXAdSPjZ4FLeNoSD93umosmzmWQb1Xz2jgxpBVjVqdljs
	bia6zzHQf7BmmTLbKyNt4VMDPXDDqKkWxGrKbcb1H3VpCes+6SNq18y9HsubCZNisdCMRvNrfYhan
	XEa5iQWQJKSpDtLwyZrp/pLsDFNWJl2HbjcS2qDYX2gurvVFvKfow4DHFZxT3Jsx5fUA0v0CvC7IQ
	rfqk95gQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdVZs-0000000DbGG-3Q2a;
	Wed, 07 Jan 2026 15:36:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A93F930057E; Wed, 07 Jan 2026 16:36:03 +0100 (CET)
Date: Wed, 7 Jan 2026 16:36:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rustam Kovhaev <rkovhaev@gmail.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: kernel crashes in BPF JIT code with kCFI and clang on x86
Message-ID: <20260107153603.GI3708021@noisy.programming.kicks-ass.net>
References: <20251223034332.GA2008178@nuc10>
 <20260107093639.GC3707891@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107093639.GC3707891@noisy.programming.kicks-ass.net>

On Wed, Jan 07, 2026 at 10:36:39AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 22, 2025 at 07:43:32PM -0800, Rustam Kovhaev wrote:
> 
> > Here is the patch that fixed it for me:
> > 
> > diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
> > index c40b9ebc1fb4..48f232d4b9d6 100644
> > --- a/arch/x86/include/asm/cfi.h
> > +++ b/arch/x86/include/asm/cfi.h
> > @@ -121,6 +121,8 @@ static inline int cfi_get_offset(void)
> >         case CFI_FINEIBT:
> >                 return 16;
> >         case CFI_KCFI:
> > +               if (IS_ENABLED(CONFIG_CC_IS_CLANG) && IS_ENABLED(CONFIG_CALL_PADDING))
> > +                       return CONFIG_FUNCTION_PADDING_CFI + 5;
> >                 if (IS_ENABLED(CONFIG_CALL_PADDING))
> >                         return 16;
> >                 return 5;
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index b0bac2a66eff..f8706d5b155f 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -435,20 +435,16 @@ static void emit_fineibt(u8 **pprog, u8 *ip, u32 hash, int arity)
> >  static void emit_kcfi(u8 **pprog, u32 hash)
> >  {
> >         u8 *prog = *pprog;
> > +       size_t nop_len = 11;
> > +       if (IS_ENABLED(CONFIG_CC_IS_CLANG) && IS_ENABLED(CONFIG_CALL_PADDING))
> > +               nop_len = 55;
> >  
> >         EMIT1_off32(0xb8, hash);                        /* movl $hash, %eax     */
> >  #ifdef CONFIG_CALL_PADDING
> > -       EMIT1(0x90);
> > -       EMIT1(0x90);
> > -       EMIT1(0x90);
> > -       EMIT1(0x90);
> > -       EMIT1(0x90);
> > -       EMIT1(0x90);
> > -       EMIT1(0x90);
> > -       EMIT1(0x90);
> > -       EMIT1(0x90);
> > -       EMIT1(0x90);
> > -       EMIT1(0x90);
> > +       while( nop_len > 0) {
> > +               EMIT1(0x90);
> > +               nop_len--;
> > +       }
> >  #endif
> >         EMIT_ENDBR();
> > 
> > After switching to clang kbuild always generates these huge paddings in my kernel config:
> > rusty@nuc10:~/code/kbuild_rust$ grep -e IBT -e PADDING .config
> > CONFIG_CC_HAS_IBT=y
> > CONFIG_X86_KERNEL_IBT=y
> > CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
> > CONFIG_CC_HAS_ENTRY_PADDING=y
> > CONFIG_FUNCTION_PADDING_CFI=59
> > CONFIG_FUNCTION_PADDING_BYTES=59
> > CONFIG_CALL_PADDING=y
> > CONFIG_FINEIBT=y
> 
> Oh gawd, you have FUNCTION_ALIGNMENT_64B. Yeah, I suppose that wasn't
> tested very well.

You appear to have CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y; is there any
particular reason you have that on?

> Let me go check all that code.

I've ended up with the below; this appears to boot (on my ADL) with
"paranoid FineIBT" and "kCFI" options tested so far.

---
 arch/x86/include/asm/cfi.h     | 12 ++++++++----
 arch/x86/include/asm/linkage.h |  4 ++--
 arch/x86/kernel/alternative.c  | 29 ++++++++++++++++++++++-------
 arch/x86/net/bpf_jit_comp.c    | 13 ++-----------
 4 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index c40b9ebc1fb4..8f8cdd20ca45 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -115,15 +115,19 @@ struct pt_regs;
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
 #define __bpfcall
 
+#ifdef CONFIG_CALL_PADDING
+#define CFI_OFFSET (CONFIG_FUNCTION_PADDING_CFI+5)
+#else
+#define CFI_OFFSET 5
+#endif
+
 static inline int cfi_get_offset(void)
 {
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
-		return 16;
+		return /* fineibt_prefix_size */ 16;
 	case CFI_KCFI:
-		if (IS_ENABLED(CONFIG_CALL_PADDING))
-			return 16;
-		return 5;
+		return CFI_OFFSET;
 	default:
 		return 0;
 	}
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 9d38ae744a2e..a7294656ad90 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -68,7 +68,7 @@
  * Depending on -fpatchable-function-entry=N,N usage (CONFIG_CALL_PADDING) the
  * CFI symbol layout changes.
  *
- * Without CALL_THUNKS:
+ * Without CALL_PADDING:
  *
  * 	.align	FUNCTION_ALIGNMENT
  * __cfi_##name:
@@ -77,7 +77,7 @@
  * 	.long	__kcfi_typeid_##name
  * name:
  *
- * With CALL_THUNKS:
+ * With CALL_PADDING:
  *
  * 	.align FUNCTION_ALIGNMENT
  * __cfi_##name:
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8ee5ff547357..bd16e9f40d51 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1168,7 +1168,7 @@ void __init_or_module noinline apply_seal_endbr(s32 *start, s32 *end)
 
 		poison_endbr(addr);
 		if (IS_ENABLED(CONFIG_FINEIBT))
-			poison_cfi(addr - 16);
+			poison_cfi(addr - CFI_OFFSET);
 	}
 }
 
@@ -1375,6 +1375,8 @@ extern u8 fineibt_preamble_end[];
 #define fineibt_preamble_ud   0x13
 #define fineibt_preamble_hash 5
 
+#define fineibt_prefix_size (fineibt_preamble_size - ENDBR_INSN_SIZE)
+
 /*
  * <fineibt_caller_start>:
  *  0:   b8 78 56 34 12          mov    $0x12345678, %eax
@@ -1620,7 +1622,7 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
 		 * have determined there are no indirect calls to it and we
 		 * don't need no CFI either.
 		 */
-		if (!is_endbr(addr + 16))
+		if (!is_endbr(addr + CFI_OFFSET))
 			continue;
 
 		hash = decode_preamble_hash(addr, &arity);
@@ -1628,6 +1630,15 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
 			 addr, addr, 5, addr))
 			return -EINVAL;
 
+		/*
+		 * FineIBT relies on being at func-16, so if the preamble is
+		 * actually larger than that, place it the tail end.
+		 *
+		 * NOTE: this is possible with things like DEBUG_CALL_THUNKS
+		 * and DEBUG_FORCE_FUNCTION_ALIGN_64B.
+		 */
+		addr += CFI_OFFSET - fineibt_prefix_size;
+
 		text_poke_early(addr, fineibt_preamble_start, fineibt_preamble_size);
 		WARN_ON(*(u32 *)(addr + fineibt_preamble_hash) != 0x12345678);
 		text_poke_early(addr + fineibt_preamble_hash, &hash, 4);
@@ -1650,10 +1661,10 @@ static void cfi_rewrite_endbr(s32 *start, s32 *end)
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
 
-		if (!exact_endbr(addr + 16))
+		if (!exact_endbr(addr + CFI_OFFSET))
 			continue;
 
-		poison_endbr(addr + 16);
+		poison_endbr(addr + CFI_OFFSET);
 	}
 }
 
@@ -1758,7 +1769,8 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 	if (FINEIBT_WARN(fineibt_preamble_size, 20)			||
 	    FINEIBT_WARN(fineibt_preamble_bhi + fineibt_bhi1_size, 20)	||
 	    FINEIBT_WARN(fineibt_caller_size, 14)			||
-	    FINEIBT_WARN(fineibt_paranoid_size, 20))
+	    FINEIBT_WARN(fineibt_paranoid_size, 20)			||
+	    WARN_ON_ONCE(CFI_OFFSET < fineibt_prefix_size))
 		return;
 
 	if (cfi_mode == CFI_AUTO) {
@@ -1871,6 +1883,11 @@ static void poison_cfi(void *addr)
 	 */
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
+		/*
+		 * FineIBT preamble is at func-16.
+		 */
+		addr += CFI_OFFSET - fineibt_prefix_size;
+
 		/*
 		 * FineIBT prefix should start with an ENDBR.
 		 */
@@ -1909,8 +1926,6 @@ static void poison_cfi(void *addr)
 	}
 }
 
-#define fineibt_prefix_size (fineibt_preamble_size - ENDBR_INSN_SIZE)
-
 /*
  * When regs->ip points to a 0xD6 byte in the FineIBT preamble,
  * return true and fill out target and type.
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index de5083cb1d37..788671a32d8e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -438,17 +438,8 @@ static void emit_kcfi(u8 **pprog, u32 hash)
 
 	EMIT1_off32(0xb8, hash);			/* movl $hash, %eax	*/
 #ifdef CONFIG_CALL_PADDING
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
-	EMIT1(0x90);
+	for (int i = 0; i < CONFIG_FUNCTION_PADDING_CFI; i++)
+		EMIT1(0x90);
 #endif
 	EMIT_ENDBR();
 

