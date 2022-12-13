Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1D364B902
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 16:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiLMP4L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 10:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiLMP4K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 10:56:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277E919005
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 07:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670946920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vN2b3MLF2n3ZPMSxXyjvxdcqBR/2NjegKSPQ6Yvcl1c=;
        b=Tn9ipNi1UR0P9JzgXlT4z8w3GdRbfMZBJuX5VH9m6HQeMTI0XVrbTULUwSRPts2bgePJNM
        m4e9pi7BTkQfZttiVWTMmisZ4zedlHg1nCJfmEYNEaKJiRSPziQfvIIDIDcMHHriAwsGfY
        rJEjN0ZSilov1HvRdpccmC2aE2sENX4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-UMyHSbuhOJSFCkoyuD6Vog-1; Tue, 13 Dec 2022 10:55:19 -0500
X-MC-Unique: UMyHSbuhOJSFCkoyuD6Vog-1
Received: by mail-ed1-f69.google.com with SMTP id m18-20020a056402511200b0046db14dc1c9so7540159edd.10
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 07:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:cc:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vN2b3MLF2n3ZPMSxXyjvxdcqBR/2NjegKSPQ6Yvcl1c=;
        b=Sg4jmLabr7bU4Lrt/jhCjsHnxN+IK+8J/cedpb2DS8AX6kuQFP07dwEK/FuK59othC
         fW4bYlnJezCiq4y+utsas/YaBkjCp2ZRZLqc3mJwmG+2eUJM3Bxkg3tfvN7tq6RIgQzK
         cfspbKZhQ2OvV+uwyerHS8OPh502qkRtBkBIl610Q/1gXyDEjKzikdNIhBnAD/UfCREs
         ZoOyN9VLjzkuf9H+QSui5WOyJOMwrY2swKJ5+Mfzq17vUhMSZUuD7VfE1ofEw3Ss30uF
         p1y3GqufQxIZLOxzh1X7XuqxtDSIOcU4PRIzCm4uVCa/06GVxaVSdZaCFSqx/Tg2mqVR
         Y8Ng==
X-Gm-Message-State: ANoB5pmNpqPEVx6T7XHI/y5YKyMebmlKYxdcjMsFmT2W8li/7H073DWX
        tuMyYafQQrTQ+uJEY/F8jeFxM9Gp16Hy2lGp+q58ZjFf6+0z0XXgb+9VlCTdIevvtnVYR28TDSZ
        ZdfALoVwuRrRv
X-Received: by 2002:a17:906:3ac1:b0:7b2:7aef:5a05 with SMTP id z1-20020a1709063ac100b007b27aef5a05mr17767887ejd.70.1670946917886;
        Tue, 13 Dec 2022 07:55:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4QTFgaMGnkWUrT0vpdDp0RoPxFQ54W+5L1LBpoDF64UzHXcp7WiI/oyElkDcFBreUG86tosg==
X-Received: by 2002:a17:906:3ac1:b0:7b2:7aef:5a05 with SMTP id z1-20020a1709063ac100b007b27aef5a05mr17767870ejd.70.1670946917628;
        Tue, 13 Dec 2022 07:55:17 -0800 (PST)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id f13-20020a17090631cd00b0073c8d4c9f38sm4839077ejf.177.2022.12.13.07.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 07:55:16 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <7ca8ac2c-7c07-a52f-ec17-d1ba86fa45ab@redhat.com>
Date:   Tue, 13 Dec 2022 16:55:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Cc:     brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 08/15] veth: Support RX XDP metadata
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20221213023605.737383-1-sdf@google.com>
 <20221213023605.737383-9-sdf@google.com>
Content-Language: en-US
In-Reply-To: <20221213023605.737383-9-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 13/12/2022 03.35, Stanislav Fomichev wrote:
> The goal is to enable end-to-end testing of the metadata for AF_XDP.
> 
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Anatoly Burakov <anatoly.burakov@intel.com>
> Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
> Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
> Cc: Maryam Tahhan <mtahhan@redhat.com>
> Cc: xdp-hints@xdp-project.net
> Cc: netdev@vger.kernel.org
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   drivers/net/veth.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 04ffd8cb2945..d5491e7a2798 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -118,6 +118,7 @@ static struct {
>   
>   struct veth_xdp_buff {
>   	struct xdp_buff xdp;
> +	struct sk_buff *skb;
>   };
>   
>   static int veth_get_link_ksettings(struct net_device *dev,
> @@ -602,6 +603,7 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
>   
>   		xdp_convert_frame_to_buff(frame, xdp);
>   		xdp->rxq = &rq->xdp_rxq;
> +		vxbuf.skb = NULL;
>   
>   		act = bpf_prog_run_xdp(xdp_prog, xdp);
>   
> @@ -823,6 +825,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>   	__skb_push(skb, skb->data - skb_mac_header(skb));
>   	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
>   		goto drop;
> +	vxbuf.skb = skb;
>   
>   	orig_data = xdp->data;
>   	orig_data_end = xdp->data_end;
> @@ -1601,6 +1604,21 @@ static int veth_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>   	}
>   }
>   
> +static int veth_xdp_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
> +{
> +	*timestamp = ktime_get_mono_fast_ns();

This should be reading the hardware timestamp in the SKB.

Details: This hardware timestamp in the SKB is located in
skb_shared_info area, which is also available for xdp_frame (currently
used for multi-buffer purposes).  Thus, when adding xdp-hints "store"
functionality, it would be natural to store the HW TS in the same place.
Making the veth skb/xdp_frame code paths able to share code.

> +	return 0;
> +}
> +
> +static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash)
> +{
> +	struct veth_xdp_buff *_ctx = (void *)ctx;
> +
> +	if (_ctx->skb)
> +		*hash = skb_get_hash(_ctx->skb);
> +	return 0;
> +}
> +
>   static const struct net_device_ops veth_netdev_ops = {
>   	.ndo_init            = veth_dev_init,
>   	.ndo_open            = veth_open,
> @@ -1622,6 +1640,11 @@ static const struct net_device_ops veth_netdev_ops = {
>   	.ndo_get_peer_dev	= veth_peer_dev,
>   };
>   
> +static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
> +	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
> +	.xmo_rx_hash			= veth_xdp_rx_hash,
> +};
> +
>   #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
>   		       NETIF_F_RXCSUM | NETIF_F_SCTP_CRC | NETIF_F_HIGHDMA | \
>   		       NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL | \
> @@ -1638,6 +1661,7 @@ static void veth_setup(struct net_device *dev)
>   	dev->priv_flags |= IFF_PHONY_HEADROOM;
>   
>   	dev->netdev_ops = &veth_netdev_ops;
> +	dev->xdp_metadata_ops = &veth_xdp_metadata_ops;
>   	dev->ethtool_ops = &veth_ethtool_ops;
>   	dev->features |= NETIF_F_LLTX;
>   	dev->features |= VETH_FEATURES;

