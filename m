Return-Path: <bpf+bounces-63119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FA8B02B60
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 16:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F523A6CF6
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4158027B4E0;
	Sat, 12 Jul 2025 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD5aUnbb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FC410F9;
	Sat, 12 Jul 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752330065; cv=none; b=AnDbc8VHCN8hZltBy08UJX+pHRSGMk15odOBNjrbXy2KuZNwihUPXvuLPBu3mge+bEHnVLW/2d0LASNnhxAkQ2WzeI2Vq9BuxmlMpi/CSpKdgOwlMGJlkvR+vTPkSdhcWfQAo/rNZBgloV6+DF3r5sT9KtD6vaKMg02lTpY+SEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752330065; c=relaxed/simple;
	bh=y5E3q9p8eUcj8rj4/JOP7JsMwx8O/rkbvrasvr6IxVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iT7g3Qv9EFOQcQPrL9dqEjdk/KLnC3NILJwzOpUFSSTtAPKhFJhG0RtqEeiOkamL0MEO8rQoo66KfFcsogSqIND52OK/NWmd/kxfMDBjF+E55V6piX2n4lIcBQ3JlofM3o0dxUsyWhRgM0XkBXWNsY1n6usl7sLiJafNVO8X1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hD5aUnbb; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so567460866b.2;
        Sat, 12 Jul 2025 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752330062; x=1752934862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwthC4DCRHqmcbQJTGVY9IQZfs3Qx6vlckt2VSx6Buk=;
        b=hD5aUnbbU7yPjF5CxddSvSz1fkJqVsHfs2DHpDwcYpKM15/TP0qOCnd8i/nbNpKe/O
         /n9Bp0j6bKk/KjmgOO70WdYixMOY9PVM261uFdxjquju1dGsuVb5dsJxxPMA8haRqLrf
         JVr3CZ169d5kPox+BuL5OBEcGD3trFiQ7FvQPF4U5YOamYcdOtDTsSYHCWBcElVPjlAK
         pdi2AFwRlyf9+k05mdk3j2DvIDs3Zi2IvU6ckE3vBlduC2OHFEopEv4vdKDvfoLeRl5N
         GrQ4aGXwf0tDEdy/uv0w3LXeGy96X9Elu66r147UAppylHnki7hAu1m4NdGemX8+7NlO
         KKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752330062; x=1752934862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwthC4DCRHqmcbQJTGVY9IQZfs3Qx6vlckt2VSx6Buk=;
        b=gEXT11JqntpfbjFxTnQDfU+L7dBc06hl2fRghPZmv3+11FXoUKOjslv5TOe/2ntmWT
         8eIaFNe6PmmQPCxDjax5DUk4+WAu8Wjodigf9/le5g2m3RJAMF0EkPHzeV1h0eFjWpv1
         2PRDbMq4fRe5tdEAcn8TnmIzK8JFJyoAN2PUThg1ikwl0Ht98quTKZupzUy4wQDDST7K
         20x+X7KNXsfL1SctXTRT9KR8iVsyN+Gd8AGe/jl73NTRXOxuf8TNIIyvTPerZUEmR/GY
         eAiWeM8cnZbl7iMfgadKQIOIWcKZEKjpkxyWzLE2S/nd1NHhObpyGc16GwB5qGMxVIax
         tTsA==
X-Forwarded-Encrypted: i=1; AJvYcCU/2rpvDQq6FQQR67BHUPfHKmVO0MeshyMS33LzLMCMTaxd6kZzzroeW9OmFA76xUbW+bE=@vger.kernel.org, AJvYcCUdU8CABIwTc2Po1nqK4cmkllQokd1ukawCWgm4hIOCHAV6IS6akoMooNiPWdZaSSvfEsFR7yvP@vger.kernel.org, AJvYcCWqUUOEWgTbOFCoPq0hDgZ0mHEiEL3EsKjV2ZfYujARG7wJ2EIIFB1X18J6TBrsWHZ5tRtFMj3pQUtfiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxilYBjJtqYWP7R6LVhTtq2Z/YMLqZmEaS265QyK+nSdjOibC4i
	MyxwAJPOHN6qLGoGYitzerJUfpoSRNWXiXWyT3bi+fttknb4h91Bs563
X-Gm-Gg: ASbGncu/qZbn9Gxyt7g1oAYPzUn6keeHlOW07hDc9wvo49Op1ujOutABNm0XT+lPUYH
	yoVstl5+wbbAByyq8O15IaLvFYIHL/OnPX4eAxfOKNzBg3nzyDfM3EEUyeV1NZnwk2DPWjgTCgg
	scRwxLB50u0VtJNrRvw1Neq+/UVLRtOxtIIQY9l2hC7YrLc28r8ZF0+oTuguSnKHeL/Y3QORoqb
	jDkK/L29pQeOEEQH0iDNI9wdSBVxjUSCi5q7BeidRGqGVV44h8mvzLWxrb2oschvjT9eArPnuc0
	obI+Cfl2o284yML1ZA+gTUTfijjYMBAUtsHl2aFXFhH0iUBHLy5vghqWlGarBrTF8ysk2brptWa
	opLNRq4RT5ICASLeu9r8vVeDjb32IEZT7j7k=
X-Google-Smtp-Source: AGHT+IHbC/0Ser4Z6s4ZYpIrEyyuEbBFkHDfb9uN6SgKFey4bLNkJuh1kQ6Ba8KoZ3nNXGHp32sU/Q==
X-Received: by 2002:a17:906:c10b:b0:ad2:425c:27ce with SMTP id a640c23a62f3a-ae6fbc11865mr730397766b.2.1752330061920;
        Sat, 12 Jul 2025 07:21:01 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:b2ad])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bf2sm485250166b.122.2025.07.12.07.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 07:21:01 -0700 (PDT)
Message-ID: <a21b340d-6d0f-4d39-906e-e983564605ed@gmail.com>
Date: Sat, 12 Jul 2025 15:22:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 8/8] mt76: use netmem descriptor and APIs for
 page pool
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
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-9-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250710082807.27402-9-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/25 09:28, Byungchul Park wrote:
> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
> 
> Use netmem descriptor and APIs for page pool in mt76 code.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> ---
...>   static inline void mt76_set_tx_blocked(struct mt76_dev *dev, bool blocked)
> diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> index 0a927a7313a6..b1d89b6f663d 100644
> --- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> +++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> @@ -68,14 +68,14 @@ mt76s_build_rx_skb(void *data, int data_len, int buf_len)
>   
>   	skb_put_data(skb, data, len);
>   	if (data_len > len) {
> -		struct page *page;
> +		netmem_ref netmem;
>   
>   		data += len;
> -		page = virt_to_head_page(data);
> -		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> -				page, data - page_address(page),
> -				data_len - len, buf_len);
> -		get_page(page);
> +		netmem = virt_to_head_netmem(data);
> +		skb_add_rx_frag_netmem(skb, skb_shinfo(skb)->nr_frags,
> +				       netmem, data - netmem_address(netmem),
> +				       data_len - len, buf_len);
> +		get_netmem(netmem);
>   	}
>   
>   	return skb;
> @@ -88,7 +88,7 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
>   	struct mt76_queue *q = &dev->q_rx[qid];
>   	struct mt76_sdio *sdio = &dev->sdio;
>   	int len = 0, err, i;
> -	struct page *page;
> +	netmem_ref netmem;
>   	u8 *buf, *end;
>   
>   	for (i = 0; i < intr->rx.num[qid]; i++)
> @@ -100,11 +100,11 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
>   	if (len > sdio->func->cur_blksize)
>   		len = roundup(len, sdio->func->cur_blksize);
>   
> -	page = __dev_alloc_pages(GFP_KERNEL, get_order(len));
> -	if (!page)
> +	netmem = page_to_netmem(__dev_alloc_pages(GFP_KERNEL, get_order(len)));
> +	if (!netmem)
>   		return -ENOMEM;
>   
> -	buf = page_address(page);
> +	buf = netmem_address(netmem);

We shouldn't just blindly convert everything to netmem just for the purpose
of creating a type casting hell. It's allocating a page, and continues to
use it as a page, e.g. netmem_address() will fail otherwise. So just leave
it to be a page, and convert it to netmem and the very last moment when
the api expects a netmem. There are likely many chunks like that.

>   
>   	sdio_claim_host(sdio->func);
>   	err = sdio_readsb(sdio->func, buf, MCR_WRDR(qid), len);
> @@ -112,7 +112,7 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
>   
>   	if (err < 0) {
>   		dev_err(dev->dev, "sdio read data failed:%d\n", err);
> -		put_page(page);
> +		put_netmem(netmem);
>   		return err;
>   	}
>   
> @@ -140,7 +140,7 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_rxq_id qid,
>   		}
>   		buf += round_up(len + 4, 4);
>   	}
> -	put_page(page);
> +	put_netmem(netmem);
>   
>   	spin_lock_bh(&q->lock);
>   	q->head = (q->head + i) % q->ndesc;
-- 
Pavel Begunkov


