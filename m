Return-Path: <bpf+bounces-34074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC48892A1FE
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 14:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 300D0B236A6
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 12:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57B213FD72;
	Mon,  8 Jul 2024 12:02:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908E713E04F;
	Mon,  8 Jul 2024 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440137; cv=none; b=cXoKKGQrzVzciX+O5hsBeK5YUq5HC+y+U4AXoFeEil9oiqT1gtvj0Oz5lfPwuQAcktLa1VY1MJgcuck9REkMUkcLA7A0I79poL29tIbBCl5soz58QfDRyI98CY5d4fGaheHcV3ULpqPOqj1bpWCLRU1VZ+Rxga0+ZbeKjp0yO+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440137; c=relaxed/simple;
	bh=t6Zv/lqQ79ZwHHAQ1h9A/xnNXcBw2yoD7S6LlS/Fqds=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=csatPhi0gLFpkvO8BkXVqSSURA3UWlVevRhO+cJMYXpdE550zMjf3qvbKX/SDnT7hxO72D3uExG5hmvYBeoX7F3Bb0jPNejqUGY1tQ51bmUg3tRLs9woA7poHH2Io5sUT+f++EfJsYoJjWtZdwg/Wf/1Otp3KVwXKFOYSA2aRt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WHjKh19jKzwWBn;
	Mon,  8 Jul 2024 19:57:28 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 48202140156;
	Mon,  8 Jul 2024 20:02:08 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jul 2024 20:02:07 +0800
Message-ID: <d9abcecb-1de1-4c88-923a-b465fb87ca51@huawei.com>
Date: Mon, 8 Jul 2024 20:02:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] riscv, bpf: Optimize stack usage of trampoline
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>
References: <20240708114758.64414-1-puranjay@kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Puranjay Mohan
	<puranjay12@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	<bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20240708114758.64414-1-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2024/7/8 19:47, Puranjay Mohan wrote:
> When BPF_TRAMP_F_CALL_ORIG is not set, stack space for passing arguments
> on stack doesn't need to be reserved because the original function is
> not called.
> 
> Only reserve space for stacked arguments when BPF_TRAMP_F_CALL_ORIG is
> set.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 685c7389ae7e..0795efdd3519 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -892,7 +892,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	stack_size += 8;
>   	sreg_off = stack_size;
>   
> -	if (nr_arg_slots - RV_MAX_REG_ARGS > 0)
> +	if ((flags & BPF_TRAMP_F_CALL_ORIG) && (nr_arg_slots - RV_MAX_REG_ARGS > 0))
>   		stack_size += (nr_arg_slots - RV_MAX_REG_ARGS) * 8;
>   
>   	stack_size = round_up(stack_size, STACK_ALIGN);

Thanks!

Acked-by: Pu Lehui <pulehui@huawei.com>

