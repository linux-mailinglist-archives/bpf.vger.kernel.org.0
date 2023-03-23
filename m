Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFF06C5F19
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 06:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCWFls (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 01:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjCWFlr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 01:41:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8D1F3
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 22:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679550056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D8WMSh/aQ+eAzT9IfV/3va57SyXLtifjECFun3hDE68=;
        b=Kd4Nr4ZZ2vPWUYQbwSM3kBk/sHoQV/SQjloPxdEM15C5sRZFOTerbBEADuHHeP0xe5fI6r
        zkxUr5QLSJU5GFv2v+VFFiVxRrFPsKyIw77VryiFbCy7n4/htBj0AG2kUNvbYMNlzEiLQ0
        6Ntea6FaMcWif4sn/BA+cvxmRJLs4j0=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-6NlAmfFMMEmJPahrElbefA-1; Thu, 23 Mar 2023 01:40:55 -0400
X-MC-Unique: 6NlAmfFMMEmJPahrElbefA-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-17270774b8fso10939864fac.3
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 22:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679550054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8WMSh/aQ+eAzT9IfV/3va57SyXLtifjECFun3hDE68=;
        b=g2E0wV5C1bDecfd6JJlENjQrPAoDaIOFEH5fnCH4PwZTdRyC4qunZX9SbE9BfFxSkC
         19SijsKs3/kuH2gKrVBjlSUmqrQyusZ3mS1geQR798l7T9iSxGOCMd3391Z3ApYiRVrs
         70F3IpMMOpZ93FJb1Ll+ELOC1T0l1m+gZObdv4AB/cwTmoaZJCs6Ec8zl4IVkIvZx5Lk
         KUc6Qivosu33sHrSLE+8aaPuBfwIsMX0lOpeOr4b06+h5Hn3aJX8Hx9fEPkVKutlXpK6
         xBboPg4G3ZH3Lobj5dunQEz9zzmqH86Vtb6pkAoiukHkMPe2q/Oys5kbyvPRwZcZx/hi
         HaWA==
X-Gm-Message-State: AAQBX9cthwyoEOLLWVSTNC7muFIoTNIWIgsW/38pu8hbWbtctS0dkPPK
        aqlJFB7zLzZZ/bmsyUDnvquYXRx2BxvsL5vXHKpgfe5b6664gKc6OyHYRe6aAlastO4LwVdTON2
        KjBrvpwDP9F6JxQ9nI0nE8CyPt7x8
X-Received: by 2002:a05:6871:8f14:b0:177:83f7:351c with SMTP id zz20-20020a0568718f1400b0017783f7351cmr593756oab.9.1679550054419;
        Wed, 22 Mar 2023 22:40:54 -0700 (PDT)
X-Google-Smtp-Source: AK7set9g1YSjMDMQC+7+4yeX/CPsFYBSYAc0A6erI1PPIA4fosMlO2u/x57fcKvYMnvLOFEHYjlSjRzQvBThlEzDl9M=
X-Received: by 2002:a05:6871:8f14:b0:177:83f7:351c with SMTP id
 zz20-20020a0568718f1400b0017783f7351cmr593745oab.9.1679550054237; Wed, 22 Mar
 2023 22:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
 <20230322030308.16046-3-xuanzhuo@linux.alibaba.com> <c7749936-c154-da51-ccfb-f16150d19c62@huawei.com>
 <1679535924.6219428-2-xuanzhuo@linux.alibaba.com> <215e791d-1802-2419-ff59-49476bcdcd02@huawei.com>
In-Reply-To: <215e791d-1802-2419-ff59-49476bcdcd02@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 23 Mar 2023 13:40:43 +0800
Message-ID: <CACGkMEv=0gt6LS0HSgKELQqnWfQ2UdFgAKdvh=CLaAPLeNytww@mail.gmail.com>
Subject: Re: [PATCH net-next 2/8] virtio_net: mergeable xdp: introduce mergeable_xdp_prepare
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> >
> >>
> >> Also, it seems better to split the xdp_linearize_page() to two functions
> >> as pskb_expand_head() and __skb_linearize() do, one to expand the headroom,
> >> the other one to do the linearizing.
> >
> > No skb here.
>
> I means following the semantics of pskb_expand_head() and __skb_linearize(),
> not to combine the headroom expanding and linearizing into one function as
> xdp_linearize_page() does now if we want a better refoctor result.

Not sure it's worth it, since the use is very specific unless we could
find a case that wants only one of them.

Thanks

>
> >
> >
> >>
>

