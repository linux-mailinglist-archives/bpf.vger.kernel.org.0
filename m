Return-Path: <bpf+bounces-66063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BB6B2D452
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 08:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A873AFE2F
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 06:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FD92C21D3;
	Wed, 20 Aug 2025 06:52:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5019217F27;
	Wed, 20 Aug 2025 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672733; cv=none; b=FLDwgTfdbdUzocKTLY5I0oO3eSV5FT8TocR2Rup5sCeuXNKn3JDeACxkJ0/qDj8SjxRmMo3a3WHoqJ1QgGKUmkhfbNIvBcU7Hv9Dpw8vcdZIX1+4pf8J7HqQL20baXlkric9XycW5TZ5DfHBtgVA4wZ/1HAR0Bjogi/YY9Z6TBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672733; c=relaxed/simple;
	bh=lftg13XEh+sVNwkBhLmMfjNGdF9EO0ZzzIRQu3aI6rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hqh1PxawCnEtQfeTQVLiLoHTTvMXumynvvwoTfNrWbj1vrWl5dkorKuqSU4C/QSsI0kfn7f6LViOvBg/z5rN4JzZrtvKoJrDru957NzhEtuX0Nrmf1Rh3ZL0BHbWlcZ3GjpUpPI5hn8taKM2r0AMjT2xsyoUj6dSzvll4X+G7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c6H7h0Gf5zPqcX;
	Wed, 20 Aug 2025 14:47:28 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id DD612180080;
	Wed, 20 Aug 2025 14:52:03 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Aug 2025 14:52:02 +0800
Message-ID: <8b836b6e-103a-41c2-b111-0417d8db4dce@huawei.com>
Date: Wed, 20 Aug 2025 14:52:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: bpf: Fix uninitialized symbol 'retval_off'
Content-Language: en-US
To: Chenghao Duan <duanchenghao@kylinos.cn>, <ast@kernel.org>,
	<bjorn@kernel.org>, <puranjay@kernel.org>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
CC: <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
	<haoluo@google.com>, <jolsa@kernel.org>, <alex@ghiti.fr>,
	<bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250820062520.846720-1-duanchenghao@kylinos.cn>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20250820062520.846720-1-duanchenghao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/8/20 14:25, Chenghao Duan wrote:
> In __arch_prepare_bpf_trampoline(), retval_off is only meaningful when
> save_ret is true, so the current logic is correct. However, in the

lgtm, and same for `ip_off`, pls patch it together.

> original logic, retval_off is only initialized under certain
> conditions, which may cause a build warning.
> 
> So initialize retval_off unconditionally to fix it.
> 
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 10e01ff06312..49bbda8372b0 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1079,10 +1079,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	stack_size += 16;
>   
>   	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
> -	if (save_ret) {
> +	if (save_ret)
>   		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
> -		retval_off = stack_size;
> -	}
> +	retval_off = stack_size;
>   
>   	stack_size += nr_arg_slots * 8;
>   	args_off = stack_size;

