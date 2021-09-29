Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C5941C3A8
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 13:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245754AbhI2Lqg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 07:46:36 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:42251 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244946AbhI2Lqg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 07:46:36 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HKF0k4WFTz9sYm;
        Wed, 29 Sep 2021 13:44:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L3SpCgnFaML8; Wed, 29 Sep 2021 13:44:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HKF0k3WXZz9sYh;
        Wed, 29 Sep 2021 13:44:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6133D8B770;
        Wed, 29 Sep 2021 13:44:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id U6I-BUaAGv78; Wed, 29 Sep 2021 13:44:54 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 32DF58B763;
        Wed, 29 Sep 2021 13:44:54 +0200 (CEST)
Subject: Re: [PATCH v4 7/8] bpf ppc32: Add BPF_PROBE_MEM support for JIT
To:     Hari Bathini <hbathini@linux.ibm.com>, naveen.n.rao@linux.ibm.com,
        mpe@ellerman.id.au, ast@kernel.org, daniel@iogearbox.net
Cc:     paulus@samba.org, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20210929111855.50254-1-hbathini@linux.ibm.com>
 <20210929111855.50254-8-hbathini@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <989a7a99-c0e4-b367-fc24-eb53b5b0a353@csgroup.eu>
Date:   Wed, 29 Sep 2021 13:44:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210929111855.50254-8-hbathini@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Le 29/09/2021 à 13:18, Hari Bathini a écrit :
> BPF load instruction with BPF_PROBE_MEM mode can cause a fault
> inside kernel. Append exception table for such instructions
> within BPF program.
> 
> Unlike other archs which uses extable 'fixup' field to pass dest_reg
> and nip, BPF exception table on PowerPC follows the generic PowerPC
> exception table design, where it populates both fixup and extable
> sections within BPF program. fixup section contains 3 instructions,
> first 2 instructions clear dest_reg (lower & higher 32-bit registers)
> and last instruction jumps to next instruction in the BPF code.
> extable 'insn' field contains relative offset of the instruction and
> 'fixup' field contains relative offset of the fixup entry. Example
> layout of BPF program with extable present:
> 
>               +------------------+
>               |                  |
>               |                  |
>     0x4020 -->| lwz   r28,4(r4)  |
>               |                  |
>               |                  |
>     0x40ac -->| lwz  r3,0(r24)   |
>               | lwz  r4,4(r24)   |
>               |                  |
>               |                  |
>               |------------------|
>     0x4278 -->| li  r28,0        |  \
>               | li  r27,0        |  | fixup entry
>               | b   0x4024       |  /
>     0x4284 -->| li  r4,0         |
>               | li  r3,0         |
>               | b   0x40b4       |
>               |------------------|
>     0x4290 -->| insn=0xfffffd90  |  \ extable entry
>               | fixup=0xffffffe4 |  /
>     0x4298 -->| insn=0xfffffe14  |
>               | fixup=0xffffffe8 |
>               +------------------+
> 
>     (Addresses shown here are chosen random, not real)
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
> 
> Changes in v4:
> * Dropped explicit fallthrough statement for empty switch cases.
> 
> 
>   arch/powerpc/net/bpf_jit.h        |  4 ++++
>   arch/powerpc/net/bpf_jit_comp.c   |  2 ++
>   arch/powerpc/net/bpf_jit_comp32.c | 30 ++++++++++++++++++++++++++++++
>   3 files changed, 36 insertions(+)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 561689a2abdf..800734056200 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -144,7 +144,11 @@ struct codegen_context {
>   	unsigned int exentry_idx;
>   };
>   
> +#ifdef CONFIG_PPC32
> +#define BPF_FIXUP_LEN	3 /* Three instructions => 12 bytes */
> +#else
>   #define BPF_FIXUP_LEN	2 /* Two instructions => 8 bytes */
> +#endif
>   
>   static inline void bpf_flush_icache(void *start, void *end)
>   {
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index f02457c6b54f..1a0041997050 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -297,6 +297,8 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, int pass, struct code
>   		(ctx->exentry_idx * BPF_FIXUP_LEN * 4);
>   
>   	fixup[0] = PPC_RAW_LI(dst_reg, 0);
> +	if (IS_ENABLED(CONFIG_PPC32))
> +		fixup[1] = PPC_RAW_LI(dst_reg - 1, 0); /* clear higher 32-bit register too */
>   
>   	fixup[BPF_FIXUP_LEN - 1] =
>   		PPC_RAW_BRANCH((long)(pc + jmp_off) - (long)&fixup[BPF_FIXUP_LEN - 1]);
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index c04291517a7e..6ee13a09c70d 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -811,9 +811,13 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   		 * BPF_LDX
>   		 */
>   		case BPF_LDX | BPF_MEM | BPF_B: /* dst = *(u8 *)(ul) (src + off) */
> +		case BPF_LDX | BPF_PROBE_MEM | BPF_B:
>   		case BPF_LDX | BPF_MEM | BPF_H: /* dst = *(u16 *)(ul) (src + off) */
> +		case BPF_LDX | BPF_PROBE_MEM | BPF_H:
>   		case BPF_LDX | BPF_MEM | BPF_W: /* dst = *(u32 *)(ul) (src + off) */
> +		case BPF_LDX | BPF_PROBE_MEM | BPF_W:
>   		case BPF_LDX | BPF_MEM | BPF_DW: /* dst = *(u64 *)(ul) (src + off) */
> +		case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
>   			switch (size) {
>   			case BPF_B:
>   				EMIT(PPC_RAW_LBZ(dst_reg, src_reg, off));
> @@ -832,6 +836,32 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   
>   			if (size != BPF_DW && !fp->aux->verifier_zext)
>   				EMIT(PPC_RAW_LI(dst_reg_h, 0));
> +
> +			if (BPF_MODE(code) == BPF_PROBE_MEM) {
> +				int insn_idx = ctx->idx - 1;
> +				int jmp_off = 4;
> +
> +				/*
> +				 * In case of BPF_DW, two lwz instructions are emitted, one
> +				 * for higher 32-bit and another for lower 32-bit. So, set
> +				 * ex->insn to the first of the two and jump over both
> +				 * instructions in fixup.
> +				 *
> +				 * Similarly, with !verifier_zext, two instructions are
> +				 * emitted for BPF_B/H/W case. So, set ex->insn to the
> +				 * instruction that could fault and skip over both
> +				 * instructions.
> +				 */
> +				if (size == BPF_DW || !fp->aux->verifier_zext) {
> +					insn_idx -= 1;
> +					jmp_off += 4;
> +				}
> +
> +				ret = bpf_add_extable_entry(fp, image, pass, ctx, insn_idx,
> +							    jmp_off, dst_reg);
> +				if (ret)
> +					return ret;
> +			}
>   			break;
>   
>   		/*
> 
