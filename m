Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EA3643CAF
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 06:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiLFFbB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 00:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbiLFFax (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 00:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D6D220DB
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 21:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670304595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UrdaxmIkU9R3lSKqzN+skDpzAUuGekW0ctr0930cr/A=;
        b=fhhtzOdddSvEqF9iG0seQy3/kWw4OH8HQIWza7jzbrlfJbLDEO43Ly9IJnYlO5jtdt+5Dd
        t9hNCAHikqZGM9ul8vyz4ky76V5QrABTcxhGsD9NpJ6CIYTD1OrQj60Pq31EUReD4+lYi/
        R8z013ob8jMYiL65MbJ9wK7cZPOX+Vg=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-249-cQVbf32DME6f7ht_ilGziQ-1; Tue, 06 Dec 2022 00:29:53 -0500
X-MC-Unique: cQVbf32DME6f7ht_ilGziQ-1
Received: by mail-oo1-f71.google.com with SMTP id m23-20020a4a3917000000b004a08a7cca84so4980260ooa.1
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 21:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrdaxmIkU9R3lSKqzN+skDpzAUuGekW0ctr0930cr/A=;
        b=jNbIldspU/MBVy0/MTvMsUtOkNO0qZs8Pwh7n7B7fzbh5rj2QxD4QswHhGFRXPu59x
         5rpve7ioRH/BKX3PZOuAyNfgdVEUMxuR7iHF7HSbZ5JPKjKbVX4zJyCU9ClboPcxfLX4
         zJPUIIUIJlFrtPlcprhDd6sGCdl/DiPHZpF0QRc9ODi6ghvDItutwJjjlu2LW6Y/72/T
         uJtH3zLpLxH0/ZUU2SxHkT+CosQdy3sM6+gXx+WHd49TVhy9vxAb+amF714vigcAttuc
         mCrH3v8Mfss3TnGaU1D4uOaaz+pIDgfYC5lbQ57XBqrOVVhuvuWD8jnfL8x+mG4HLXNG
         ssTQ==
X-Gm-Message-State: ANoB5pnMqt+ibIONdJQHPE3Tqu8odmYEH59cA5YpN1LVMJEpvu/QaHcY
        fZv15ZoLSn/nKTnH7K9DscaTg4/PE4Svkx9nX72jnQe1ale6d3th7+xr4jvzj0Msw5CX2CjPk/6
        HG2IkdIiaLGiQhWignfj1AyEge35q
X-Received: by 2002:aca:1a12:0:b0:35c:303d:fe37 with SMTP id a18-20020aca1a12000000b0035c303dfe37mr4032013oia.35.1670304593136;
        Mon, 05 Dec 2022 21:29:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6l9v2aYuxnEBGmCEsIj8zQk1K2aSin0sjamhXhP/Yt985bXk8FjhcMHR1OvJvvG6gC8ksK1A2vuriXQ64EZrw=
X-Received: by 2002:aca:1a12:0:b0:35c:303d:fe37 with SMTP id
 a18-20020aca1a12000000b0035c303dfe37mr4032006oia.35.1670304592948; Mon, 05
 Dec 2022 21:29:52 -0800 (PST)
MIME-Version: 1.0
References: <20221122074348.88601-1-hengqi@linux.alibaba.com> <20221122074348.88601-3-hengqi@linux.alibaba.com>
In-Reply-To: <20221122074348.88601-3-hengqi@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 6 Dec 2022 13:29:42 +0800
Message-ID: <CACGkMEsaU1Ogytfmy4rVYx6U2Rkd3HcLMjuULZPvR-JJHeRkgA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] virtio_net: set up xdp for multi buffer packets
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 22, 2022 at 3:44 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>
> When the xdp program sets xdp.frags, which means it can process
> multi-buffer packets, so we continue to open xdp support when
> features such as GRO_HW are negotiated.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c5046d21b281..8f7d207d58d6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3080,14 +3080,21 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>         u16 xdp_qp = 0, curr_qp;
>         int i, err;
>
> -       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)
> -           && (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> -               virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> -               virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
> -               virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
> -               virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))) {
> -               NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
> -               return -EOPNOTSUPP;
> +       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
> +               if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM)) {
> +                       NL_SET_ERR_MSG_MOD(extack, "Can't set XDP without frags while guest is implementing GUEST_CSUM");
> +                       return -EOPNOTSUPP;
> +               }
> +
> +               if (prog && !prog->aux->xdp_has_frags) {
> +                       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> +                           virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> +                           virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
> +                           virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO)) {
> +                               NL_SET_ERR_MSG_MOD(extack, "Can't set XDP without frags while guest is implementing GUEST_GRO_HW");
> +                               return -EOPNOTSUPP;
> +                       }
> +               }
>         }
>
>         if (vi->mergeable_rx_bufs && !vi->any_header_sg) {
> @@ -3095,8 +3102,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>                 return -EINVAL;
>         }
>
> -       if (dev->mtu > max_sz) {
> -               NL_SET_ERR_MSG_MOD(extack, "MTU too large to enable XDP");
> +       if (prog && !prog->aux->xdp_has_frags && dev->mtu > max_sz) {
> +               NL_SET_ERR_MSG_MOD(extack, "MTU too large to enable XDP without frags");
>                 netdev_warn(dev, "XDP requires MTU less than %lu\n", max_sz);
>                 return -EINVAL;
>         }
> @@ -3218,9 +3225,6 @@ static int virtnet_set_features(struct net_device *dev,
>         int err;
>
>         if ((dev->features ^ features) & NETIF_F_GRO_HW) {
> -               if (vi->xdp_enabled)
> -                       return -EBUSY;

This seems suspicious, GRO_HW could be re-enabled accidentally even if
it was disabled when attaching an XDP program that is not capable of
doing multi-buffer XDP?

Thanks

> -
>                 if (features & NETIF_F_GRO_HW)
>                         offloads = vi->guest_offloads_capable;
>                 else
> --
> 2.19.1.6.gb485710b
>

