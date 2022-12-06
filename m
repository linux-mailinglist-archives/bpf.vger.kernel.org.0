Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E165643CB3
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 06:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiLFFcu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 00:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLFFct (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 00:32:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B794122B13
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 21:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670304716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M4jYQApmL+usNuNEAfFw2Nb6ZS+E8atQWPQ4LsFIloQ=;
        b=RW1Kcja/allHiwN1jIJs2hXzcwJKBZj00ShLmnGXKIfcMxzDdEgwx2LdxSTmogzF9WA7oi
        wxPMpwI9rFwJbmyJ+xjIZkiXc0/VZHAK82SodyiLAzFJpiYCqR+kzXQDRz/zUooedNAzuJ
        c1SuSBWP1TUH3TluM9rqS+si5Xd2+Zo=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-4RL20vHEOoCPSEB23SXuVQ-1; Tue, 06 Dec 2022 00:31:48 -0500
X-MC-Unique: 4RL20vHEOoCPSEB23SXuVQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-142a7a82700so6066851fac.14
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 21:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4jYQApmL+usNuNEAfFw2Nb6ZS+E8atQWPQ4LsFIloQ=;
        b=h2+b6EEhTEI0nB3AFydokaxVFxn/XmbNNHbeFcWq2njxBtN3qQ6nXbbSjwBLnZiFRE
         nlB2+OMEMr8BO3g2o9Su2JJ2SOE55YL6DLn8EMgvlBxJBrRzf4YUjODYo6GWdfU8ii46
         JTbGt6JKa0tG0oOxvk0mIA8RbRIjF7UYy8KEcrgVOH1qLgSgp4AaGdMVvH3OfblkwZ7v
         ObELXP9GQ8P+r4ecRhgNJVB0vPFIommzcN4ozXZuVnCupcvRrsHvHpJgPEa4fWVOe9Uy
         JaRReRN9J0M73mSVaHKNbZ3kEieG1k0E4P7AGfDVu7SpX8CdgVnP2MKEZ/MYnAcPz8hR
         n1QA==
X-Gm-Message-State: ANoB5pnNdxZbRvItERS1JTXiS2Iw1GOtu8elNo4bgA5UNZCZR9MJKFpZ
        IeNWh5bwXpB68iZd6uynaKlkGUXuARkgVn5PSWd3Fug+rX3I+9l93sixvXFEPRa1B7EXgxYUc1S
        bTu3hlZkTrklHYQgWYfWrfb2u+fx2
X-Received: by 2002:a05:6870:b9b:b0:144:b22a:38d3 with SMTP id lg27-20020a0568700b9b00b00144b22a38d3mr2688935oab.280.1670304707842;
        Mon, 05 Dec 2022 21:31:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf51i0iUaFszXKYuaebvANrMUwYCsYmCwpdlwO+FrUNB/le+UKxGmQ4fEzSosOe7boGZe7/P92lxILNsX3YRVxw=
X-Received: by 2002:a05:6870:b9b:b0:144:b22a:38d3 with SMTP id
 lg27-20020a0568700b9b00b00144b22a38d3mr2688925oab.280.1670304707639; Mon, 05
 Dec 2022 21:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20221122074348.88601-1-hengqi@linux.alibaba.com> <20221122074348.88601-4-hengqi@linux.alibaba.com>
In-Reply-To: <20221122074348.88601-4-hengqi@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 6 Dec 2022 13:31:36 +0800
Message-ID: <CACGkMEu_WTLJ4QRJ4_KevGLFAu=L7qgY6zV0McnSsDe2TLRawQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] virtio_net: update bytes calculation for xdp_frame
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
> Update relative record value for xdp_frame as basis
> for multi-buffer xdp transmission.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8f7d207d58d6..d3e8c63b9c4b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -658,7 +658,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>                 if (likely(is_xdp_frame(ptr))) {
>                         struct xdp_frame *frame = ptr_to_xdp(ptr);
>
> -                       bytes += frame->len;
> +                       bytes += xdp_get_frame_len(frame);
>                         xdp_return_frame(frame);
>                 } else {
>                         struct sk_buff *skb = ptr;
> @@ -1604,7 +1604,7 @@ static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
>                 } else {
>                         struct xdp_frame *frame = ptr_to_xdp(ptr);
>
> -                       bytes += frame->len;
> +                       bytes += xdp_get_frame_len(frame);
>                         xdp_return_frame(frame);
>                 }
>                 packets++;
> --
> 2.19.1.6.gb485710b
>

