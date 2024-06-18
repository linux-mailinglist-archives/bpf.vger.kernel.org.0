Return-Path: <bpf+bounces-32399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E0290C7B6
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 12:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF49428541C
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42414155C97;
	Tue, 18 Jun 2024 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqAOasgD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33AE13DB99;
	Tue, 18 Jun 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702009; cv=none; b=iX8ZsYfkkTC9Og4nnkXRtkofTUtEm9vgQIxCJtKtiaxhhbmTcGpKkLlx/pHZnYcphU4x+wjQ7K2yVVJD9CJ4Mlzev2khlpnHCttVPPyUOAQvEAQxKSozx8f+sjVS7bOsLz1gOYK6VAn56hcitjcxThD7HoMXjiq2Riv8v+R/Xxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702009; c=relaxed/simple;
	bh=b3HK2kOnus2xn44LD4/7n1YbYkes4t+zstxuJ2EcEtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxWRIlG7EnoGAQIpABnvzaresHZ+I/2OUMLXj2P0fnjN9E0+MbvX3z1+M7ytTrZQha74pFKhVvDX+XvPa9D9pqsdTvQA92spZ9wr5+8qoZUQFmbeOOzn+bxiVY4L1kQO2rAIs2a7eDii3ujMLEClQh25ji0BsV6ulSas7dHT8dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqAOasgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25A6C4AF1D;
	Tue, 18 Jun 2024 09:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718702009;
	bh=b3HK2kOnus2xn44LD4/7n1YbYkes4t+zstxuJ2EcEtM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IqAOasgDKg0i8YKqY+6jfNvoc+FomZys6U4FtzsyyOQVf641TkJyp7gaY/BC+2JyT
	 LRtVUJo8Ck5AoECAgx+mPjvwtQdzZMEhCamBtjo25a0yju+yorMgNePo0ngFYxc4aw
	 J70W0SrSHlNOLgGaW2w12SoZvw9VJb7UEM6JNlgQgoRlU8FvjANC5mWRmRxhzMrVT5
	 FaaZrC0L0nCDperZloobwzIDYJFTnDf6QSt7rM6BvLylb6aThK5Vnbm1+D9/YtEvUi
	 3gdxuOdYlrUyo9sdZde9D9BNoqqFL6KfKO7llmEfz8/0lBzdDtLD2Fy0/LkGLqpq8W
	 3KbnudCA8KRgQ==
Message-ID: <655bbb57-3806-44fe-81a9-5c6e8d1e048c@kernel.org>
Date: Tue, 18 Jun 2024 11:13:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xdp: remove WARN() from __xdp_reg_mem_model()
To: Daniil Dulov <d.dulov@aladdin.ru>, Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240617162708.492159-1-d.dulov@aladdin.ru>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240617162708.492159-1-d.dulov@aladdin.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/06/2024 18.27, Daniil Dulov wrote:
> Syzkaller reports a warning in __xdp_reg_mem_model().
> 
> The warning occurs only if __mem_id_init_hash_table() returns
> an error. It returns the error in two cases:
> 
>      1. memory allocation fails;
>      2. rhashtable_init() fails when some fields of rhashtable_params
>         struct are not initialized properly.
> 
> The second case cannot happen since there is a static const
> rhashtable_params struct with valid fields. So, warning is only triggered
> when there is a problem with memory allocation.
> 
> Thus, there is no sense in using WARN() to handle this error and it can be
> safely removed.
> 
> WARNING: CPU: 0 PID: 5065 at net/core/xdp.c:299 __xdp_reg_mem_model+0x2d9/0x650 net/core/xdp.c:299
> 
> CPU: 0 PID: 5065 Comm: syz-executor883 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> RIP: 0010:__xdp_reg_mem_model+0x2d9/0x650 net/core/xdp.c:299
> 
> Call Trace:
>   xdp_reg_mem_model+0x22/0x40 net/core/xdp.c:344
>   xdp_test_run_setup net/bpf/test_run.c:188 [inline]
>   bpf_test_run_xdp_live+0x365/0x1e90 net/bpf/test_run.c:377
>   bpf_prog_test_run_xdp+0x813/0x11b0 net/bpf/test_run.c:1267
>   bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4240
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5649
>   __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
>   do_syscall_64+0xfb/0x240
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 8d5d88527587 ("xdp: rhashtable with allocator ID to pointer mapping")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> ---
>   net/core/xdp.c | 1 -
>   1 file changed, 1 deletion(-)
> 

Sure, looks like we can remove this WARN_ON()

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 41693154e426..fb2f00e3f701 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -296,7 +296,6 @@ static struct xdp_mem_allocator *__xdp_reg_mem_model(struct xdp_mem_info *mem,
>   		ret = __mem_id_init_hash_table();
>   		mutex_unlock(&mem_id_lock);
>   		if (ret < 0) {
> -			WARN_ON(1);
>   			return ERR_PTR(ret);
>   		}
>   	}

