Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8106423751
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 07:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhJFFCx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 01:02:53 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:46193 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhJFFCw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 01:02:52 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HPMjS0x2wz9sVL;
        Wed,  6 Oct 2021 07:01:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dGRjBtbP4sHU; Wed,  6 Oct 2021 07:01:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HPMjS065kz9sVK;
        Wed,  6 Oct 2021 07:01:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD6C38B765;
        Wed,  6 Oct 2021 07:00:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CUQ6Ot4R_emJ; Wed,  6 Oct 2021 07:00:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.229])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E0248B763;
        Wed,  6 Oct 2021 07:00:59 +0200 (CEST)
Subject: Re: [PATCH v2 08/10] powerpc/bpf ppc32: Fix JMP32_JSET_K
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
 <b94489f52831305ec15aca4dd04a3527236be7e8.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9e360bb5-12a0-230b-54ef-837424ebfe2b@csgroup.eu>
Date:   Wed, 6 Oct 2021 07:00:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b94489f52831305ec15aca4dd04a3527236be7e8.1633464148.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Le 05/10/2021 à 22:25, Naveen N. Rao a écrit :
> 'andi' only takes an unsigned 16-bit value. Correct the imm range used
> when emitting andi.
> 
> Fixes: 51c66ad849a703 ("powerpc/bpf: Implement extended BPF on PPC32")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/net/bpf_jit_comp32.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index 519ecb9ab67266..7c65de9ed4fa64 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -1075,7 +1075,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>   				break;
>   			case BPF_JMP32 | BPF_JSET | BPF_K:
>   				/* andi does not sign-extend the immediate */
> -				if (imm >= -32768 && imm < 32768) {
> +				if (imm >= 0 && imm < 32768) {
>   					/* PPC_ANDI is _only/always_ dot-form */
>   					EMIT(PPC_RAW_ANDI(_R0, dst_reg, imm));
>   				} else {
> 
