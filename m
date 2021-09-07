Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5CA402AEC
	for <lists+bpf@lfdr.de>; Tue,  7 Sep 2021 16:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbhIGOka (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 10:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231667AbhIGOk3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 10:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631025563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWg0sqChxjVCKWuzF+VAVos/r0t2VNxT/zhEmY7OWok=;
        b=h0QMAyGL80affMI68F/fuch8jFmDYs6i5HS6d1hsg/9WjxY18B1nJoxsnwZT9ExENi9MMD
        EMRJbiV2Zmh8oLP31tqsg4IJ3joPt+Zs3ZCYVvQiAjddFKPvFkUNugP+phqUs8rpKFb1F1
        eLh7xiUet1aJ+bpdkNDVvLIVQVLpPbs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-HJy3SfWKNPuY6ibknf8ZEQ-1; Tue, 07 Sep 2021 10:39:21 -0400
X-MC-Unique: HJy3SfWKNPuY6ibknf8ZEQ-1
Received: by mail-wr1-f72.google.com with SMTP id p10-20020adfce0a000000b001572d05c970so2181371wrn.21
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 07:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tWg0sqChxjVCKWuzF+VAVos/r0t2VNxT/zhEmY7OWok=;
        b=S4FAZqBJgnzBBuzta8VxmAwLqlLbTCDtGWFYtaCoZJyTtuN3DURWuIXJ/hOIHFhVlU
         jrsY6B0aWsdzoeNB/KeP5QfUH7uHoRRzeHTZ300exw22DsbEqSHy0JAffA0r44SjOXeW
         tIPp/86UJXVXB1GipXu32uIUdeKymFQw0hJ1N1ZL9RSR/QxfU3ZDno80Zi4Yz6pOqVna
         cj4wwkoofSAmu0ZKORYwLWZQ954u52WaGuVkLkpifkSHoWgzHPBpLHalX8R93+TvVP74
         PYtUIM8ThAWN+MXYJwEhumMAcdqz0cLI05i+wTUH4z/3IHNYrGt7Tr9dqs0MctYNT0J7
         aeAg==
X-Gm-Message-State: AOAM531qziqL/QiSm0wZaewDonvfYqvPfX+QqdouSzysodG/cePtvWoQ
        yNqoHLo3cTN97+YnJWx+o8nLhcjt1S2ARwpOwGa4D2lW9Rt3MYRiVxBSroUAL7DuWiLmeqKv56Z
        GkUrzSbe4PxTl
X-Received: by 2002:a1c:98d5:: with SMTP id a204mr4491131wme.52.1631025560694;
        Tue, 07 Sep 2021 07:39:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcwRg64MAs790alfvMBbhipE3LrcecqWOOt1yvyCs7bsrGU1KOjLIdRDzSWgQj8A7fuMKrdg==
X-Received: by 2002:a1c:98d5:: with SMTP id a204mr4491089wme.52.1631025560389;
        Tue, 07 Sep 2021 07:39:20 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id s12sm11340851wru.41.2021.09.07.07.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 07:39:19 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, shayagr@amazon.com, john.fastabend@gmail.com,
        dsahern@kernel.org, echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com, toke@redhat.com
Subject: Re: [PATCH v13 bpf-next 01/18] net: skbuff: add size metadata to
 skb_shared_info for xdp
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
References: <cover.1631007211.git.lorenzo@kernel.org>
 <1721d45800a333a46c2cdde0fd25eb6f02f49ecf.1631007211.git.lorenzo@kernel.org>
Message-ID: <2bfd067e-a5aa-29ad-7b3c-0f8af61422ad@redhat.com>
Date:   Tue, 7 Sep 2021 16:39:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1721d45800a333a46c2cdde0fd25eb6f02f49ecf.1631007211.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 07/09/2021 14.35, Lorenzo Bianconi wrote:
> Introduce xdp_frags_tsize field in skb_shared_info data structure
> to store xdp_buff/xdp_frame truesize (xdp_frags_tsize will be used
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
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 6bdb0db3e825..1abeba7ef82e 100644
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
> +	unsigned int	xdp_frags_tsize;

I wonder if we could call this variable: xdp_frags_truesize.

As while reviewing patches I had to focus my eyes extra hard to tell the 
variables xdp_frags_size and xdp_frags_tsize from each-other.

--Jesper

