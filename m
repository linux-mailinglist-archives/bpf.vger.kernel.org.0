Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5483A1062
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 12:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhFIJop (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 05:44:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5942 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233898AbhFIJop (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Jun 2021 05:44:45 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G0MbZ04cdzB11B;
        Wed,  9 Jun 2021 11:42:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZeQI-HI4y8Zp; Wed,  9 Jun 2021 11:42:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G0MbX2t47zBF5X;
        Wed,  9 Jun 2021 11:42:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 49A308B7D7;
        Wed,  9 Jun 2021 11:42:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0i0ijwN2cyBI; Wed,  9 Jun 2021 11:42:48 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E65438B7C3;
        Wed,  9 Jun 2021 11:42:47 +0200 (CEST)
Subject: Re: [PATCH] powerpc/bpf: Use bctrl for making function calls
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org
References: <20210609090024.1446800-1-naveen.n.rao@linux.vnet.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4c371bd1-1fcf-54c1-d0a2-836d40887893@csgroup.eu>
Date:   Wed, 9 Jun 2021 11:42:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609090024.1446800-1-naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Le 09/06/2021 à 11:00, Naveen N. Rao a écrit :
> blrl corrupts the link stack. Instead use bctrl when making function
> calls from BPF programs.

What's the link stack ? Is it the PPC64 branch predictor stack ?

> 
> Reported-by: Anton Blanchard <anton@ozlabs.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/ppc-opcode.h |  1 +
>   arch/powerpc/net/bpf_jit_comp32.c     |  4 ++--
>   arch/powerpc/net/bpf_jit_comp64.c     | 12 ++++++------
>   3 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index ac41776661e963..1abacb8417d562 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -451,6 +451,7 @@
>   #define PPC_RAW_MTLR(r)			(0x7c0803a6 | ___PPC_RT(r))
>   #define PPC_RAW_MFLR(t)			(PPC_INST_MFLR | ___PPC_RT(t))
>   #define PPC_RAW_BCTR()			(PPC_INST_BCTR)
> +#define PPC_RAW_BCTRL()			(PPC_INST_BCTRL)

Can you use the numeric value instead of the PPC_INST_BCTRL, to avoid conflict with 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/4ca2bfdca2f47a293d05f61eb3c4e487ee170f1f.1621506159.git.christophe.leroy@csgroup.eu/

>   #define PPC_RAW_MTCTR(r)		(PPC_INST_MTCTR | ___PPC_RT(r))
>   #define PPC_RAW_ADDI(d, a, i)		(PPC_INST_ADDI | ___PPC_RT(d) | ___PPC_RA(a) | IMM_L(i))
>   #define PPC_RAW_LI(r, i)		PPC_RAW_ADDI(r, 0, i)
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index bbb16099e8c7fa..40ab50bea61c02 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -195,8 +195,8 @@ void bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 fun
>   		/* Load function address into r0 */
>   		EMIT(PPC_RAW_LIS(__REG_R0, IMM_H(func)));
>   		EMIT(PPC_RAW_ORI(__REG_R0, __REG_R0, IMM_L(func)));
> -		EMIT(PPC_RAW_MTLR(__REG_R0));
> -		EMIT(PPC_RAW_BLRL());
> +		EMIT(PPC_RAW_MTCTR(__REG_R0));
> +		EMIT(PPC_RAW_BCTRL());
>   	}
>   }
>   
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 57a8c1153851a0..ae9a6532be6ad4 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -153,8 +153,8 @@ static void bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx,
>   	PPC_LI64(b2p[TMP_REG_2], func);
>   	/* Load actual entry point from function descriptor */
>   	PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_2], 0);
> -	/* ... and move it to LR */
> -	EMIT(PPC_RAW_MTLR(b2p[TMP_REG_1]));
> +	/* ... and move it to CTR */
> +	EMIT(PPC_RAW_MTCTR(b2p[TMP_REG_1]));
>   	/*
>   	 * Load TOC from function descriptor at offset 8.
>   	 * We can clobber r2 since we get called through a
> @@ -165,9 +165,9 @@ static void bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx,
>   #else
>   	/* We can clobber r12 */
>   	PPC_FUNC_ADDR(12, func);
> -	EMIT(PPC_RAW_MTLR(12));
> +	EMIT(PPC_RAW_MTCTR(12));
>   #endif
> -	EMIT(PPC_RAW_BLRL());
> +	EMIT(PPC_RAW_BCTRL());
>   }
>   
>   void bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 func)
> @@ -202,8 +202,8 @@ void bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 fun
>   	PPC_BPF_LL(12, 12, 0);
>   #endif
>   
> -	EMIT(PPC_RAW_MTLR(12));
> -	EMIT(PPC_RAW_BLRL());
> +	EMIT(PPC_RAW_MTCTR(12));
> +	EMIT(PPC_RAW_BCTRL());
>   }
>   
>   static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
> 
> base-commit: 112f47a1484ddca610b70cbe4a99f0d0f1701daf
> 
