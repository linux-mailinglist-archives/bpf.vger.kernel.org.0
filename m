Return-Path: <bpf+bounces-22202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5A5858E8F
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 11:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629F71F2215F
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 10:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CC21DDC9;
	Sat, 17 Feb 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6Spw9tF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE01DA3D;
	Sat, 17 Feb 2024 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708164432; cv=none; b=GvARgCK2sQecXbZ9pSmUJ4nD9weRI1GhmIMNUEn4DxVmO4Ykt5GryVppWknHdJi46CrahkWmzLCVVSpd337OUtQG9+82WQE+vUQ7MX2uNFE/FB5LyuaGIUyAKKlqXoXOo9yFxgkkX0eYp9aq8aqltgM9n/WtjSyP9hgJDnnnugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708164432; c=relaxed/simple;
	bh=JavLGhUTJDpG8aaqbfw3hSE1Z1tpC/+8PIHUmyudyvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYHzEKxlu5sZrJPCA7o8oC1D8HXLjHMQhUB3i74FAdKJmYM8iD/tdNpn/MwoJhzPA5XdJ9HJQMPsNpNBG3akc/7cNPex3reuqm0/9hkItmG64Ing86qyelcygQRdP/8H6mYS8/D2oWOmyeBZC4UgqsG4ZE9zHlYn6lT0lZo0sFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6Spw9tF; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511a02b82dbso1135140e87.0;
        Sat, 17 Feb 2024 02:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708164424; x=1708769224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xcGMykGXnDItFmDLKz+olIPa5dx1f4SG2gEoYVEaPaw=;
        b=Y6Spw9tFOprSWJbLIzrtdGfnBELoxZjeZchGGkOMuE+QICtt66+pZCRi6LJOmiBVx/
         RedtWTcyOy1df9EcZsSdacpr7/qTfD7zVHTKbFVCqHvn8QoYdwIzsI4Mo8EKS88oDxHT
         QnJvtmPTbLw7UQEpnrJXHb+RE34F/UuSeCAE8Sehha2r7fYYSXab9bWZumA/7NpDZS9O
         DUd+qSLV1J//QaHFmWiruHuYe+jsv0v5w48WLoBhJsUJ5mD9bn60Wi0FgOuip62ttFV3
         Ed7SzTJ6F25bJCBvNGQqz76ab0cJxl8E03dNBGX+Ryyu6U4Q2/uIz0bUqVn/AEo2y5pf
         gJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708164424; x=1708769224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcGMykGXnDItFmDLKz+olIPa5dx1f4SG2gEoYVEaPaw=;
        b=RCdUC3jRS5q1Y15+aqVJma8nFbeofExr+W9orP2GKFH7YuexpuNKULY1FhkxCaqgbX
         PyFVLusIFkU7VJQl8yKxDBbCLNABbFfEk8JYIWKmVB4icSOinJ8bcf1KJEqLIl6SZ/hm
         5BvgnPaBMHydt++aWxkv6B1x/TKTtIR2JE1t2ctxl4ViypvBM8HxEgT12IG5tKEVkl+O
         HaEi/i9KYBdThIOCdeXQUuxJYBxqdhiRfQJ1QHAtWzy5afV4SVsyPf8c1LMkOPYjwlp/
         EBHi8Y+yWwgcxfj+lRA0RCD5wL3rCJQ9H/kcYCcvWCdB5nMLCrDZTxf77zrhmX1S3Kj8
         UxIw==
X-Forwarded-Encrypted: i=1; AJvYcCUV/SJ56k0Kl6hXfabWZszWoUFlquAkDKbcc4/S+TpTMIj0Rog0CCfQNys7rsN0lCn/6RJJKDpe9+tn+z5SomtVoTpRpQX255AgHHM2owZIkbav3/WeJ9pY8FB/
X-Gm-Message-State: AOJu0YxdP3Qx8JiFNBfjwpLrLRFd8DCyddqmC810/DeHlfXJsUmcNwxC
	IAIugJCgBJZb0sFH/rpfYP9UaZA20DezgAF1YQfC3iLM4OzlLr24
X-Google-Smtp-Source: AGHT+IFZITD1alzdjiGsGJWP4t2oMSqBd0n4h0pF+hbK4bjvdtIidy9ksejZPHT3MI0ztxbRiQ0d1A==
X-Received: by 2002:a19:7016:0:b0:511:9ea2:f589 with SMTP id h22-20020a197016000000b005119ea2f589mr2604639lfc.0.1708164423822;
        Sat, 17 Feb 2024 02:07:03 -0800 (PST)
Received: from [192.168.8.105] (m91-129-97-170.cust.tele2.ee. [91.129.97.170])
        by smtp.gmail.com with ESMTPSA id c33-20020a05651223a100b00512a740d502sm101221lfv.108.2024.02.17.02.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 02:07:03 -0800 (PST)
Message-ID: <8b68b781-879a-43b5-be41-7b5f75342daf@gmail.com>
Date: Sat, 17 Feb 2024 12:07:01 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 net-next 3/4] xdp: add multi-buff support for xdp
 running in generic mode
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 toke@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 sdf@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 linyunsheng@huawei.com
References: <cover.1707729884.git.lorenzo@kernel.org>
 <1044d6412b1c3e95b40d34993fd5f37cd2f319fd.1707729884.git.lorenzo@kernel.org>
Content-Language: en-US
From: Julian Wiedmann <jwiedmann.dev@gmail.com>
In-Reply-To: <1044d6412b1c3e95b40d34993fd5f37cd2f319fd.1707729884.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12.02.24 11:50, Lorenzo Bianconi wrote:
> Similar to native xdp, do not always linearize the skb in
> netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
> processed by the eBPF program. This allow to add multi-buffer support
> for xdp running in generic mode.
> 
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Reviewed-by: Toke Hoiland-Jorgensen <toke@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/linux/skbuff.h |  2 +
>  net/core/dev.c         | 70 +++++++++++++++++++++++---------
>  net/core/skbuff.c      | 91 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 144 insertions(+), 19 deletions(-)
> 

[...]

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 9e5eb47b4025..bdb94749f05d 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -895,6 +895,97 @@ static bool is_pp_page(struct page *page)
>  	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
>  }
>  
> +static int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
> +			   unsigned int headroom)
> +{
> +#if IS_ENABLED(CONFIG_PAGE_POOL)
> +	u32 size, truesize, len, max_head_size, off;
> +	struct sk_buff *skb = *pskb, *nskb;
> +	int err, i, head_off;
> +	void *data;
> +
> +	/* XDP does not support fraglist so we need to linearize
> +	 * the skb.
> +	 */
> +	if (skb_has_frag_list(skb))
> +		return -EOPNOTSUPP;
> +
> +	max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE - headroom);
> +	if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
> +		return -ENOMEM;
> +
> +	size = min_t(u32, skb->len, max_head_size);
> +	truesize = SKB_HEAD_ALIGN(size) + headroom;
> +	data = page_pool_dev_alloc_va(pool, &truesize);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	nskb = napi_build_skb(data, truesize);
> +	if (!nskb) {
> +		page_pool_free_va(pool, data, true);
> +		return -ENOMEM;
> +	}
> +
> +	skb_reserve(nskb, headroom);
> +	skb_copy_header(nskb, skb);
> +	skb_mark_for_recycle(nskb);
> +
> +	err = skb_copy_bits(skb, 0, nskb->data, size);
> +	if (err) {
> +		consume_skb(nskb);
> +		return err;
> +	}
> +	skb_put(nskb, size);
> +
> +	head_off = skb_headroom(nskb) - skb_headroom(skb);
> +	skb_headers_offset_update(nskb, head_off);
> +
> +	off = size;
> +	len = skb->len - off;
> +	for (i = 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
> +		struct page *page;
> +		u32 page_off;
> +
> +		size = min_t(u32, len, PAGE_SIZE);
> +		truesize = size;
> +
> +		page = page_pool_dev_alloc(pool, &page_off, &truesize);
> +		if (!data) {
> +			consume_skb(nskb);
> +			return -ENOMEM;
> +		}
> +

This should check for !page instead, no?

(picked up as CID 1583654 by the coverity scan for linux-next)

