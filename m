Return-Path: <bpf+bounces-75435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04718C84683
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 11:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 76F2A34F534
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 10:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2022F12AD;
	Tue, 25 Nov 2025 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWjXfqRb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D02609FD;
	Tue, 25 Nov 2025 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065715; cv=none; b=KHbAB4yor1CWaCPzD/GsVbqPybjagl43rnseYbqOhgrvZKZ5qtdb717svrapGHqu3nnSjkoVo6xTOlxmT+fAMy7Aji64rIhjlgGEvFuozZlbSnp1KB4JLtRRO0qbpibK3gqymUtQ3Ge29Uy+0RCATBrfrdeA8FdXaNMD9nbBifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065715; c=relaxed/simple;
	bh=PCZTA7CvmQSqQVYlMmBwBTfrOIW/wW5BU9i50jf3yeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Khqav/TubbTQBL95dnzXp4V6ILdpFSvwDnFwIao2QwuNqwI9BqZ/BYtr9wfiMrC2bIW/QkS8deBFjxRxZHIkMrhuwd4Am5yMY1XkgqBcwLbXKMfAo+DtczO69fGPfcDWCrypKOnyTdqd+yR49fDUepk6mBHR5a81q56NeGbeqIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWjXfqRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD0EC4AF09;
	Tue, 25 Nov 2025 10:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764065713;
	bh=PCZTA7CvmQSqQVYlMmBwBTfrOIW/wW5BU9i50jf3yeI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QWjXfqRbwubOSTGPMSqYm28L/bIZ7iWVjIWHKZ+DB8g7XVlauedGg9pW1ud1Q+PUA
	 OKgr0ThV6DJA3AMs7aodw1M+S304kycMfFy6McrCPqdOmr1cAxWleNaf23dMdMP0hs
	 0K2Dp5AiO55tiBGqhUVDXDdfo93HnpGbbYk6j+G/4tXAMEBMQYCyxBYw9NAE/STYdz
	 pZ/CU4uc/XN3iKB6R7K49C+WmqIHb26M8qbmb7s5ZBJm39ahCWNCqlYgBcLr5WiB2O
	 IlYKqVXQkH8xutX+uBFC6TCGC8uvC0TnCybpemKZSjwcGRWffQrQNGJs+WG9RxmJTh
	 +VGG1sAKiGLjQ==
Message-ID: <37ae675e-dab2-478d-a5a5-17e50679fefa@kernel.org>
Date: Tue, 25 Nov 2025 11:15:03 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] powerpc64/bpf: Inline
 bpf_get_smp_processor_id() and bpf_get_current_task()
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, naveen@kernel.org, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com
References: <cover.1762422548.git.skb99@linux.ibm.com>
 <1ff85160e12abfe1bd1e553b394957492187d133.1762422548.git.skb99@linux.ibm.com>
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Language: fr-FR
In-Reply-To: <1ff85160e12abfe1bd1e553b394957492187d133.1762422548.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/11/2025 à 07:52, Saket Kumar Bhaskar a écrit :
> Inline the calls to bpf_get_smp_processor_id()/bpf_get_current_task()
> in the powerpc bpf jit.
> 
> powerpc saves the Logical processor number (paca_index) and pointer
> to current task (__current) in paca.
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
> mr	8, 3
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
> | glob-arr-inc  | 40.701 ± 0.008M/s | 55.207 ± 0.021M/s |   + 35.64%   |
> | arr-inc       | 39.401 ± 0.007M/s | 56.275 ± 0.023M/s |   + 42.42%   |
> | hash-inc      | 24.944 ± 0.004M/s | 26.212 ± 0.003M/s |   +  5.08%   |
> +---------------+-------------------+-------------------+--------------+
> 
> [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fanakryiko%2Flinux%2Fcommit%2F8dec900975ef&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4a08a3af41ff4f9bc55d08de25a5f0ee%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638989591794687135%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=FtfTYpm9VgLfO1Q3iZvyrE4QRG317%2B%2BjfPd66Wd%2FQP4%3D&reserved=0
> 
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c   | 11 +++++++++++
>   arch/powerpc/net/bpf_jit_comp64.c | 10 ++++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 2f2230ae2145..c88dfa1418ec 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -471,6 +471,17 @@ bool bpf_jit_supports_percpu_insn(void)
>   	return IS_ENABLED(CONFIG_PPC64);
>   }
>   
> +bool bpf_jit_inlines_helper_call(s32 imm)
> +{
> +	switch (imm) {
> +	case BPF_FUNC_get_smp_processor_id:
> +	case BPF_FUNC_get_current_task:

What about BPF_FUNC_get_current_task_btf ?

> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   void *arch_alloc_bpf_trampoline(unsigned int size)
>   {
>   	return bpf_prog_pack_alloc(size, bpf_jit_fill_ill_insns);
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 21486706b5ea..4e1643422370 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -1399,6 +1399,16 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   		case BPF_JMP | BPF_CALL:
>   			ctx->seen |= SEEN_FUNC;
>   
> +			if (insn[i].src_reg == BPF_REG_0) {

Are you sure you want to use BPF_REG_0 here ? Is it the correct meaning 
? I see RISCV and ARM64 use 0 instead.

If you keep BPF_REG_0 I would have a preference for

		if (src_reg == bpf_to_ppc(BPF_REG_0))

> +				if (imm == BPF_FUNC_get_smp_processor_id) {
> +					EMIT(PPC_RAW_LHZ(insn[i].src_reg, _R13, offsetof(struct paca_struct, paca_index)));

This looks wrong, you can't use insn[i].src_reg to emit powerpc 
instructions, you must use the local src_reg which converts the register 
ID with bpf_to_ppc()

> +					break;
> +				} else if (imm == BPF_FUNC_get_current_task) {
> +					EMIT(PPC_RAW_LD(insn[i].src_reg, _R13, offsetof(struct paca_struct, __current)));

Same here.

> +					break;
> +				}
> +			}
> +
>   			ret = bpf_jit_get_func_addr(fp, &insn[i], extra_pass,
>   						    &func_addr, &func_addr_fixed);
>   			if (ret < 0)


