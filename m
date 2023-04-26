Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFD36EECA8
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 05:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbjDZDRu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 23:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbjDZDRq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 23:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C442121
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 20:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682479014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YY+zUiI918bhRekp/k04uyQHuZyBvT9YitN/0BGqWBg=;
        b=bslConQF2DVBQTOtRZaejLOfNqN8o0EPZs0x110w+C6IZMu4YU5NYaCluKvHdjYl1Jcp5v
        mlrrLJHr0kqV/7Z+PTRpp7L872KpjPFLFHEScpInzF3f9jVA8YE3x6WC6Y8FVm5ZwbsTGx
        Y4/dYkY/5mMgQZLGqkQipER/YqYQZPc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-ZJbtMz0NOsq7aGaQvkfRuw-1; Tue, 25 Apr 2023 23:16:52 -0400
X-MC-Unique: ZJbtMz0NOsq7aGaQvkfRuw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-63b79d8043eso34042718b3a.0
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 20:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682479012; x=1685071012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YY+zUiI918bhRekp/k04uyQHuZyBvT9YitN/0BGqWBg=;
        b=I/Dd5lWJGa///HTXG1YeXXpPjgQm3J2yM2z7gUrHfHNbHC/npkSQ1Bz2AOR8174FLO
         4fGWlRA0CxHKsx1cEXmwdMnc5soj0iTrv+1DWz9EO7sw19CP/7PfaxhG+u7x/hLbzItO
         oUCyyLgG3gdWe0zZI0lqjH7LMmyS+Tia0VKt9EedUq95zrrEppCnU41ArmvHtSyGK98h
         L/gVo2P5ZmzloEomB6NzdeqGBe5zK5rANRMYZJ3cghyt6NGwiod9fbV07yf28hZOr4Jo
         ZugEvYQfCIQAj0nY7o3Yri4gfLIp0kW34Pt+DuEjNot0EA8nBK/mj1CJm+c1SZ3altwr
         VAVA==
X-Gm-Message-State: AC+VfDwGuzbQLC0NKJ4agbEs40JdEEXe8Hv4Ll5pLivSo/7kwY2Y+TN6
        WlVAITPeV53AQKNA6fLcJZkeRYAUhKrT7vAcdUapK5LPMFF/BSbQzB3rGBMetaBQhETwCg9lDrn
        +Ppam3BHSq3pD
X-Received: by 2002:a05:6a20:5482:b0:f5:ae09:cdf2 with SMTP id i2-20020a056a20548200b000f5ae09cdf2mr1273130pzk.17.1682479011867;
        Tue, 25 Apr 2023 20:16:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6TBpoXENwf1shIIT69AtLezqAGfiV1jveqvkQ53XfFHqioJ3xhSxQbFjMMo+u+zHPQJ9jDTA==
X-Received: by 2002:a05:6a20:5482:b0:f5:ae09:cdf2 with SMTP id i2-20020a056a20548200b000f5ae09cdf2mr1273106pzk.17.1682479011512;
        Tue, 25 Apr 2023 20:16:51 -0700 (PDT)
Received: from [10.72.13.54] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b0050927cb606asm8563730pgv.13.2023.04.25.20.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 20:16:51 -0700 (PDT)
Message-ID: <8f14df81-c1af-7b55-7473-187ed3b13fef@redhat.com>
Date:   Wed, 26 Apr 2023 11:16:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH net-next v3 15/15] virtio_net: introduce
 virtnet_build_skb()
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
 <20230423105736.56918-16-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230423105736.56918-16-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2023/4/23 18:57, Xuan Zhuo 写道:
> This logic is used in multiple places, now we separate it into
> a helper.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>   drivers/net/virtio_net.c | 34 +++++++++++++++++++++-------------
>   1 file changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 811cf1046df2..f768e683dadb 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -443,6 +443,22 @@ static unsigned int mergeable_ctx_to_truesize(void *mrg_ctx)
>   	return (unsigned long)mrg_ctx & ((1 << MRG_CTX_HEADER_SHIFT) - 1);
>   }
>   
> +static struct sk_buff *virtnet_build_skb(void *buf, unsigned int buflen,
> +					 unsigned int headroom,
> +					 unsigned int len)
> +{
> +	struct sk_buff *skb;
> +
> +	skb = build_skb(buf, buflen);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	skb_reserve(skb, headroom);
> +	skb_put(skb, len);
> +
> +	return skb;
> +}
> +
>   /* Called from bottom half context */
>   static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>   				   struct receive_queue *rq,
> @@ -476,13 +492,10 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>   
>   	/* copy small packet so we can reuse these pages */
>   	if (!NET_IP_ALIGN && len > GOOD_COPY_LEN && tailroom >= shinfo_size) {
> -		skb = build_skb(buf, truesize);
> +		skb = virtnet_build_skb(buf, truesize, p - buf, len);
>   		if (unlikely(!skb))
>   			return NULL;
>   
> -		skb_reserve(skb, p - buf);
> -		skb_put(skb, len);
> -
>   		page = (struct page *)page->private;
>   		if (page)
>   			give_pages(rq, page);
> @@ -946,13 +959,10 @@ static struct sk_buff *receive_small_build_skb(struct virtnet_info *vi,
>   	buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
>   		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>   
> -	skb = build_skb(buf, buflen);
> -	if (!skb)
> +	skb = virtnet_build_skb(buf, buflen, headroom, len);
> +	if (unlikely(!skb))
>   		return NULL;
>   
> -	skb_reserve(skb, headroom);
> -	skb_put(skb, len);
> -
>   	buf += header_offset;
>   	memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
>   
> @@ -1028,12 +1038,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>   		goto err_xdp;
>   	}
>   
> -	skb = build_skb(buf, buflen);
> -	if (!skb)
> +	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
> +	if (unlikely(!skb))
>   		goto err;
>   
> -	skb_reserve(skb, xdp.data - buf);
> -	skb_put(skb, len);
>   	if (metasize)
>   		skb_metadata_set(skb, metasize);
>   

