Return-Path: <bpf+bounces-54695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C7DA70607
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 17:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558833A6B7C
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 16:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B4625332D;
	Tue, 25 Mar 2025 16:07:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6D42561B8
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918835; cv=none; b=NBLAtKIbmDXPKXMzDYMnDPN8jGiBlC8JV/lTuJXpQX1zgZjbZAogfbE2AoUU+2TnADXzZ21R8LROVRCQUL8t1Hq2CgLzF8CyKKCrvmbxbq1gqcb/M7KUqfgBDvqUviXDvpR8ciw4sF03GNW+VUhRoGZzAg4qTw8AKtUx0tusp5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918835; c=relaxed/simple;
	bh=EgK9+MZTh47IL/MKT6n9CWy7R0px1MQ9zq07hA4ND4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvBekPT3+WzrdCYQpr1F815Bq5qVD7wRc6ieQprehzYpbijH4Dk+3Lt/WIFR0tUEfoWkkB+Y+9WkqXKu6a6O0wfnwF8uYtwNIgtMOqNH8KIVDNZPWL7BAfBqSZbqitLnSNsbPFrgE+/9GjvzHNQNjoYo88R4zkVES+7LRYMEVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [36.112.165.186])
	by gateway (Coremail) with SMTP id _____8Axz3Or1OJn6OylAA--.15761S3;
	Wed, 26 Mar 2025 00:07:07 +0800 (CST)
Received: from [192.168.100.199] (unknown [36.112.165.186])
	by front1 (Coremail) with SMTP id qMiowMCx_cap1OJnksZfAA--.24298S3;
	Wed, 26 Mar 2025 00:07:06 +0800 (CST)
Message-ID: <d4870294-86c2-c458-3b2d-b581afcd9fa9@loongson.cn>
Date: Wed, 26 Mar 2025 00:07:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] LoongArch: BPF: Don't override subprog's return value
Content-Language: en-US
To: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org
Cc: chenhuacai@kernel.org, john.fastabend@gmail.com
References: <20250325141046.38347-1-hengqi.chen@gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <20250325141046.38347-1-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCx_cap1OJnksZfAA--.24298S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFyDZrW3tF1rXrWfJr1DArc_yoW8Cry7p3
	9rCas8AF4vgr45XF17t3yfXFy0gFsxGrWa9a4jyrW0vrn0v34fXr48Ka45XFW5Cw4rury8
	Xr4vvw1SvF4kAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
	UUU==

On 3/25/25 22:10, Hengqi Chen wrote:
> The verifier test `calls: div by 0 in subprog` triggers a panic at the
> ld.bu instruction. The ld.bu insn is trying to load byte from memory
> address returned by the subprog. The subprog actually set the correct
> address at the a5 register (dedicated register for BPF return values).
> But at commit 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
> we also sign extended a5 to the a0 register (return value in LoongArch).
> For function call insn, we later propagate the a0 register back to a5
> register. This is right for native calls but wrong for bpf2bpf calls
> which expect zero-extended return value in a5 register. So only move a0
> to a5 for native calls (i.e. non-BPF_PSEUDO_CALL).
> 
> Fixes: 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>   arch/loongarch/net/bpf_jit.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index a06bf89fed67..73ff1a657aa5 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -907,7 +907,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>   
>   		move_addr(ctx, t1, func_addr);
>   		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
> -		move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
> +
> +		if (insn->src_reg != BPF_PSEUDO_CALL)
> +			move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
>   		break;
>   
>   	/* tail call */

In my opinion, it is better to give a test case and show the test
result without and with this change.

The test case should be put in the commit message at least and then
added into tools/testing/selftests/bpf or lib/test_bpf.c if not exist.

Thanks,
Tiezhu


