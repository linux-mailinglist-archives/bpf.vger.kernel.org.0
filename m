Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FBA46E407
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 09:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbhLIIX2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 03:23:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36171 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234599AbhLIIX1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Dec 2021 03:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639037994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEpawBZHKqDeDQKo/yN12N0IK537hgmoTf00FptBiYQ=;
        b=jWRwL24iXXXjNCIZ/8165HENs8a/z8hQXVjyn0ZAqlbeFo94lvsywdvRFgHDvk7g13j7Lp
        IsENhxznay+dGVhuJzGrK3Cm7+aXD+/3kjEWjFzBhNndOmRxvDlKOSl+iEwd0mJo0SW1CC
        wMde50UuzIHP3+H/2JG5Sb/PiOtKOZE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-CBfQ_ayJO7q3l0lWgdpAHA-1; Thu, 09 Dec 2021 03:19:51 -0500
X-MC-Unique: CBfQ_ayJO7q3l0lWgdpAHA-1
Received: by mail-lj1-f200.google.com with SMTP id w16-20020a05651c103000b00218c9d46faeso1530254ljm.2
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 00:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=rEpawBZHKqDeDQKo/yN12N0IK537hgmoTf00FptBiYQ=;
        b=EOfZYM/8V4g/ZCIRmldUV4+2hlW0PJY+89mEcRs4SyKYvrQVXE3LCu2z5erQgeZxXF
         IVSL8DYNj/4vIciYrXQ91rG2BmxVzQtiPgTk4bDgYoXnFFeonz57ew3MAIRixiyWsmgg
         CdIMCbCdXFdHUJ7p4rrEq2R+u31tP1tTjw+MH5JOFmFfwYAx+p9JlOTIG6PLQjmrzwtt
         jJcGW2YRdxSsHEswwa3vusfV71FlmzWXPZeq95AFKfgK0Q/nYBSbJ3tZ45RdXf1MhA8q
         1GHQ/3aeXmz2q8HPYa3q2KwfUfhqywpL7jjdIdN7RhmNrRHqjlZw/RbvCj4Db0nSJbgp
         fEig==
X-Gm-Message-State: AOAM533wr8vW4WSfko9VC2D7ftPUlIDbAoGr4K+dDps7you58LIB1FVy
        wU3OjAxpXY1NOB4TAgvajos7MZfaQMENSeS43A77WcumN/eYIW1H1HvQtbLjn/vGc/YsTJL7liW
        15bhCIEKSVeq2
X-Received: by 2002:a05:6512:3081:: with SMTP id z1mr4632974lfd.583.1639037989629;
        Thu, 09 Dec 2021 00:19:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyS/NhDYClzEMqPHgcZJoc8Qn3jO1V0yHANyUzHNzpfzXYHvvQ5/cG/fdFk6UVQADSQjn3bhg==
X-Received: by 2002:a05:6512:3081:: with SMTP id z1mr4632963lfd.583.1639037989444;
        Thu, 09 Dec 2021 00:19:49 -0800 (PST)
Received: from [192.168.0.50] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id m10sm527889lji.11.2021.12.09.00.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 00:19:48 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <da317f39-8679-96f7-ec6f-309216b02f33@redhat.com>
Date:   Thu, 9 Dec 2021 09:19:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 net-next 1/9] i40e: don't reserve excessive
 XDP_PACKET_HEADROOM on XSK Rx to skb
Content-Language: en-US
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        intel-wired-lan@lists.osuosl.org
References: <20211208140702.642741-1-alexandr.lobakin@intel.com>
 <20211208140702.642741-2-alexandr.lobakin@intel.com>
In-Reply-To: <20211208140702.642741-2-alexandr.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 08/12/2021 15.06, Alexander Lobakin wrote:
> {__,}napi_alloc_skb() allocates and reserves additional NET_SKB_PAD
> + NET_IP_ALIGN for any skb.
> OTOH, i40e_construct_skb_zc() currently allocates and reserves
> additional `xdp->data - xdp->data_hard_start`, which is
> XDP_PACKET_HEADROOM for XSK frames.
> There's no need for that at all as the frame is post-XDP and will
> go only to the networking stack core.

I disagree with this assumption, that headroom is not needed by netstack.
Why "no need for that at all" for netstack?

Having headroom is important for netstack in general.  When packet will 
grow we avoid realloc of SKB.  Use-case could also be cpumap or veth 
redirect, or XDP-generic, that expect this headroom.


> Pass the size of the actual data only to __napi_alloc_skb() and
> don't reserve anything. This will give enough headroom for stack
> processing.
> 
> Fixes: 0a714186d3c0 ("i40e: add AF_XDP zero-copy Rx support")
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index f08d19b8c554..9564906b7da8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -245,13 +245,11 @@ static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
>   	struct sk_buff *skb;
>   
>   	/* allocate a skb to store the frags */
> -	skb = __napi_alloc_skb(&rx_ring->q_vector->napi,
> -			       xdp->data_end - xdp->data_hard_start,
> +	skb = __napi_alloc_skb(&rx_ring->q_vector->napi, datasize,
>   			       GFP_ATOMIC | __GFP_NOWARN);
>   	if (unlikely(!skb))
>   		goto out;
>   
> -	skb_reserve(skb, xdp->data - xdp->data_hard_start);
>   	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
>   	if (metasize)
>   		skb_metadata_set(skb, metasize);
> 

