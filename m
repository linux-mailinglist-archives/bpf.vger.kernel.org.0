Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91394423744
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 06:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhJFEys (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 00:54:48 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:36975 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230444AbhJFEys (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 00:54:48 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HPMX74sRpz9sVL;
        Wed,  6 Oct 2021 06:52:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mgFTI4CG0l-l; Wed,  6 Oct 2021 06:52:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HPMX74457z9sVK;
        Wed,  6 Oct 2021 06:52:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 70D3E8B765;
        Wed,  6 Oct 2021 06:52:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZuEQYkquUSFU; Wed,  6 Oct 2021 06:52:55 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.229])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AC23E8B763;
        Wed,  6 Oct 2021 06:52:54 +0200 (CEST)
Subject: Re: [PATCH v2 03/10] powerpc/bpf: Fix BPF_MOD when imm == 1
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
 <c674ca18c3046885602caebb326213731c675d06.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <dfced8b0-b194-6092-688a-73c409dbae58@csgroup.eu>
Date:   Wed, 6 Oct 2021 06:52:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c674ca18c3046885602caebb326213731c675d06.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Le 05/10/2021 à 22:25, Naveen N. Rao a écrit :
> Only ignore the operation if dividing by 1.
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> Tested-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> Fixes: 156d0e290e969c ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/net/bpf_jit_comp64.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index f06c62089b1457..d67f6d62e2e1ff 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -391,8 +391,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   		case BPF_ALU64 | BPF_DIV | BPF_K: /* dst /= imm */
>   			if (imm == 0)
>   				return -EINVAL;
> -			else if (imm == 1)
> -				goto bpf_alu32_trunc;
> +			if (imm == 1) {
> +				if (BPF_OP(code) == BPF_DIV) {
> +					goto bpf_alu32_trunc;
> +				} else {
> +					EMIT(PPC_RAW_LI(dst_reg, 0));
> +					break;
> +				}
> +			}
>   
>   			PPC_LI32(b2p[TMP_REG_1], imm);
>   			switch (BPF_CLASS(code)) {
> 
