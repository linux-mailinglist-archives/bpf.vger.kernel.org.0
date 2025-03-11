Return-Path: <bpf+bounces-53851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23FAA5CCBF
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 18:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C833B9AD1
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 17:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1FA264621;
	Tue, 11 Mar 2025 17:50:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EAF263F3F;
	Tue, 11 Mar 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715406; cv=none; b=E2t0FJ6cF0YvrrKvRLe/Q3bC+MUfyuZWmGKqcKmkOr+AbPjKTPggKyJcHsUt1KUPoYgKG6oFu6c9Nv08G4VIdroXzmSTIs6MeysfJBewNuzY7373POgxnoPn6TPR6LpZnUUKnh8AclTKqvfdTFGsfowBx7X3++NodAzltyFYhMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715406; c=relaxed/simple;
	bh=IQgyv713wKOnG600Vb8w3N5JVPkyAyOIQlT6Xh1de2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Spucia9RTOg1gu7ZrbUwKb0fiadqkfNcNKwCG9X9GaTug+VLPax9Fq6OhrSMjOSdImjZIWHAjZVsuEHFSkuSF159W0c548rNDnq5yJUBtaMCPEkBcAcdZIQagY1Zfa8uWVQmWL2MPNzlV0s0sFONkiFXEKYEVlzqaMAX+wgRZ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZC1FZ17WZz9sgH;
	Tue, 11 Mar 2025 18:38:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kFuG1knKSIsb; Tue, 11 Mar 2025 18:38:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZC1FY6qB7z9sVm;
	Tue, 11 Mar 2025 18:38:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CF7678B768;
	Tue, 11 Mar 2025 18:38:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id VRYLasL8g2vh; Tue, 11 Mar 2025 18:38:25 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 887658B763;
	Tue, 11 Mar 2025 18:38:24 +0100 (CET)
Message-ID: <ab2a370d-3e71-41f1-9afc-6e2c47db87d9@csgroup.eu>
Date: Tue, 11 Mar 2025 18:38:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc, bpf: Support internal-only MOV instruction
 to resolve per-CPU addrs
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 naveen@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
References: <20250311160955.825647-1-skb99@linux.ibm.com>
 <20250311160955.825647-2-skb99@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250311160955.825647-2-skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/03/2025 à 17:09, Saket Kumar Bhaskar a écrit :
> [Vous ne recevez pas souvent de courriers de skb99@linux.ibm.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> With the introduction of commit 7bdbf7446305 ("bpf: add special
> internal-only MOV instruction to resolve per-CPU addrs"),
> a new BPF instruction BPF_MOV64_PERCPU_REG has been added to
> resolve absolute addresses of per-CPU data from their per-CPU
> offsets. This update requires enabling support for this
> instruction in the powerpc JIT compiler.
> 
> As of commit 7a0268fa1a36 ("[PATCH] powerpc/64: per cpu data
> optimisations"), the per-CPU data offset for the CPU is stored in
> the paca.
> 
> To support this BPF instruction in the powerpc JIT, the following
> powerpc instructions are emitted:
> 
> mr dst_reg, src_reg             //Move src_reg to dst_reg, if src_reg != dst_reg
> ld tmp1_reg, 48(13)             //Load per-CPU data offset from paca(r13) in tmp1_reg.
> add dst_reg, dst_reg, tmp1_reg  //Add the per cpu offset to the dst.

Why not do:

   add dst_reg, src_reg, tmp1_reg

instead of a combination of 'mr' and 'add' ?


> 
> To evaluate the performance improvements introduced by this change,
> the benchmark described in [1] was employed.
> 
> Before Change:
> glob-arr-inc   :   41.580 ± 0.034M/s
> arr-inc        :   39.592 ± 0.055M/s
> hash-inc       :   25.873 ± 0.012M/s
> 
> After Change:
> glob-arr-inc   :   42.024 ± 0.049M/s
> arr-inc        :   55.447 ± 0.031M/s
> hash-inc       :   26.565 ± 0.014M/s
> 
> [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fanakryiko%2Flinux%2Fcommit%2F8dec900975ef&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Ca4bc35a9cb49457fb5cc08dd60b73783%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638773062200197453%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=1t2Bc3w6Ye0u33UNEjsSAv114HDOGNXmk1I%2Fxt7K2sc%3D&reserved=0
> 
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c   | 5 +++++
>   arch/powerpc/net/bpf_jit_comp64.c | 8 ++++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 2991bb171a9b..3d4bd45a9a22 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -440,6 +440,11 @@ bool bpf_jit_supports_far_kfunc_call(void)
>          return IS_ENABLED(CONFIG_PPC64);
>   }
> 
> +bool bpf_jit_supports_percpu_insn(void)
> +{
> +       return true;
> +}
> +

What about PPC32 ?

>   void *arch_alloc_bpf_trampoline(unsigned int size)
>   {
>          return bpf_prog_pack_alloc(size, bpf_jit_fill_ill_insns);
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 233703b06d7c..06f06770ceea 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -679,6 +679,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>                   */
>                  case BPF_ALU | BPF_MOV | BPF_X: /* (u32) dst = src */
>                  case BPF_ALU64 | BPF_MOV | BPF_X: /* dst = src */
> +                       if (insn_is_mov_percpu_addr(&insn[i])) {
> +                               if (dst_reg != src_reg)
> +                                       EMIT(PPC_RAW_MR(dst_reg, src_reg));

Shouldn't be needed except for the non-SMP case maybe.

> +#ifdef CONFIG_SMP
> +                               EMIT(PPC_RAW_LD(tmp1_reg, _R13, offsetof(struct paca_struct, data_offset)));
> +                               EMIT(PPC_RAW_ADD(dst_reg, dst_reg, tmp1_reg));

Can use src_reg as first operand instead of dst_reg

> +#endif

data_offset always exists in paca_struct, please use 
IS_ENABLED(CONFIG_SMP) instead of #ifdef

> +                       }
>                          if (imm == 1) {
>                                  /* special mov32 for zext */
>                                  EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 0, 31));
> --
> 2.43.5
> 


