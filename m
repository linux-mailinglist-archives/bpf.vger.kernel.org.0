Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A95643D36
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 07:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiLFGn3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 01:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLFGn2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 01:43:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475B7209A4
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 22:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670308950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/m/LKEM8E8gWvLZfOCL85LkossT//XPtieS+3hIIhc=;
        b=B7Zp+A18IxSPtyYsWmrLguoYQ9WTDsu8oBT4yhX8He4rXn53wlb4CJMHT/4Bt4PaW0AfbD
        503fwVeuqfQb/tb+jFalgKabwtOQ92JpaDXqqBvbZYHP+IHCHMJq1bdf3txPZPSDNi8Ew7
        wnowfEpfQjlCw9W24H/6jW1pGy6Nw2Q=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-34-4Pw3xYeFM8ynACjPDTqxWQ-1; Tue, 06 Dec 2022 01:42:26 -0500
X-MC-Unique: 4Pw3xYeFM8ynACjPDTqxWQ-1
Received: by mail-oi1-f199.google.com with SMTP id bj30-20020a056808199e00b0035a0734664bso6139591oib.8
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 22:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/m/LKEM8E8gWvLZfOCL85LkossT//XPtieS+3hIIhc=;
        b=TDxqdnvgTPY3G7P7cZinr1mt5H2hlWV7devUByg5BFSs3IRusw9HtlTwP+fzxZs1ys
         cwU3Sq3KTRN5dh+NMbIT7AsikWFLlNSGr3bDLieH7OW7R5vwrE2mrZIW9sLGXbkc+nJz
         MJHR5DJF6wc2Y/Gs07p4W/EW3F2AXFvEHRUdpneusR3Z/0js/IdRMqcSz2RqzbMMurGo
         5X0d0NLqc6L+UiIEril46QNxkLpUwIhWwJDU4P5egZXD4PHEbWRHXuQqaPcuJ79teDRV
         TksimSi23FpHB4kQ4GIQpR1iLcmT2unniUaYzDO8q1AMTM0OjdBZIU7ovC60o9ek0yDA
         bYxg==
X-Gm-Message-State: ANoB5plyiHiTXxivQcNUKm+wNixN4fvC0WdxpHb0NfLa4ZlR07toDNWb
        Lx5d7YfjvL6rvR/8hDGMTK19GPQmgqapWy+/UQdd8FqnRYzTDHU8Tn46YfURETejFEKLMbSv955
        aEJIDzrxfWFEM2sLB4MshtKuFtcqN
X-Received: by 2002:a05:6870:b9b:b0:144:b22a:38d3 with SMTP id lg27-20020a0568700b9b00b00144b22a38d3mr2765599oab.280.1670308945570;
        Mon, 05 Dec 2022 22:42:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6HV/xZ/HG4/5jJbnBTSk5WGlj3qqcglUA80mK4pOlvA5TfI1GgyNRYpPF7uNQ2rReqhWQHgoK4yrfEuzHx1Wk=
X-Received: by 2002:a05:6870:b9b:b0:144:b22a:38d3 with SMTP id
 lg27-20020a0568700b9b00b00144b22a38d3mr2765592oab.280.1670308945316; Mon, 05
 Dec 2022 22:42:25 -0800 (PST)
MIME-Version: 1.0
References: <20221122074348.88601-1-hengqi@linux.alibaba.com> <20221122074348.88601-10-hengqi@linux.alibaba.com>
In-Reply-To: <20221122074348.88601-10-hengqi@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 6 Dec 2022 14:42:14 +0800
Message-ID: <CACGkMEsd75VYCeSSQo_H6+0reNxQsAMSamNr-_k3ndJ-ToJHHQ@mail.gmail.com>
Subject: Re: [RFC PATCH 9/9] virtio_net: support multi-buffer xdp
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
> Driver can pass the skb to stack by build_skb_from_xdp_buff().
>
> Driver forwards multi-buffer packets using the send queue
> when XDP_TX and XDP_REDIRECT, and clears the reference of multi
> pages when XDP_DROP.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 65 ++++++----------------------------------
>  1 file changed, 9 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 431f2126a2b5..bbd5cd9bfd47 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1065,7 +1065,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>         struct bpf_prog *xdp_prog;
>         unsigned int truesize = mergeable_ctx_to_truesize(ctx);
>         unsigned int headroom = mergeable_ctx_to_headroom(ctx);
> -       unsigned int metasize = 0;
>         unsigned int frame_sz;
>         int err;
>
> @@ -1137,63 +1136,22 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>
>                 switch (act) {
>                 case XDP_PASS:
> -                       metasize = xdp.data - xdp.data_meta;
> -
> -                       /* recalculate offset to account for any header
> -                        * adjustments and minus the metasize to copy the
> -                        * metadata in page_to_skb(). Note other cases do not
> -                        * build an skb and avoid using offset
> -                        */
> -                       offset = xdp.data - page_address(xdp_page) -
> -                                vi->hdr_len - metasize;
> -
> -                       /* recalculate len if xdp.data, xdp.data_end or
> -                        * xdp.data_meta were adjusted
> -                        */
> -                       len = xdp.data_end - xdp.data + vi->hdr_len + metasize;
> -
> -                       /* recalculate headroom if xdp.data or xdp_data_meta
> -                        * were adjusted, note that offset should always point
> -                        * to the start of the reserved bytes for virtio_net
> -                        * header which are followed by xdp.data, that means
> -                        * that offset is equal to the headroom (when buf is
> -                        * starting at the beginning of the page, otherwise
> -                        * there is a base offset inside the page) but it's used
> -                        * with a different starting point (buf start) than
> -                        * xdp.data (buf start + vnet hdr size). If xdp.data or
> -                        * data_meta were adjusted by the xdp prog then the
> -                        * headroom size has changed and so has the offset, we
> -                        * can use data_hard_start, which points at buf start +
> -                        * vnet hdr size, to calculate the new headroom and use
> -                        * it later to compute buf start in page_to_skb()
> -                        */
> -                       headroom = xdp.data - xdp.data_hard_start - metasize;
> -
> -                       /* We can only create skb based on xdp_page. */
> -                       if (unlikely(xdp_page != page)) {
> -                               rcu_read_unlock();
> -                               put_page(page);
> -                               head_skb = page_to_skb(vi, rq, xdp_page, offset,
> -                                                      len, PAGE_SIZE);
> -                               return head_skb;
> -                       }
> -                       break;
> +                       head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
> +                       rcu_read_unlock();
> +                       return head_skb;
>                 case XDP_TX:
>                         stats->xdp_tx++;
>                         xdpf = xdp_convert_buff_to_frame(&xdp);
>                         if (unlikely(!xdpf)) {
> -                               if (unlikely(xdp_page != page))
> -                                       put_page(xdp_page);
> -                               goto err_xdp;
> +                               pr_debug("%s: convert buff to frame failed for xdp\n", dev->name);

netdev_dbg()?

Thanks

> +                               goto err_xdp_frags;
>                         }
>                         err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
>                         if (unlikely(!err)) {
>                                 xdp_return_frame_rx_napi(xdpf);
>                         } else if (unlikely(err < 0)) {
>                                 trace_xdp_exception(vi->dev, xdp_prog, act);
> -                               if (unlikely(xdp_page != page))
> -                                       put_page(xdp_page);
> -                               goto err_xdp;
> +                               goto err_xdp_frags;
>                         }
>                         *xdp_xmit |= VIRTIO_XDP_TX;
>                         if (unlikely(xdp_page != page))
> @@ -1203,11 +1161,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>                 case XDP_REDIRECT:
>                         stats->xdp_redirects++;
>                         err = xdp_do_redirect(dev, &xdp, xdp_prog);
> -                       if (err) {
> -                               if (unlikely(xdp_page != page))
> -                                       put_page(xdp_page);
> -                               goto err_xdp;
> -                       }
> +                       if (err)
> +                               goto err_xdp_frags;
>                         *xdp_xmit |= VIRTIO_XDP_REDIR;
>                         if (unlikely(xdp_page != page))
>                                 put_page(page);
> @@ -1220,9 +1175,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>                         trace_xdp_exception(vi->dev, xdp_prog, act);
>                         fallthrough;
>                 case XDP_DROP:
> -                       if (unlikely(xdp_page != page))
> -                               __free_pages(xdp_page, 0);
> -                       goto err_xdp;
> +                       goto err_xdp_frags;
>                 }
>  err_xdp_frags:
>                 shinfo = xdp_get_shared_info_from_buff(&xdp);
> --
> 2.19.1.6.gb485710b
>

