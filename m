Return-Path: <bpf+bounces-67525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 305F8B44B5E
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 03:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9396B7AA5FC
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 01:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB631F4C84;
	Fri,  5 Sep 2025 01:55:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16220EB
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 01:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757037356; cv=none; b=CE4kWVmlW/dJ8nwqs96M4jJ8WW3QI/9UCHh3d4jtf4YFYOWumouZvgp6BDMULL9lUHYnUjWi7531HJ06gPKhWcIkTLWyINNhGCOsH1EdrEfI5oAbfjG36IvjGHKJU19FaSb7aEiyAxedLzt6vV5+WLp4ICDWjAApeZmHrpHQ5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757037356; c=relaxed/simple;
	bh=6AByOwb7HisVrmBoPtg6FIKjm018BKX07bq3rjf6kX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k4j69r5FxZDD//jxWgpunz7qQz+3J6+wEA2S+QDpYbvblAztE5mgTcqgKkCjmQkrWXVfVFFKGJuTWtaLALxCb0MTrQDEkBgySN/at4g++xX28NdBxM8k6PSqYFUnkjLyRfoiMrCMxQNqWXRxdqceI1flNMcG+7UsJn7pTIF7SP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cHzpV18CKzQjv8;
	Fri,  5 Sep 2025 09:51:14 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id CC986140278;
	Fri,  5 Sep 2025 09:55:50 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Sep 2025 09:55:50 +0800
Message-ID: <95324d30-2e75-47dd-8ef7-0eb1bc80ab90@huawei.com>
Date: Fri, 5 Sep 2025 09:55:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] riscv, bpf: Remove duplicated bpf_flush_icache()
Content-Language: en-US
To: Hengqi Chen <hengqi.chen@gmail.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<bjorn@kernel.org>, <puranjay@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20250904105119.21861-1-hengqi.chen@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20250904105119.21861-1-hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2025/9/4 18:51, Hengqi Chen wrote:
> The bpf_flush_icache() is done by bpf_arch_text_copy() already.
> Remove the duplicated one in arch_prepare_bpf_trampoline().
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index c7ae4d0a8361..3fcc011c6be4 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1305,7 +1305,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
>   		goto out;
>   	}
>   
> -	bpf_flush_icache(ro_image, ro_image_end);
>   out:
>   	kvfree(image);
>   	return ret < 0 ? ret : size;

Reviewed-by: Pu Lehui <pulehui@huawei.com>

