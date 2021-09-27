Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9952C419B37
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 19:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbhI0RQY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 13:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbhI0ROw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 13:14:52 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D20C051741
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 10:06:03 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id s20so23695141ioa.4
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Q9onsPk/TXaOCMEv4AT2657vSl1grxBTxAt6ZfawYo=;
        b=TmTxwovudp5NuP4w1Yeav+5kzXC8glrF0pAih0hr9exRJq9p+mHHhKDJElNbNQb1Ij
         h+r066Z2Av7U6b40IEiWrx12F7aN4+Z5f8L9+T7LzV4stdIMkoGD8e3ug2D5RsKORi/i
         nhLKqjHNYmRrcQr30jTbOCBw6CP6HDWTkcMekBeDmzIpiBtjcvgqj2vbN99Tk5LReCQh
         bF1qrR6bCgYDfsgmNDbd5XtDvWz9+ca1ZnElRUxlI0oIHsmrzcVzC4L5Bk45+AtRdHnI
         cR+KTBa0Bi66JFv2Gv1nZWs5hxg0qBljSSrlt3NaBdHQffIeQ0Bq1bT+emufpjF4Oeab
         5gsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Q9onsPk/TXaOCMEv4AT2657vSl1grxBTxAt6ZfawYo=;
        b=Sbwo544A2yWwTEs/Yy7YoPedrjfSzLfo4pRttza44EySE/VwNLJCKdgEV7sQlhAN7Z
         LjfwawZW31RF5L42hLSfqReoHVrvnezaWDqquhQ9ocoAyQOEfpbUOBjx/Uhl8B2uXBCP
         Ug06atvRcD5a1Oz0QtfxqZ6dFhGVCyKSvCEmilYZuIDcft+zuOsOnKlsTH4Q7GsbjMK4
         0cW6xdE8kSpiAYroZRUAUFfK3XpXQ9cS9RUrGaovna4GJrvRjk5YZQTRLj0s9IdjK1KJ
         tcLVyVKSbuBTFCqu/XkJ/NL48IqokYXZE92P2x9j3xa/cr9T4RVMBeFQITj9vQ6X68Ve
         KudQ==
X-Gm-Message-State: AOAM530SsVb6XnCWO7YtJ77ffnDckyMHgdf+1R4UNqCeysfSdMM3ZXdP
        o5G2+0Iwxcm9188cCc6CdRm2r6vx8u9veRjfLbfphg==
X-Google-Smtp-Source: ABdhPJzkXYuDVcmVIoUNLd6urdFTTEYgOR6P/eci74DDABaFSKWw4J2VkcNJElNnd4nCoY4BMaiZPqBe1B+b6Az61+0=
X-Received: by 2002:a02:1049:: with SMTP id 70mr827455jay.123.1632762362607;
 Mon, 27 Sep 2021 10:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210922222935.495290-1-irogers@google.com> <e126f901-f3ce-1325-b3c1-9d325bbc8249@iogearbox.net>
 <014c2f18-cede-ccc6-6d45-ca09093a6c76@iogearbox.net>
In-Reply-To: <014c2f18-cede-ccc6-6d45-ca09093a6c76@iogearbox.net>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Sep 2021 10:05:48 -0700
Message-ID: <CAP-5=fWr9EunVXMoYu08AwVpK_Gq2qWixof_Gw5CWJGCeWeD6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools/include: Update if_link.h and netlink.h
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Igor Russkikh <irusskikh@marvell.com>,
        Mark Starovoytov <mstarovoitov@marvell.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Alexandre Cassen <acassen@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 27, 2021 at 10:03 AM Daniel Borkmann <daniel@iogearbox.net> wro=
te:
>
> On 9/27/21 7:02 PM, Daniel Borkmann wrote:
> > On 9/23/21 12:29 AM, Ian Rogers wrote:
> >> Sync the uAPI headers so that userspace and the kernel match. These
> >> changes make the tools version match the updates to the files in the
> >> kernel directory that were updated by commits:
> >>
> >> if_link.h:
> >> 8f4c0e01789c hsr: enhance netlink socket interface to support PRP
> >> 427f0c8c194b macvlan: Add nodst option to macvlan type source
> >> 583be982d934 mctp: Add device handling and netlink interface
> >> c7fa1d9b1fb1 net: bridge: mcast: dump ipv4 querier state
> >> 2dba407f994e net: bridge: multicast: make tracked EHT hosts limit conf=
igurable
> >> b6e5d27e32ef net: ethernet: rmnet: Add support for MAPv5 egress packet=
s
> >> 14452ca3b5ce net: qualcomm: rmnet: Export mux_id and flags to netlink
> >> 78a3ea555713 net: remove comments on struct rtnl_link_stats
> >> 0db0c34cfbc9 net: tighten the definition of interface statistics
> >> 571912c69f0e net: UDP tunnel encapsulation module for tunnelling diffe=
rent protocols like MPLS, IP, NSH etc.
> >> 00e77ed8e64d rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME
> >> 829eb208e80d rtnetlink: add support for protodown reason
> >>
> >> netlink.h:
> >> d07dcf9aadd6 netlink: add infrastructure to expose policies to userspa=
ce
> >> 44f3625bc616 netlink: export policy in extended ACK
> >> d409989b59ad netlink: simplify NLMSG_DATA with NLMSG_HDRLEN
> >> a85cbe6159ff uapi: move constants from <linux/kernel.h> to <linux/cons=
t.h>
> >>
> >> v2. Is a rebase and sync to the latest versions. A list of changes
> >>      computed via diff and blame was added to the commit message as su=
ggested
> >>      in:
> >> https://lore.kernel.org/lkml/20201015223119.1712121-1-irogers@google.c=
om/
> >>
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > With both patches applied to bpf-next, this would break our CI:
> >
> > [...]
> >    CC       bench.o
> >    CC       bench_count.o
> >    CC       bench_rename.o
> >    CC       bench_trigger.o
> >    CC       bench_ringbufs.o
> >    BINARY   bench
> >    BINARY   xdpxceiver
> > xdpxceiver.c: In function =E2=80=98testapp_invalid_desc=E2=80=99:
> > xdpxceiver.c:1223:41: warning: implicit declaration of function =E2=80=
=98ARRAY_SIZE=E2=80=99 [-Wimplicit-function-declaration]
> >   1223 |  pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
> >        |                                         ^~~~~~~~~~
> > /usr/bin/ld: /tmp/ccoQONpi.o: in function `testapp_invalid_desc':
> > /root/daniel/bpf/tools/testing/selftests/bpf/xdpxceiver.c:1223: undefin=
ed reference to `ARRAY_SIZE'
> > collect2: error: ld returned 1 exit status
> > make: *** [Makefile:166: /root/daniel/bpf/tools/testing/selftests/bpf/x=
dpxceiver] Error 1
> >
> > Please take a look and submit v3 of the series with the build issue fix=
ed.
>
> See also: https://github.com/kernel-patches/bpf/pull/1822/checks?check_ru=
n_id=3D3714445336


Thanks, this looks like an "include what you use" problem in
xdpxceiver.c and so I'll need to add a patch to fix that ahead of
these patches.

Ian

> Thanks,
> Daniel
