Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A186423746
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 06:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhJFE5b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 00:57:31 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:59567 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhJFE5a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 00:57:30 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HPMbG03prz9sVL;
        Wed,  6 Oct 2021 06:55:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tDM3FMpnLmzo; Wed,  6 Oct 2021 06:55:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HPMbF6MC4z9sVK;
        Wed,  6 Oct 2021 06:55:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C2DA78B765;
        Wed,  6 Oct 2021 06:55:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MB898tySZN-z; Wed,  6 Oct 2021 06:55:37 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.229])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F202F8B763;
        Wed,  6 Oct 2021 06:55:36 +0200 (CEST)
Subject: Re: [PATCH v2 04/10] powerpc/bpf: Fix BPF_SUB when imm == 0x80000000
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
 <fc4b1276eb10761fd7ce0814c8dd089da2815251.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <90494652-7551-7ecb-e44d-a2adbb6a1afe@csgroup.eu>
Date:   Wed, 6 Oct 2021 06:55:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fc4b1276eb10761fd7ce0814c8dd089da2815251.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Le 05/10/2021 à 22:25, Naveen N. Rao a écrit :
> We aren't handling subtraction involving an immediate value of
> 0x80000000 properly. Fix the same.
> 
> Fixes: 156d0e290e969c ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Changelog:
> - Split up BPF_ADD and BPF_SUB cases per Christophe's comments
> 
>   arch/powerpc/net/bpf_jit_comp64.c | 27 +++++++++++++++++----------
>   1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index d67f6d62e2e1ff..6626e6c17d4ed2 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -330,18 +330,25 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   			EMIT(PPC_RAW_SUB(dst_reg, dst_reg, src_reg));
>   			goto bpf_alu32_trunc;
>   		case BPF_ALU | BPF_ADD | BPF_K: /* (u32) dst += (u32) imm */
> -		case BPF_ALU | BPF_SUB | BPF_K: /* (u32) dst -= (u32) imm */
>   		case BPF_ALU64 | BPF_ADD | BPF_K: /* dst += imm */
> +			if (!imm) {
> +				goto bpf_alu32_trunc;
> +			} else if (imm >= -32768 && imm < 32768) {
> +				EMIT(PPC_RAW_ADDI(dst_reg, dst_reg, IMM_L(imm)));
> +			} else {
> +				PPC_LI32(b2p[TMP_REG_1], imm);
> +				EMIT(PPC_RAW_ADD(dst_reg, dst_reg, b2p[TMP_REG_1]));
> +			}
> +			goto bpf_alu32_trunc;
> +		case BPF_ALU | BPF_SUB | BPF_K: /* (u32) dst -= (u32) imm */
>   		case BPF_ALU64 | BPF_SUB | BPF_K: /* dst -= imm */
> -			if (BPF_OP(code) == BPF_SUB)
> -				imm = -imm;
> -			if (imm) {
> -				if (imm >= -32768 && imm < 32768)
> -					EMIT(PPC_RAW_ADDI(dst_reg, dst_reg, IMM_L(imm)));
> -				else {
> -					PPC_LI32(b2p[TMP_REG_1], imm);
> -					EMIT(PPC_RAW_ADD(dst_reg, dst_reg, b2p[TMP_REG_1]));
> -				}
> +			if (!imm) {
> +				goto bpf_alu32_trunc;
> +			} else if (imm > -32768 && imm < 32768) {

Why do you exclude imm == 32768 ?


Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>



> +				EMIT(PPC_RAW_ADDI(dst_reg, dst_reg, IMM_L(-imm)));
> +			} else {
> +				PPC_LI32(b2p[TMP_REG_1], imm);
> +				EMIT(PPC_RAW_SUB(dst_reg, dst_reg, b2p[TMP_REG_1]));
>   			}
>   			goto bpf_alu32_trunc;
>   		case BPF_ALU | BPF_MUL | BPF_X: /* (u32) dst *= (u32) src */
> 
