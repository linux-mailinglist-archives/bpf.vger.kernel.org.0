Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4218488411
	for <lists+bpf@lfdr.de>; Sat,  8 Jan 2022 15:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbiAHOpH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Jan 2022 09:45:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234477AbiAHOpG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 8 Jan 2022 09:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641653105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kIMiqV1yAZ33ux+d9eUm0sLEHRYTI8oFyptIaVpcFAs=;
        b=RvvLXHwsh3W2ceuYIYdywmLbEB5kqNzmeoY4ipRsNuDm0q7DurbebSpSVstnA4a1IB9dEP
        WR6vKtfNdAiVrciTbv0ZY+AgbNnRvPvZIjQHKZ+kjUT+Nha4r5SmCnw1SwG6fK4lnv6JZq
        Q15uWyK/pVU9bqiEIFYF1Ku/tfcFQJ4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-y4Z_LjfkPKaeh0Db4tLifw-1; Sat, 08 Jan 2022 09:45:04 -0500
X-MC-Unique: y4Z_LjfkPKaeh0Db4tLifw-1
Received: by mail-wm1-f72.google.com with SMTP id c188-20020a1c35c5000000b00346a2160ea8so1457604wma.9
        for <bpf@vger.kernel.org>; Sat, 08 Jan 2022 06:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kIMiqV1yAZ33ux+d9eUm0sLEHRYTI8oFyptIaVpcFAs=;
        b=4HAsmB64OTAiUfqYx3t7YaBGcQEMbANjPe0v34rbH7QbkHj1nFfJVfxiLhANYXRHvd
         HX8aFSF/D/k7PzEsUAPyOgaa2B4R06ykglyTkZYUDqFuw/Kh/3Imr/vosU8W12XuVoLZ
         tVvIgtxXxl8Yq4xP2X4woPxJunH1b+59FMHu2w4Jy6o90UgEGLPCySE5tsM3VRBsYlcP
         11w+u2YRgAQ5TR36I6wFCaBCFb7MzzGcbMvDP1gZxw3kk22xzPhm71HJmMygSFZPa8qI
         3k0HPLZFSZvpJqK2dsrEENQfGYqHxvweaM6zAuxqHeiHfbakxwn39OVZrlDrHq2mdMpP
         XGzw==
X-Gm-Message-State: AOAM530EKZcLYEH7BmYtqgVj95mEt1AEW/kvMJTyKBbXMIAfudTYAQr0
        W2QnFY8/zxBGaweCZ7J1hbBd+b1IxPARXtdBvjVqIX7r4IygGEaIRnuVCt6G4f0yphSoEAViKAl
        HVJJrO27R+uED
X-Received: by 2002:adf:eb12:: with SMTP id s18mr27244231wrn.717.1641653103667;
        Sat, 08 Jan 2022 06:45:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzqVdn2B+eHWvHfhUeSYTREvqIx8GQcMycr6Wfy0rrIRZGR8GA+GeMmRBxaNIkI/8Lk4HaPg==
X-Received: by 2002:adf:eb12:: with SMTP id s18mr27244221wrn.717.1641653103485;
        Sat, 08 Jan 2022 06:45:03 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id az1sm1766758wrb.104.2022.01.08.06.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 06:45:03 -0800 (PST)
Date:   Sat, 8 Jan 2022 15:45:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        ykaliuta@redhat.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        song@kernel.org, johan.almbladh@anyfinetworks.com,
        Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/13] powerpc/bpf: Update ldimm64 instructions during
 extra pass
Message-ID: <YdmjbccR1LOJjaEv@krava>
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
 <7cc162af77ba918eb3ecd26ec9e7824bc44b1fae.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cc162af77ba918eb3ecd26ec9e7824bc44b1fae.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 06, 2022 at 05:15:07PM +0530, Naveen N. Rao wrote:
> These instructions are updated after the initial JIT, so redo codegen
> during the extra pass. Rename bpf_jit_fixup_subprog_calls() to clarify
> that this is more than just subprog calls.
> 
> Fixes: 69c087ba6225b5 ("bpf: Add bpf_for_each_map_elem() helper")
> Cc: stable@vger.kernel.org # v5.15
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Tested-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  arch/powerpc/net/bpf_jit_comp.c   | 29 +++++++++++++++++++++++------
>  arch/powerpc/net/bpf_jit_comp32.c |  6 ++++++
>  arch/powerpc/net/bpf_jit_comp64.c |  7 ++++++-
>  3 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index d6ffdd0f2309d0..56dd1f4e3e4447 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -23,15 +23,15 @@ static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
>  	memset32(area, BREAKPOINT_INSTRUCTION, size / 4);
>  }
>  
> -/* Fix the branch target addresses for subprog calls */
> -static int bpf_jit_fixup_subprog_calls(struct bpf_prog *fp, u32 *image,
> -				       struct codegen_context *ctx, u32 *addrs)
> +/* Fix updated addresses (for subprog calls, ldimm64, et al) during extra pass */
> +static int bpf_jit_fixup_addresses(struct bpf_prog *fp, u32 *image,
> +				   struct codegen_context *ctx, u32 *addrs)
>  {
>  	const struct bpf_insn *insn = fp->insnsi;
>  	bool func_addr_fixed;
>  	u64 func_addr;
>  	u32 tmp_idx;
> -	int i, ret;
> +	int i, j, ret;
>  
>  	for (i = 0; i < fp->len; i++) {
>  		/*
> @@ -66,6 +66,23 @@ static int bpf_jit_fixup_subprog_calls(struct bpf_prog *fp, u32 *image,
>  			 * of the JITed sequence remains unchanged.
>  			 */
>  			ctx->idx = tmp_idx;
> +		} else if (insn[i].code == (BPF_LD | BPF_IMM | BPF_DW)) {
> +			tmp_idx = ctx->idx;
> +			ctx->idx = addrs[i] / 4;
> +#ifdef CONFIG_PPC32
> +			PPC_LI32(ctx->b2p[insn[i].dst_reg] - 1, (u32)insn[i + 1].imm);
> +			PPC_LI32(ctx->b2p[insn[i].dst_reg], (u32)insn[i].imm);
> +			for (j = ctx->idx - addrs[i] / 4; j < 4; j++)
> +				EMIT(PPC_RAW_NOP());
> +#else
> +			func_addr = ((u64)(u32)insn[i].imm) | (((u64)(u32)insn[i + 1].imm) << 32);
> +			PPC_LI64(b2p[insn[i].dst_reg], func_addr);
> +			/* overwrite rest with nops */
> +			for (j = ctx->idx - addrs[i] / 4; j < 5; j++)
> +				EMIT(PPC_RAW_NOP());
> +#endif
> +			ctx->idx = tmp_idx;
> +			i++;
>  		}
>  	}
>  
> @@ -200,13 +217,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  		/*
>  		 * Do not touch the prologue and epilogue as they will remain
>  		 * unchanged. Only fix the branch target address for subprog
> -		 * calls in the body.
> +		 * calls in the body, and ldimm64 instructions.
>  		 *
>  		 * This does not change the offsets and lengths of the subprog
>  		 * call instruction sequences and hence, the size of the JITed
>  		 * image as well.
>  		 */
> -		bpf_jit_fixup_subprog_calls(fp, code_base, &cgctx, addrs);
> +		bpf_jit_fixup_addresses(fp, code_base, &cgctx, addrs);
>  
>  		/* There is no need to perform the usual passes. */
>  		goto skip_codegen_passes;
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index 997a47fa615b30..2258d3886d02ec 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -293,6 +293,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>  		bool func_addr_fixed;
>  		u64 func_addr;
>  		u32 true_cond;
> +		u32 tmp_idx;
> +		int j;
>  
>  		/*
>  		 * addrs[] maps a BPF bytecode address into a real offset from
> @@ -908,8 +910,12 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>  		 * 16 byte instruction that uses two 'struct bpf_insn'
>  		 */
>  		case BPF_LD | BPF_IMM | BPF_DW: /* dst = (u64) imm */
> +			tmp_idx = ctx->idx;
>  			PPC_LI32(dst_reg_h, (u32)insn[i + 1].imm);
>  			PPC_LI32(dst_reg, (u32)insn[i].imm);
> +			/* padding to allow full 4 instructions for later patching */
> +			for (j = ctx->idx - tmp_idx; j < 4; j++)
> +				EMIT(PPC_RAW_NOP());
>  			/* Adjust for two bpf instructions */
>  			addrs[++i] = ctx->idx * 4;
>  			break;
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 472d4a551945dd..3d018ecc475b2b 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -319,6 +319,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>  		u64 imm64;
>  		u32 true_cond;
>  		u32 tmp_idx;
> +		int j;
>  
>  		/*
>  		 * addrs[] maps a BPF bytecode address into a real offset from
> @@ -848,9 +849,13 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>  		case BPF_LD | BPF_IMM | BPF_DW: /* dst = (u64) imm */
>  			imm64 = ((u64)(u32) insn[i].imm) |
>  				    (((u64)(u32) insn[i+1].imm) << 32);
> +			tmp_idx = ctx->idx;
> +			PPC_LI64(dst_reg, imm64);
> +			/* padding to allow full 5 instructions for later patching */
> +			for (j = ctx->idx - tmp_idx; j < 5; j++)
> +				EMIT(PPC_RAW_NOP());
>  			/* Adjust for two bpf instructions */
>  			addrs[++i] = ctx->idx * 4;
> -			PPC_LI64(dst_reg, imm64);
>  			break;
>  
>  		/*
> -- 
> 2.34.1
> 

