Return-Path: <bpf+bounces-75434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DFCC8457B
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 11:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FEBA3AAC39
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 10:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C20263C8A;
	Tue, 25 Nov 2025 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOosHrQO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD9CA4E;
	Tue, 25 Nov 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064944; cv=none; b=WCqBEJuZmH/KMbHNpdveM/5CMtyW8zHon7O62L+rFg4nGV0uyKbgpuPLcW0OW+Hd+sfIEug9pW3zw/gbpXdvdwfIN+1jAxLeUqTWeKnsq8t3iSgynsHv7OqKc6t03fWs5vmOUeJLIhAXsNJ64sHMYccOjfZP9X27oY7OQyAkuVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064944; c=relaxed/simple;
	bh=oxKQBafDlsGK4Tb3liQhHwe/MwCuDbCdtq7GrpW29HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrW2gA8kRazbdwo2bUWqGztwfnfo8GZKpt5TQuaaVLwrE0d+mQzAMunIaILKx5pF4ln3XXNdzSRMDZtot/DCz8eh6ZcUp8GtpZRXmflnaY5ayNHNOUub8mJi0g+1s+AJSos9pEmOJT3f+10c5YXqoDSlgo8WcoT04knnFG3o1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOosHrQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE17C4CEF1;
	Tue, 25 Nov 2025 10:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764064942;
	bh=oxKQBafDlsGK4Tb3liQhHwe/MwCuDbCdtq7GrpW29HY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YOosHrQOulAFT3yRgBySi9dL0VSDpGYZ/TW3IosH3l3PhqYJTzBjgBq05JSmX5voR
	 haL3sjx6T1BRzXA3oFrz6v0XdvYCIGrYfPFYQPiSXTssqkzuOO0qIDj5f9WuJI4hgS
	 cK/JR/2sFK1gbcCcJ6ruUZIHzsU3acHTiUUGlVPTU3yCfQcUoHBtIoOl/zSPW+BpDU
	 bt3Z10Acj/AjG54vSiTUR6tdRz/RZ6iDkLu7pwP8Qxfow8kYO5q8RB+rz6alfi00bn
	 NAPTbqKu/lcPS1CsDQqloP4AGfRtNjNrnMTgt8XLJtqVwEjMgad/crEVXSlbU07cTF
	 4il40N+bYqDGw==
Message-ID: <1a14025c-6cd5-4e04-b49d-cd65b8b35e68@kernel.org>
Date: Tue, 25 Nov 2025 11:02:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] powerpc64/bpf: Support internal-only MOV
 instruction to resolve per-CPU addrs
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, naveen@kernel.org, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com
References: <cover.1762422548.git.skb99@linux.ibm.com>
 <e58dc8bfd5be16f95684d35fd68919ea83c7e322.1762422548.git.skb99@linux.ibm.com>
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Language: fr-FR
In-Reply-To: <e58dc8bfd5be16f95684d35fd68919ea83c7e322.1762422548.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/11/2025 à 07:52, Saket Kumar Bhaskar a écrit :
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
> ld tmp1_reg, 48(13)		//Load per-CPU data offset from paca(r13) in tmp1_reg.
> add dst_reg, src_reg, tmp1_reg	//Add the per cpu offset to the dst.
> mr dst_reg, src_reg		//Move src_reg to dst_reg, if src_reg != dst_reg

Must be something wrong here. The 'add' was done into the dst_reg so 
here you erase the result of the addition by the source register.

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
> [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fanakryiko%2Flinux%2Fcommit%2F8dec900975ef&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C2f16cef7d35341c9683608de25a5ee3b%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638989591756011820%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=dNHc3FAFJkZpHq%2Be1hTv5CfBrGEXxWTKrLGSHaUw%2BRk%3D&reserved=0
> 
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c   | 5 +++++
>   arch/powerpc/net/bpf_jit_comp64.c | 9 +++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 88ad5ba7b87f..2f2230ae2145 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -466,6 +466,11 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
>   	return true;
>   }
>   
> +bool bpf_jit_supports_percpu_insn(void)
> +{
> +	return IS_ENABLED(CONFIG_PPC64);
> +}
> +
>   void *arch_alloc_bpf_trampoline(unsigned int size)
>   {
>   	return bpf_prog_pack_alloc(size, bpf_jit_fill_ill_insns);
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 1fe37128c876..21486706b5ea 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -918,6 +918,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   		case BPF_ALU | BPF_MOV | BPF_X: /* (u32) dst = src */
>   		case BPF_ALU64 | BPF_MOV | BPF_X: /* dst = src */
>   
> +			if (insn_is_mov_percpu_addr(&insn[i])) {
> +				if (IS_ENABLED(CONFIG_SMP)) {
> +					EMIT(PPC_RAW_LD(tmp1_reg, _R13, offsetof(struct paca_struct, data_offset)));
> +					EMIT(PPC_RAW_ADD(dst_reg, src_reg, tmp1_reg));
> +				} else {
> +					EMIT(PPC_RAW_MR(dst_reg, src_reg));

You should make sure dst_reg is different from src_reg before emitting 
this, you may otherwise generate one of the following instructions that 
change the thread priority:

#define HMT_very_low()		asm volatile("or 31, 31, 31	# very low priority")
#define HMT_low()		asm volatile("or 1, 1, 1	# low priority")
#define HMT_medium_low()	asm volatile("or 6, 6, 6	# medium low priority")
#define HMT_medium()		asm volatile("or 2, 2, 2	# medium priority")
#define HMT_medium_high()	asm volatile("or 5, 5, 5	# medium high priority")
#define HMT_high()		asm volatile("or 3, 3, 3	# high priority")


> +				}
> +			}
> +
>   			if (insn_is_cast_user(&insn[i])) {
>   				EMIT(PPC_RAW_RLDICL_DOT(tmp1_reg, src_reg, 0, 32));
>   				PPC_LI64(dst_reg, (ctx->user_vm_start & 0xffffffff00000000UL));


