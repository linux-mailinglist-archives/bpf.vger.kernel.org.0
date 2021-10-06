Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4FE423754
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 07:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhJFFEw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 01:04:52 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:43723 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhJFFEw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 01:04:52 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HPMlm06Vlz9sVL;
        Wed,  6 Oct 2021 07:03:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xAEXDdeBPiZG; Wed,  6 Oct 2021 07:02:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HPMll6CBfz9sVK;
        Wed,  6 Oct 2021 07:02:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA32B8B765;
        Wed,  6 Oct 2021 07:02:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QtB9uTetnFVH; Wed,  6 Oct 2021 07:02:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.229])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F09138B763;
        Wed,  6 Oct 2021 07:02:58 +0200 (CEST)
Subject: Re: [PATCH v2 10/10] powerpc/bpf ppc32: Fix BPF_SUB when imm ==
 0x80000000
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
 <7135360a0cdf70adedbccf9863128b8daef18764.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c60168f9-4648-c794-e6b2-b1ad4090391c@csgroup.eu>
Date:   Wed, 6 Oct 2021 07:02:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7135360a0cdf70adedbccf9863128b8daef18764.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Le 05/10/2021 à 22:25, Naveen N. Rao a écrit :
> Special case handling of the smallest 32-bit negative number for BPF_SUB.
> 
> Fixes: 51c66ad849a703 ("powerpc/bpf: Implement extended BPF on PPC32")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/net/bpf_jit_comp32.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index 68dc8a8231de04..0da31d41d41310 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -357,7 +357,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   				PPC_LI32(_R0, imm);
>   				EMIT(PPC_RAW_ADDC(dst_reg, dst_reg, _R0));
>   			}
> -			if (imm >= 0)
> +			if (imm >= 0 || (BPF_OP(code) == BPF_SUB && imm == 0x80000000))
>   				EMIT(PPC_RAW_ADDZE(dst_reg_h, dst_reg_h));
>   			else
>   				EMIT(PPC_RAW_ADDME(dst_reg_h, dst_reg_h));
> 
