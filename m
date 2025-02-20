Return-Path: <bpf+bounces-52077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E820A3DA0A
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 13:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9C8423593
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74AC1F7069;
	Thu, 20 Feb 2025 12:25:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FD51F463E;
	Thu, 20 Feb 2025 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054301; cv=none; b=NvFg5/zHh15c2UMOe9aoo4CkmHLeTmH5FARbmS4on1LqC2pDKGp8EUHAKZEWrrLnLX1uoeR0CZ03xHfZv91Cz9fTrdM8Q3g5A/KdN5jwdesGbVshVTToa//EzCy6yTikDI2/mRF1ce0mfq6RMoQwThXojt67AnvGXL+2BzrrLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054301; c=relaxed/simple;
	bh=9lDxV9SZANXBV7H7rNmJV5m4Mh5PQt86AdSh42FbJeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k8kmWX5pMIkG3PoorQuwz2py0rnyg1VPv72Fho4UmmmyXs4fKUBcG2xomDnWQwEMaGWQlWOMFUzSmh022LlGSxgepyZvXMczVxw0COdGTUV/ljxQJMjybydNl/DiMMIzPtzzSYmS6Wlmj3CPjEgFMilLYXA889PZwezc81rjU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YzC8j6JLvzWmMc;
	Thu, 20 Feb 2025 20:23:17 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 12F7C140390;
	Thu, 20 Feb 2025 20:24:51 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 20:24:50 +0800
Message-ID: <c6a25b61-6545-4a03-b2f1-a38c07037d29@huawei.com>
Date: Thu, 20 Feb 2025 20:24:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btf: move kern_type_id to goto cand_cache_unlock
Content-Language: en-US
To: Ethan Carter Edwards <ethan@ethancedwards.com>, Andrii Nakryiko
	<andrii@kernel.org>
CC: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
	<eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20250220-bpf-uninit-v1-1-af07a5a57e5b@ethancedwards.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20250220-bpf-uninit-v1-1-af07a5a57e5b@ethancedwards.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100007.china.huawei.com (7.202.181.221)

On 2025/2/20 13:50, Ethan Carter Edwards wrote:
> In most code paths variable move_kern_type_id remains uninitialized upon
> return. By moving it to the goto, it is initialized in these code paths.
> As well as others. Caught by Coverity.
> 
> Closes: https://scan5.scan.coverity.com/#/project-view/63874/10063?selectedIssue=1595567
> Fixes: e2b3c4ff5d183d ("bpf: add __arg_trusted global func arg tag")
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>   kernel/bpf/btf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9de6acddd479b4f5e32a5e6ba43cf369de4cee29..8c82ced7da299ad1ad769024fe097898c269013b 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7496,9 +7496,9 @@ static int btf_get_ptr_to_btf_id(struct bpf_verifier_log *log, int arg_idx,
>   		err = -EOPNOTSUPP;
>   		goto cand_cache_unlock;
>   	}
> -	kern_type_id = cc->cands[0].id;
>   
>   cand_cache_unlock:
> +	kern_type_id = cc->cands[0].id;

Hi, for goto's branches, it will always `return err`, no need to make 
this move.

>   	mutex_unlock(&cand_cache_mutex);
>   	if (err)
>   		return err;
> 
> ---
> base-commit: 87a132e73910e8689902aed7f2fc229d6908383b
> change-id: 20250220-bpf-uninit-3323a4426da9
> 
> Best regards,

