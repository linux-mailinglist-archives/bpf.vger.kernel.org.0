Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1C3394F0F
	for <lists+bpf@lfdr.de>; Sun, 30 May 2021 05:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhE3D0s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 May 2021 23:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhE3D0r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 May 2021 23:26:47 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95483C061574
        for <bpf@vger.kernel.org>; Sat, 29 May 2021 20:25:08 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y2so11420632ybq.13
        for <bpf@vger.kernel.org>; Sat, 29 May 2021 20:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6KEfHIS/523MOtnGuGKDiEfJ2Pjnarvoi6fAiA5JinI=;
        b=blvKm7VUSAHySCJAOemXlB4qBO/dstjwO4JbGQbzxIQqQ5BHNv86EHvQn9kojNeCXd
         k/TcQv+ld9jNhENn+KGcIsmnhBJzVapFcPrxT10H8LMDoKySZXFM8ZA0k4xBL1QiOMzr
         E/wF4EVsyuz4l5WRClI/nKaNpQYAJQ7QiWIlfN23quSWjf3DQeMfru/q511qPlwPflko
         OYVv14FLaxf/5gx+eGciXwL5vsGWfusuL/iuKMM3wYSlmHxgpLcRy6hkswq2FzPf1jkU
         lq7jMi++1tOwYJOCE0TUyGwh32dxDQ6sut6o/cbb8oOSRS4geWPyyaGYk01vqqjxol7y
         Sz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6KEfHIS/523MOtnGuGKDiEfJ2Pjnarvoi6fAiA5JinI=;
        b=g2Dg3RwmO+7EAuijp9bJukhQ8vkVQOjV+ClRIAzHHAgDurTns6KQUPMGmL62xnSKxV
         tOCP1LtBMlRtCQZH61HUu8LZHEhoDvkZ38O6ipX+Y0bIMgcStI9FyvELJoNttGL6ECPR
         i5UEEEJ5QhreTBnAeFdZUMfPlNCfTzPMLkihmRRS+L07ea6pfZ9dIjtJvH2gshtk/Dpq
         SWShUCHvxjWoNaZ1+c+mm0KufvsyMOpykxQVhWHt1G3kuLfsg5GoKevZv7hxxJRyT1IP
         BLr4Ahw+ihgrOgYHrUa4R8XeHknBo8AKT5V+McOH7UAFyBeaS5BJ77c+ur0C0LnOpYdj
         0Cyw==
X-Gm-Message-State: AOAM531NYSEpJ3kMpo2kBbd5nSuUXrx815F2GQK7SfgBN71jEIWGRatm
        hTJEuaPUAlxt8NdVKfxadMIsJMlBmksXGpia5o2Ul8S5
X-Google-Smtp-Source: ABdhPJx97Tlh5RBQWMCH/hMNR2ehyveuuLvpPxNy3A9Pv26la3WEaGTYVjIVgikz0lklHP5pzY4vNNWCpIEvl5VR2Yw=
X-Received: by 2002:a25:3357:: with SMTP id z84mr22432930ybz.260.1622345107662;
 Sat, 29 May 2021 20:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210526125848.1c7adbb0@carbon> <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
 <20210526222023.44f9b3c6@carbon> <CAEf4BzZ+VSemxx7WFanw7DfLGN7w42G6ZC4dvOSB1zAsUgRQaw@mail.gmail.com>
 <20210528131607.22f51b43@carbon>
In-Reply-To: <20210528131607.22f51b43@carbon>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 29 May 2021 20:24:56 -0700
Message-ID: <CAEf4BzYAoVxKSCK9vUo+OS5j0rLH9sJOT98bCfu_aHHSPt9m4w@mail.gmail.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     BPF-dev-list <bpf@vger.kernel.org>, xdp-hints@xdp-project.net,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        William Tu <u9012063@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 28, 2021 at 4:16 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> On Wed, 26 May 2021 15:39:17 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Wed, May 26, 2021 at 1:20 PM Jesper Dangaard Brouer
> > <brouer@redhat.com> wrote:
> > >
> > > On Wed, 26 May 2021 12:12:09 -0700
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > On Wed, May 26, 2021 at 3:59 AM Jesper Dangaard Brouer
> > > > <brouer@redhat.com> wrote:
> > > > >
> > > > > Hi All,
> > > > >
> > > > > I see a need for a driver to use different XDP metadata layout on=
 a per
> > > > > packet basis. E.g. PTP packets contains a hardware timestamp. E.g=
. VLAN
> > > > > offloading and associated metadata as only relevant for packets u=
sing
> > > > > VLANs. (Reserving room for every possible HW-hint is against the =
idea
> > > > > of BTF).
> > > > >
> > > > > The question is how to support multiple BTF types on per packet b=
asis?
> > > > > (I need input from BTF experts, to tell me if I'm going in the wr=
ong
> > > > > direction with below ideas).
> > > >
> > > > I'm trying to follow all three threads, but still, can someone dumb=
 it
> > > > down for me and use few very specific examples to show how all this=
 is
> > > > supposed to work end-to-end. I.e., how the C definition for those
> > > > custom BTF layouts might look like and how they are used in BPF
> > > > programs, etc. I'm struggling to put all the pieces together, even
> > > > ignoring all the netdev-specific configuration questions.
> > >
> > > I admit that this thread is pushing the boundaries and "ask" too much=
.
> > > I think we need some steps in-between to get the ball rolling first. =
 I
> > > myself need to learn more of what is possible today with BTF, before =
I
> > > ask for more features and multiple simultaneous BTF IDs.
> > >
> > > I will go read Andrii's excellent docs [1]+[2] *again*, and perhaps[3=
].
> > > Do you recommend other BTF docs?
> >
> > BTF in itself, at least as related to type definitions, is a super
> > lightweight and straightforward DWARF replacement. I'd recommend to
> > just play around with building a simple BPF code with various types
> > defined (use `clang -target bpf -g`) and then dump BTF info in both
> > raw format (just `bpftool btf dump file <path>` and in C format
> > (`bpftool btf dump file <path> format c`). That should be plenty to
> > get the feel for BTF.
>
> I've played with this and I think I get this part now :-)

ok, great

>
> > As for how libbpf and BPF CO-RE use BTF, I guess the below blog post
> > is a good start, I'm not sure we have another dedicated post
> > describing how CO-RE relocations work.
> >
> > >
> > >  [1] https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-por=
tability-and-co-re.html
> > >  [2] https://nakryiko.com/posts/bpf-portability-and-co-re/
> >
> > Choose [2], it's slightly more updated, but otherwise is the same as [1=
].
> >
> > >  [3] https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enh=
ancement.html
> >
> > It's up to you, but I wouldn't bother reading the BTF dedup
> > description in order to understand BTF in general :)
>
> Yes, I think I'll skip that dedup part ;-)
>
> > >
> > > > As for BTF on a per-packet basis. This means that BTF itself is not
> > > > known at the BPF program verification time, so there will be some s=
ort
> > > > of if/else if/else conditions to handle all recognized BTF IDs? Is
> > > > that right?
> > >
> > > I do want libbpf CO-RE and BPF program verification to work.  I'm
> > > asking for a BPF-program that can supply multiple BTF struct layouts
> > > and get all of them CO-RE offset adjusted.
> > >
> > > The XDP/BPF-prog itself have if/else conditions on BPF-IDs to handle
> > > all the BPF IDs it knows.  When loading the BPF-prog the offset
> > > relocation are done for the code (as usual I presume).
> >
> > Ok, so assuming kernel/driver somehow defines these two C structs:
> >
> > struct xdp_meta_1 { int x; char y[32]; } __attribute__((preserve_access=
_index));
> >
> > struct xdp_meta_2 { void *z; int q[4]; } __attribute__((preserve_access=
_index));
> >
> > on BPF program side, you should be able to do something like this:
> >
> > int xdp_btf_id =3D xdp_ctx->btf_id;
> > void *xdp_meta =3D xdp_ctx->meta;
> >
> > if (xdp_btf_id =3D=3D bpf_core_type_id_kernel(struct xdp_meta_1)) {
> >     struct xdp_meta_1 *m =3D xdp_meta;
> >
> >     return m->x + m->y[7] * 3;
> > } else if (xdp_btf_id =3D=3D bpf_core_type_id_kernel(struct xdp_meta_2)=
) {
> >     struct xdp_meta_2 *m =3D xdp_meta;
> >
> >     return m->z - m->q[2];
> > } else {
> >     /* we don't know what metadata layout we are working with */
> >     return XDP_DROP;
> > }
>
> Yes, I think this is the gist of what I was thinking.
>
> Cool that we have a bpf_core_type_id_kernel() macro (if others want to
> follow in tools/lib/bpf/bpf_core_read.h).  That looks VERY helpful for
> what I'm looking for.
>
>  /*
>   * Convenience macro to get BTF type ID of a target kernel's type that m=
atches
>   * specified local type.
>   * Returns:
>   *    - valid 32-bit unsigned type ID in kernel BTF;
>   *    - 0, if no matching type was found in a target kernel BTF.
>   */
>  #define bpf_core_type_id_kernel(type)                                   =
   \
>         __builtin_btf_type_id(*(typeof(type) *)0, BPF_TYPE_ID_TARGET)
>
>
> At what point in "time" is this bpf_core_type_id_kernel() resolved?

During the load time (i.e., bpf_object__load() or skeleton's
xxx__load()). It's done completely on the libbpf side before the
kernel sees the final relocated BPF instructions.

>
>
> > What I'm struggling a bit is how xdp_meta_1 and xdp_meta_2 come to be,
> > how they get to users building BPF application, etc. For example, if
> > those xdp_meta_x structs are dumped on the target kernel and the
> > program is compiled right there, you don't really need CO-RE because
> > you know exact layout and you are compiling on the fly BCC-style.
> >
> > I guess one way to allow pre-compilation and still let hardware define
> > the actual memory layout would be to have a pre-defined struct
> > xdp_meta___mega for BPF program, something like:
> >
> > struct xdp_meta___mega { int x; char y[32]; void *z; int q[4]; }
> > __attribute__((preserve_access_index));
> >
> > I.e., it defines all potentially possible fields. But then driver
> > knows that only, say, x and q are actually present, so in kernel we
> > have
> >
> > struct xdp_meta { int q[4]; int x; }
> >
> > With that, libbpf will match local xdp_meta___mega (___suffix is
> > ignored) to actual kernel definition, x and q offsets will be
> > relocated. If BPF program is trying to access y or z, though, it will
> > result in an error.
>
> Wow, this is also a cool trick that I didn't know we could do.
> Having a 'xdp_meta_generic_common___mega' could be very useful.
>

Yes, this triple underscore suffix allows to have multiple versions of
types in kernel BTF (which can happen during dedup due to struct name
collisions, like it happened before with two different struct
ring_buffer until they got renamed) and/or on BPF program side, e.g.,
to have struct layouts for multiple kernel versions or configurations
all in one compilable application.


> > CO-RE also allows to check the presence of y and z
> > and deal with that, so you have flexibility to do "feature detection"
> > right in BPF code:
> >
> > if (bpf_core_field_exists(m->z)) {
> >     return m->z;
> > } else {
> >     /* deal with lack of m->z */
> > }
>
> The bpf_core_field_exists() also look like an interesting and useful
> feature.  I assume this bpf_core_field_exists() happens at libbpf
> load-time, or even at BPF-syscall load-time. Right?
>

yep

>
> > Hopefully that gives a bit clearer picture of what CO-RE is about. I
> > guess I can also suggest reading [0] for a few more uses of CO-RE,
> > just for general understanding.
>
> Thanks a lot for educating me :-)

sure, you are welcome!

>
> >   [0] https://nakryiko.com/posts/bpf-tips-printk/
> >
> > >
> > > Maybe it is worth pointing out, that the reason for requiring the
> > > BPF-prog to check the BPF-ID match, is to solve the netdev HW feature
> > > update problem.  I'm basically evil and say we can update the netdev =
HW
> > > features anytime, because it is the BPF programmers responsibility to
> > > check if BTF info changed (after prog was loaded). (The BPF programme=
r
> > > can solve this via requesting all the possible BTF IDs the driver can
> > > change between, or choose she is only interested in a single variant)=
.
> >
> > Ok, see above, if you know all possible BTF IDs ahead of time, then
> > yes, you can do this. You'll pay the price of doing a bunch of if/else
> > for BTF ID comparison, of course, but not the price of accessing those
> > fields.
>
> It sounds great that this is basically already possible today.
>
> I'm willing to pay the if/else for BTF ID comparison cost, only because
> it solves the problem of allowing the kernel/driver to change the
> BTF-layout for the XDP metadata area dynamically, AFTER the BPF-prog
> have been loaded (and after all the nice libbpf relocations).

Ok, cool. This assumes you can know all possible BTF IDs, don't know
how realistic that is in each particular use case.

>
> > >
> > > By this, I'm trying to avoid loading an XDP-prog locks down what
> > > hardware features can be enabled/disabled.  It would be sad running
> > > tcpdump (-j adapter_unsynced) that request for HW RX-timestamp is
> > > blocked due to XDP being loaded.
>
> I think we need to included this as part of our XDP-hints design.  Yes,
> there is an annoying overhead in the XDP-prog to check bpf_id's, but it
> will be even more annoying/user-unfriendly to lock-down any hardware
> changed when an XDP-prog is loaded.
>
> If sysadm knows that nobody will ever run those commands that change
> hardware state and affect XDP-metadata layout, then end-user can remove
> this bpf_id check from their BPF-prog and get back the performance.
>
>
> > >
> > > > Fake but specific code would help (at least me) to actually join th=
e
> > > > discussion. Thanks.
> > >
> > > I agree, I actually want to code-up a simple example that use BTF CO-=
RE
> > > and then try to follow the libbpf code that adjust the offsets.  I
> > > admit I need to understand BTF better myself, before I ask for
> > > new/advanced features ;-)
> > >
> > > Thanks Andrii for giving us feedback, I do need to learn more about B=
TF
> > > myself to join the discussion myself.
> >
> > You are welcome. I left a few breadcrumbs above, I hope that helps a bi=
t.
>
> Thanks for all the breadcrumbs, really appreciate it!
> ... I'm trying to follow them, and the rabbit hole is deep :-)
>

The good thing is that CO-RE seems pretty stable and complete and
hasn't changed much over a pretty long time now, so it probably will
pay off to learn that now and use in the future.

>
> > >
> > > > >
> > > > > Let me describe a possible/proposed packet flow (feel free to
> > > > > disagree):
> > > > >
> > > > >  When driver RX e.g. a PTP packet it knows HW is configured for
> > > > > PTP-TS and when it sees a TS is available, then it chooses a code
> > > > > path that use the BTF layout that contains RX-TS. To communicate
> > > > > what BTF-type the XDP-metadata contains, it simply store the BTF-=
ID
> > > > > in xdp_buff->btf_id.
> > > > >
> > > > >  When redirecting the xdp_buff is converted to xdp_frame, and als=
o
> > > > > contains the btf_id member. When converting xdp_frame to SKB, the=
n
> > > > > netcore-code checks if this BTF-ID have been registered, if so
> > > > > there is a (callback or BPF-hook) registered to handle this
> > > > > BTF-type that transfer the fields from XDP-metadata area into SKB
> > > > > fields.
> > > > >
> > > > >  The XDP-prog also have access to this ctx->btf_id and can
> > > > > multiplex on this in the BPF-code itself. Or use other methods li=
ke
> > > > > parsing PTP packet and extract TS as expected BTF offset in XDP
> > > > > metadata (perhaps add a sanity check if metadata-size match).
> > > > >
> > > > >
> > > > > I talked to AF_XDP people (Magnus, Bj=C3=B8rn and William) about =
this
> > > > > idea, and they pointed out that AF_XDP also need to know what
> > > > > BTF-layout is used. As Magnus wrote in other thread; there is onl=
y
> > > > > 32-bit left in AF_XDP descriptor option. We could store the BTF-I=
D
> > > > > in this field, but it would block for other use-cases. Bj=C3=B8rn=
 came
> > > > > up with the idea of storing the BTF-ID in the BTF-layout itself,
> > > > > but as the last-member (to have fixed offset to check in userspac=
e
> > > > > AF_XDP program). Then we only need to use a single bit in AF_XDP
> > > > > descriptor option to say XDP-metadata is BTF described.
> > > > >
> > > > > In the AF_XDP userspace program, the programmers can have a simil=
ar
> > > > > callback system per known BTF-ID. This way they can compile
> > > > > efficient code per ID via requesting the BTF layout from the
> > > > > kernel. (Hint: `bpftool btf dump id 42 format c`).
> > > > >
> > > > > Please let me know if this it the right or wrong direction?
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>
