Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4256B392182
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 22:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhEZUdK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 16:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbhEZUdI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 16:33:08 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63DEC06175F
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 13:31:34 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d25so2456429ioe.1
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Lodm93eQs22zJEFoDSwR2A3QCB8FPTQcJV64GGKPtZM=;
        b=g8F25fDPtywtm7p4BcTiPH/9gGKFi0kxaYMTB/YYNTXUK0EZeQ7ZBCwKJ4rsueULz2
         IFV4oKzLQe7eVGn5JyWWE3YxLWIJZ3Q2sjiucKWSS3mAyemUR5u8buVMyWwfHqJ24QkK
         XOL9hUXEx3vBvV7Liwtgw13wn/53ZWp7W52IqsR6Q4HIEngyN7aMC6PZ5FGZhK4Tz2Br
         NS/HYeI7taFlP7Wnr0jS1rUbEvsk3blaJOT0FcnwlZqaNiyyOlL6ZdhMukqHEJmmXA09
         qppoAGgQwREGJwOqj07T1n79LNyvaROeNoxr9Bp5LndzZUIxuxs9o3dJ1FbO0AaWi0YV
         ukXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Lodm93eQs22zJEFoDSwR2A3QCB8FPTQcJV64GGKPtZM=;
        b=rFI6njIWXM/5MiIWPS1UBjizbxQCQWVy7XCbkOYMakitYtTP4dHHb4Tfj/u3RNHSps
         gT3O9DXyJIw4rWz2pTcVPK4KEj0heKDmZJ03ZfkDHTzpHgG/PZZnwHJHK3RVczQHBRc3
         jm3lPp1/tOTqZ66Mhjhr7UtSD/Lz+hC4QBqvew4LCn67S1uJxsTpw4d8Vevr0bBt1jVq
         k3+D9Fygoj9D2eLUhDrZy4vlxaCUY8D6SArPpVQqXlDgnIHcccfHFAPhvXUGFtK26AV9
         Q9t9ewCTdG/fJcwSHgpLjwt6+15SaDfdhVb82oS/YVASke+AQTgtDO3sHkLr3SAavL4o
         Us9A==
X-Gm-Message-State: AOAM533/W04jHZNJlaxlNlGmgrk0sn246PqUMhaGFvRb2GXugtFTqxOW
        +FtTllmjSTSj7gcGKDcqdSY=
X-Google-Smtp-Source: ABdhPJwGmyw3JMLJGdRbj+2piBabjTSblBGOiO7cU1Wy2DrxlVb9+sUl1kA+343cbbZW3LCfxXDWnQ==
X-Received: by 2002:a6b:d80b:: with SMTP id y11mr66013iob.202.1622061093996;
        Wed, 26 May 2021 13:31:33 -0700 (PDT)
Received: from localhost ([172.242.244.146])
        by smtp.gmail.com with ESMTPSA id a11sm195179ilp.75.2021.05.26.13.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 13:31:33 -0700 (PDT)
Date:   Wed, 26 May 2021 13:31:26 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     BPF-dev-list <bpf@vger.kernel.org>,
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
        John Fastabend <john.fastabend@gmail.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        William Tu <u9012063@gmail.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Message-ID: <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
References: <20210526125848.1c7adbb0@carbon>
 <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Wed, May 26, 2021 at 3:59 AM Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
> >
> > Hi All,
> >
> > I see a need for a driver to use different XDP metadata layout on a p=
er
> > packet basis. E.g. PTP packets contains a hardware timestamp. E.g. VL=
AN
> > offloading and associated metadata as only relevant for packets using=

> > VLANs. (Reserving room for every possible HW-hint is against the idea=

> > of BTF).
> >
> > The question is how to support multiple BTF types on per packet basis=
?
> > (I need input from BTF experts, to tell me if I'm going in the wrong
> > direction with below ideas).
> =

> I'm trying to follow all three threads, but still, can someone dumb it

Thanks ;)

> down for me and use few very specific examples to show how all this is
> supposed to work end-to-end. I.e., how the C definition for those
> custom BTF layouts might look like and how they are used in BPF
> programs, etc. I'm struggling to put all the pieces together, even
> ignoring all the netdev-specific configuration questions.

Best to start with the simplest possible usable thing and get more
complex over time.

For a C definition I would expect drivers to do something like this,

 struct mynic_rx_descriptor {
	__u64 len;
        __u64 head;
	__u64 tail;
	__u64 foobar;
 }

 struct mynic_metadata {
	__u64 timestamp;
	__u64 hash;
	__u64 pkt_type;
	struct mynic_rx_descriptor *ptr_to_rx;
	/* other things */
 }

It doesn't really matter how the driver folks generate their metadata
though. They might use some non-C thing that is more natural for
writing parser/action/tcam codes.

Anyways given some C block like above we generate BTF from above
using normal method, quick hack just `pahole -J` the thing. Now we
have a BTF file.

Next up write some XDP program to do something with it,

 void myxdp_prog(struct xdp_md *ctx) {
	struct mynic_metadata m =3D (struct mynic_metadata *)ctx->data_meta;	=


	// now I can get data using normal CO-RE
	// I usually have this _(&) to put CO-RE attributes in I
        // believe that is standard? Or use the other macros
	__u64 pkt_type =3D _(&m->pkt_type)

        // we can even walk into structs if we have probe read
        // around.
        struct mynic_rx_descriptor *rxdesc =3D _(&m->ptr_to_rx)

        // now do whatever I like with above metadata
 }

Run above program through normal CO-RE pass and as long as it has
access to the BTF from above it will work. I have some logic
sitting around to stitch two BTF blocks together but we have
that now done properly for linking.

probe_read from XDP should be added regardless of above. I've
found it super handy in skmsg programs to dig out kernel info
inline. With probe_read we can also start to walk net_device
struct for more detailed info as needed. Or into sock structs
for process level conntrack (other thread). Even without
probe_read above would be useful but fields would need to fit
into the metadata where we know we can read/write data.

Having drivers export their BTF over a /sys/fs/ interface
so that BTF can change with fimware/parser updates is possible
as well, but I would want to see above working in real world
before committing to a /sys/fs interface. Anyways the
interface is just a convienence.

> =

> As for BTF on a per-packet basis. This means that BTF itself is not
> known at the BPF program verification time, so there will be some sort
> of if/else if/else conditions to handle all recognized BTF IDs? Is
> that right? Fake but specific code would help (at least me) to
> actually join the discussion. Thanks.

I don't think we actually want per-packet data that sounds a bit
clumsy for me. Lets use a union and define it so that we have a
single BTF.

 struct mynic_metadata {
  __u64 pkt_type
  union {
      struct ipv6_meta meta; =

      struct ipv4_meta meta;
      struct arp_meta meta;
  }
 };

Then program has to swivel on pkt_type but that is most natural
C thing to do IMO.

Honestly we have about 90% of the necessary bits to do this now.
Typed that up a bit fast hope its legible. Got a lot going on today.

Andrii, make sense?

Thanks,
John
> =

> >
> > Let me describe a possible/proposed packet flow (feel free to disagre=
e):
> >
> >  When driver RX e.g. a PTP packet it knows HW is configured for PTP-T=
S and
> >  when it sees a TS is available, then it chooses a code path that use=
 the
> >  BTF layout that contains RX-TS. To communicate what BTF-type the
> >  XDP-metadata contains, it simply store the BTF-ID in xdp_buff->btf_i=
d.
> >
> >  When redirecting the xdp_buff is converted to xdp_frame, and also co=
ntains
> >  the btf_id member. When converting xdp_frame to SKB, then netcore-co=
de
> >  checks if this BTF-ID have been registered, if so there is a (callba=
ck or
> >  BPF-hook) registered to handle this BTF-type that transfer the field=
s from
> >  XDP-metadata area into SKB fields.
> >
> >  The XDP-prog also have access to this ctx->btf_id and can multiplex =
on
> >  this in the BPF-code itself. Or use other methods like parsing PTP p=
acket
> >  and extract TS as expected BTF offset in XDP metadata (perhaps add a=

> >  sanity check if metadata-size match).
> >
> >
> > I talked to AF_XDP people (Magnus, Bj=C3=B8rn and William) about this=
 idea,
> > and they pointed out that AF_XDP also need to know what BTF-layout is=

> > used. As Magnus wrote in other thread; there is only 32-bit left in
> > AF_XDP descriptor option. We could store the BTF-ID in this field, bu=
t
> > it would block for other use-cases. Bj=C3=B8rn came up with the idea =
of
> > storing the BTF-ID in the BTF-layout itself, but as the last-member (=
to
> > have fixed offset to check in userspace AF_XDP program). Then we only=

> > need to use a single bit in AF_XDP descriptor option to say
> > XDP-metadata is BTF described.
> >
> > In the AF_XDP userspace program, the programmers can have a similar
> > callback system per known BTF-ID. This way they can compile efficient=

> > code per ID via requesting the BTF layout from the kernel. (Hint:
> > `bpftool btf dump id 42 format c`).
> >
> > Please let me know if this it the right or wrong direction?
> >
> > --
> > Best regards,
> >   Jesper Dangaard Brouer
> >   MSc.CS, Principal Kernel Engineer at Red Hat
> >   LinkedIn: http://www.linkedin.com/in/brouer
> >


