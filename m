Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1234ACFBC
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 04:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346398AbiBHDY3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 22:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346394AbiBHDY3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 22:24:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E232C0401D3
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 19:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644290667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XmzNPlkxWWEnYip16aRoQo9kev5KhShz7UfafEwcglg=;
        b=XHELVZFZOpAKnfqCtHpjhR7muPCp3bkjX9DWGYMNnvyGJzZgc/HYDZ8an8ehLvmX1aCIjr
        TO4NiRy8Mvl77YrWbQOdy11eDcpI7AlX1h6wqNLFYhe2nfui/Kf0/0nIxAmEIr6PIUB4UG
        7TPNFXHAtQT1LYBBS+Iw6oc86rWpYdI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-aPxE_OEbNaq9-l_ZsYJhUQ-1; Mon, 07 Feb 2022 22:24:25 -0500
X-MC-Unique: aPxE_OEbNaq9-l_ZsYJhUQ-1
Received: by mail-lj1-f200.google.com with SMTP id 184-20020a2e05c1000000b0023a30a97e36so5364823ljf.14
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 19:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XmzNPlkxWWEnYip16aRoQo9kev5KhShz7UfafEwcglg=;
        b=zwJ75v1K1GJxcbxpscCQrX3SUllOgBABD/o3e4sMeCpLsgFuDCPfc2spaAPtTK85+n
         UjaypVIrdpe1fPSe/JADEPgP8bYlgC11s0qHNv+2ZmrEsBbmsB9ldFzC8Jmz3bBLfNs0
         hoqyQriFSPd/ykvOVdOztYcIvBk0tjXzWTStu8txM/hoawoLS99nS+vw5OGrkfqtG0ak
         zwbIgQ7xxba7IUz4vb8JpP7hlMn2uI0bpXY4yHx53VCpEbrVSYCWM6mzCylz0llScfC4
         2wjTXPU7oAvWrNVmX8TjIoIdiwtmycCYcOv4f2lUybONltbwBs2DDba4FAovCRD1Wrtu
         oNkA==
X-Gm-Message-State: AOAM531cdsJYRY54CcBjgl1+JT9tZufERlxEh64JL0ZGSOyssNJRCiue
        1PtiKE31qxwaRQEqLiBzMQloagmOxUrpxbDtiJl1OR7cscRFvYuU3bc6bC4axP1j+mBDqlaWbXH
        fk+6+eThNNAVmsg3VOjJ3Qx8p9xiT
X-Received: by 2002:ac2:4acf:: with SMTP id m15mr1720188lfp.580.1644290664408;
        Mon, 07 Feb 2022 19:24:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwW38r/MbqhEQoE0DC7dUknDgPDexQGx026XujMyoT9wTt77AHO3Jo4bfMJvjYC7HugGD8zwBA3+PWfIrkxA9U=
X-Received: by 2002:ac2:4acf:: with SMTP id m15mr1720177lfp.580.1644290664230;
 Mon, 07 Feb 2022 19:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
 <20220126073533.44994-2-xuanzhuo@linux.alibaba.com> <28013a95-4ce4-7859-9ca1-d836265e8792@redhat.com>
 <1644213876.065673-2-xuanzhuo@linux.alibaba.com> <CACGkMEuJ_v5g2ypLZ3eNhAcUM9Q3PpWuiaeWVfEC6KACGzWAZw@mail.gmail.com>
 <1644286649.5989025-1-xuanzhuo@linux.alibaba.com> <CACGkMEvVmKg0r4WudojL6dGt3vG4f=_4Pnsn-kBwQcge63jNqQ@mail.gmail.com>
 <1644290312.0241497-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1644290312.0241497-3-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 8 Feb 2022 11:24:13 +0800
Message-ID: <CACGkMEtOoSF293nDwLFpAcs9M1+sUZufO309kCO0tRy7w40vdQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 8, 2022 at 11:20 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrot=
e:
>
> On Tue, 8 Feb 2022 11:03:17 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Tue, Feb 8, 2022 at 10:17 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> =
wrote:
> > >
> > > On Mon, 7 Feb 2022 16:06:15 +0800, Jason Wang <jasowang@redhat.com> w=
rote:
> > > > On Mon, Feb 7, 2022 at 2:07 PM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
> > > > >
> > > > > On Mon, 7 Feb 2022 11:41:06 +0800, Jason Wang <jasowang@redhat.co=
m> wrote:
> > > > > >
> > > > > > =E5=9C=A8 2022/1/26 =E4=B8=8B=E5=8D=883:35, Xuan Zhuo =E5=86=99=
=E9=81=93:
> > > > > > > Add queue_notify_data in struct virtio_pci_common_cfg, which =
comes from
> > > > > > > here https://github.com/oasis-tcs/virtio-spec/issues/89
> > > > > > >
> > > > > > > Since I want to add queue_reset after it, I submitted this pa=
tch first.
> > > > > > >
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > ---
> > > > > > >   include/uapi/linux/virtio_pci.h | 1 +
> > > > > > >   1 file changed, 1 insertion(+)
> > > > > > >
> > > > > > > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/l=
inux/virtio_pci.h
> > > > > > > index 3a86f36d7e3d..492c89f56c6a 100644
> > > > > > > --- a/include/uapi/linux/virtio_pci.h
> > > > > > > +++ b/include/uapi/linux/virtio_pci.h
> > > > > > > @@ -164,6 +164,7 @@ struct virtio_pci_common_cfg {
> > > > > > >     __le32 queue_avail_hi;          /* read-write */
> > > > > > >     __le32 queue_used_lo;           /* read-write */
> > > > > > >     __le32 queue_used_hi;           /* read-write */
> > > > > > > +   __le16 queue_notify_data;       /* read-write */
> > > > > > >   };
> > > > > >
> > > > > >
> > > > > > So I had the same concern as previous version.
> > > > > >
> > > > > > This breaks uABI where program may try to use sizeof(struct
> > > > > > virtio_pci_common_cfg).
> > > > > >
> > > > > > We probably need a container structure here.
> > > > >
> > > > > I see, I plan to add a struct like this, do you think it's approp=
riate?
> > > > >
> > > > > struct virtio_pci_common_cfg_v1 {
> > > > >         struct virtio_pci_common_cfg cfg;
> > > > >         __le16 queue_notify_data;       /* read-write */
> > > > > }
> > > >
> > > > Something like this but we probably need a better name.
> > >
> > >
> > > how about this?
> > >
> > >         /* Ext Fields in VIRTIO_PCI_CAP_COMMON_CFG: */
> > >         struct virtio_pci_common_cfg_ext {
> > >                 struct virtio_pci_common_cfg cfg;
> > >
> > >                 __le16 queue_notify_data;       /* read-write */
> > >
> > >                 __le16 reserved0;
> > >                 __le16 reserved1;
> > >                 __le16 reserved2;
> > >                 __le16 reserved3;
> > >                 __le16 reserved4;
> > >                 __le16 reserved5;
> > >                 __le16 reserved6;
> > >                 __le16 reserved7;
> > >                 __le16 reserved8;
> > >                 __le16 reserved9;
> > >                 __le16 reserved10;
> > >                 __le16 reserved11;
> > >                 __le16 reserved12;
> > >                 __le16 reserved13;
> > >                 __le16 reserved14;
> > >         };
> >
> > I still think the container without padding is better. Otherwise
> > userspace needs to use offset_of() trick instead of sizeof().
>
> In this case, as virtio_pci_common_cfg_ext adds new members in the future=
, we
> will add more container structures.
>
> In that case, I think virtio_pci_common_cfg_v1 is a good name instead.

Something like "virtio_pci_common_cfg_notify" might be a little bit better.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > > >
> > > > > > THanks
> > > > > >
> > > > > >
> > > > > > >
> > > > > > >   /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> > > > > >
> > > > >
> > > >
> > >
> >
>

