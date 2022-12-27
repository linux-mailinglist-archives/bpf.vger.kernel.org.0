Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B736567DA
	for <lists+bpf@lfdr.de>; Tue, 27 Dec 2022 08:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiL0Hci (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Dec 2022 02:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiL0Hci (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Dec 2022 02:32:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5235109A
        for <bpf@vger.kernel.org>; Mon, 26 Dec 2022 23:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672126312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W2wV9Ru15RgYIMf7o5N9UF6E1LS25n2e/R46tB7Xi3k=;
        b=DxL7e7uCI/7Fa0ujRyiBgkOQJedaWLDPRnXMVf84WkTES0ubDHuxxAhqoqoE5fy+Qwo3aV
        1NJdNAx0QUivfrUCmd2XOUt8Q0anMV9tVeW6y3S/s8VENxdIAHO0DjIaftXbQKpPv5sMTv
        6Yp1tyJODDnwzeqNGIqJ8fYW4fsaWXw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-93-lwBS-UboMwOk3dGCZQcfuA-1; Tue, 27 Dec 2022 02:31:48 -0500
X-MC-Unique: lwBS-UboMwOk3dGCZQcfuA-1
Received: by mail-pj1-f72.google.com with SMTP id b16-20020a17090a551000b00225aa26f1dbso5246602pji.8
        for <bpf@vger.kernel.org>; Mon, 26 Dec 2022 23:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2wV9Ru15RgYIMf7o5N9UF6E1LS25n2e/R46tB7Xi3k=;
        b=KV4SVHRJr1RkY9Iyi2YnWKvUIb3756GkDDpobL4+/gQQGsekqeWPGzpOB8GQ3QHTKR
         pDixC4tQkjRinRGCub+JqVu4RCL4gTZeL30ihjrBWylwt7FcxzkpwnQ4zQVFDFA+wFlC
         MguAVS7JOiRz4W5VNm7QQKwEXjWP/PtnJnbAMIgOrjuBVTc+K/bgAIACJuocJbx9U3bs
         6XGrgMAKsHSGuYMKdfkTO1Hejqw6xrahAzIZjIo5eDApCZCCoXrvwBU6FlnnQf3HOWvO
         68sna+o0PN54KgRbZjiqjsYF+c7tBz+hCHyIzw70n0UdS7YCXx0iGIdWFU1dsuiqkl2V
         oklA==
X-Gm-Message-State: AFqh2krL5gEJ+3Cd0CiqKsptAHuHmNm3u2Lu5Q7iCvQZrPC3O2P3jAW7
        suJ09jXHSkYCWwI5lrA09Q6R34cIAXed3DIyhJ2y+rSWnfXvCgnUK3ai6DjtWwiXVC4SK+Jc/HU
        OMteFDLN+YHrR
X-Received: by 2002:a17:90b:3793:b0:226:744:d46a with SMTP id mz19-20020a17090b379300b002260744d46amr2138839pjb.41.1672126307781;
        Mon, 26 Dec 2022 23:31:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXud3ceh+S6ptBkVdEfki5fg6mqgyU/IgMImjqfqcDI/5201CA5WG4A1Z2qhWnLktdN82iHPyA==
X-Received: by 2002:a17:90b:3793:b0:226:744:d46a with SMTP id mz19-20020a17090b379300b002260744d46amr2138825pjb.41.1672126307511;
        Mon, 26 Dec 2022 23:31:47 -0800 (PST)
Received: from [10.72.13.143] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id mm2-20020a17090b358200b0021937b2118bsm10070935pjb.54.2022.12.26.23.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 23:31:47 -0800 (PST)
Message-ID: <9d049351-11c8-2178-c88c-6d4496df773e@redhat.com>
Date:   Tue, 27 Dec 2022 15:31:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 7/9] virtio_net: build skb from multi-buffer xdp
Content-Language: en-US
To:     Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221220141449.115918-1-hengqi@linux.alibaba.com>
 <20221220141449.115918-8-hengqi@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221220141449.115918-8-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/12/20 22:14, Heng Qi 写道:
> This converts the xdp_buff directly to a skb, including
> multi-buffer and single buffer xdp. We'll isolate the
> construction of skb based on xdp from page_to_skb().
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/net/virtio_net.c | 50 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9f31bfa7f9a6..4e12196fcfd4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -948,6 +948,56 @@ static struct sk_buff *receive_big(struct net_device *dev,
>   	return NULL;
>   }
>   
> +/* Why not use xdp_build_skb_from_frame() ?
> + * XDP core assumes that xdp frags are PAGE_SIZE in length, while in
> + * virtio-net there are 2 points that do not match its requirements:
> + *  1. The size of the prefilled buffer is not fixed before xdp is set.
> + *  2. When xdp is loaded, virtio-net has a hole mechanism (refer to
> + *     add_recvbuf_mergeable()), which will make the size of a buffer
> + *     exceed PAGE_SIZE.


Is point 2 still valid after patch 1?

Other than this:

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> + */
> +static struct sk_buff *build_skb_from_xdp_buff(struct net_device *dev,
> +					       struct virtnet_info *vi,
> +					       struct xdp_buff *xdp,
> +					       unsigned int xdp_frags_truesz)
> +{
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	unsigned int headroom, data_len;
> +	struct sk_buff *skb;
> +	int metasize;
> +	u8 nr_frags;
> +
> +	if (unlikely(xdp->data_end > xdp_data_hard_end(xdp))) {
> +		pr_debug("Error building skb as missing reserved tailroom for xdp");
> +		return NULL;
> +	}
> +
> +	if (unlikely(xdp_buff_has_frags(xdp)))
> +		nr_frags = sinfo->nr_frags;
> +
> +	skb = build_skb(xdp->data_hard_start, xdp->frame_sz);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	headroom = xdp->data - xdp->data_hard_start;
> +	data_len = xdp->data_end - xdp->data;
> +	skb_reserve(skb, headroom);
> +	__skb_put(skb, data_len);
> +
> +	metasize = xdp->data - xdp->data_meta;
> +	metasize = metasize > 0 ? metasize : 0;
> +	if (metasize)
> +		skb_metadata_set(skb, metasize);
> +
> +	if (unlikely(xdp_buff_has_frags(xdp)))
> +		xdp_update_skb_shared_info(skb, nr_frags,
> +					   sinfo->xdp_frags_size,
> +					   xdp_frags_truesz,
> +					   xdp_buff_is_frag_pfmemalloc(xdp));
> +
> +	return skb;
> +}
> +
>   /* TODO: build xdp in big mode */
>   static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>   				      struct virtnet_info *vi,

