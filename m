Return-Path: <bpf+bounces-63707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD562B0A1F3
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 13:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510391894D16
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 11:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88502D9498;
	Fri, 18 Jul 2025 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFwPSbbk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4A3221F04;
	Fri, 18 Jul 2025 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838401; cv=none; b=oUO4gwPq94zceEdH+3BoI1ZNlu+h7Hq81S1UNOEDxZx5s7tdQPayjXsoCaPZCgiTEYkKhCRD1POaqVZw4qF7ysU8bUdeM1dg9rk+tkVTZ5qVJnYqsR6zpbs/tknhgzSc9z1J/OhqPCPjyDNL984xcD/HWl2pBiEuYOeCt1SZ7b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838401; c=relaxed/simple;
	bh=92arq/Wo1/KhOpoRdEXUKIc1y6xuILihx9THlijFiR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjVq/qbyBJH2d4hikvH2BzQDi89E4Xcwz0ZTFoky4OJZgw16320d+xBZ+VtnY3sIDIzePfoqqOvQsGPGCBmskCoVw7J2wPtkXWgRQCQ+pnmNUXgQQW6whr84oeU/n5DLGFHbb2vND/yyK+wVfhSTZ7PQAME0i1dfgHaqd86WJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFwPSbbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A11AC4CEEB;
	Fri, 18 Jul 2025 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752838400;
	bh=92arq/Wo1/KhOpoRdEXUKIc1y6xuILihx9THlijFiR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFwPSbbkzFb40PzhDQ/wJAwKW3YmtkzoutTGTkV/zX1+GLT4rYBnnKNNYzGDui87P
	 Yi7IOtoXvaRhL5fa1rWumqqxtuAhQae5fbYevDcyF+Lxo0ccUSuMoguYPO/egRL/Qm
	 EQeCo/h2G3/kiEcq4oJQnk+8G+3ev4ZIRyyke8n1bh/8qHk9kyldId2MUKh5ePVkjP
	 lcCkEdu1CxQu9uFDq34mw7pvxII3CRaE2y464pDItUdJhiCri28vwejHJU0WqreC7G
	 7BXZuGgFrCPbtERV8zuJ/vRXT1P1j0zzRzJhZ+1NFvXe3udHk/iOi+ANqxnMqWa2ud
	 2yZwCecPVUMaw==
Date: Fri, 18 Jul 2025 12:33:15 +0100
From: Will Deacon <will@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxwell Bland <mbland@motorola.com>, Dao Huang <huangdao1@oppo.com>
Subject: Re: [PATCH bpf-next v10 1/3] cfi: add C CFI type macro
Message-ID: <aHow-yVsJCO2AJsn@willie-the-truck>
References: <20250715225733.3921432-5-samitolvanen@google.com>
 <20250715225733.3921432-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715225733.3921432-6-samitolvanen@google.com>

On Tue, Jul 15, 2025 at 10:57:35PM +0000, Sami Tolvanen wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> Currently x86 and riscv open-code 4 instances of the same logic to
> define a u32 variable with the KCFI typeid of a given function.
> 
> Replace the duplicate logic with a common macro.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Co-developed-by: Maxwell Bland <mbland@motorola.com>
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Tested-by: Dao Huang <huangdao1@oppo.com>
> ---
>  arch/riscv/kernel/cfi.c       | 35 +++--------------------------------
>  arch/x86/kernel/alternative.c | 31 +++----------------------------
>  include/linux/cfi_types.h     | 23 +++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 60 deletions(-)

[...]

> diff --git a/include/linux/cfi_types.h b/include/linux/cfi_types.h
> index 6b8713675765..e5567c0fd0b3 100644
> --- a/include/linux/cfi_types.h
> +++ b/include/linux/cfi_types.h
> @@ -41,5 +41,28 @@
>  	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
>  #endif
>  
> +#else /* __ASSEMBLY__ */
> +
> +#ifdef CONFIG_CFI_CLANG
> +#define DEFINE_CFI_TYPE(name, func)						\
> +	/*									\
> +	 * Force a reference to the function so the compiler generates		\
> +	 * __kcfi_typeid_<func>.						\
> +	 */									\
> +	__ADDRESSABLE(func);							\
> +	/* u32 name __ro_after_init = __kcfi_typeid_<func> */			\
> +	extern u32 name;							\
> +	asm (									\
> +	"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"	\
> +	"	.type	" #name ",@object				\n"	\
> +	"	.globl	" #name "					\n"	\
> +	"	.p2align	2, 0x0					\n"	\
> +	#name ":							\n"	\
> +	"	.4byte	__kcfi_typeid_" #func "				\n"	\
> +	"	.size	" #name ", 4					\n"	\
> +	"	.popsection						\n"	\
> +	);
> +#endif

This looks good to me. I was initially a bit worried about the portability
of the '.4byte' directive, but it seems that cfi_types.h is already using
that for the __CFI_TYPE() macro so I'm assuming it's not an issue.

In which case:

Acked-by: Will Deacon <will@kernel.org>

Thanks for cleaning it up.

Will

