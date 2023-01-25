Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AC467AFC9
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 11:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjAYKg5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 05:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbjAYKgy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 05:36:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD78F8A51
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 02:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674642971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q11Y6sRP5eB+2E1lyhg8TSSmTlKL355gp5xgzQC5zjU=;
        b=MESGHr7HwTv6alIYJAQRu1cJfbry74k3DEXObYHvFf8LghYp0444E155rAo7gmYnxYN96e
        vjlNfTM/0g+I+FVVyuNzNQGU0RFA2Er6GHZ/+VlLCWEDS+zzXqP4s9xC6sSE9MPyjS6mzK
        TWLypA32OCWCpk1LNZsbx2tvgCN3SEc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-xTeps4OtOUOKXDw0-azwXQ-1; Wed, 25 Jan 2023 05:36:02 -0500
X-MC-Unique: xTeps4OtOUOKXDw0-azwXQ-1
Received: by mail-ed1-f71.google.com with SMTP id g14-20020a056402090e00b0046790cd9082so12788923edz.21
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 02:36:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q11Y6sRP5eB+2E1lyhg8TSSmTlKL355gp5xgzQC5zjU=;
        b=OmY6nYBuSKBfV6uOeQXHcVZFITUol11vUlE5w9kTcZzkJqmU8PW7QAilvTV6q+fCgY
         Y2IYAupztSUh75cazbp+ogSZi8RDg3sRmEgKhB5+g3176f5uEzO4eeqjqE9YDwK7kzwA
         kojXrutCg3GL8VRZElNyd7bcaq6pCmWR4luCDO9gvOWaIseLZ2aXujU7/GzMe8FeQ9KI
         DzPZFXml/LOXI3JeUoARJx/UYyl48oo5o+uJl1izG8wK0vRuXE6RhVTJovUeki83JBEb
         nWImKOqXAx5cmUA9mbLNOOHyvnuVa2nNA/qpfcUPIestCyK3M5yMoD/Ek4bTbFJNyQ7X
         2N1w==
X-Gm-Message-State: AFqh2krUELRBJ7gXC4e3mUHWh38m7aQp5L1BYzodcz/9JfuwAHp6o7zA
        OjWzBhxfyxLcRkyVD/Fj4rW4IPD/oDN1GQznLGopE5zaAfwTuWwTx/+Utetarnzle69oS23YgOA
        jy9KgpBpf6g2Z
X-Received: by 2002:a50:ff17:0:b0:499:d208:e8f4 with SMTP id a23-20020a50ff17000000b00499d208e8f4mr32863542edu.19.1674642960969;
        Wed, 25 Jan 2023 02:36:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsDrWe+0gNE++0AFOt7XfTm42J1viN/NP1zx2tX/yL5luN1ZDInl8rOSE8HEiSjpLfJOIWeTw==
X-Received: by 2002:a50:ff17:0:b0:499:d208:e8f4 with SMTP id a23-20020a50ff17000000b00499d208e8f4mr32863520edu.19.1674642960737;
        Wed, 25 Jan 2023 02:36:00 -0800 (PST)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id j21-20020a17090686d500b007c1675d2626sm2168222ejy.96.2023.01.25.02.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 02:36:00 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <d3a041f3-5fba-a114-1796-492b68a8c011@redhat.com>
Date:   Wed, 25 Jan 2023 11:35:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, pabeni@redhat.com,
        edumazet@google.com, toke@redhat.com, memxor@gmail.com,
        alardam@gmail.com, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
        gospo@broadcom.com, vladimir.oltean@nxp.com, nbd@nbd.name,
        john@phrozen.org, leon@kernel.org, simon.horman@corigine.com,
        aelior@marvell.com, christophe.jaillet@wanadoo.fr,
        ecree.xilinx@gmail.com, mst@redhat.com, bjorn@kernel.org,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        intel-wired-lan@lists.osuosl.org, lorenzo.bianconi@redhat.com,
        martin.lau@linux.dev
Subject: Re: [PATCH v2 bpf-next 6/8] bpf: devmap: check XDP features in
 __xdp_enqueue routine
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org
References: <cover.1674606193.git.lorenzo@kernel.org>
 <46f49d11939557aee7315bc23589cf261c19b494.1674606198.git.lorenzo@kernel.org>
In-Reply-To: <46f49d11939557aee7315bc23589cf261c19b494.1674606198.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 25/01/2023 01.33, Lorenzo Bianconi wrote:
> Check if the destination device implements ndo_xdp_xmit callback relying
> on NETDEV_XDP_ACT_NDO_XMIT flags. Moreover, check if the destination device
> supports XDP non-linear frame in __xdp_enqueue and is_valid_dst routines.
> This patch allows to perform XDP_REDIRECT on non-linear XDP buffers.
> 
> Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   kernel/bpf/devmap.c | 16 +++++++++++++---
>   net/core/filter.c   | 13 +++++--------
>   2 files changed, 18 insertions(+), 11 deletions(-)
> 

LGTM
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index d01e4c55b376..2675fefc6cb6 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -474,7 +474,11 @@ static inline int __xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
>   {
>   	int err;
>   
> -	if (!dev->netdev_ops->ndo_xdp_xmit)
> +	if (!(dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT))
> +		return -EOPNOTSUPP;

Good: dev->netdev_ops and dev->xdp_features are on same cacheline.

This means dev->netdev_ops will be hot, once we need to deref 
netdev_ops->ndo_xdp_xmit, which only happens as part of bulking towards 
driver.

> +
> +	if (unlikely(!(dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT_SG) &&
> +		     xdp_frame_has_frags(xdpf)))

Good: xdp_frame_has_frags() look at xdpf->flags and avoids deref of 
shared_info area.

>   		return -EOPNOTSUPP;
>   
>   	err = xdp_ok_fwd_dev(dev, xdp_get_frame_len(xdpf));
> @@ -532,8 +536,14 @@ int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
>   
>   static bool is_valid_dst(struct bpf_dtab_netdev *obj, struct xdp_frame *xdpf)
>   {
> -	if (!obj ||
> -	    !obj->dev->netdev_ops->ndo_xdp_xmit)
> +	if (!obj)
> +		return false;
> +
> +	if (!(obj->dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT))
> +		return false;
> +
> +	if (unlikely(!(obj->dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT_SG) &&
> +		     xdp_frame_has_frags(xdpf)))
>   		return false;
>   
>   	if (xdp_ok_fwd_dev(obj->dev, xdp_get_frame_len(xdpf)))
> diff --git a/net/core/filter.c b/net/core/filter.c
> index ed08dbf10338..aeebe21a7eff 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4314,16 +4314,13 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
>   	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
>   	enum bpf_map_type map_type = ri->map_type;
>   
> -	/* XDP_REDIRECT is not fully supported yet for xdp frags since
> -	 * not all XDP capable drivers can map non-linear xdp_frame in
> -	 * ndo_xdp_xmit.
> -	 */
> -	if (unlikely(xdp_buff_has_frags(xdp) &&
> -		     map_type != BPF_MAP_TYPE_CPUMAP))
> -		return -EOPNOTSUPP;

Nice to see this limitation being lifted :-)

> +	if (map_type == BPF_MAP_TYPE_XSKMAP) {
> +		/* XDP_REDIRECT is not supported AF_XDP yet. */
> +		if (unlikely(xdp_buff_has_frags(xdp)))
> +			return -EOPNOTSUPP;
>   
> -	if (map_type == BPF_MAP_TYPE_XSKMAP)
>   		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
> +	}
>   
>   	return __xdp_do_redirect_frame(ri, dev, xdp_convert_buff_to_frame(xdp),
>   				       xdp_prog);

