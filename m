Return-Path: <bpf+bounces-78073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FD2CFCF62
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 10:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2541330807E7
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A352FF664;
	Wed,  7 Jan 2026 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GsKsK5JM"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD5D2FBE0F;
	Wed,  7 Jan 2026 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778604; cv=none; b=N/lXWsdBH8qRnWz+gCj0PYZlzX0CaGRqpkL4PB5HirEooBtbO7QVy2Xm4YrUE8paYQub0E0YTTDPUcCXEN5qqKd6uBELVa2qwIWpA06X3njgT0eEE8rmr97v9XghM/QT9SUgBgTea6nDhSojhiX3QyrSdrFdQNATKzaivHuHUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778604; c=relaxed/simple;
	bh=svDT2qlQ+nuWIWsXPFWbSi3aHQZNYfi3cE0fVRM0pqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4FLKOdj8LMHnvKxN4PV8lPQ+t9/jFTk/XiQyaYbzMr90nnCzIf2BMbYlEn2QnObqhdATjjXabquXiBnycqSVxJ3WZgbqUGV+7MJtXf+aIMxv7MgRtrh0mzSmyAiY1beu1ZlIBV1zT+Ep4sImMzo/+fmD3MuFXaedzGI9MvOuRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GsKsK5JM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bir03K+jFt6wyT0uPIWE3+5fDCMcjUnb3HcoUdCUmTE=; b=GsKsK5JMSB4GGAYz7je6MPvI7k
	DA46rucM7UlgvJ5AZ16XPFrcBvW0FIsY+fpxcR0IM42uct2w3sGGwhBb4Vyw8xbAFUmKi4Tcsmd0/
	gAUuR+A9fNdQPyCupigWlAIYUV15YfnRWh8TVy50hMAZm5E0IvhfHMd7Q2BACfruk0E9Mmv1+/l9F
	SdziPw3y0YCrSBrCCi/aG8+iB+lHSBksucMERzJbUJyPXSDr9fYArqQS+Kxp5Wz7y5poNunDZJuRx
	Wbjof+qyH2BrjdWn6EgUQzt6v3zdV4GWEiL1iWlcYfR+Uk0DL+z/9kSzkqBm1YteqWEb2HQDZl/w1
	AI+ysBkw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdPy4-0000000B4kq-3ert;
	Wed, 07 Jan 2026 09:36:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9522930056B; Wed, 07 Jan 2026 10:36:39 +0100 (CET)
Date: Wed, 7 Jan 2026 10:36:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rustam Kovhaev <rkovhaev@gmail.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: kernel crashes in BPF JIT code with kCFI and clang on x86
Message-ID: <20260107093639.GC3707891@noisy.programming.kicks-ass.net>
References: <20251223034332.GA2008178@nuc10>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223034332.GA2008178@nuc10>

On Mon, Dec 22, 2025 at 07:43:32PM -0800, Rustam Kovhaev wrote:

> Here is the patch that fixed it for me:
> 
> diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
> index c40b9ebc1fb4..48f232d4b9d6 100644
> --- a/arch/x86/include/asm/cfi.h
> +++ b/arch/x86/include/asm/cfi.h
> @@ -121,6 +121,8 @@ static inline int cfi_get_offset(void)
>         case CFI_FINEIBT:
>                 return 16;
>         case CFI_KCFI:
> +               if (IS_ENABLED(CONFIG_CC_IS_CLANG) && IS_ENABLED(CONFIG_CALL_PADDING))
> +                       return CONFIG_FUNCTION_PADDING_CFI + 5;
>                 if (IS_ENABLED(CONFIG_CALL_PADDING))
>                         return 16;
>                 return 5;
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index b0bac2a66eff..f8706d5b155f 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -435,20 +435,16 @@ static void emit_fineibt(u8 **pprog, u8 *ip, u32 hash, int arity)
>  static void emit_kcfi(u8 **pprog, u32 hash)
>  {
>         u8 *prog = *pprog;
> +       size_t nop_len = 11;
> +       if (IS_ENABLED(CONFIG_CC_IS_CLANG) && IS_ENABLED(CONFIG_CALL_PADDING))
> +               nop_len = 55;
>  
>         EMIT1_off32(0xb8, hash);                        /* movl $hash, %eax     */
>  #ifdef CONFIG_CALL_PADDING
> -       EMIT1(0x90);
> -       EMIT1(0x90);
> -       EMIT1(0x90);
> -       EMIT1(0x90);
> -       EMIT1(0x90);
> -       EMIT1(0x90);
> -       EMIT1(0x90);
> -       EMIT1(0x90);
> -       EMIT1(0x90);
> -       EMIT1(0x90);
> -       EMIT1(0x90);
> +       while( nop_len > 0) {
> +               EMIT1(0x90);
> +               nop_len--;
> +       }
>  #endif
>         EMIT_ENDBR();
> 
> After switching to clang kbuild always generates these huge paddings in my kernel config:
> rusty@nuc10:~/code/kbuild_rust$ grep -e IBT -e PADDING .config
> CONFIG_CC_HAS_IBT=y
> CONFIG_X86_KERNEL_IBT=y
> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
> CONFIG_CC_HAS_ENTRY_PADDING=y
> CONFIG_FUNCTION_PADDING_CFI=59
> CONFIG_FUNCTION_PADDING_BYTES=59
> CONFIG_CALL_PADDING=y
> CONFIG_FINEIBT=y

Oh gawd, you have FUNCTION_ALIGNMENT_64B. Yeah, I suppose that wasn't
tested very well.

Let me go check all that code.

