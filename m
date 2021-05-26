Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6623922F6
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 00:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbhEZW4p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 18:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhEZW4o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 18:56:44 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C70C061574
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 15:55:11 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y197so4343623ybe.11
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 15:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j0GcHbnoMjbR9NNKgH/PZ+e6de+jErnyHv4HEzaAoD0=;
        b=sB/4MaumyVfJbVQdFBlooPqEbA5zrgTIpyKSqECi6HN0pJp5VK2wSHkr3+5eXGpJXm
         qSpwI6XOcLs9yAW75oN5kCh1TrMkgJqdaYkP+aFlimmfyn0zDfMeJPJ8X6lNRvzD6Y/j
         QW0NewKnKvcPyp93lLOHeBIwb7p7j5uFQfC174UNedcFBhwNLLzpdUVNjwxGz9avaWXl
         x4uQkSQF4We4jFVlfdIYxFtVEY9g6UStj/iI74bYL31UIPNtFtBf5lRXBEudqiaQWJHb
         ghKNL+PpveEU4CWtsha/u6MqNEblwsanZ4Ep/rYU7kJRzD+63znTEtfTsJP0c4pWkszk
         m/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j0GcHbnoMjbR9NNKgH/PZ+e6de+jErnyHv4HEzaAoD0=;
        b=lWcN40zNffYp7Cv+WmPbJGel1lwVBXQbyNlwtb6o7dVe2z9LNbW+9XVKpzjIxqEZX0
         J4N7aNtEoZcQGjxB0V4l85ZZc9Fnajt8QtJsPpVBgEn96od7yV1jLsZOdnH3EcUb3ant
         uayuq80osPRQhHpAxQedWNVQLTB2sZ2CPOi4UhVAkfHCjKFPAjEpOpTNxRkGF/AAa0XC
         KcUgibmB6KkiztR1OlR9KOpbyQ+ed0cjR0gHfM9dJtmCzMZ8nyZzUQFWmlGgp351IlX6
         QAYxLMrZ1FfrxhTIKtNMJxxD8qxs01x23xGclPcSOfh9Bs3kvDOu5ilT40U2eBdJ0Eaz
         j5+g==
X-Gm-Message-State: AOAM531/Wb2Q8If7bW6ZxCqQnoG8XZwTxjTPyyiVmsj260IGHAo59KM0
        ECqwsSgTMfAd2u42UHXx4jdbCYR8XAuaLUhRAbA=
X-Google-Smtp-Source: ABdhPJyCg8HGdWB5IIGkFNr4bJP4/QSTDgX1yE11Mj3DgAiXXG1b+iIyaJQacvuisp4m2/MLAYgq9Eov4texaXGmaSo=
X-Received: by 2002:a5b:f05:: with SMTP id x5mr466768ybr.425.1622069710506;
 Wed, 26 May 2021 15:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210526125848.1c7adbb0@carbon> <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
 <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch>
In-Reply-To: <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 May 2021 15:54:59 -0700
Message-ID: <CAEf4Bza3m5dwZ_d0=zAWR+18f5RUjzv9=1NbhTKAO1uzWg_fzQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 1:31 PM John Fastabend <john.fastabend@gmail.com> w=
rote:
>
> Andrii Nakryiko wrote:
> > On Wed, May 26, 2021 at 3:59 AM Jesper Dangaard Brouer
> > <brouer@redhat.com> wrote:
> > >
> > > Hi All,
> > >
> > > I see a need for a driver to use different XDP metadata layout on a p=
er
> > > packet basis. E.g. PTP packets contains a hardware timestamp. E.g. VL=
AN
> > > offloading and associated metadata as only relevant for packets using
> > > VLANs. (Reserving room for every possible HW-hint is against the idea
> > > of BTF).
> > >
> > > The question is how to support multiple BTF types on per packet basis=
?
> > > (I need input from BTF experts, to tell me if I'm going in the wrong
> > > direction with below ideas).
> >
> > I'm trying to follow all three threads, but still, can someone dumb it
>
> Thanks ;)
>
> > down for me and use few very specific examples to show how all this is
> > supposed to work end-to-end. I.e., how the C definition for those
> > custom BTF layouts might look like and how they are used in BPF
> > programs, etc. I'm struggling to put all the pieces together, even
> > ignoring all the netdev-specific configuration questions.
>
> Best to start with the simplest possible usable thing and get more
> complex over time.
>
> For a C definition I would expect drivers to do something like this,
>
>  struct mynic_rx_descriptor {
>         __u64 len;
>         __u64 head;
>         __u64 tail;
>         __u64 foobar;
>  }
>
>  struct mynic_metadata {
>         __u64 timestamp;
>         __u64 hash;
>         __u64 pkt_type;
>         struct mynic_rx_descriptor *ptr_to_rx;
>         /* other things */
>  }
>
> It doesn't really matter how the driver folks generate their metadata
> though. They might use some non-C thing that is more natural for
> writing parser/action/tcam codes.
>
> Anyways given some C block like above we generate BTF from above
> using normal method, quick hack just `pahole -J` the thing. Now we
> have a BTF file.
>
> Next up write some XDP program to do something with it,
>
>  void myxdp_prog(struct xdp_md *ctx) {
>         struct mynic_metadata m =3D (struct mynic_metadata *)ctx->data_me=
ta;
>
>         // now I can get data using normal CO-RE
>         // I usually have this _(&) to put CO-RE attributes in I
>         // believe that is standard? Or use the other macros
>         __u64 pkt_type =3D _(&m->pkt_type)

add __attribute__((preserve_access_index)) to the struct
mynic_metadata above (when compiling your BPF program) and you don't
need _() ugliness:

__u64 pkt_type =3D m->pkt_type; /* it's CO-RE relocatable already */

we have preserve_access_index as a code block (some selftests do this)
for cases when you can't annotate types

>
>         // we can even walk into structs if we have probe read
>         // around.
>         struct mynic_rx_descriptor *rxdesc =3D _(&m->ptr_to_rx)
>
>         // now do whatever I like with above metadata
>  }
>
> Run above program through normal CO-RE pass and as long as it has
> access to the BTF from above it will work. I have some logic
> sitting around to stitch two BTF blocks together but we have
> that now done properly for linking.

"stitching BTF blocks together" sort of jumped out of nowhere, what is
this needed for? And not sure what "BTF block" means exactly, it's a
new terminology.

>
> probe_read from XDP should be added regardless of above. I've
> found it super handy in skmsg programs to dig out kernel info
> inline. With probe_read we can also start to walk net_device
> struct for more detailed info as needed. Or into sock structs

yes, libbpf provides BPF_CORE_READ() macro that allows to walk across
struct referenced by pointers, e.g.,:

int my_data =3D BPF_CORE_READ(m, ptr_to_rx, rx_field);

is logical equivalent of

int my_data =3D m->ptr_to_rx->rx_field;

> for process level conntrack (other thread). Even without
> probe_read above would be useful but fields would need to fit
> into the metadata where we know we can read/write data.
>
> Having drivers export their BTF over a /sys/fs/ interface
> so that BTF can change with fimware/parser updates is possible
> as well, but I would want to see above working in real world
> before committing to a /sys/fs interface. Anyways the
> interface is just a convienence.

it's important enough to discuss because libbpf has to get it somehow
(or be directly provided as an extra option or something).

>
> >
> > As for BTF on a per-packet basis. This means that BTF itself is not
> > known at the BPF program verification time, so there will be some sort
> > of if/else if/else conditions to handle all recognized BTF IDs? Is
> > that right? Fake but specific code would help (at least me) to
> > actually join the discussion. Thanks.
>
> I don't think we actually want per-packet data that sounds a bit
> clumsy for me. Lets use a union and define it so that we have a
> single BTF.

union and independent set of BTFs are two different things, I'll let
you guys figure out which one you need, but I replied how it could
look like in CO-RE world

>
>  struct mynic_metadata {
>   __u64 pkt_type
>   union {
>       struct ipv6_meta meta;
>       struct ipv4_meta meta;
>       struct arp_meta meta;

obviously fields can't be named the same, so you'll have meta_ipv6,
meta_ipv4, meta_arp fields, but I get the idea. This works if BTF
layout is set in stone. What Jesper proposes would allow to adds new
BTF layouts at runtime and still be able to handle that (as in detect
and ignore) with already running BPF programs.

CO-RE is sufficiently sophisticated to handle both today, so I don't care :=
)

>   }
>  };
>
> Then program has to swivel on pkt_type but that is most natural
> C thing to do IMO.
>
> Honestly we have about 90% of the necessary bits to do this now.
> Typed that up a bit fast hope its legible. Got a lot going on today.
>
> Andrii, make sense?

Yes, thanks! The logistics of getting that BTF to libbpf is the most
fuzzy area and not worked out completely. The low-level details of
relocations are already in place if libbpf can be pointed to the right
set of BTF types.

BTW, not that I encourage such abuse, but for the experiment's sake,
you can (ab)use module BTFs mechanism today to allow dynamically
adding/removing split BTFs built on top of kernel (vmlinux) BTF. I
suggest looking into how module BTFs are handled both inside the
kernel and in libbpf.

>
> Thanks,
> John
> >
> > >
> > > Let me describe a possible/proposed packet flow (feel free to disagre=
e):
> > >
> > >  When driver RX e.g. a PTP packet it knows HW is configured for PTP-T=
S and
> > >  when it sees a TS is available, then it chooses a code path that use=
 the
> > >  BTF layout that contains RX-TS. To communicate what BTF-type the
> > >  XDP-metadata contains, it simply store the BTF-ID in xdp_buff->btf_i=
d.
> > >
> > >  When redirecting the xdp_buff is converted to xdp_frame, and also co=
ntains
> > >  the btf_id member. When converting xdp_frame to SKB, then netcore-co=
de
> > >  checks if this BTF-ID have been registered, if so there is a (callba=
ck or
> > >  BPF-hook) registered to handle this BTF-type that transfer the field=
s from
> > >  XDP-metadata area into SKB fields.
> > >
> > >  The XDP-prog also have access to this ctx->btf_id and can multiplex =
on
> > >  this in the BPF-code itself. Or use other methods like parsing PTP p=
acket
> > >  and extract TS as expected BTF offset in XDP metadata (perhaps add a
> > >  sanity check if metadata-size match).
> > >
> > >
> > > I talked to AF_XDP people (Magnus, Bj=C3=B8rn and William) about this=
 idea,
> > > and they pointed out that AF_XDP also need to know what BTF-layout is
> > > used. As Magnus wrote in other thread; there is only 32-bit left in
> > > AF_XDP descriptor option. We could store the BTF-ID in this field, bu=
t
> > > it would block for other use-cases. Bj=C3=B8rn came up with the idea =
of
> > > storing the BTF-ID in the BTF-layout itself, but as the last-member (=
to
> > > have fixed offset to check in userspace AF_XDP program). Then we only
> > > need to use a single bit in AF_XDP descriptor option to say
> > > XDP-metadata is BTF described.
> > >
> > > In the AF_XDP userspace program, the programmers can have a similar
> > > callback system per known BTF-ID. This way they can compile efficient
> > > code per ID via requesting the BTF layout from the kernel. (Hint:
> > > `bpftool btf dump id 42 format c`).
> > >
> > > Please let me know if this it the right or wrong direction?
> > >
> > > --
> > > Best regards,
> > >   Jesper Dangaard Brouer
> > >   MSc.CS, Principal Kernel Engineer at Red Hat
> > >   LinkedIn: http://www.linkedin.com/in/brouer
> > >
>
>
