Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE44B86F5E
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2019 03:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbfHIBba (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Aug 2019 21:31:30 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:34401 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405132AbfHIBba (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Aug 2019 21:31:30 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4AAFB3D0;
        Thu,  8 Aug 2019 21:31:29 -0400 (EDT)
Received: from imap35 ([10.202.2.85])
  by compute4.internal (MEProxy); Thu, 08 Aug 2019 21:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=5sDIpz+Q1W/rlz24lgJ6xaeLRAf8Zos
        vcBxO48IT5ms=; b=p3QsYROU1TIrO4Xx2AJdaA1AVO9n8QFLR6DNVQS/qEfw+xO
        eMYfG6OS/JWar84hLR9aJpClWbmlupW7MBvsGsfizIgsxifCSgzqDCQp62gr21IC
        T5QptCSm1NUaTFwzSbjLjslGeiTcBJJVMMtKXTA7Xxa0lbmCXNXaX60wmZ41+vWG
        U2nrxQ00vdqktnTVlKxLbnc54vHX+6SdolDACNeIp7QEAc+gsvWCgd7N/JZ1nITs
        t9kSt5nSK7a6xIXbc0Res8elFC16fLrbUDiqYt5KLhpBeTWn8BGG7D+tUkVP47J4
        LXq94cEil2VuD2QcpTnuipROR6iKbGBizXq7AzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5sDIpz
        +Q1W/rlz24lgJ6xaeLRAf8ZosvcBxO48IT5ms=; b=EVoyCFILEoAcZcErT6PYGK
        IUBIphHcgb+jl/hRyqyZz5o7F8C/rF0jtL0P0mZH53YSyq3+2dHgWqnlk6ANBZPY
        Wa4jPa9C52Oo/pgpbM6o39uPj1GZ9ug+rf3To5Vhsile59JiFLKQnOj/e4prAgps
        vHcaIyvSa+7jYhgIRb2tVeMlLxRx2H2YnwrYN5PsZ6SocEOhq7lLZSaIVVX3zJTh
        nRaF08hzXiZ2ZSvl9/wnZq6ItIeFpgfRADU9f4Au7E7aaN6YmRbzMVZxgzv1vEJB
        h91gjORVq06C2XPkA00LMt2PCZ+Z3Y1cl2I0HcTZhcyYGyTYJDhmkbaAhXo7Ua2g
        ==
X-ME-Sender: <xms:8MxMXfJlOt-hQ21fQLBTYbl_qXOmjwdL_8M_FovJKn9-7TnlCblUqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduiedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
    redtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihii
    eqnecuffhomhgrihhnpehvvddrthhoohhlshenucfrrghrrghmpehmrghilhhfrhhomhep
    ugiguhesugiguhhuuhdrgiihiienucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:8MxMXeodXI_6Np0R5Xwrpff9V7wXrjMl8rnOaZfd3zYSde5fnOhZbg>
    <xmx:8MxMXes7pZynCpH79rENspa4B3YKxxHP-Zt5I5IOgxqpNySB0AAbJQ>
    <xmx:8MxMXRWrqKV635-yY4zsivNyswkKhtPDyGMfZ873oS_38LRsSkSZTg>
    <xmx:8MxMXSVfRV4sbTgXmJ-8W3X-mYfopJ7bq5-jin9-ydSKu4fbXZEUlw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6B28E14C0062; Thu,  8 Aug 2019 21:31:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-808-g930a1a1-fmstable-20190805v2
Mime-Version: 1.0
Message-Id: <e8b7930a-ce08-4c05-a407-b7a92a89ded9@www.fastmail.com>
In-Reply-To: <CAEf4BzaQZrEuqqGhFrf1cDiWiUXYDy6x8zAMXayry6H2ow78Og@mail.gmail.com>
References: <20190806234201.6296-1-dxu@dxuuu.xyz>
 <CAEf4BzaQZrEuqqGhFrf1cDiWiUXYDy6x8zAMXayry6H2ow78Og@mail.gmail.com>
Date:   Thu, 08 Aug 2019 18:31:27 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc:     "Song Liu" <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Kernel Team" <kernel-team@fb.com>
Subject: Re: [PATCH 2/3] libbpf: Add helper to extract perf fd from bpf_link
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 7, 2019, at 11:57 AM, Andrii Nakryiko wrote:
> On Tue, Aug 6, 2019 at 4:42 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > It is sometimes necessary to perform ioctl's on the underlying perf fd.
> > There is not currently a way to extract the fd given a bpf_link, so add a
> > helper for it.
> > ---
> 
> So I've been going back and forth with this approach and the
> alternative one, and I think I'm leaning towards the alternative one
> still.
> 
> I think it's better to have a broad "categories" of bpf_links, e.g.:
> 
> - FD-based bpf_link (which is the only one we have right now):
> bpf_link_fd. It's not just for perf FD-based ones, raw tracepoint is
> not, but it's still FD-based;
> - for cgroup-related links (once they are added), it will be
> bpf_link_cg (or something along the lines);
> - there probably should be separate XDP-related bpf_link with device
> ID/name inside;
> - etc, whatever we'll need.
> 
> Then we can have a set of casting APIs and getter APIs that extract
> useful information from specific type of bpf_link. We can also add
> direct bpf_link creation API (e.g., from known FD), for cases where it
> makes sense.
> 
> So something like (in libbpf.h):
> 
> struct bpf_link_fd;
> struct bpf_link_cg;
> 
> /* casting APIs */
> const struct bpf_link_fd *bpf_link__as_fd(const struct bpf_link *link);
> const struct bpf_link_cg *bpf_link__as_cg(const struct bpf_link *link);
> 
> /* getters APIs */
> int bpf_link_fd__fd(const struct bpf_link_fd *link);
> int bpf_link_cg__cgroup_fd(const struct bpf_link_cg *link);
> 
> /* link factories (in addition to attach APIs) */
> const struct bpf_link_fd *bpf_link__from_fd(int fd);
> const struct bpf_link_cg *bpf_link__from_cg(int cg_fd, /* whatever
> else necessary */);
> 
> I think this way it becomes obvious what you can expect to get of each
> possible type of bpf_link and you'll have to explicitly cast to the
> right type. Yet we still hide implementation details, allow no-brainer
> bpf_link__destroy regardless of specific type of link (which probably
> will be a common case).
> 
> Thoughts?

Makes sense to me. This would probably result in a more predictable API when
new types are added. I'll make it this way in V2.

> 
> >  tools/lib/bpf/libbpf.c   | 13 +++++++++++++
> >  tools/lib/bpf/libbpf.h   |  1 +
> >  tools/lib/bpf/libbpf.map |  5 +++++
> >  3 files changed, 19 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index ead915aec349..8469d69448ae 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -4004,6 +4004,19 @@ static int bpf_link__destroy_perf_event(struct bpf_link *link)
> >         return err;
> >  }
> >
> > +int bpf_link__get_perf_fd(struct bpf_link *link)
> 
> this seems like a bit too specific name (and we should avoid "get"
> words, as we do in a bunch of other libbpf APIs for getters). Maybe
> just `bpf_link__fd`? This especially makes sense with a "file-based
> bpf_link" abstraction I proposed above.

Ok.
