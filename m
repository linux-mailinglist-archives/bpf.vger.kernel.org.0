Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13BD6EECA3
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 05:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjDZDQ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 23:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239081AbjDZDQr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 23:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4E52121
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 20:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682478955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdgqUYnfdAd9yYGT3jWLr/aAVynWA1K/zHRTBmBRQZU=;
        b=ZacpIYj394cPtvIZ0JdpU31xwAzc5mC7+jgZM9ijS1AxaNpIbWxgGxQHRWr/PnHtYOWa84
        jiERnpXxWpEs6d1t6lZcbhKm+3hmt7KMo8T+TzVhL615uO/rDnBXES+OVBlgNg9O/epW+a
        pPYPMPK1aoI+kGiKqoBcraFaDFcpbWY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-MqoMg7NOMyyrEbwoYoV6sw-1; Tue, 25 Apr 2023 23:15:53 -0400
X-MC-Unique: MqoMg7NOMyyrEbwoYoV6sw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-63b5c830d77so4477987b3a.1
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 20:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682478952; x=1685070952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdgqUYnfdAd9yYGT3jWLr/aAVynWA1K/zHRTBmBRQZU=;
        b=JoxH/l30nqYKGvj13PHgw79rk+TXbjWqmAI67/xxAYAKSUX7uBLiZ1vtGVpwQIj7cm
         FuD0LAiUKIA3ZYGx9wtDMUbPdca27DjGtj1jv/I+St3CEBxQtAk7PXAzz/a5mFmyPByI
         UxhrcCcnbw/IjKVMZSnTZdovQW94bUOH5KFa/dfZ4MdojpQfICv0l25XVBCRrTifkR28
         EZPyifwzHIM3YFS/NkOhp6olo+XhuPRWyK40X/OEoxTcdYCMyj1TYINHvmDAzy2Pn9p3
         djPKu7KiK5NUIsSMB/daRi1+RWb/KoVkVk5q55zw37NxqydwGe+hGsfuDO+1OkYd74ur
         NVKQ==
X-Gm-Message-State: AAQBX9cdrvM3l3yhAbHOB30V9lCYrb6R9f//aitaq+GPq1nTcm782NRj
        9YSHkT6D/9+pXhM+zslneGikvyNingiHCQEhDDl70iHr1GNIGnjEfl7LJgHjEDmJ5ICR4ghwcez
        n6FI+W/H40Jwm
X-Received: by 2002:a05:6a00:15c9:b0:63b:854e:8459 with SMTP id o9-20020a056a0015c900b0063b854e8459mr28889455pfu.31.1682478952342;
        Tue, 25 Apr 2023 20:15:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350YwsMM+6nH+RCaQZjSGkf/VpoJD7jHIjgY6Elv8FV37cNsdgbEzPSNGm46pnGbHEC4ks7bD8w==
X-Received: by 2002:a05:6a00:15c9:b0:63b:854e:8459 with SMTP id o9-20020a056a0015c900b0063b854e8459mr28889440pfu.31.1682478952021;
        Tue, 25 Apr 2023 20:15:52 -0700 (PDT)
Received: from [10.72.13.54] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0063a5837d9e8sm9935447pff.156.2023.04.25.20.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 20:15:51 -0700 (PDT)
Message-ID: <2f2899c4-4e7a-85fd-f399-7cd119fa6aca@redhat.com>
Date:   Wed, 26 Apr 2023 11:15:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH net-next v3 14/15] virtio_net: introduce
 receive_small_build_xdp
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
References: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com>
 <20230423105736.56918-15-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230423105736.56918-15-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2023/4/23 18:57, Xuan Zhuo 写道:
> Simplifying receive_small() function. Bringing the logic relating to
> build_skb together.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>   drivers/net/virtio_net.c | 48 ++++++++++++++++++++++++++--------------
>   1 file changed, 31 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d2973c8fa48c..811cf1046df2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -931,6 +931,34 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>   	return NULL;
>   }
>   
> +static struct sk_buff *receive_small_build_skb(struct virtnet_info *vi,
> +					       unsigned int xdp_headroom,
> +					       void *buf,
> +					       unsigned int len)
> +{
> +	unsigned int header_offset;
> +	unsigned int headroom;
> +	unsigned int buflen;
> +	struct sk_buff *skb;
> +
> +	header_offset = VIRTNET_RX_PAD + xdp_headroom;
> +	headroom = vi->hdr_len + header_offset;
> +	buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
> +		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +
> +	skb = build_skb(buf, buflen);
> +	if (!skb)
> +		return NULL;
> +
> +	skb_reserve(skb, headroom);
> +	skb_put(skb, len);
> +
> +	buf += header_offset;
> +	memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
> +
> +	return skb;
> +}
> +
>   static struct sk_buff *receive_small_xdp(struct net_device *dev,
>   					 struct virtnet_info *vi,
>   					 struct receive_queue *rq,
> @@ -1030,9 +1058,6 @@ static struct sk_buff *receive_small(struct net_device *dev,
>   {
>   	unsigned int xdp_headroom = (unsigned long)ctx;
>   	struct page *page = virt_to_head_page(buf);
> -	unsigned int header_offset;
> -	unsigned int headroom;
> -	unsigned int buflen;
>   	struct sk_buff *skb;
>   
>   	len -= vi->hdr_len;
> @@ -1060,20 +1085,9 @@ static struct sk_buff *receive_small(struct net_device *dev,
>   		rcu_read_unlock();
>   	}
>   
> -	header_offset = VIRTNET_RX_PAD + xdp_headroom;
> -	headroom = vi->hdr_len + header_offset;
> -	buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
> -		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> -
> -	skb = build_skb(buf, buflen);
> -	if (!skb)
> -		goto err;
> -	skb_reserve(skb, headroom);
> -	skb_put(skb, len);
> -
> -	buf += header_offset;
> -	memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
> -	return skb;
> +	skb = receive_small_build_skb(vi, xdp_headroom, buf, len);
> +	if (likely(skb))
> +		return skb;
>   
>   err:
>   	stats->drops++;

