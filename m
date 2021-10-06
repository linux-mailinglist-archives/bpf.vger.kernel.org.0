Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8590A423749
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 06:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhJFE6S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 00:58:18 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:34035 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhJFE6R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 00:58:17 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HPMc93jg4z9sVL;
        Wed,  6 Oct 2021 06:56:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tNlxHWF2q9jc; Wed,  6 Oct 2021 06:56:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HPMc92xF5z9sVK;
        Wed,  6 Oct 2021 06:56:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D2568B765;
        Wed,  6 Oct 2021 06:56:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SBhqc5Gm290q; Wed,  6 Oct 2021 06:56:25 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.229])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 813A28B763;
        Wed,  6 Oct 2021 06:56:24 +0200 (CEST)
Subject: Re: [PATCH v2 07/10] powerpc/bpf ppc32: Fix ALU32 BPF_ARSH operation
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
 <6d24c1f9e79b6f61f5135eaf2ea1e8bcd4dac87b.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4c9ac9a0-369f-8df0-c753-8104b8cc9c31@csgroup.eu>
Date:   Wed, 6 Oct 2021 06:56:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6d24c1f9e79b6f61f5135eaf2ea1e8bcd4dac87b.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Le 05/10/2021 à 22:25, Naveen N. Rao a écrit :
> Correct the destination register used for ALU32 BPF_ARSH operation.
> 
> Fixes: 51c66ad849a703 ("powerpc/bpf: Implement extended BPF on PPC32")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/net/bpf_jit_comp32.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index a74d52204f8da2..519ecb9ab67266 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -625,7 +625,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   			EMIT(PPC_RAW_LI(dst_reg_h, 0));
>   			break;
>   		case BPF_ALU | BPF_ARSH | BPF_X: /* (s32) dst >>= src */
> -			EMIT(PPC_RAW_SRAW(dst_reg_h, dst_reg, src_reg));
> +			EMIT(PPC_RAW_SRAW(dst_reg, dst_reg, src_reg));
>   			break;
>   		case BPF_ALU64 | BPF_ARSH | BPF_X: /* (s64) dst >>= src */
>   			bpf_set_seen_register(ctx, tmp_reg);
> 
