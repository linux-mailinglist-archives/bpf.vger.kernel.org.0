Return-Path: <bpf+bounces-39612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B3597551F
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 16:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F823B239DE
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E6D192B96;
	Wed, 11 Sep 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="p/vr0KPk"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E81191F9F
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064327; cv=none; b=ZhTkTbNV4aQCCcxWpZOcalK/eR4d0NaNc0fiV5MEqkAK7yCCEA9LveyiaJyO7qgwzjY0cRjsTV+kzReI9qdfd3Ttdo044gNkpdPKcq3Yi3tqUybN2eyWxBK3GeRDRtNOMfSNM5wfQ2WiGMxcYWVNvCqksxTqBw4n4fbYJmKzbRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064327; c=relaxed/simple;
	bh=ZEEG2YJO/mCLt8ef6UboVBY8aXzg+EofpDtZllI/66Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GbgITGsdgYo95+En1a8tMb+cofcnaEXBpDF9iExYX3Up18RKwLBQ4bLgrdm3FP7dnMOtM23TqpICieiaLbm8sT6nXIWk6PjgT+rWASGGU9Nnr9Nd2/rv8OCn0qyEJHO61sHzdRgpgPDn5WC8W2eF0gBwWX6eUU3UFVeemBmgWd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=p/vr0KPk; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=L7gzNvt/hOCqsLT136YGoPO63iJkSJs6JHuVSPxH+Qs=; b=p/vr0KPk3L/ESWjDk5qjBQ8u6f
	0HDa9/U/DrJ1HjvtKXxceHX6vhl4ce8V4PB35yHIVN18HbzTeiRSS/YFmaIml3MRnkpGM1uQbpsVT
	+Ds2Pm5ncX8R/72TRV9o3P6jMHvRmP4/2uW4hw4QxM/OS9oQ5KF8e46n+NKmLpQ0yYDGybejKRycp
	ckojNuy7wgG/PJ8yqejg/RxTWjfEU6cRLgTvvVhPNPdlRooh/iybC6bnyGB2J8C+eukL+cf3bidSv
	MSwvg/cHkK9PxOSQuBSR2cOUD0TPRTTs8KnGwyBpqQNQqnGhCyqdW6dKum98fCNonV8ip70gSJg6s
	1TescQNA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1soOB1-000F5N-1o; Wed, 11 Sep 2024 16:18:34 +0200
Received: from [85.1.206.226] (helo=linux-2.home)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1soOAz-000H3s-33;
	Wed, 11 Sep 2024 16:18:34 +0200
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix a sdiv overflow issue
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Zac Ecob <zacecob@protonmail.com>, dthaler1968@googlemail.com
References: <20240911044017.2261738-1-yonghong.song@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bf721309-0bf7-667c-16c9-b2601e033fe7@iogearbox.net>
Date: Wed, 11 Sep 2024 16:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240911044017.2261738-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27395/Wed Sep 11 10:32:20 2024)

On 9/11/24 6:40 AM, Yonghong Song wrote:
> Zac Ecob reported a problem where a bpf program may cause kernel crash due
> to the following error:
>    Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> 
> The failure is due to the below signed divide:
>    LLONG_MIN/-1 where LLONG_MIN equals to -9,223,372,036,854,775,808.
> LLONG_MIN/-1 is supposed to give a positive number 9,223,372,036,854,775,808,
> but it is impossible since for 64-bit system, the maximum positive
> number is 9,223,372,036,854,775,807. On x86_64, LLONG_MIN/-1 will
> cause a kernel exception. On arm64, the result for LLONG_MIN/-1 is
> LLONG_MIN.
> 
> So for 64-bit signed divide (sdiv), some additional insns are patched
> to check LLONG_MIN/-1 pattern. If such a pattern does exist, the result
> will be LLONG_MIN. Otherwise, it follows normal sdiv operation.

I presume this could be follow-up but it would also need an update to [0]
to describe the behavior.

   [0] Documentation/bpf/standardization/instruction-set.rst

>    [1] https://lore.kernel.org/bpf/tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com/
> 
> Reported-by: Zac Ecob <zacecob@protonmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   kernel/bpf/verifier.c | 29 ++++++++++++++++++++++++++---
>   1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f35b80c16cda..d77f1a05a065 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20506,6 +20506,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>   		    insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
>   			bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
>   			bool isdiv = BPF_OP(insn->code) == BPF_DIV;
> +			bool is_sdiv64 = is64 && isdiv && insn->off == 1;
>   			struct bpf_insn *patchlet;
>   			struct bpf_insn chk_and_div[] = {
>   				/* [R,W]x div 0 -> 0 */
> @@ -20525,10 +20526,32 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>   				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>   				BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
>   			};
> +			struct bpf_insn chk_and_sdiv64[] = {
> +				/* Rx sdiv 0 -> 0 */
> +				BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, insn->src_reg,
> +					     0, 2, 0),
> +				BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
> +				BPF_JMP_IMM(BPF_JA, 0, 0, 8),
> +				/* LLONG_MIN sdiv -1 -> LLONG_MIN */
> +				BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, insn->src_reg,
> +					     0, 6, -1),
> +				BPF_LD_IMM64(insn->src_reg, LLONG_MIN),
> +				BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_X, insn->dst_reg,
> +					     insn->src_reg, 2, 0),
> +				BPF_MOV64_IMM(insn->src_reg, -1),
> +				BPF_JMP_IMM(BPF_JA, 0, 0, 2),
> +				BPF_MOV64_IMM(insn->src_reg, -1),

Looks good, we could probably shrink this snippet via BPF_REG_AX ?
Untested, like below:

+				/* Rx sdiv 0 -> 0 */
+				BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, insn->src_reg, 0, 2, 0),
+				BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
+				BPF_JMP_IMM(BPF_JA, 0, 0, 5),
+				/* LLONG_MIN sdiv -1 -> LLONG_MIN */
+				BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, insn->src_reg, 0, 2, -1),
+				BPF_LD_IMM64(BPF_REG_AX, LLONG_MIN),
+				BPF_RAW_INSN(BPF_JMP | BPF_JEQ | BPF_X, insn->dst_reg, BPF_REG_AX, 1, 0),
+				*insn,

Then we don't need to restore the src_reg in both paths.

> +				*insn,
> +			};

Have you also looked into rejecting this pattern upfront on load when its a known
constant as we do with div by 0 in check_alu_op()?

Otherwise lgtm if this is equivalent to arm64 as you describe.

> -			patchlet = isdiv ? chk_and_div : chk_and_mod;
> -			cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
> -				      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
> +			if (is_sdiv64) {
> +				patchlet = chk_and_sdiv64;
> +				cnt = ARRAY_SIZE(chk_and_sdiv64);
> +			} else {
> +				patchlet = isdiv ? chk_and_div : chk_and_mod;
> +				cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
> +					      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
> +			}
>   
>   			new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
>   			if (!new_prog)
> 


