Return-Path: <bpf+bounces-39172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD58196FD50
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FC11F2605C
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E518B15990E;
	Fri,  6 Sep 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vUuR3q29"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC57159209
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658020; cv=none; b=H5AUibygJrRQpjE91IvEsOFeexPLS29PBL9u1ze3rqT6izDKekQ/SPL9M1+43cwyoucsMiaipnvWMaIVo7RNGM2eUG8YkHqOMBRAoiSibSlgLLjKCqIj81NZNRDt8Nj2JXm31jP5ImLVWjIEbnGirT5fUknBvc7PAbb5JIMi7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658020; c=relaxed/simple;
	bh=qDf0sb0zPsk31XSFWnAJCXFWqxuz317WwFUOXHBUD0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJeC5JTmZAuOW+6/DMhvJP1VTCUgoWobehEKQGzfASuI8C+AYvxPlB7HK7AA2cyc2e/hh1HZqDHYRKKBFxi0v+hr4Q/G09RMXgKBhfxHlOtbt6kj2fDZdDOfhYEkBOHCm5dGm6tTpX5wYdCKHZvNGpwpDcSEa0tEdlNZkyeXkFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vUuR3q29; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0467d279-e825-4c15-ac85-859fc6b95ee2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725658015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2P9GMowORIBDHwl53frehcwBdS235SGtbdUPMq/wILw=;
	b=vUuR3q29yw/UATf/+C5Qwr5M/xBvFNMgwkGYaZa4IpNQrHtFnaSUzJllEaS1AyWoSXLjsO
	YZEiVnIm186jVC0u/xRV3Ht0shQhkSHon4J4DfUamS5p/AWY+H77FIakjlr4wOIYbVgQO7
	iVFW92hsZlfGOxkZq0bqd9UOCHrLjl8=
Date: Fri, 6 Sep 2024 14:26:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] sock_map: add a cond_resched() in sock_hash_free()
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>
References: <20240906154449.3742932-1-edumazet@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240906154449.3742932-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/6/24 8:44 AM, Eric Dumazet wrote:
> Several syzbot soft lockup reports all have in common sock_hash_free()
> 
> If a map with a large number of buckets is destroyed, we need to yield
> the cpu when needed.
> 
> Fixes: 75e68e5bf2c7 ("bpf, sockhash: Synchronize delete from bucket list on map free")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>   net/core/sock_map.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index d3dbb92153f2fe7f1ddc8e35b495533fbf60a8cb..724b6856fcc3e9fd51673d31927cfd52d5d7d0aa 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1183,6 +1183,7 @@ static void sock_hash_free(struct bpf_map *map)
>   			sock_put(elem->sk);
>   			sock_hash_free_elem(htab, elem);
>   		}
> +		cond_resched();

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

Jakub, may be you can directly take it to net tree ?


