Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76866393CC1
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 07:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhE1Fuh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 01:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhE1Fug (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 01:50:36 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B857C061574
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 22:49:01 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id c2so2323129ilo.11
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 22:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=tnWjFM9dNoh2zTu8L6kW3nIoxYwplllU7iJeQNGb2+g=;
        b=ED53VvNo0P/dqM2Av7cp280TpKMgs73Mc2Y7pE25x1lEfnLjG1n3tJmzbMifBR8m6G
         YEJPu7KoRdjzdhUK96glJE7eGoJyyIkJ4OhFhIu9yqk2Yi0r8HXSnxHh9KgvniUmtetL
         FTSy5XoO1qPGSrgZVusLFG/cnAA8X3K/ri9uDCKpnvu+lGKgJxLBk7Kjcs8eOFvrbKj4
         8r9e4GG2n1/QOW7Ciytow/XCsQIxfjOA84yR9KLmc0iaXgzvFTJ4AlIrOxwLJ62riZh4
         3wYNTvf3q8ofMmk1mmg7/wlMrbhWz8qBsXtJi5qJDRVda7dgwEKYOTLh06lGUuzbnphs
         vStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=tnWjFM9dNoh2zTu8L6kW3nIoxYwplllU7iJeQNGb2+g=;
        b=uJlZ37Dx7gISzZacrWd0ayYYj9uPtA/Hj6ynxVvcC/UVNczCbCXs1IsavneVf4QJgD
         Yrpq6XJUgES2w/CMtB50Myh+N63elgpKCo1aNanmDdtfFNmMsFYNDURvquR08vEs4pkd
         SFgk2GR1X8BoJt7vgukoK0/n4cWyKtksK/B8SBvxtPySmSHm4idv/xBgPRdP+2BZnW+n
         W+GMAd4N+zBjwBOAnPpEodi1eOW+RFh30K6p0heSVIETL0q1D2JvgEMnjYnF3wWiMelC
         AXd0wHkXgpL4HTd9EHpYsBMR+teJZI7Gllxt/pgGYeEcmbRF9FLMySq6oLL4nWoVnf6a
         xziw==
X-Gm-Message-State: AOAM533yMLJpHRQxDzsN1EREnFcy8hZvi14oIDIQgBq2/iDl7Bw+26t9
        cWcnYHyA9ci0cikodK15lK4=
X-Google-Smtp-Source: ABdhPJzUt2f180WWBtLm8X5CpOB/kCCgcmDWSYuUs4VYisOYOCy1p4jSXCJ5/xUGcJV4QFLA/TS8VQ==
X-Received: by 2002:a05:6e02:16c6:: with SMTP id 6mr5958405ilx.279.1622180940344;
        Thu, 27 May 2021 22:49:00 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id l21sm2227391iol.22.2021.05.27.22.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 22:48:59 -0700 (PDT)
Date:   Thu, 27 May 2021 22:48:50 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        "Raczynski, Piotr" <piotr.raczynski@intel.com>,
        "Zhang, Jessica" <jessica.zhang@intel.com>,
        "Maloor, Kishen" <kishen.maloor@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "Plantykow, Marta A" <marta.a.plantykow@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        William Tu <u9012063@gmail.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Message-ID: <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4Bzb1OZHpHYagbVs7s9tMSk4wrbxzGeBCCBHQ-qCOgdu6EQ@mail.gmail.com>
References: <20210526125848.1c7adbb0@carbon>
 <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
 <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch>
 <CAEf4Bza3m5dwZ_d0=zAWR+18f5RUjzv9=1NbhTKAO1uzWg_fzQ@mail.gmail.com>
 <60aeeb5252147_19a622085a@john-XPS-13-9370.notmuch>
 <CAEf4Bzb1OZHpHYagbVs7s9tMSk4wrbxzGeBCCBHQ-qCOgdu6EQ@mail.gmail.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Wed, May 26, 2021 at 5:44 PM John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > [...]

[...]

> > > > Next up write some XDP program to do something with it,
> > > >
> > > >  void myxdp_prog(struct xdp_md *ctx) {
> > > >         struct mynic_metadata m = (struct mynic_metadata *)ctx->data_meta;
> > > >
> > > >         // now I can get data using normal CO-RE
> > > >         // I usually have this _(&) to put CO-RE attributes in I
> > > >         // believe that is standard? Or use the other macros
> > > >         __u64 pkt_type = _(&m->pkt_type)
> > >
> > > add __attribute__((preserve_access_index)) to the struct
> > > mynic_metadata above (when compiling your BPF program) and you don't
> > > need _() ugliness:
> >
> > +1. Although sometimes I like the ugliness so I can keep track
> > of whats in CO-RE and not.
> 
> Oh, I'm just against using underscore as an identifier, I'd use
> something a bit more explicit.

Sure.

> 
> >
> > >
> > > __u64 pkt_type = m->pkt_type; /* it's CO-RE relocatable already */
> > >
> > > we have preserve_access_index as a code block (some selftests do this)
> > > for cases when you can't annotate types
> > >
> > > >
> > > >         // we can even walk into structs if we have probe read
> > > >         // around.
> > > >         struct mynic_rx_descriptor *rxdesc = _(&m->ptr_to_rx)
> > > >
> > > >         // now do whatever I like with above metadata
> > > >  }
> > > >
> > > > Run above program through normal CO-RE pass and as long as it has
> > > > access to the BTF from above it will work. I have some logic
> > > > sitting around to stitch two BTF blocks together but we have
> > > > that now done properly for linking.
> > >
> > > "stitching BTF blocks together" sort of jumped out of nowhere, what is
> > > this needed for? And not sure what "BTF block" means exactly, it's a
> > > new terminology.
> >
> > I didn't know what the correct terminology here would be.
> 
> I just wasn't sure if "BTF block" is a single BTF type or it's a
> collection of types built on top of vmlinux BTF (what we call split
> BTF). Seems like it's the latter.

Yep, collection of types. Also we have all the BTF writers there so
its easy to create them from whatever backend is creating the
hardware configuration/ucode.

> 
> >
> > What I meant is I think what you have here,
> >
> > "
> >  BTW, not that I encourage such abuse, but for the experiment's sake,
> >  you can (ab)use module BTFs mechanism today to allow dynamically
> >  adding/removing split BTFs built on top of kernel (vmlinux) BTF
> > "
> >
> > So if vendor/driver writer has a BTF file for whatever the current
> > hardware is doing we can use the split BTF build mechanism to
> > include it. This can be used to get Jespers dynamic reprogram
> > hardware example. We just need someway to get the BTF of the
> > current running hardware. What I'm suggesting to get going we
> > can just take that out of band, libbpf/kernel don't have
> > to care where it comes from as long as libbpf can consume the
> > split BTFs before doing CO-RE.
> >
> > With this model I can have a single XDP program and it will
> > run on multiple hardware or the same hardware across updates
> > when I can use the normal CO-RE macros to access the metadata.
> > When I update my hardware I just need to get ahold of the
> > BTF when I do that update and my programs will continue to
> > work.
> >
> > Once we show the value of above we can talk about a driver
> > mechanism to expose the BTF over some interface, maybe in
> > /sys/fs. But that would still look like a split BTF from libbpf
> > side. The advantage is it should work today.
> 
> Right, except I don't think we have libbpf APIs to specify this, but
> that's solvable.

Sure, I believe I just pulled some internals out to get it
working. It shouldn't be too difficult to do it correctly.

> 
> >
> > I called the process of taking two BTF files, vmlinux BTF and
> > user provided NIC metadata BTF, and using those for CO-RE
> > logic "stitching BTF blocks together".
> >
> > >
> > > >
> > > > probe_read from XDP should be added regardless of above. I've
> > > > found it super handy in skmsg programs to dig out kernel info
> > > > inline. With probe_read we can also start to walk net_device
> > > > struct for more detailed info as needed. Or into sock structs
> > >
> > > yes, libbpf provides BPF_CORE_READ() macro that allows to walk across
> > > struct referenced by pointers, e.g.,:
> > >
> > > int my_data = BPF_CORE_READ(m, ptr_to_rx, rx_field);
> > >
> > > is logical equivalent of
> > >
> > > int my_data = m->ptr_to_rx->rx_field;
> >
> > The only complication here is ptr_to_rx is outside XDP data
> > so we need XDP program to support probe_read(). So depending
> > on current capabilities a BPF program might be limited to
> > just its own data block or with higher caps able to use
> > more of the features.
> >
> 
> Right.

Likely start with just metadata and worry about probe later. Anyways
I think it would be useful to have probe to read netdev, sock and
task structs that has nothing to do with this thread.

[...]

> > > union and independent set of BTFs are two different things, I'll let
> > > you guys figure out which one you need, but I replied how it could
> > > look like in CO-RE world
> >
> > I think a union is sufficient and more aligned with how the
> > hardware would actually work.
> 
> Sure. And I think those are two orthogonal concerns. You can start
> with a single struct mynic_metadata with union inside it, and later
> add the ability to swap mynic_metadata with another
> mynic_metadata___v2 that will have a similar union but with a
> different layout.

Right and then you just have normal upgrade/downgrade problems with
any struct.

Seems like a workable path to me. But, need to circle back to the
what we want to do with it part that Jesper replied to.

.John
