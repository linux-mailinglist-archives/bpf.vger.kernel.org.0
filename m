Return-Path: <bpf+bounces-66212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B37B4B2FB61
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 15:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326381D019CC
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 13:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D952DF6FE;
	Thu, 21 Aug 2025 13:49:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29322192B66
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784143; cv=none; b=Hds6zRmmTKKdAyFPpadNJrxW97suvS/XXhf6KznYCd6LgWJmApthZs754eNcm/W+TAHZz6HZdlASMPbkZVsOBdnYN1BVfeMhHCx9vPAGlCMaz0Pjrz+xIZzEXVBGz7HDCpqa8YVcHEyAxI+AtsE0xw6e+8bR0H+7she7F+Lk3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784143; c=relaxed/simple;
	bh=5Gwu3gr9vnmpJzZUJbk2sP4G4x7XcGQ7vcQ/3FcAoMg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=X4FHOpaS54tNYfvEIv6Ayp2riHQQZ22zqS2GLGozbbFX1TC9YgzJWS3FrxwCxtoaKNOzQCZAULGohcSzp5b6MoHamuItaquj4mxsLZMUit9NAbp3/I43UiGcfQ5OgicSNjkdfMK3qzq6pLndzU0ljPKcfOVFgQm6bAk97Mpa7xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx_tLHI6do83QBAA--.2655S3;
	Thu, 21 Aug 2025 21:48:55 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxdOTGI6do_r9dAA--.27533S3;
	Thu, 21 Aug 2025 21:48:55 +0800 (CST)
Subject: Re: [PATCH 1/3] LoongArch: BPF: Remove duplicated flags check
To: Hengqi Chen <hengqi.chen@gmail.com>, chenhuacai@kernel.org,
 jianghaoran@kylinos.cn, duanchenghao@kylinos.cn, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 vincent.mc.li@gmail.com
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev
References: <20250821091003.404870-1-hengqi.chen@gmail.com>
 <20250821091003.404870-2-hengqi.chen@gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <800cfa7a-ecaf-94bc-a44f-3ee83acc9d3a@loongson.cn>
Date: Thu, 21 Aug 2025 21:48:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250821091003.404870-2-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxdOTGI6do_r9dAA--.27533S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JF4fWw4xGrW8XFW5AF1kJFc_yoWkGrb_Jr
	17A34xCrs8JFWrC3WDKr45ArnFvw15XFn5uFn3WrWIka45XrW5ArW8t345Zry7K39I9rW5
	G393Xas3Aw4jvosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa02
	0Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1l
	Yx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI
	0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0b6pPUUUUU==

On 2025/8/21 下午5:10, Hengqi Chen wrote:
> The check for (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY)
> is duplicated in __arch_prepare_bpf_trampoline(). Remove it.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>   arch/loongarch/net/bpf_jit.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index abfdb6bb5c38..b646c6b73014 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1462,9 +1462,6 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>   	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
>   	u32 **branches = NULL;
>   
> -	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
> -		return -ENOTSUPP;
> -
>   	/*
>   	 * FP + 8       [ RA to parent func ] return address to parent
>   	 *                    function
> 

Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Maybe "stack_size = 0;" in this function is redundant too, if yes,
you can remove it together.

Thanks,
Tiezhu


