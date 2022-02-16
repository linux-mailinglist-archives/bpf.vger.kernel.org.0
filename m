Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E2F4B7F30
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 05:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245738AbiBPEO6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 23:14:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245724AbiBPEO5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 23:14:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EF7075E64
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 20:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644984885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2raDdORm9sCAKZb6XeZ+x40LM248zzmNyFjzWRyfSv4=;
        b=eYy6jj32H+CapIlCTV1HmEfd0Ki+AP5VyXSKL8pnAqqVzn3OdZ66I307GDvPwT+cWJlGOV
        2CobOz7CICx1Mz8m5tl+IwFWvok285dxVaiYHLqNWiOgpJHFsaJhse3wGWtM/gYa5SKnno
        N8ruaRZKfNl8kFCic49WHt+BzCXZvzY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86--9Ji0X5QPZC3UqDgauFRMg-1; Tue, 15 Feb 2022 23:14:43 -0500
X-MC-Unique: -9Ji0X5QPZC3UqDgauFRMg-1
Received: by mail-lj1-f198.google.com with SMTP id p9-20020a2ea409000000b0023ced6b0f51so442521ljn.19
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 20:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2raDdORm9sCAKZb6XeZ+x40LM248zzmNyFjzWRyfSv4=;
        b=N4pYbtlJA5YmwvOmK6P/9KNfLT9/KAVGaRlNfddNUfcC3d9F7T91eZVYFy0CceNa73
         AGvJlMbV1MbZMwyRozfqdv5q8+sKfhpyUy+wXqvflgF4W2JgeJSJsmhRlThKzuIfwkhj
         cOsjk0mWK4/IOH+nAekp/bLymv0EERe7bVkuYHgqHpuHLN+1bWMR3H6p9jlPnc74nmGH
         3KaK78bN/2xgG518eRj2BEuiTOEc5V/FKjhoY0F1jiVULpJDyJN+kVnv2l3UCfgV6jM1
         ecpyT7E9fDHwbxwumoHiFgUr/bAsJ2aRrmHjZ2lpYZF2BZuc/ySRDOZgu5mTCn08X2CL
         WpMA==
X-Gm-Message-State: AOAM531N4Lcfr6mbZRIxA+ORJeCRksDDvdgxByvMCHxE/9epzzE90XZm
        u6QUhkg4qgyKlIGuG5aUIK65taTnMlrV0LIaajhTc4hil+ISynMKqCzjLlBgtt8cixHp+VvWPip
        BYAe6jSGsIaxzl5s34f+PyTie+XMF
X-Received: by 2002:a2e:8798:0:b0:244:d49b:956a with SMTP id n24-20020a2e8798000000b00244d49b956amr684190lji.420.1644984882251;
        Tue, 15 Feb 2022 20:14:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxH6YX6v5CHZMPwVh4dpJuBHMaStdfAomp4/RnQuTSSt3QANNDD4w+gRLrrwap+t4sKtL3jQ5qhoIHJD7N0c7g=
X-Received: by 2002:a2e:8798:0:b0:244:d49b:956a with SMTP id
 n24-20020a2e8798000000b00244d49b956amr684177lji.420.1644984882033; Tue, 15
 Feb 2022 20:14:42 -0800 (PST)
MIME-Version: 1.0
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com> <20220214081416.117695-21-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220214081416.117695-21-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 16 Feb 2022 12:14:31 +0800
Message-ID: <CACGkMEvZvhSb0veCynEHN3EfFu_FwbCAb8w1b0Oi3LDc=ffNaw@mail.gmail.com>
Subject: Re: [PATCH v5 20/22] virtio_net: set the default max ring num
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 14, 2022 at 4:14 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Sets the default maximum ring num based on virtio_set_max_ring_num().
>
> The default maximum ring num is 1024.

Having a default value is pretty useful, I see 32K is used by default for IFCVF.

Rethink this, how about having a different default value based on the speed?

Without SPEED_DUPLEX, we use 1024. Otherwise

10g 4096
40g 8192

etc.

(The number are just copied from the 10g/40g default parameter from
other vendors)

Thanks

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a4ffd7cdf623..77e61fe0b2ce 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -35,6 +35,8 @@ module_param(napi_tx, bool, 0644);
>  #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
>  #define GOOD_COPY_LEN  128
>
> +#define VIRTNET_DEFAULT_MAX_RING_NUM 1024
> +
>  #define VIRTNET_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
>
>  /* Amount of XDP headroom to prepend to packets for use by xdp_adjust_head */
> @@ -3045,6 +3047,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>                         ctx[rxq2vq(i)] = true;
>         }
>
> +       virtio_set_max_ring_num(vi->vdev, VIRTNET_DEFAULT_MAX_RING_NUM);
> +
>         ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
>                                   names, ctx, NULL);
>         if (ret)
> --
> 2.31.0
>

