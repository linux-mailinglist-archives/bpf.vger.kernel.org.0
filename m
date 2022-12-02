Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F1E63FFE8
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 06:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiLBFmx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 00:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiLBFmw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 00:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AAFD2913
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 21:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669959716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUKoGhwXuawO+Q9ctXLJTWVmMFQ1RDIh1AE3sBU1nvc=;
        b=iO/lJyUCaXt0tQca8HF4vfcUn8rB95+2xnUprg9OXdtn1LIMmYWYXFZm6nZeFDnueCCKG3
        o+1Zz40arJA2cY6uV1IRvPGeyW898gZvxB8GlUQEx/Sr1ljznjFva3keiyNCHqJnSHTdLF
        0nP6ze3Sc2t7I56D+8kOSdM5ugViibI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-331-I6600y_jNOGIn1Mv-vZQAw-1; Fri, 02 Dec 2022 00:41:55 -0500
X-MC-Unique: I6600y_jNOGIn1Mv-vZQAw-1
Received: by mail-ot1-f69.google.com with SMTP id bm9-20020a056830374900b0066e7ffcb95dso702894otb.2
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 21:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUKoGhwXuawO+Q9ctXLJTWVmMFQ1RDIh1AE3sBU1nvc=;
        b=NBF3RMDu0kox3foXPhQ0ghspyspSxn4FxzXOCsL9yK25zpR4AR0f3hFn+1luOhmTqD
         mBpCD1SF7rN1UD1Hz/IxMvIHzh+YL9WkhZTuJlqZyqERz0sfSHhNbYeh7m3vS+wDyQXo
         wxzSJOkyiDuqN/CyS6hZmjuxexeg1OqRs2ZY/otiKWKF2php/fKPvY5LZEW9T5K+YCzF
         zbWYEAIAu54UeefF7mouSgOJmRJ+4aVW+NP1KWtp34u9BRLbjqUrCgVY0RgLXHV9+8ns
         3DboyWFX02+LV60BsX15W3swBxcmrgJYHbg2RsamUTXxTfpB+pDuWTiyciXmmrwVpZrj
         h/4w==
X-Gm-Message-State: ANoB5pl8yBokLOHPEj637XNBDf3NxEL8Tb//LDA4ArPQs7FInTIROZ7Z
        +Z98Zps7VVOLr54k5hGgfDE5sU7ZKmn/jXZp2khev3qe0rz9M6G6E35J7YIJhKLDj4yochX3q59
        AuAldUbwTRhcGuh48eNfudT19Lq6b
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id cm5-20020a056830650500b0066cfb5b4904mr34941997otb.237.1669959714274;
        Thu, 01 Dec 2022 21:41:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4GqKUi4a7OPQXgIY85nJalmtGjjKzQneNkJaMeFgfh1jL18scOCPin9+AeQkaBI16rY6l76WIiFLo4kfWXGKE=
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr34941991otb.237.1669959714031; Thu, 01
 Dec 2022 21:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20221122074348.88601-1-hengqi@linux.alibaba.com> <1b95612c-a38b-90e2-cbe3-211d8129fb9f@linux.alibaba.com>
In-Reply-To: <1b95612c-a38b-90e2-cbe3-211d8129fb9f@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 2 Dec 2022 13:41:42 +0800
Message-ID: <CACGkMEtm7dh+PqiFi4XDwN-XSei0WqMWq5TBkYzGAWmEj83awg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] virtio_net: support multi buffer xdp
To:     Heng Qi <hengqi@linux.alibaba.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 2, 2022 at 12:50 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>
> Hi, Jason.
>
> Do you have any comments on this series?

-EBUSY this week, but I will review it next week for sure.

Thanks

>
> Thanks.
>
> =E5=9C=A8 2022/11/22 =E4=B8=8B=E5=8D=883:43, Heng Qi =E5=86=99=E9=81=93:
> > Currently, virtio net only supports xdp for single-buffer packets
> > or linearized multi-buffer packets. This patchset supports xdp for
> > multi-buffer packets, then GRO_HW related features can be
> > negotiated, and do not affect the processing of single-buffer xdp.
> >
> > In order to build multi-buffer xdp neatly, we integrated the code
> > into virtnet_build_xdp_buff() for xdp. The first buffer is used
> > for prepared xdp buff, and the rest of the buffers are added to
> > its skb_shared_info structure. This structure can also be
> > conveniently converted during XDP_PASS to get the corresponding skb.
> >
> > Since virtio net uses comp pages, and bpf_xdp_frags_increase_tail()
> > is based on the assumption of the page pool,
> > (rxq->frag_size - skb_frag_size(frag) - skb_frag_off(frag))
> > is negative in most cases. So we didn't set xdp_rxq->frag_size in
> > virtnet_open() to disable the tail increase.
> >
> > Heng Qi (9):
> >    virtio_net: disable the hole mechanism for xdp
> >    virtio_net: set up xdp for multi buffer packets
> >    virtio_net: update bytes calculation for xdp_frame
> >    virtio_net: remove xdp related info from page_to_skb()
> >    virtio_net: build xdp_buff with multi buffers
> >    virtio_net: construct multi-buffer xdp in mergeable
> >    virtio_net: build skb from multi-buffer xdp
> >    virtio_net: transmit the multi-buffer xdp
> >    virtio_net: support multi-buffer xdp
> >
> >   drivers/net/virtio_net.c | 356 ++++++++++++++++++++++++--------------=
-
> >   1 file changed, 219 insertions(+), 137 deletions(-)
> >
>

