Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6590393513
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 19:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhE0Rpr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 13:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhE0Rpr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 13:45:47 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE362C061574
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 10:44:12 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id b13so1824886ybk.4
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGQxDcEjjg+Fn2jV2zJJJtwy2BNmbQqLO01I8hjhsLs=;
        b=pSuyJo6kOZC1h5ebYfG6bhkJFJFfzD6qYz+VHyGohV/EQoO8V9pwzHmPnYjqeGtgA2
         WkhAqHvNEAYb3LBbGCLbZWzgPFI9DWz8lFu498YPvpFllyif6TBlw+IVXNBFO9ss791k
         zCeg8KE5+sp39eDDa2KLW1shkkokM4k2vusXLFietf5K2VlOf5S3d6Htvdr+QgMpbfhk
         mCvRv1fN7XHx1AGuV5JgZP33mfSPryEqPofQUk9MQRFJmqzbRhuzkxV99WO1zFPevDVk
         iTIp+kaS4ddvZVFQRkx0dMoOau1p0U5SLQU1qJWs6ShDusXQcUbiHskiyUzNCkyUet5P
         ++Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGQxDcEjjg+Fn2jV2zJJJtwy2BNmbQqLO01I8hjhsLs=;
        b=TSXsL2ef4pzH0CiaUi/hwFm6u+C1LEBAI/aTUaaP+VO9C7y3McMgZOn29A9vZ1iaNI
         LCRCaRL4egGI8o6w2k/d8KYtcxFiPpSy2iE+sPJxhvHGL/e8gTiaCj+fDNu0mt9ioeUA
         i1dGz4EplRgpNuHNzUCcQnfjPdZU8UF9nP0YPc+7TkAAyNRvyQwfJaGoCH/p5btJL0aM
         nh7czcZz2veCB0WD8ayp8hrP1bASLa+V6YmwhyQ17oVEI7Z1rrxltJ3E5JJYx7ZFH3ZJ
         Nu/HXAA7U2BIeNUh97VTUXoOvGbp/dLNH7FD1sHAOy/e85RrZOQJlFzhNVJE35KsdtGp
         /khg==
X-Gm-Message-State: AOAM530iWRoEfMVQoSHfyDLggEvn0jn9znlTCt1HvlJ1ioCXui/MPqjk
        F7ORuOhTmnl28SofzD2h9NYV3Gwuqax6AcErHt0=
X-Google-Smtp-Source: ABdhPJwz7pAHBpniJO6Os8L3ts1VQq5YpxS6sGn8uPFsxm0u5Pm+vpE5mppuyYDLVm9lOHmYk7SQ0YDMdiq2zRJluOk=
X-Received: by 2002:a25:7246:: with SMTP id n67mr6579177ybc.510.1622137452030;
 Thu, 27 May 2021 10:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210526125848.1c7adbb0@carbon> <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
 <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch> <CAEf4Bza3m5dwZ_d0=zAWR+18f5RUjzv9=1NbhTKAO1uzWg_fzQ@mail.gmail.com>
 <60aeeb5252147_19a622085a@john-XPS-13-9370.notmuch>
In-Reply-To: <60aeeb5252147_19a622085a@john-XPS-13-9370.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 May 2021 10:44:00 -0700
Message-ID: <CAEf4Bzb1OZHpHYagbVs7s9tMSk4wrbxzGeBCCBHQ-qCOgdu6EQ@mail.gmail.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
To:     John Fastabend <john.fastabend@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 5:44 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> [...]
>
> > > Best to start with the simplest possible usable thing and get more
> > > complex over time.
> > >
> > > For a C definition I would expect drivers to do something like this,
> > >
> > >  struct mynic_rx_descriptor {
> > >         __u64 len;
> > >         __u64 head;
> > >         __u64 tail;
> > >         __u64 foobar;
> > >  }
> > >
> > >  struct mynic_metadata {
> > >         __u64 timestamp;
> > >         __u64 hash;
> > >         __u64 pkt_type;
> > >         struct mynic_rx_descriptor *ptr_to_rx;
> > >         /* other things */
> > >  }
> > >
> > > It doesn't really matter how the driver folks generate their metadata
> > > though. They might use some non-C thing that is more natural for
> > > writing parser/action/tcam codes.
> > >
> > > Anyways given some C block like above we generate BTF from above
> > > using normal method, quick hack just `pahole -J` the thing. Now we
> > > have a BTF file.
> > >
> > > Next up write some XDP program to do something with it,
> > >
> > >  void myxdp_prog(struct xdp_md *ctx) {
> > >         struct mynic_metadata m = (struct mynic_metadata *)ctx->data_meta;
> > >
> > >         // now I can get data using normal CO-RE
> > >         // I usually have this _(&) to put CO-RE attributes in I
> > >         // believe that is standard? Or use the other macros
> > >         __u64 pkt_type = _(&m->pkt_type)
> >
> > add __attribute__((preserve_access_index)) to the struct
> > mynic_metadata above (when compiling your BPF program) and you don't
> > need _() ugliness:
>
> +1. Although sometimes I like the ugliness so I can keep track
> of whats in CO-RE and not.

Oh, I'm just against using underscore as an identifier, I'd use
something a bit more explicit.

>
> >
> > __u64 pkt_type = m->pkt_type; /* it's CO-RE relocatable already */
> >
> > we have preserve_access_index as a code block (some selftests do this)
> > for cases when you can't annotate types
> >
> > >
> > >         // we can even walk into structs if we have probe read
> > >         // around.
> > >         struct mynic_rx_descriptor *rxdesc = _(&m->ptr_to_rx)
> > >
> > >         // now do whatever I like with above metadata
> > >  }
> > >
> > > Run above program through normal CO-RE pass and as long as it has
> > > access to the BTF from above it will work. I have some logic
> > > sitting around to stitch two BTF blocks together but we have
> > > that now done properly for linking.
> >
> > "stitching BTF blocks together" sort of jumped out of nowhere, what is
> > this needed for? And not sure what "BTF block" means exactly, it's a
> > new terminology.
>
> I didn't know what the correct terminology here would be.

I just wasn't sure if "BTF block" is a single BTF type or it's a
collection of types built on top of vmlinux BTF (what we call split
BTF). Seems like it's the latter.

>
> What I meant is I think what you have here,
>
> "
>  BTW, not that I encourage such abuse, but for the experiment's sake,
>  you can (ab)use module BTFs mechanism today to allow dynamically
>  adding/removing split BTFs built on top of kernel (vmlinux) BTF
> "
>
> So if vendor/driver writer has a BTF file for whatever the current
> hardware is doing we can use the split BTF build mechanism to
> include it. This can be used to get Jespers dynamic reprogram
> hardware example. We just need someway to get the BTF of the
> current running hardware. What I'm suggesting to get going we
> can just take that out of band, libbpf/kernel don't have
> to care where it comes from as long as libbpf can consume the
> split BTFs before doing CO-RE.
>
> With this model I can have a single XDP program and it will
> run on multiple hardware or the same hardware across updates
> when I can use the normal CO-RE macros to access the metadata.
> When I update my hardware I just need to get ahold of the
> BTF when I do that update and my programs will continue to
> work.
>
> Once we show the value of above we can talk about a driver
> mechanism to expose the BTF over some interface, maybe in
> /sys/fs. But that would still look like a split BTF from libbpf
> side. The advantage is it should work today.

Right, except I don't think we have libbpf APIs to specify this, but
that's solvable.

>
> I called the process of taking two BTF files, vmlinux BTF and
> user provided NIC metadata BTF, and using those for CO-RE
> logic "stitching BTF blocks together".
>
> >
> > >
> > > probe_read from XDP should be added regardless of above. I've
> > > found it super handy in skmsg programs to dig out kernel info
> > > inline. With probe_read we can also start to walk net_device
> > > struct for more detailed info as needed. Or into sock structs
> >
> > yes, libbpf provides BPF_CORE_READ() macro that allows to walk across
> > struct referenced by pointers, e.g.,:
> >
> > int my_data = BPF_CORE_READ(m, ptr_to_rx, rx_field);
> >
> > is logical equivalent of
> >
> > int my_data = m->ptr_to_rx->rx_field;
>
> The only complication here is ptr_to_rx is outside XDP data
> so we need XDP program to support probe_read(). So depending
> on current capabilities a BPF program might be limited to
> just its own data block or with higher caps able to use
> more of the features.
>

Right.

> >
> > > for process level conntrack (other thread). Even without
> > > probe_read above would be useful but fields would need to fit
> > > into the metadata where we know we can read/write data.
> > >
> > > Having drivers export their BTF over a /sys/fs/ interface
> > > so that BTF can change with fimware/parser updates is possible
> > > as well, but I would want to see above working in real world
> > > before committing to a /sys/fs interface. Anyways the
> > > interface is just a convienence.
> >
> > it's important enough to discuss because libbpf has to get it somehow
> > (or be directly provided as an extra option or something).
>
> I believe to start with directly providing it is the easiest
> approach. Then as a second step we can pull it from a /sys/fs
> interface.
>
> >
> > >
> > > >
> > > > As for BTF on a per-packet basis. This means that BTF itself is not
> > > > known at the BPF program verification time, so there will be some sort
> > > > of if/else if/else conditions to handle all recognized BTF IDs? Is
> > > > that right? Fake but specific code would help (at least me) to
> > > > actually join the discussion. Thanks.
> > >
> > > I don't think we actually want per-packet data that sounds a bit
> > > clumsy for me. Lets use a union and define it so that we have a
> > > single BTF.
> >
> > union and independent set of BTFs are two different things, I'll let
> > you guys figure out which one you need, but I replied how it could
> > look like in CO-RE world
>
> I think a union is sufficient and more aligned with how the
> hardware would actually work.

Sure. And I think those are two orthogonal concerns. You can start
with a single struct mynic_metadata with union inside it, and later
add the ability to swap mynic_metadata with another
mynic_metadata___v2 that will have a similar union but with a
different layout.

>
> >
> > >
> > >  struct mynic_metadata {
> > >   __u64 pkt_type
> > >   union {
> > >       struct ipv6_meta meta;
> > >       struct ipv4_meta meta;
> > >       struct arp_meta meta;
> >
> > obviously fields can't be named the same, so you'll have meta_ipv6,
>
> Sure just typing a quick example.
>
> > meta_ipv4, meta_arp fields, but I get the idea. This works if BTF
> > layout is set in stone. What Jesper proposes would allow to adds new
> > BTF layouts at runtime and still be able to handle that (as in detect
> > and ignore) with already running BPF programs.
>
> Same answer as above. As long as the BTF can be split into two
> files I don't think libbpf should care if its always the same
> NIC.btf + vmlinux.btf or diffent correct?
>
> >
> > CO-RE is sufficiently sophisticated to handle both today, so I don't care :)
>
> +1
>
> >
> > >   }
> > >  };
> > >
> > > Then program has to swivel on pkt_type but that is most natural
> > > C thing to do IMO.
> > >
> > > Honestly we have about 90% of the necessary bits to do this now.
> > > Typed that up a bit fast hope its legible. Got a lot going on today.
> > >
> > > Andrii, make sense?
> >
> > Yes, thanks! The logistics of getting that BTF to libbpf is the most
> > fuzzy area and not worked out completely. The low-level details of
> > relocations are already in place if libbpf can be pointed to the right
> > set of BTF types.
>
> Per above, getting that BTF to libbpf should be a user problem for
> a bit. Once how those programs look is worked out I think drivers
> can push them out via /sys/kernel/btf/mynic
>
> >
> > BTW, not that I encourage such abuse, but for the experiment's sake,
> > you can (ab)use module BTFs mechanism today to allow dynamically
> > adding/removing split BTFs built on top of kernel (vmlinux) BTF. I
> > suggest looking into how module BTFs are handled both inside the
> > kernel and in libbpf.
> >
>
> Exactly the abuse I was thinking ;)
