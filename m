Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44B842008F
	for <lists+bpf@lfdr.de>; Sun,  3 Oct 2021 09:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhJCH4i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Oct 2021 03:56:38 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:36869 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhJCH4f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Oct 2021 03:56:35 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HMbjM3xcpz9sVW;
        Sun,  3 Oct 2021 09:54:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rlWuBHzcqAZ7; Sun,  3 Oct 2021 09:54:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HMbjM2yVfz9sVS;
        Sun,  3 Oct 2021 09:54:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 505F88B76D;
        Sun,  3 Oct 2021 09:54:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rdwzYvnLorqf; Sun,  3 Oct 2021 09:54:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (po18950.idsi0.si.c-s.fr [192.168.203.204])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B6148B765;
        Sun,  3 Oct 2021 09:54:46 +0200 (CEST)
Subject: Re: [PATCH 1/9] powerpc/lib: Add helper to check if offset is within
 conditional branch range
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
 <f8d581e6a5d9555180c38e009f90d236f310f85e.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <6745a836-1991-24d0-f02a-437f06052c63@csgroup.eu>
Date:   Sun, 3 Oct 2021 09:50:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f8d581e6a5d9555180c38e009f90d236f310f85e.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Le 01/10/2021 à 23:14, Naveen N. Rao a écrit :
> Add a helper to check if a given offset is within the branch range for a
> powerpc conditional branch instruction, and update some sites to use the
> new helper.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/code-patching.h | 1 +
>   arch/powerpc/lib/code-patching.c         | 7 ++++++-
>   arch/powerpc/net/bpf_jit.h               | 7 +------
>   3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
> index a95f63788c6b14..4ba834599c4d4c 100644
> --- a/arch/powerpc/include/asm/code-patching.h
> +++ b/arch/powerpc/include/asm/code-patching.h
> @@ -23,6 +23,7 @@
>   #define BRANCH_ABSOLUTE	0x2
>   
>   bool is_offset_in_branch_range(long offset);
> +bool is_offset_in_cond_branch_range(long offset);
>   int create_branch(struct ppc_inst *instr, const u32 *addr,
>   		  unsigned long target, int flags);
>   int create_cond_branch(struct ppc_inst *instr, const u32 *addr,
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index f9a3019e37b43c..e2342b9a1ab9c9 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -228,6 +228,11 @@ bool is_offset_in_branch_range(long offset)
>   	return (offset >= -0x2000000 && offset <= 0x1fffffc && !(offset & 0x3));
>   }
>   
> +bool is_offset_in_cond_branch_range(long offset)
> +{
> +	return offset >= -0x8000 && offset <= 0x7FFF && !(offset & 0x3);
> +}

Would be better without capital letters in numbers, in extenso 0x7fff 
instead of 0x7FFF

> +
>   /*
>    * Helper to check if a given instruction is a conditional branch
>    * Derived from the conditional checks in analyse_instr()
> @@ -280,7 +285,7 @@ int create_cond_branch(struct ppc_inst *instr, const u32 *addr,
>   		offset = offset - (unsigned long)addr;
>   
>   	/* Check we can represent the target in the instruction format */
> -	if (offset < -0x8000 || offset > 0x7FFF || offset & 0x3)
> +	if (!is_offset_in_cond_branch_range(offset))
>   		return 1;
>   
>   	/* Mask out the flags and target, so they don't step on each other. */
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 99fad093f43ec1..935ea95b66359e 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -78,11 +78,6 @@
>   #define PPC_FUNC_ADDR(d,i) do { PPC_LI32(d, i); } while(0)
>   #endif
>   
> -static inline bool is_nearbranch(int offset)
> -{
> -	return (offset < 32768) && (offset >= -32768);
> -}
> -
>   /*
>    * The fly in the ointment of code size changing from pass to pass is
>    * avoided by padding the short branch case with a NOP.	 If code size differs
> @@ -91,7 +86,7 @@ static inline bool is_nearbranch(int offset)
>    * state.
>    */
>   #define PPC_BCC(cond, dest)	do {					      \
> -		if (is_nearbranch((dest) - (ctx->idx * 4))) {		      \
> +		if (is_offset_in_cond_branch_range((long)(dest) - (ctx->idx * 4))) {	\
>   			PPC_BCC_SHORT(cond, dest);			      \
>   			EMIT(PPC_RAW_NOP());				      \
>   		} else {						      \
> 
