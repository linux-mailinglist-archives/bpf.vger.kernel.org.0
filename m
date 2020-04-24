Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FA01B77FF
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 16:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgDXOHb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 10:07:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53612 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726993AbgDXOHb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Apr 2020 10:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587737249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6uwnvyAVoj+I9gMGJ1DJrhwVmXzWQsJIIyAgcdm+XQ=;
        b=gKrBR5FX8rgwX+DSL1oHC+2payn+QTPtnduyk5YyBMdjsHFwdfSBBQTmOgy5CT584eq8J5
        WjfJ7ycWsX3gdNqNdIFWz4A4G0IWqUDaZ0kYeqKd+OLI98d8jgKmtLeC9BL1XHhtdS4BzV
        uy15UZj+Ddnp573UbkuX6hVbELxja+w=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-tlpDvi3COaqgNo8cOgUYDA-1; Fri, 24 Apr 2020 10:07:26 -0400
X-MC-Unique: tlpDvi3COaqgNo8cOgUYDA-1
Received: by mail-lj1-f200.google.com with SMTP id b26so1817836ljp.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 07:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=x6uwnvyAVoj+I9gMGJ1DJrhwVmXzWQsJIIyAgcdm+XQ=;
        b=slWoKvlU39KVWpwCim/q3KEVAb62eSON7OmSo6T6R+LNPgVKAqpDL38X1oKiEBl8Cq
         0SegEI/z1VeVhLRcoyRQHO7ZWA9IHkdhnb3uhiw87T20/aRRewV7KCoeK8JalZ8Iz+ul
         dJRMuNhZh/JurboJznSAYozlw37m2oUvvA2dwoChGL+oeDbrgHxsaUzvRITDOA9FP0pG
         ZAl5oLaN0D6uysM/xb55rro7o6WD9BKPUS4MDAzj9FhGxdFhkvsJLZ6N97cMfi2J/qLU
         xqhtD5vH+y/I+L6xpga53WysKVvwn3kjJpxs/z8e8eU0ivYY3OD4q7UGn17AIMRtjn0w
         wYxQ==
X-Gm-Message-State: AGi0Pua1syXaL9jiEJ7etN9RpxjFRpcfTm3gk5KB8nGMflbapWPD4Ywu
        F7dS1SErpP2HRPQhUgZi740ZS/aFg50tPvchJ8bUt4MyGhKlYgSYUIcyoZMcj0hHMYsqzdEh9a3
        iJcKIupwjJ7Z6
X-Received: by 2002:a2e:953:: with SMTP id 80mr6082399ljj.276.1587737244548;
        Fri, 24 Apr 2020 07:07:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypIdf5Wy0ENa/dzuMG4BF0/+FyZVmEuC5/hCeSGMucDztWfrfDjjLLuYNFqI/StHcMp1Rh66PQ==
X-Received: by 2002:a2e:953:: with SMTP id 80mr6082387ljj.276.1587737244302;
        Fri, 24 Apr 2020 07:07:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4sm4265343ljf.79.2020.04.24.07.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 07:07:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7B2851814FF; Fri, 24 Apr 2020 16:07:07 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, sameehj@amazon.com
Cc:     Toshiaki Makita <toshiaki.makita1@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org, zorik@amazon.com,
        akiyano@amazon.com, gtzalik@amazon.com,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        steffen.klassert@secunet.com
Subject: Re: [PATCH net-next 10/33] veth: xdp using frame_sz in veth driver
In-Reply-To: <158757169184.1370371.6898362883018539033.stgit@firesoul>
References: <158757160439.1370371.13213378122947426220.stgit@firesoul> <158757169184.1370371.6898362883018539033.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Apr 2020 16:07:07 +0200
Message-ID: <87zhb12d10.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> The veth driver can run XDP in "native" mode in it's own NAPI
> handler, and since commit 9fc8d518d9d5 ("veth: Handle xdp_frames in
> xdp napi ring") packets can come in two forms either xdp_frame or
> skb, calling respectively veth_xdp_rcv_one() or veth_xdp_rcv_skb().
>
> For packets to arrive in xdp_frame format, they will have been
> redirected from an XDP native driver. In case of XDP_PASS or no
> XDP-prog attached, the veth driver will allocate and create an SKB.
>
> The current code in veth_xdp_rcv_one() xdp_frame case, had to guess
> the frame truesize of the incoming xdp_frame, when using
> veth_build_skb(). With xdp_frame->frame_sz this is not longer
> necessary.
>
> Calculating the frame_sz in veth_xdp_rcv_skb() skb case, is done
> similar to the XDP-generic handling code in net/core/dev.c.
>
> Cc: Toshiaki Makita <toshiaki.makita1@gmail.com>
> Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

