Return-Path: <bpf+bounces-66509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFA6B35507
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 09:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0121B63892
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED37D23D2BF;
	Tue, 26 Aug 2025 07:08:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75E82877C0
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192104; cv=none; b=pBPIJYQuO+VTgD5KGtsmUrBD7yyqomhfAWr6wBvZ9ZJEsCjp9nOBixaihi0qd0qDxh7BdjP80FCBpy3UEZvycAOUIvX5ZNefopxkpcfLAW+nEZptPpSj8Kix7+COMJ9/31oD9mX73ARZjMoZE4m9wgEMOm1EfduS/mIwejpwCps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192104; c=relaxed/simple;
	bh=OVE9hGqVcrmr2QU6izD836shHsGG1g38C4ChzAfeGaI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YlXhrEmoVU1bcwU2wgExyzY+jWzgimPG0Wy16tNfiBiPp4O2CtPDA5UfVwVEYtPAzQvjAPns/67IUxE+bz05oheUi7cJrTuWGRG+h4pbrF3BmrDB8rwFVJ76yBw4cUbSBjacuwFAc8x4JMBYlYA6hKMStWFmHbJEGDM9kEopsvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dxvr9iXa1oEEMDAA--.5298S3;
	Tue, 26 Aug 2025 15:08:18 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxfcFfXa1oQ3RpAA--.11172S3;
	Tue, 26 Aug 2025 15:08:15 +0800 (CST)
Subject: Re: [PATCH] LoongArch: BPF: Fix uninitialized symbol 'retval_off'
To: Huacai Chen <chenhuacai@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, Hengqi Chen <hengqi.chen@gmail.com>,
 Huacai Chen <chenhuacai@gmail.com>, George Guo <guodongtai@kylinos.cn>,
 Chenghao Duan <duanchenghao@kylinos.cn>, loongarch@lists.linux.dev,
 kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250819111953.3197428-1-chenhuacai@loongson.cn>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <1378057e-4fc1-2bcd-4d60-1a10bd98e5bb@loongson.cn>
Date: Tue, 26 Aug 2025 15:07:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250819111953.3197428-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxfcFfXa1oQ3RpAA--.11172S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFW7Jr15CFWDGrWktFy3ZFc_yoW8Wr13pr
	ZrZrnIyF48Wry2qa9rX3yrXrn0qr4DGrnxWF1YyFyrCay5Xw1vvr1rGa98WFyjy39Yvw10
	qrs0krnIk3ZrAacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=

On 2025/8/19 下午7:19, Huacai Chen wrote:
> In __arch_prepare_bpf_trampoline(), retval_off is meaningful only when
> save_ret is not 0, so the current logic is correct. But it may cause a
> build warning:
> 
> arch/loongarch/net/bpf_jit.c:1547 __arch_prepare_bpf_trampoline() error: uninitialized symbol 'retval_off'.
> 
> So initialize retval_off unconditionally to fix it.
> 
> Fixes: f9b6b41f0cf3 ("LoongArch: BPF: Add basic bpf trampoline support")
> Closes: https://lore.kernel.org/r/202508191020.PBBh07cK-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/net/bpf_jit.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index abfdb6bb5c38..a73f6ea4ed4a 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1504,11 +1504,10 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>   	stack_size += 16;
>   
>   	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
> -	if (save_ret) {
> -		/* Save BPF R0 and A0 */
> -		stack_size += 16;
> -		retval_off = stack_size;
> -	}
> +	if (save_ret)
> +		stack_size += 16; /* Save BPF R0 and A0 */
> +
> +	retval_off = stack_size;

Just init retval_off as 0 at the beginning of this function?
What is the difference? which is better?

Thanks,
Tiezhu


