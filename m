Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA39643D09
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 07:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiLFGPU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 01:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLFGPT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 01:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D1727176
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 22:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670307260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zA63JcIbEH1qJJe/ZX34ePPAj2qQmsK++bcoFZNFq3M=;
        b=CQgGfzx+iqmyvnM5DBml4EOIPnAxSA+R/4sQdBA18kddKOFXWvTpaP446F7UTi+0EH6c3H
        J8EmdHuMlZu/vZsZyd6910uF1wI1xtniljBLmu6u6XBtQYPzGnHHNHFBxKdxQDiK2kwO3N
        5qNC6A1eOXoN7Eac7LVYEXeIJbbufp8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-134-AHar7YMFOfOswlHudifU1g-1; Tue, 06 Dec 2022 01:14:16 -0500
X-MC-Unique: AHar7YMFOfOswlHudifU1g-1
Received: by mail-oi1-f200.google.com with SMTP id bd24-20020a056808221800b0035b94fc144aso6136015oib.5
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 22:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zA63JcIbEH1qJJe/ZX34ePPAj2qQmsK++bcoFZNFq3M=;
        b=ELqbGW/qoS5iGZqvorr8ZYW7XAnp4lt4HngwSHq1rWlfqWiYqzfyhdz+asHZ1VncYi
         fYQfBNCegRLldkIu6gG0FDJdw0jixEXIVuRcYcvkXWHlOV0ecTjlZp1O3KOmC5aM3b+d
         OrC3wCNOPYzX6pWtl29ryprHWIUTNuqUweztO2YqeAdorvqMsXxoBp9WJxJK+glrD7aI
         C/52cdjDtyOKWzA2z0iapKduSQ8gjpSIwn4fsX9ckrrDoP+bVkviZIoWAaxi9nvcV1JH
         U3FE2CIxCBl++5+fI3mELJzby+/n/zFt5CX8vPZIJsKSkjgUk+CED+s1Xlou5uMvMZbV
         AkIQ==
X-Gm-Message-State: ANoB5pkDCWz73mJSx/QZGv7M/7mXaJNVHQxYhvk9KoUgaDVcEoG2nG+3
        2FrUdjMTvr0TyG2ySriBjrUPwSyfJw2AGhCv9bz8OdFPb1A/Tpeov45mLFU1rFEU/wrZx/QqfEk
        NVDz0n0cxndnB/bThULzJzYWv4GTE
X-Received: by 2002:a9d:832:0:b0:670:5283:dd3e with SMTP id 47-20020a9d0832000000b006705283dd3emr2159320oty.201.1670307256032;
        Mon, 05 Dec 2022 22:14:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4uISUnmjmqgd1VtGsaoldh2HqBkPk4zqyZoOHQl+kwvUBtoygRgXuYUPjUVWOgssTjaIRxxBkgI8svKbNGw2o=
X-Received: by 2002:a9d:832:0:b0:670:5283:dd3e with SMTP id
 47-20020a9d0832000000b006705283dd3emr2159310oty.201.1670307255776; Mon, 05
 Dec 2022 22:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20221122074348.88601-1-hengqi@linux.alibaba.com> <20221122074348.88601-6-hengqi@linux.alibaba.com>
In-Reply-To: <20221122074348.88601-6-hengqi@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 6 Dec 2022 14:14:04 +0800
Message-ID: <CACGkMEvBDmGdP7e1c-8s2OQFEYQ2LLbhnDF+qN+yPVwvkxPjCw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] virtio_net: build xdp_buff with multi buffers
To:     Heng Qi <hengqi@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 22, 2022 at 3:44 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>
> Support xdp for multi buffer packets.
>
> Putting the first buffer as the linear part for xdp_buff,
> and the rest of the buffers as non-linear fragments to struct
> skb_shared_info in the tailroom belonging to xdp_buff.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 74 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index cd65f85d5075..20784b1d8236 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -911,6 +911,80 @@ static struct sk_buff *receive_big(struct net_device *dev,
>         return NULL;
>  }
>
> +static int virtnet_build_xdp_buff(struct net_device *dev,
> +                                 struct virtnet_info *vi,
> +                                 struct receive_queue *rq,
> +                                 struct xdp_buff *xdp,
> +                                 void *buf,
> +                                 unsigned int len,
> +                                 unsigned int frame_sz,
> +                                 u16 *num_buf,
> +                                 unsigned int *xdp_frags_truesize,
> +                                 struct virtnet_rq_stats *stats)
> +{
> +       unsigned int tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +       struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
> +       unsigned int truesize, headroom;
> +       struct skb_shared_info *shinfo;
> +       unsigned int xdp_frags_truesz = 0;
> +       unsigned int cur_frag_size;
> +       struct page *page;
> +       skb_frag_t *frag;
> +       int offset;
> +       void *ctx;
> +
> +       xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
> +       xdp_prepare_buff(xdp, buf - VIRTIO_XDP_HEADROOM,
> +                        VIRTIO_XDP_HEADROOM + vi->hdr_len, len - vi->hdr_len, true);
> +       shinfo = xdp_get_shared_info_from_buff(xdp);
> +       shinfo->nr_frags = 0;
> +       shinfo->xdp_frags_size = 0;
> +
> +       if ((*num_buf - 1) > MAX_SKB_FRAGS)
> +               return -EINVAL;
> +
> +       while ((--*num_buf) >= 1) {
> +               buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx);

So this works only for a mergeable buffer, I wonder if it's worth it
to make it work for big mode as well. Or at least we can mention it as
a TODO somewhere and rename this function (with mergeable suffix).

Others look good.

Thanks

> +               if (unlikely(!buf)) {
> +                       pr_debug("%s: rx error: %d buffers out of %d missing\n",
> +                                dev->name, *num_buf,
> +                                virtio16_to_cpu(vi->vdev, hdr->num_buffers));
> +                       dev->stats.rx_length_errors++;
> +                       return -EINVAL;
> +               }
> +
> +               if (!xdp_buff_has_frags(xdp))
> +                       xdp_buff_set_frags_flag(xdp);
> +
> +               stats->bytes += len;
> +               page = virt_to_head_page(buf);
> +               offset = buf - page_address(page);
> +               truesize = mergeable_ctx_to_truesize(ctx);
> +               headroom = mergeable_ctx_to_headroom(ctx);
> +
> +               cur_frag_size = truesize + (headroom ? (headroom + tailroom) : 0);
> +               xdp_frags_truesz += cur_frag_size;
> +               if (unlikely(len > truesize || cur_frag_size > PAGE_SIZE)) {
> +                       pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
> +                                dev->name, len, (unsigned long)ctx);
> +                       dev->stats.rx_length_errors++;
> +                       return -EINVAL;
> +               }
> +
> +               frag = &shinfo->frags[shinfo->nr_frags++];
> +               __skb_frag_set_page(frag, page);
> +               skb_frag_off_set(frag, offset);
> +               skb_frag_size_set(frag, len);
> +               if (page_is_pfmemalloc(page))
> +                       xdp_buff_set_frag_pfmemalloc(xdp);
> +
> +               shinfo->xdp_frags_size += len;
> +       }
> +
> +       *xdp_frags_truesize = xdp_frags_truesz;
> +       return 0;
> +}
> +
>  static struct sk_buff *receive_mergeable(struct net_device *dev,
>                                          struct virtnet_info *vi,
>                                          struct receive_queue *rq,
> --
> 2.19.1.6.gb485710b
>

