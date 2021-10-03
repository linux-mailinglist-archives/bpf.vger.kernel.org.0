Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8221B4200AA
	for <lists+bpf@lfdr.de>; Sun,  3 Oct 2021 10:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhJCIJ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Oct 2021 04:09:29 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:39199 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229896AbhJCIJR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Oct 2021 04:09:17 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HMbzy0y5Rz9sVT;
        Sun,  3 Oct 2021 10:07:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5mDpLs_9IUiW; Sun,  3 Oct 2021 10:07:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HMbzy06KMz9sVS;
        Sun,  3 Oct 2021 10:07:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E0FF38B76D;
        Sun,  3 Oct 2021 10:07:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id oqc8ttxPOLtS; Sun,  3 Oct 2021 10:07:25 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (po18950.idsi0.si.c-s.fr [192.168.203.204])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B4E68B765;
        Sun,  3 Oct 2021 10:07:25 +0200 (CEST)
Subject: Re: [PATCH 6/9] powerpc/bpf: Fix BPF_SUB when imm == 0x80000000
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
 <1912a409447071f46ac6cc957ce8edea0e5232b7.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <43626c62-9a3a-bbba-8cbc-11efb0468b4b@csgroup.eu>
Date:   Sun, 3 Oct 2021 10:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1912a409447071f46ac6cc957ce8edea0e5232b7.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Le 01/10/2021 à 23:14, Naveen N. Rao a écrit :
> We aren't handling subtraction involving an immediate value of
> 0x80000000 properly. Fix the same.
> 
> Fixes: 156d0e290e969c ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp64.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index ffb7a2877a8469..4641a50e82d50d 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -333,15 +333,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   		case BPF_ALU | BPF_SUB | BPF_K: /* (u32) dst -= (u32) imm */
>   		case BPF_ALU64 | BPF_ADD | BPF_K: /* dst += imm */
>   		case BPF_ALU64 | BPF_SUB | BPF_K: /* dst -= imm */
> -			if (BPF_OP(code) == BPF_SUB)
> -				imm = -imm;
> -			if (imm) {
> -				if (imm >= -32768 && imm < 32768)
> -					EMIT(PPC_RAW_ADDI(dst_reg, dst_reg, IMM_L(imm)));
> -				else {
> -					PPC_LI32(b2p[TMP_REG_1], imm);
> +			if (imm > -32768 && imm < 32768) {
> +				EMIT(PPC_RAW_ADDI(dst_reg, dst_reg,
> +					BPF_OP(code) == BPF_SUB ? IMM_L(-imm) : IMM_L(imm)));
> +			} else {
> +				PPC_LI32(b2p[TMP_REG_1], imm);
> +				if (BPF_OP(code) == BPF_SUB)
> +					EMIT(PPC_RAW_SUB(dst_reg, dst_reg, b2p[TMP_REG_1]));
> +				else
>   					EMIT(PPC_RAW_ADD(dst_reg, dst_reg, b2p[TMP_REG_1]));
> -				}
>   			}
>   			goto bpf_alu32_trunc;

There is now so few code common to both BPF_ADD and BPF_SUB that you 
should make them different cases.

While at it, why not also use ADDIS if imm is 32 bits ? That would be an 
ADDIS/ADDI instead of LIS/ORI/ADD

>   		case BPF_ALU | BPF_MUL | BPF_X: /* (u32) dst *= (u32) src */
> 
