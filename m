Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0230C4B99C7
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 08:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiBQHV4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 02:21:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiBQHV4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 02:21:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4FB03B029
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 23:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645082500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MK/w5CaqVN2WaOvoDgze1gKvnvxbRCEDpuTeg5VSM88=;
        b=cSmvf53VA5OppSPtT+5EQJbbzclKdWAw9WTzH52KY3bCAjm8G1efGKRrBNkte6aNMg+qPf
        xFsfhc6zB9HijqYgQliUiTLkdGYBvk8Rr+pHIkx5Dv1Y4yehLvLVIxxDdirrsEzeheKP7T
        o28iNFEuFJY9uYFk9J+hOSMRCILS8vY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-L9jmOFISPQe2_kSTPapQFg-1; Thu, 17 Feb 2022 02:21:38 -0500
X-MC-Unique: L9jmOFISPQe2_kSTPapQFg-1
Received: by mail-lj1-f199.google.com with SMTP id a6-20020a05651c210600b00244bd884dbfso1887261ljq.12
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 23:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MK/w5CaqVN2WaOvoDgze1gKvnvxbRCEDpuTeg5VSM88=;
        b=Gti7HtXkToBaYoEzVlbFiW8vD4kKQOy8ufPz9dONmuaI4c61TZy907T+h6+bEeaS5x
         zwjIJFExYhfl06EOv/Vcmhlzx2ZMya5zSjj11rgHPnpqSJ5DROq4GOl9V/MByMqjX6Sy
         pmihrg3jOqoxqLk3Xvfw7Gnqeyu5djMMhwB7owYlcunrO11tli1KCSRlaqflYY8JYUDS
         ki/m9pG+DNwUXlYcGCLZ5E1clfA3sF2LYXAl7KGIib+20gt7jBxoWxjz8OQvVj3s8liw
         zDiAr7KIqtw2C7Aa2OpO7nUyxwCdHH/ma5/MCGqkd/bz2VsdZ5koCUVHhD2pX3sIRzeS
         +J1Q==
X-Gm-Message-State: AOAM531QlqgWbwMT41E/s0tlG0t2wKSx1/jDrwOX7s17LtP/hTcItImK
        uonYp3QTxry1wjBZ6AIjqexsRhdkutG69Q3pMPkWXIBnyj15yfAybuG6p158G8PKYFkF8x3p3eq
        E3RytR2nA2DMM1MI/xooS9adl4An/
X-Received: by 2002:ac2:5dc9:0:b0:443:5db1:244c with SMTP id x9-20020ac25dc9000000b004435db1244cmr1234541lfq.84.1645082497394;
        Wed, 16 Feb 2022 23:21:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbfpKRrqedpKyeZauCLg5Kmr+HPSiEonm1qoPRESgaCwlyrbWvcenrKeaJ0wCQuxOVhIznhGs2jYN71FJfjD0=
X-Received: by 2002:ac2:5dc9:0:b0:443:5db1:244c with SMTP id
 x9-20020ac25dc9000000b004435db1244cmr1234535lfq.84.1645082497203; Wed, 16 Feb
 2022 23:21:37 -0800 (PST)
MIME-Version: 1.0
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-21-xuanzhuo@linux.alibaba.com> <CACGkMEvZvhSb0veCynEHN3EfFu_FwbCAb8w1b0Oi3LDc=ffNaw@mail.gmail.com>
 <1644997568.827981-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1644997568.827981-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 17 Feb 2022 15:21:26 +0800
Message-ID: <CACGkMEt_AEw2Jh9VzkGQ2A8f8Y0nuuFxr193_vnkFpc=JyD2Sg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 16, 2022 at 3:52 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Wed, 16 Feb 2022 12:14:31 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Mon, Feb 14, 2022 at 4:14 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > Sets the default maximum ring num based on virtio_set_max_ring_num().
> > >
> > > The default maximum ring num is 1024.
> >
> > Having a default value is pretty useful, I see 32K is used by default for IFCVF.
> >
> > Rethink this, how about having a different default value based on the speed?
> >
> > Without SPEED_DUPLEX, we use 1024. Otherwise
> >
> > 10g 4096
> > 40g 8192
>
> We can define different default values of tx and rx by the way. This way I can
> just use it in the new interface of find_vqs().
>
> without SPEED_DUPLEX:  tx 512 rx 1024
>

Any reason that TX is smaller than RX?

Thanks

> Thanks.
>
>
> >
> > etc.
> >
> > (The number are just copied from the 10g/40g default parameter from
> > other vendors)
> >
> > Thanks
> >
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index a4ffd7cdf623..77e61fe0b2ce 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -35,6 +35,8 @@ module_param(napi_tx, bool, 0644);
> > >  #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
> > >  #define GOOD_COPY_LEN  128
> > >
> > > +#define VIRTNET_DEFAULT_MAX_RING_NUM 1024
> > > +
> > >  #define VIRTNET_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
> > >
> > >  /* Amount of XDP headroom to prepend to packets for use by xdp_adjust_head */
> > > @@ -3045,6 +3047,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > >                         ctx[rxq2vq(i)] = true;
> > >         }
> > >
> > > +       virtio_set_max_ring_num(vi->vdev, VIRTNET_DEFAULT_MAX_RING_NUM);
> > > +
> > >         ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
> > >                                   names, ctx, NULL);
> > >         if (ret)
> > > --
> > > 2.31.0
> > >
> >
>

