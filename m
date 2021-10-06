Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B7A42373C
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 06:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhJFExQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 00:53:16 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:60947 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhJFExP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 00:53:15 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HPMVL45x3z9sVL;
        Wed,  6 Oct 2021 06:51:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N5MaXjpcEhOH; Wed,  6 Oct 2021 06:51:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HPMVL35Ysz9sVK;
        Wed,  6 Oct 2021 06:51:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 51AF78B765;
        Wed,  6 Oct 2021 06:51:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qJX007NXBtpC; Wed,  6 Oct 2021 06:51:22 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.229])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6EDD18B763;
        Wed,  6 Oct 2021 06:51:21 +0200 (CEST)
Subject: Re: [PATCH v2 02/10] powerpc/bpf: Validate branch ranges
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
 <71d33a6b7603ec1013c9734dd8bdd4ff5e929142.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a391e669-ac55-8217-d12f-4b082f8cd89e@csgroup.eu>
Date:   Wed, 6 Oct 2021 06:51:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <71d33a6b7603ec1013c9734dd8bdd4ff5e929142.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Le 05/10/2021 à 22:25, Naveen N. Rao a écrit :
> Add checks to ensure that we never emit branch instructions with
> truncated branch offsets.
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> Tested-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/net/bpf_jit.h        | 26 ++++++++++++++++++++------
>   arch/powerpc/net/bpf_jit_comp.c   |  6 +++++-
>   arch/powerpc/net/bpf_jit_comp32.c |  8 ++++++--
>   arch/powerpc/net/bpf_jit_comp64.c |  8 ++++++--
>   4 files changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 935ea95b66359e..7e9b978b768ed9 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -24,16 +24,30 @@
>   #define EMIT(instr)		PLANT_INSTR(image, ctx->idx, instr)
>   
>   /* Long jump; (unconditional 'branch') */
> -#define PPC_JMP(dest)		EMIT(PPC_INST_BRANCH |			      \
> -				     (((dest) - (ctx->idx * 4)) & 0x03fffffc))
> +#define PPC_JMP(dest)							      \
> +	do {								      \
> +		long offset = (long)(dest) - (ctx->idx * 4);		      \
> +		if (!is_offset_in_branch_range(offset)) {		      \
> +			pr_err_ratelimited("Branch offset 0x%lx (@%u) out of range\n", offset, ctx->idx);			\
> +			return -ERANGE;					      \
> +		}							      \
> +		EMIT(PPC_INST_BRANCH | (offset & 0x03fffffc));		      \
> +	} while (0)
> +
>   /* blr; (unconditional 'branch' with link) to absolute address */
>   #define PPC_BL_ABS(dest)	EMIT(PPC_INST_BL |			      \
>   				     (((dest) - (unsigned long)(image + ctx->idx)) & 0x03fffffc))
>   /* "cond" here covers BO:BI fields. */
> -#define PPC_BCC_SHORT(cond, dest)	EMIT(PPC_INST_BRANCH_COND |	      \
> -					     (((cond) & 0x3ff) << 16) |	      \
> -					     (((dest) - (ctx->idx * 4)) &     \
> -					      0xfffc))
> +#define PPC_BCC_SHORT(cond, dest)					      \
> +	do {								      \
> +		long offset = (long)(dest) - (ctx->idx * 4);		      \
> +		if (!is_offset_in_cond_branch_range(offset)) {		      \
> +			pr_err_ratelimited("Conditional branch offset 0x%lx (@%u) out of range\n", offset, ctx->idx);		\
> +			return -ERANGE;					      \
> +		}							      \
> +		EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | (offset & 0xfffc));					\
> +	} while (0)
> +
>   /* Sign-extended 32-bit immediate load */
>   #define PPC_LI32(d, i)		do {					      \
>   		if ((int)(uintptr_t)(i) >= -32768 &&			      \
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 53aefee3fe70be..fcbf7a917c566e 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -210,7 +210,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>   		/* Now build the prologue, body code & epilogue for real. */
>   		cgctx.idx = 0;
>   		bpf_jit_build_prologue(code_base, &cgctx);
> -		bpf_jit_build_body(fp, code_base, &cgctx, addrs, extra_pass);
> +		if (bpf_jit_build_body(fp, code_base, &cgctx, addrs, extra_pass)) {
> +			bpf_jit_binary_free(bpf_hdr);
> +			fp = org_fp;
> +			goto out_addrs;
> +		}
>   		bpf_jit_build_epilogue(code_base, &cgctx);
>   
>   		if (bpf_jit_enable > 1)
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index beb12cbc8c2994..a74d52204f8da2 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -200,7 +200,7 @@ void bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 fun
>   	}
>   }
>   
> -static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
> +static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
>   {
>   	/*
>   	 * By now, the eBPF program has already setup parameters in r3-r6
> @@ -261,7 +261,9 @@ static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32
>   	bpf_jit_emit_common_epilogue(image, ctx);
>   
>   	EMIT(PPC_RAW_BCTR());
> +
>   	/* out: */
> +	return 0;
>   }
>   
>   /* Assemble the body code between the prologue & epilogue */
> @@ -1090,7 +1092,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   		 */
>   		case BPF_JMP | BPF_TAIL_CALL:
>   			ctx->seen |= SEEN_TAILCALL;
> -			bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
> +			ret = bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
> +			if (ret < 0)
> +				return ret;
>   			break;
>   
>   		default:
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index b87a63dba9c8fb..f06c62089b1457 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -206,7 +206,7 @@ void bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 fun
>   	EMIT(PPC_RAW_BCTRL());
>   }
>   
> -static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
> +static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
>   {
>   	/*
>   	 * By now, the eBPF program has already setup parameters in r3, r4 and r5
> @@ -267,7 +267,9 @@ static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32
>   	bpf_jit_emit_common_epilogue(image, ctx);
>   
>   	EMIT(PPC_RAW_BCTR());
> +
>   	/* out: */
> +	return 0;
>   }
>   
>   /* Assemble the body code between the prologue & epilogue */
> @@ -993,7 +995,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   		 */
>   		case BPF_JMP | BPF_TAIL_CALL:
>   			ctx->seen |= SEEN_TAILCALL;
> -			bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
> +			ret = bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
> +			if (ret < 0)
> +				return ret;
>   			break;
>   
>   		default:
> 
