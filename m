Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D3E406F87
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 18:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhIJQTa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 12:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229686AbhIJQT3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 12:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631290698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bVwb4xgVCPE4xO7m7QqDyPvYMqtac8bl6AY+84GyYjg=;
        b=gJWxaCy8ZgSw+YCAK7sCxET1ow2N+WCkZfvr8OTP8ky9Ct/kiNqSSRC1MToqVKJA/i+ni/
        LdD4usiiktrEqYwPqdU6G7karNFxNoPMulPxW6fCfcImwWJHl5fvyfU/GTIedY+0x0zoPY
        SjqgIxAv915UZbmEFcz+0QtRHy4ZfCA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-u-rNDLtwOCSUyEPSOEx4MQ-1; Fri, 10 Sep 2021 12:18:17 -0400
X-MC-Unique: u-rNDLtwOCSUyEPSOEx4MQ-1
Received: by mail-lj1-f197.google.com with SMTP id v2-20020a2e5042000000b001def54ff19eso1152064ljd.2
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 09:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bVwb4xgVCPE4xO7m7QqDyPvYMqtac8bl6AY+84GyYjg=;
        b=hICZJUgvlGH1JJ489HzKwTaGMXTkUR2DXYvNTeV7tSVHE3dDreAenudsrmiG4l/SaE
         ppPdBKEvoI4dOqqPx3JAAZaXb+MhzQG1uF1q7rquVzI+WdUG+B0/vwsg2aqY+ZX0Etm7
         xgMxIHY++85elZNf2spwEi0pWCOqcUU730enCZ08eI5YZAQUld4fQBNIXzMYwPfow1ys
         Dp+H3/6iw8eS2jB/MQKxZvz4k6wLoNMFaaKl9zLZMV983K+TsSBsEtPsouyOQfaXzIKC
         TFvxQ2TQcDKKzlqhzFq8vfUwaGXj9nmwQQinyPKOHwapL8N0faku8Y+u9vlB5TCXBAif
         9dTA==
X-Gm-Message-State: AOAM531dqMpoQIBfjkVcmrpudq08Mf5VZTZ0eNMhjV7UB0PXeY4rOQyq
        Q76jOTQJBiDIDy961g+8aGA06OCV8Henrl4aq5dhCpxxfl9jX1Ww5wvKd5QqzAN/IDCi6hN/swk
        77wPSrr4cdhQj
X-Received: by 2002:a2e:9a59:: with SMTP id k25mr4705314ljj.52.1631290695377;
        Fri, 10 Sep 2021 09:18:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6n3E/WZ4PU7yxujz/KFg/XsuTTIhEoHX7uVNUP6UXPYZWkTUfqvEDkBW6zaG7MScUjvz3LA==
X-Received: by 2002:a2e:9a59:: with SMTP id k25mr4705307ljj.52.1631290695199;
        Fri, 10 Sep 2021 09:18:15 -0700 (PDT)
Received: from [192.168.42.238] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id o17sm452308lfi.203.2021.09.10.09.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 09:18:14 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, shayagr@amazon.com, john.fastabend@gmail.com,
        dsahern@kernel.org, echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com, toke@redhat.com
Subject: Re: [PATCH v14 bpf-next 01/18] net: skbuff: add size metadata to
 skb_shared_info for xdp
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
References: <cover.1631289870.git.lorenzo@kernel.org>
 <1a6336639c151227b263d6d621c490a8267d4119.1631289870.git.lorenzo@kernel.org>
Message-ID: <4aef85af-5843-91ca-39db-e7cd2e9cdf28@redhat.com>
Date:   Fri, 10 Sep 2021 18:18:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1a6336639c151227b263d6d621c490a8267d4119.1631289870.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 10/09/2021 18.14, Lorenzo Bianconi wrote:
> Introduce xdp_frags_truesize field in skb_shared_info data structure
> to store xdp_buff/xdp_frame truesize (xdp_frags_truesize will be used
> in xdp multi-buff support). In order to not increase skb_shared_info
> size we will use a hole due to skb_shared_info alignment.
> Introduce xdp_frags_size field in skb_shared_info data structure
> reusing gso_type field in order to store xdp_buff/xdp_frame paged size.
> xdp_frags_size will be used in xdp multi-buff support.
> 
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   include/linux/skbuff.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>


> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 6bdb0db3e825..769ffd09f975 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -522,13 +522,17 @@ struct skb_shared_info {
>   	unsigned short	gso_segs;
>   	struct sk_buff	*frag_list;
>   	struct skb_shared_hwtstamps hwtstamps;
> -	unsigned int	gso_type;
> +	union {
> +		unsigned int	gso_type;
> +		unsigned int	xdp_frags_size;
> +	};
>   	u32		tskey;
>   
>   	/*
>   	 * Warning : all fields before dataref are cleared in __alloc_skb()
>   	 */
>   	atomic_t	dataref;
> +	unsigned int	xdp_frags_truesize;
>   
>   	/* Intermediate layers must ensure that destructor_arg
>   	 * remains valid until skb destructor */
> 

