Return-Path: <bpf+bounces-59708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB1CACED86
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BD6174E9D
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56E6214A7D;
	Thu,  5 Jun 2025 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ieu1dsbO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EAC1A2C25;
	Thu,  5 Jun 2025 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119145; cv=none; b=AAKknLPTe2DunE9vwTeigrxssffsLkqiK/FRWZtMVxWMjvyCDLUHEoN6keb+DORyTe6r/NtqdOvr32tfh9SnADpkF2Zhkpo2U7mobLJ6TV7lH595Fv26EszY5gsh8/lUnI9FAaay19BD3MR+/2IalRvZFZyVrWE+/nyzj2vkX6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119145; c=relaxed/simple;
	bh=Y6odTPkaS4fOfYNHRYgsmVh7nl91jNEtq7WCKbmDCAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXarD/ypyDiV0rB/Sca4vaQEO6a7P6ViZhyyJh+m9Awh2KHdx1Ca3UeiAbEuLeiAoCiVHQQ5fH7kzT9g1GmZ8YVdmvEaYYQh8bVR65d+6Kbz55xeKENeVlXFoaWHjNd1YppmkZDtNSL3xJOHP/sN203/64VwkX2u378Kujfnkkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ieu1dsbO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-adb2bd27c7bso134255066b.2;
        Thu, 05 Jun 2025 03:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749119141; x=1749723941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itRQPWabF7d6IdaAkp4MBncmkvXPAe8HLLkNyEpU2ug=;
        b=Ieu1dsbO4YNZ0Sij4j9owQnq0t605ibIwCLymHlB2UCaxSQs+HAF2s5OSUmvAESZxx
         yuxm0t3u5g0RbboZq/Xoj61dvDhoCSCQ9qoqoDt/YXQguu0y+d71WhqUUElr8l45XD98
         Pd70PiNiPCxIv7B/4oOMgD5DB3dbu+f5dQVLS5b/PCmXKkQMQP8E7b/HpbWZGXadEvyH
         50FTS4xCsMYIgXIvnwBDDfGyzoeyah0fzdxWqA60xF0+b+Ny5SkFqPybJ7XuzwQkyKZz
         FrVHHiZt2oWGPzNNE4ExqWddIhIWv4UV3NE6/N/Ve2Xnd3q6eTNZhyKZCDBe3lb+eAiK
         tQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119141; x=1749723941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itRQPWabF7d6IdaAkp4MBncmkvXPAe8HLLkNyEpU2ug=;
        b=Ilaflht0no8Cnq0g8KhwNPykndNE2acpXUPkGAkv/FpU9zsleBrpdeGM88ih0/zn6o
         W9skaNzrMXyBxQolk/i6GAEZ4LNgVaYMEA3taeq4Ri6bkEQIg7TKdl3Z7bDlsTKmePZt
         K8qwdVGeYVGKfCMV0SFIpSnPmc3Hd1V6WHEAl5fccMwIRaqFzbDLcEpN9nIAc2+TyG+p
         mEd4cfk+xvBxBpy/5c35p+L+Ljkc8X4FdNybJ4hh2GnUBhZNvux78an8t100wvRswR9s
         wflXnPG4qHYZ3B1g9UBdWCTlxA84F71YOwC5Sq45Y6r3VCJCQyFZke8m9x0pM5n62LvI
         w09g==
X-Forwarded-Encrypted: i=1; AJvYcCUOLG67atCA5QHhNxMrHSco/C8WrZuVKlx0t/8kJHQMKIW5QlUPHnBNZqBqZdA5OpqLtfo=@vger.kernel.org, AJvYcCWaJyU4dHYo+/U8zahCK9eIZq6EATpXtPTwlGDtvQ1T4UzKjFB6JV64+ubbd7VptCKcrVvSdWFZ@vger.kernel.org, AJvYcCWo65KWJ7E4bJajFJsPF5N2mPk8TtlZTHFRVQzP9nZDNLE8erS5F2+P0LiVF6pXrjrgw+pMJwwo0gIhQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp5ZGTm6vxhPrZSs375QzTLK+kHWt0lOyDPQdgyQ4JHHC1+7Cc
	1e6VvMkARAAFKXKqouWMJFO1cjY6EpyMAnfMRXj2d4+es5hPmrO5rcuD
X-Gm-Gg: ASbGncsr1bm2FTlSCPkTLriULdGgiOUbFNMw0Ez8u7+DRVKSwoL3lN7uaSLvWWzARX+
	TYM1v0SrDL7ZdJCcNL4n7WAY1V0gDRYy+he22f9/TJbgz9WKG9CuXcr12PYTtAXEQKFUD0C+R5E
	Xp9fovXiME7KVRCG6o9oMbotm1Cn/7ZNeOIZGfVzEbAA3yvs8LQoLZ9/QU+5UQN9c03kRIcp7ho
	BCPb3oIKpznVCvDGhhomgMSA9CxdckiCnj2S+ZMbGUdncsjMLIbcOBQI9x1XiwQr/KRyzLiV7fz
	EMZBSeeIcAmy5wVRibTJ4ZQ67wR5adf8ODTT0zFJ0WJ8gydDolPtB/amTSpKM68IGJxaB8k0KHE
	=
X-Google-Smtp-Source: AGHT+IEJVIeyPovY+XNoaWDAFKnxn+Gk0ei3Mrur69LBv34N0LN+wxmIwZL7D5wIY9s978A9r9fmyA==
X-Received: by 2002:a17:906:f58c:b0:ad8:93a3:299c with SMTP id a640c23a62f3a-addf8c96579mr614742266b.10.1749119140426;
        Thu, 05 Jun 2025 03:25:40 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb31ea3504sm1104621366b.172.2025.06.05.03.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:25:39 -0700 (PDT)
Message-ID: <29f2c375-65e3-4d22-8274-552653222f8d@gmail.com>
Date: Thu, 5 Jun 2025 11:26:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 03/18] page_pool: use netmem alloc/put APIs in
 __page_pool_alloc_page_order()
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-4-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250604025246.61616-4-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/25 03:52, Byungchul Park wrote:
> Use netmem alloc/put APIs instead of page alloc/put APIs and make it
> return netmem_ref instead of struct page * in
> __page_pool_alloc_page_order().
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> ---
>   net/core/page_pool.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 4011eb305cee..523354f2db1c 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -518,29 +518,29 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t g
>   	return false;
>   }
>   
> -static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
> -						 gfp_t gfp)
> +static netmem_ref __page_pool_alloc_page_order(struct page_pool *pool,
> +					       gfp_t gfp)
>   {
> -	struct page *page;
> +	netmem_ref netmem;
>   
>   	gfp |= __GFP_COMP;
> -	page = alloc_pages_node(pool->p.nid, gfp, pool->p.order);
> -	if (unlikely(!page))
> -		return NULL;
> +	netmem = alloc_netmems_node(pool->p.nid, gfp, pool->p.order);
> +	if (unlikely(!netmem))
> +		return 0;
>   
> -	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page), gfp))) {
> -		put_page(page);
> -		return NULL;
> +	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, netmem, gfp))) {
> +		put_netmem(netmem);

It's a bad idea to have {put,get}_netmem in page pool's code, it has a
different semantics from what page pool expects for net_iov. I.e.
instead of releasing the netmem and allowing it to be reallocated by
page pool, put_netmem(niov) will drop a memory provider reference and
leak the net_iov. Depending on implementation it might even underflow
mp refs if a net_iov is ever passed here.

The second problem is that you pass it page_pool_dma_map(), which
works only with struct page and not net_iov, and so it just
unconditionally casts it back to struct page. Which, to be fair,
a pre-existent issue.

This function deals with pages, can we just use pages instead and
cast to netmem when needed? Sth like in this pseudo code:

netmem_ref __page_pool_alloc_page_order() {
	struct page *p = alloc_pages_order();

	netmem = page_to_netmem(p);
	if (!page_pool_dma_map(netmem)) {
		put_page(p);
		return 0;
	}
	return netmem;
}

-- 
Pavel Begunkov


