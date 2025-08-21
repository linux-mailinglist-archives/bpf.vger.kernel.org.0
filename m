Return-Path: <bpf+bounces-66214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F9EB2FBBA
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 16:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C071D22311
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DF246B5;
	Thu, 21 Aug 2025 13:57:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A982EC54A
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784642; cv=none; b=UogAaDf/XIwKWATZ/H+qPyiQoYNdnGxvE7K6UhNWq/yp64FdB3E8OoHK5GaB7Hr33KS1l9ecQDKS1H+RP+0Wq6G3A2kJYQ6OxO0Hs+a3bn50bXI2sgO94QYWO53Yd4SadI98LUUY+XcdXoZjwV1arPjgCBgbeKmDSiqNRjxPBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784642; c=relaxed/simple;
	bh=HpItTb+c1tnNZomgUg+j0M9PgucXLcsaOZnwSK3zXns=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=O24vULDiqrM+0Lyw+ihqwrZjEjff3fKlBzKPpWk/yzdG8eMqb9dI0gHuRfqyRF6rYmG3gAjUNXEdhPXCi8paOOTorcNst7swbEvYZoke9EEwmmUuIsaQOEvgVrjWTNysbkP71U6mlPJ25+/OQ1L07DhqNyqcUH9Ex57FGVrYmdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx77+5JadonXUBAA--.1707S3;
	Thu, 21 Aug 2025 21:57:13 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDx_8O4Jado7MNdAA--.26264S3;
	Thu, 21 Aug 2025 21:57:12 +0800 (CST)
Subject: Re: [PATCH 3/3] LoongArch: BPF: No support of struct argument in
 trampoline programs
To: Hengqi Chen <hengqi.chen@gmail.com>, chenhuacai@kernel.org,
 jianghaoran@kylinos.cn, duanchenghao@kylinos.cn, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 vincent.mc.li@gmail.com
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev
References: <20250821091003.404870-1-hengqi.chen@gmail.com>
 <20250821091003.404870-4-hengqi.chen@gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <21c7ea87-6e48-6e96-fff2-6436db8fdb2a@loongson.cn>
Date: Thu, 21 Aug 2025 21:57:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250821091003.404870-4-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx_8O4Jado7MNdAA--.26264S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw1DJr1kJw4fXw1xJFW5Arc_yoW8JFW3pr
	45uFsIyFZYgry7XFnrJ3yDXr1ayFZ8GrW2ga1FkryUGFnxX3s8Xr1rKas8XFs5JwsYkFyF
	qw1q9rnIy3WUAacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=

On 2025/8/21 下午5:10, Hengqi Chen wrote:
> The current implementation does not support struct argument.

...

> Reject it for now.
> 
> Fixes: f9b6b41f0cf3 ("LoongArch: BPF: Add basic bpf trampoline support")
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>   arch/loongarch/net/bpf_jit.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 6754e5231ece..a87f51f5b708 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1516,6 +1516,12 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>   	if (m->nr_args > LOONGARCH_MAX_REG_ARGS)
>   		return -ENOTSUPP;
>   
> +	/* don't support struct argument */
> +	for (i = 0; i < m->nr_args; i++) {
> +		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
> +			return -ENOTSUPP;
> +	}
> +

Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>

By the way, I have 2 patches locally, one patch is to implement this 
feature, but there exist some other problems now, maybe it is related 
with the following failed testcase:

   sudo ./test_progs -t module_attach

Anyway, I will send a RFC series later for your review.

Thanks,
Tiezhu


