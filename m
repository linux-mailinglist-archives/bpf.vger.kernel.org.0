Return-Path: <bpf+bounces-53853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C65BA5CDBB
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 19:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0481B189E9B2
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F33E263C69;
	Tue, 11 Mar 2025 18:20:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A9825C6F9;
	Tue, 11 Mar 2025 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717205; cv=none; b=Pp4In3mDCiOsJVFFpYXFqyr/Vc4hZqBxMwu6lZCL8GtAYJMZpLSgPeNGAKekkD4k71a6ZD/xEPjdZLPLeGj11dlGHmYgX9bB5xISCvEEEo/gqzzLgPA5EgHGIfRkCSe8cWU5N+OT9AEyybWyzKjTES8YegtO0VpqCI69kNC2RKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717205; c=relaxed/simple;
	bh=lrA7X7dr/o7Vl9yRSzzERDbxoLlxULn4YSC2YPrCtWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDeDYYVzEADmVnn++oUOeVGiIOG7JpAP+BFvvpA2DpBdutLAZjaDhCmxL8/5woBnqFzHSpysp8b2QrvXcqfrzBWFtMHWz/MKUCTLp6clb/VZ8S+0/qAhhwLG/PccnDML5rPg3ePkRE+JXnt7E3yPXfqGtH+hbpcbvhJTtQYgVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZC1Xf6JvGz9sgH;
	Tue, 11 Mar 2025 18:51:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fvDIzXamRURc; Tue, 11 Mar 2025 18:51:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZC1Xf5CWCz9sVm;
	Tue, 11 Mar 2025 18:51:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9A2E28B768;
	Tue, 11 Mar 2025 18:51:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 175KqGxnGV_Y; Tue, 11 Mar 2025 18:51:30 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3AF2D8B763;
	Tue, 11 Mar 2025 18:51:29 +0100 (CET)
Message-ID: <61e746ca-456f-4824-9678-85399b450bce@csgroup.eu>
Date: Tue, 11 Mar 2025 18:51:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] powerpc, bpf: Inline bpf_get_smp_processor_id()
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 naveen@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
References: <20250311160955.825647-1-skb99@linux.ibm.com>
 <20250311160955.825647-3-skb99@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250311160955.825647-3-skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/03/2025 à 17:09, Saket Kumar Bhaskar a écrit :
> [Vous ne recevez pas souvent de courriers de skb99@linux.ibm.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Inline the calls to bpf_get_smp_processor_id() in the powerpc bpf jit.
> 
> powerpc saves the Logical processor number (paca_index) in paca.
> 
> Here is how the powerpc JITed assembly changes after this commit:
> 
> Before:
> 
> cpu = bpf_get_smp_processor_id();
> 
> addis 12, 2, -517
> addi 12, 12, -29456
> mtctr 12
> bctrl
> mr      8, 3
> 
> After:
> 
> cpu = bpf_get_smp_processor_id();
> 
> lhz 8, 8(13)
> 
> To evaluate the performance improvements introduced by this change,
> the benchmark described in [1] was employed.
> 
> +---------------+-------------------+-------------------+--------------+
> |      Name     |      Before       |        After      |   % change   |
> |---------------+-------------------+-------------------+--------------|
> | glob-arr-inc  | 41.580 ± 0.034M/s | 54.137 ± 0.019M/s |   + 30.20%   |
> | arr-inc       | 39.592 ± 0.055M/s | 54.000 ± 0.026M/s |   + 36.39%   |
> | hash-inc      | 25.873 ± 0.012M/s | 26.334 ± 0.058M/s |   + 1.78%    |
> +---------------+-------------------+-------------------+--------------+
> 

Nice improvement.

I see that bpf_get_current_task() could be inlined as well, on PPC32 it 
is in r2, on PPC64 it is in paca.

> [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fanakryiko%2Flinux%2Fcommit%2F8dec900975ef&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C1d1f40ce41344cf1ecf508dd60b73ae0%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638773062267813839%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=T%2BG206FHtW7hhFT1%2BXxRwN7pc%2BRzu8SiMlZ5njIlhB8%3D&reserved=0
> 
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c   | 10 ++++++++++
>   arch/powerpc/net/bpf_jit_comp64.c |  5 +++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 3d4bd45a9a22..4b79b2d95469 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -445,6 +445,16 @@ bool bpf_jit_supports_percpu_insn(void)
>          return true;
>   }
> 
> +bool bpf_jit_inlines_helper_call(s32 imm)
> +{
> +       switch (imm) {
> +       case BPF_FUNC_get_smp_processor_id:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}

What about PPC32 ?


> +
>   void *arch_alloc_bpf_trampoline(unsigned int size)
>   {
>          return bpf_prog_pack_alloc(size, bpf_jit_fill_ill_insns);
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 06f06770ceea..a8de12c026da 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -1087,6 +1087,11 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>                  case BPF_JMP | BPF_CALL:
>                          ctx->seen |= SEEN_FUNC;
> 
> +                       if (insn[i].src_reg == 0 && imm == BPF_FUNC_get_smp_processor_id) {

Please use BPF_REG_0 instead of just 0.

> +                               EMIT(PPC_RAW_LHZ(bpf_to_ppc(BPF_REG_0), _R13, offsetof(struct paca_struct, paca_index)));

Can just use 'src_reg' instead of 'bpf_to_ppc(BPF_REG_0)'

> +                               break;
> +                       }
> +
>                          ret = bpf_jit_get_func_addr(fp, &insn[i], extra_pass,
>                                                      &func_addr, &func_addr_fixed);
>                          if (ret < 0)
> --
> 2.43.5
> 


