Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A784C63F5
	for <lists+bpf@lfdr.de>; Mon, 28 Feb 2022 08:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiB1Hrz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Feb 2022 02:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiB1Hry (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Feb 2022 02:47:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E04568F89
        for <bpf@vger.kernel.org>; Sun, 27 Feb 2022 23:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646034435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aUXNIN60U26tD/3N7dMMfSzdsR2HBfgMEkzDNq/C3Eo=;
        b=CQAWisnI2Ho5yJ3OVxT172+GWh10soWNnSiMSz5z+6z03b7EH0BFDWsYirPt7lw3J34JRG
        8FCFZSDfk2GhHHYe3a3iOr6Zo198bC2OOyhpDFOZQfWhRM4gPPA6ZzMYNxNkeNwkrilEBV
        /VKUDl2+s7bnAagVCk8SRl7nYnhyYZI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389--DclV2S1MwmmyDHZvehVjA-1; Mon, 28 Feb 2022 02:47:09 -0500
X-MC-Unique: -DclV2S1MwmmyDHZvehVjA-1
Received: by mail-lj1-f198.google.com with SMTP id 20-20020a2e0914000000b0024635d136ddso5302632ljj.22
        for <bpf@vger.kernel.org>; Sun, 27 Feb 2022 23:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUXNIN60U26tD/3N7dMMfSzdsR2HBfgMEkzDNq/C3Eo=;
        b=QhTyMfHlTtd0kMSVFvwe8MFQfmodcm7smLVRFsK4UqKgnHiDdfezHouBgIal99V8lK
         zdqs8QTAmgTl1oeaZtY4ee/LWFgmm0vQ/1RRyQ0oU4lXK4yE51KZMHLZE2lpzo7kM5cr
         AD1QsM1t5cHRVyUS8NAImghEDH83rapGEi7WW9iSBmuUAUltJtJt9DGL/vzdyGcRGz/3
         yC9ZVWpROokEdEIV9LcD6I82mBh+ko45szhqItM8RtXgciAW+r+Qa+MnXMgV60QAgbU2
         RS4hpLG09lAoExqT8WpdSkKvu2VqXImFPyJtSld8loFLaT8xdDwOw304TgDp6KR9a8mX
         ZwAg==
X-Gm-Message-State: AOAM530m1DCjJO4o6nVUQ6g7hJtc3lT+Eb4K9yt6pmSykwNOSvk9xEre
        33a9XMuBMBEfDEArm8T0g3FqxJhBcFEE0vPiy/Cw0U5EtZc/EJP6wNMqmr60ZyB8s+yHVtMZ4qE
        CXzhTSdprdt8MxQrPRw2YrccqcPn9
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id y1-20020a056512334100b00433b033bd22mr11614977lfd.190.1646034427585;
        Sun, 27 Feb 2022 23:47:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWaQtCTk3mFw1wzzyGlheyom7wph+t1lT88MJiKZ34pemCt5LBVKfxtLSrFj5vHtVJOMgVCeciDuad74iBnpM=
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr11614963lfd.190.1646034427235; Sun, 27
 Feb 2022 23:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20220224103852.311369-1-baymaxhuang@gmail.com> <20220228033805.1579435-1-baymaxhuang@gmail.com>
In-Reply-To: <20220228033805.1579435-1-baymaxhuang@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 28 Feb 2022 15:46:56 +0800
Message-ID: <CACGkMEtFFe3mVkXYjYJZtGdU=tAB+T5TYCqySzSxR2N5e4UV1A@mail.gmail.com>
Subject: Re: [PATCH net-next v3] tun: support NAPI for packets received from
 batched XDP buffs
To:     Harold Huang <baymaxhuang@gmail.com>
Cc:     netdev <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 28, 2022 at 11:38 AM Harold Huang <baymaxhuang@gmail.com> wrote:
>
> In tun, NAPI is supported and we can also use NAPI in the path of
> batched XDP buffs to accelerate packet processing. What is more, after
> we use NAPI, GRO is also supported. The iperf shows that the throughput of
> single stream could be improved from 4.5Gbps to 9.2Gbps. Additionally, 9.2
> Gbps nearly reachs the line speed of the phy nic and there is still about
> 15% idle cpu core remaining on the vhost thread.
>
> Test topology:
> [iperf server]<--->tap<--->dpdk testpmd<--->phy nic<--->[iperf client]
>
> Iperf stream:
> iperf3 -c 10.0.0.2  -i 1 -t 10
>
> Before:
> ...
> [  5]   5.00-6.00   sec   558 MBytes  4.68 Gbits/sec    0   1.50 MBytes
> [  5]   6.00-7.00   sec   556 MBytes  4.67 Gbits/sec    1   1.35 MBytes
> [  5]   7.00-8.00   sec   556 MBytes  4.67 Gbits/sec    2   1.18 MBytes
> [  5]   8.00-9.00   sec   559 MBytes  4.69 Gbits/sec    0   1.48 MBytes
> [  5]   9.00-10.00  sec   556 MBytes  4.67 Gbits/sec    1   1.33 MBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  5.39 GBytes  4.63 Gbits/sec   72          sender
> [  5]   0.00-10.04  sec  5.39 GBytes  4.61 Gbits/sec               receiver
>
> After:
> ...
> [  5]   5.00-6.00   sec  1.07 GBytes  9.19 Gbits/sec    0   1.55 MBytes
> [  5]   6.00-7.00   sec  1.08 GBytes  9.30 Gbits/sec    0   1.63 MBytes
> [  5]   7.00-8.00   sec  1.08 GBytes  9.25 Gbits/sec    0   1.72 MBytes
> [  5]   8.00-9.00   sec  1.08 GBytes  9.25 Gbits/sec   77   1.31 MBytes
> [  5]   9.00-10.00  sec  1.08 GBytes  9.24 Gbits/sec    0   1.48 MBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  10.8 GBytes  9.28 Gbits/sec  166          sender
> [  5]   0.00-10.04  sec  10.8 GBytes  9.24 Gbits/sec               receiver
>
> Reported-at: https://lore.kernel.org/all/CACGkMEvTLG0Ayg+TtbN4q4pPW-ycgCCs3sC3-TF8cuRTf7Pp1A@mail.gmail.com
> Signed-off-by: Harold Huang <baymaxhuang@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
> v2 -> v3
>  - return the queued NAPI packet from tun_xdp_one
>
>  drivers/net/tun.c | 43 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index fed85447701a..969ea69fd29d 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2388,9 +2388,10 @@ static int tun_xdp_one(struct tun_struct *tun,
>         struct virtio_net_hdr *gso = &hdr->gso;
>         struct bpf_prog *xdp_prog;
>         struct sk_buff *skb = NULL;
> +       struct sk_buff_head *queue;
>         u32 rxhash = 0, act;
>         int buflen = hdr->buflen;
> -       int err = 0;
> +       int ret = 0;
>         bool skb_xdp = false;
>         struct page *page;
>
> @@ -2405,13 +2406,13 @@ static int tun_xdp_one(struct tun_struct *tun,
>                 xdp_set_data_meta_invalid(xdp);
>
>                 act = bpf_prog_run_xdp(xdp_prog, xdp);
> -               err = tun_xdp_act(tun, xdp_prog, xdp, act);
> -               if (err < 0) {
> +               ret = tun_xdp_act(tun, xdp_prog, xdp, act);
> +               if (ret < 0) {
>                         put_page(virt_to_head_page(xdp->data));
> -                       return err;
> +                       return ret;
>                 }
>
> -               switch (err) {
> +               switch (ret) {
>                 case XDP_REDIRECT:
>                         *flush = true;
>                         fallthrough;
> @@ -2435,7 +2436,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>  build:
>         skb = build_skb(xdp->data_hard_start, buflen);
>         if (!skb) {
> -               err = -ENOMEM;
> +               ret = -ENOMEM;
>                 goto out;
>         }
>
> @@ -2445,7 +2446,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>         if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun))) {
>                 atomic_long_inc(&tun->rx_frame_errors);
>                 kfree_skb(skb);
> -               err = -EINVAL;
> +               ret = -EINVAL;
>                 goto out;
>         }
>
> @@ -2455,16 +2456,27 @@ static int tun_xdp_one(struct tun_struct *tun,
>         skb_record_rx_queue(skb, tfile->queue_index);
>
>         if (skb_xdp) {
> -               err = do_xdp_generic(xdp_prog, skb);
> -               if (err != XDP_PASS)
> +               ret = do_xdp_generic(xdp_prog, skb);
> +               if (ret != XDP_PASS) {
> +                       ret = 0;
>                         goto out;
> +               }
>         }
>
>         if (!rcu_dereference(tun->steering_prog) && tun->numqueues > 1 &&
>             !tfile->detached)
>                 rxhash = __skb_get_hash_symmetric(skb);
>
> -       netif_receive_skb(skb);
> +       if (tfile->napi_enabled) {
> +               queue = &tfile->sk.sk_write_queue;
> +               spin_lock(&queue->lock);
> +               __skb_queue_tail(queue, skb);
> +               spin_unlock(&queue->lock);
> +               ret = 1;
> +       } else {
> +               netif_receive_skb(skb);
> +               ret = 0;
> +       }
>
>         /* No need to disable preemption here since this function is
>          * always called with bh disabled
> @@ -2475,7 +2487,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>                 tun_flow_update(tun, rxhash, tfile);
>
>  out:
> -       return err;
> +       return ret;
>  }
>
>  static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
> @@ -2492,7 +2504,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
>         if (ctl && (ctl->type == TUN_MSG_PTR)) {
>                 struct tun_page tpage;
>                 int n = ctl->num;
> -               int flush = 0;
> +               int flush = 0, queued = 0;
>
>                 memset(&tpage, 0, sizeof(tpage));
>
> @@ -2501,12 +2513,17 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
>
>                 for (i = 0; i < n; i++) {
>                         xdp = &((struct xdp_buff *)ctl->ptr)[i];
> -                       tun_xdp_one(tun, tfile, xdp, &flush, &tpage);
> +                       ret = tun_xdp_one(tun, tfile, xdp, &flush, &tpage);
> +                       if (ret > 0)
> +                               queued += ret;
>                 }
>
>                 if (flush)
>                         xdp_do_flush();
>
> +               if (tfile->napi_enabled && queued > 0)
> +                       napi_schedule(&tfile->napi);
> +
>                 rcu_read_unlock();
>                 local_bh_enable();
>
> --
> 2.27.0
>

