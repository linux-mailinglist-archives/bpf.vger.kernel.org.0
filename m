Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52D84C8073
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 02:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiCABsY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Feb 2022 20:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiCABsY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Feb 2022 20:48:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4F6511A32
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 17:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646099262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=luuUiMnqhEGGpxdu/95KFzZYsnUnE9Pq8uUGjugbrlY=;
        b=BUYu3uoHJT7hzqWzqywIDHjyGpod0vNeja7MYerL52/SBFk0ttPzK0k2o+w4J7AdPqWJ86
        6AZiC4Q8zcrutpGLfxcN+mKkWCN66j6gFiKO8PkFuorv6QzyKxpMlxOgDAk9sJi5gZKtzj
        23cwjAMdVkgg5GzDAOZ8LZ4HFb+xkbI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-yAHRJiViP66nIcG2pfE1Ig-1; Mon, 28 Feb 2022 20:47:41 -0500
X-MC-Unique: yAHRJiViP66nIcG2pfE1Ig-1
Received: by mail-lj1-f199.google.com with SMTP id n9-20020a2e82c9000000b002435af2e8b9so6502369ljh.20
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 17:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luuUiMnqhEGGpxdu/95KFzZYsnUnE9Pq8uUGjugbrlY=;
        b=Z6VcHsx4mi7jyiYitstfzl+9Ev3moK22dZLK+T07DTS5cBFkFHX1oEmzwMbIHk4U8g
         G4m4g11Dbums9m5M1LdhoY8e2EyAWqV/QWm/OLwmOa3qFuB0dF3s/GEnSk8rh99Wg6MD
         cpMJjfJ0gld+gslrFRpcTnaR2HLSpOuksRKRwkkUrqd7GoqoORa9hyoL6nXs6B0L8LfJ
         fxgnQ9K/73kKTRJfZtqa7cUHfZ2m3mQshVnIWM9KAUXIwhwOoGC7e/7yvSjIHj2McYzI
         goED1iYjxDLvKojt0lAg92L9+6AfTJrAtOOWW7NoJ4ioqSqQGrpNQZLkfJ20HOnZ7PzK
         gcCg==
X-Gm-Message-State: AOAM533WiAbdg3lWWDIF6ZSRvbaDzMH7DaI6ng4yvPyMefJE5Hj8LiaB
        iQK2PD5IPBTAwLbBp3iimO6RjbPKMuVKlHVHK59v7ZBtJO0A+4Dft5DWIwgL4F94ikj7vMZjG9/
        a67tG+1+/uYCkvJIwdtrliikRjYeE
X-Received: by 2002:a05:651c:90b:b0:244:c4a4:d5d8 with SMTP id e11-20020a05651c090b00b00244c4a4d5d8mr15365305ljq.97.1646099259986;
        Mon, 28 Feb 2022 17:47:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJ5hCTbfyBOqrRW7yCVhA13lM9sJi5Vxe5wjHoF/hQ4fvPwxZrUmAPDewdu4KFv9hll3xHVZ0CbU9/hV+Sprk=
X-Received: by 2002:a05:651c:90b:b0:244:c4a4:d5d8 with SMTP id
 e11-20020a05651c090b00b00244c4a4d5d8mr15365294ljq.97.1646099259773; Mon, 28
 Feb 2022 17:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20220224103852.311369-1-baymaxhuang@gmail.com>
 <20220228033805.1579435-1-baymaxhuang@gmail.com> <CACGkMEtFFe3mVkXYjYJZtGdU=tAB+T5TYCqySzSxR2N5e4UV1A@mail.gmail.com>
 <20220228091539.057c80ef@hermes.local>
In-Reply-To: <20220228091539.057c80ef@hermes.local>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 1 Mar 2022 09:47:28 +0800
Message-ID: <CACGkMEsqKQD_mBRB5FQwoOTR-gq1Br1oEdtEoxBLhbCSt4SRgA@mail.gmail.com>
Subject: Re: [PATCH net-next v3] tun: support NAPI for packets received from
 batched XDP buffs
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Harold Huang <baymaxhuang@gmail.com>,
        netdev <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 1, 2022 at 1:15 AM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 28 Feb 2022 15:46:56 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> > On Mon, Feb 28, 2022 at 11:38 AM Harold Huang <baymaxhuang@gmail.com> wrote:
> > >
> > > In tun, NAPI is supported and we can also use NAPI in the path of
> > > batched XDP buffs to accelerate packet processing. What is more, after
> > > we use NAPI, GRO is also supported. The iperf shows that the throughput of
> > > single stream could be improved from 4.5Gbps to 9.2Gbps. Additionally, 9.2
> > > Gbps nearly reachs the line speed of the phy nic and there is still about
> > > 15% idle cpu core remaining on the vhost thread.
> > >
> > > Test topology:
> > > [iperf server]<--->tap<--->dpdk testpmd<--->phy nic<--->[iperf client]
> > >
> > > Iperf stream:
> > > iperf3 -c 10.0.0.2  -i 1 -t 10
> > >
> > > Before:
> > > ...
> > > [  5]   5.00-6.00   sec   558 MBytes  4.68 Gbits/sec    0   1.50 MBytes
> > > [  5]   6.00-7.00   sec   556 MBytes  4.67 Gbits/sec    1   1.35 MBytes
> > > [  5]   7.00-8.00   sec   556 MBytes  4.67 Gbits/sec    2   1.18 MBytes
> > > [  5]   8.00-9.00   sec   559 MBytes  4.69 Gbits/sec    0   1.48 MBytes
> > > [  5]   9.00-10.00  sec   556 MBytes  4.67 Gbits/sec    1   1.33 MBytes
> > > - - - - - - - - - - - - - - - - - - - - - - - - -
> > > [ ID] Interval           Transfer     Bitrate         Retr
> > > [  5]   0.00-10.00  sec  5.39 GBytes  4.63 Gbits/sec   72          sender
> > > [  5]   0.00-10.04  sec  5.39 GBytes  4.61 Gbits/sec               receiver
> > >
> > > After:
> > > ...
> > > [  5]   5.00-6.00   sec  1.07 GBytes  9.19 Gbits/sec    0   1.55 MBytes
> > > [  5]   6.00-7.00   sec  1.08 GBytes  9.30 Gbits/sec    0   1.63 MBytes
> > > [  5]   7.00-8.00   sec  1.08 GBytes  9.25 Gbits/sec    0   1.72 MBytes
> > > [  5]   8.00-9.00   sec  1.08 GBytes  9.25 Gbits/sec   77   1.31 MBytes
> > > [  5]   9.00-10.00  sec  1.08 GBytes  9.24 Gbits/sec    0   1.48 MBytes
> > > - - - - - - - - - - - - - - - - - - - - - - - - -
> > > [ ID] Interval           Transfer     Bitrate         Retr
> > > [  5]   0.00-10.00  sec  10.8 GBytes  9.28 Gbits/sec  166          sender
> > > [  5]   0.00-10.04  sec  10.8 GBytes  9.24 Gbits/sec               receiver
> > >
> > > Reported-at: https://lore.kernel.org/all/CACGkMEvTLG0Ayg+TtbN4q4pPW-ycgCCs3sC3-TF8cuRTf7Pp1A@mail.gmail.com
> > > Signed-off-by: Harold Huang <baymaxhuang@gmail.com>
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
>
> Would this help when using sendmmsg and recvmmsg on the TAP device?

We haven't exported the socket object of tuntap to userspace. So we
can't use sendmmsg()/recvmsg() now.

> Asking because interested in speeding up another use of TAP device, and wondering
> if this would help.
>

Yes, it would be interesting. We need someone to work on that.

Thanks

