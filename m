Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA9B3922D9
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 00:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhEZWlG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 18:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhEZWlB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 18:41:01 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF257C061574
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 15:39:29 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id g38so4308693ybi.12
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 15:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4wIwfzF65f9WIQiN8b18TZJTYuskznDUdmG5VwhHg6Y=;
        b=t4Lw8hOZM3UeIXUrIJgbvDbIVcfA/yNRyJO7PNRJJuhxH/xfwVEQaD0oFljuwi0IMK
         jZY7ZnnPkLtrZQpmjNTLWOhBN6lNkwddrm2VFWR7KxHNbLNy19RWbiRp3L3KHlulhV+H
         OQIdbsr/+5Ml8oMUyz7CUu8d/y+hxg8CjUhbYjeXp5Ld1GpczEx/a9tPDAqwab/qTn8m
         KT91QSKt/1DNLLZ3QrFj9+cVkpnr/o04mgxsel60QxrctHw2jLdd6GgUqyb/UV0k2J8N
         i5y4mLJpcKxx2FsyAa0wfQC057dGaALlW89OgoO9OGoturiIeNK3fN2y7g7mD7RVd2MV
         1eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4wIwfzF65f9WIQiN8b18TZJTYuskznDUdmG5VwhHg6Y=;
        b=l14CLIyXAGdHLxB+aQCepA1vJYWE/ZXlrwvoGmf5yoA10hxPNP4+U/u+WIPImckO6y
         u1uMYU1u3hNaxdyXxbZ8YGCadTpgJhNi/kj2qFb4bsYGq6hBackRL+uZrCXBoJciS+9L
         CShWuwfghnoYyKLIAR/QLopo4sfFovopqj8Iq4/YVVuxebEnfhXVPGolJ8gPWNWDmUsi
         clXQTQLF/Sz2CkZ0KGuI/si8a/FX+D4ABW+/PV4JbDP0fEmHxY/7UTFGtqAg6nFQO58W
         +WijlCJWXYOZcC7VGKEFwdTtZ4Zy007gSX98yINf22Ef/hMWhW+L8dco2lm+vgKLduKj
         iuNw==
X-Gm-Message-State: AOAM5328YlPwz1SdPGR6J3ZlG2DYqvfyvP4N9Jf9bWwEsBtKvaor6aUv
        k+2ml22v7VM+WNCySKylPLlxTp+rYXF9povh3pg=
X-Google-Smtp-Source: ABdhPJy6Kz6+POc/HE7e8n1NynM554iYTMcwrts1FKZwGlEDReCdB0KSCoab7XoRcVJVx5z+2Cwjp0mLcvAIfRwfeMM=
X-Received: by 2002:a5b:f05:: with SMTP id x5mr392412ybr.425.1622068768869;
 Wed, 26 May 2021 15:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210526125848.1c7adbb0@carbon> <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
 <20210526222023.44f9b3c6@carbon>
In-Reply-To: <20210526222023.44f9b3c6@carbon>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 May 2021 15:39:17 -0700
Message-ID: <CAEf4BzZ+VSemxx7WFanw7DfLGN7w42G6ZC4dvOSB1zAsUgRQaw@mail.gmail.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
To:     Jesper Dangaard Brouer <brouer@redhat.com>
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
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 1:20 PM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> On Wed, 26 May 2021 12:12:09 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
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
> > down for me and use few very specific examples to show how all this is
> > supposed to work end-to-end. I.e., how the C definition for those
> > custom BTF layouts might look like and how they are used in BPF
> > programs, etc. I'm struggling to put all the pieces together, even
> > ignoring all the netdev-specific configuration questions.
>
> I admit that this thread is pushing the boundaries and "ask" too much.
> I think we need some steps in-between to get the ball rolling first.  I
> myself need to learn more of what is possible today with BTF, before I
> ask for more features and multiple simultaneous BTF IDs.
>
> I will go read Andrii's excellent docs [1]+[2] *again*, and perhaps[3].
> Do you recommend other BTF docs?

BTF in itself, at least as related to type definitions, is a super
lightweight and straightforward DWARF replacement. I'd recommend to
just play around with building a simple BPF code with various types
defined (use `clang -target bpf -g`) and then dump BTF info in both
raw format (just `bpftool btf dump file <path>` and in C format
(`bpftool btf dump file <path> format c`). That should be plenty to
get the feel for BTF.

As for how libbpf and BPF CO-RE use BTF, I guess the below blog post
is a good start, I'm not sure we have another dedicated post
describing how CO-RE relocations work.

>
>  [1] https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-portabi=
lity-and-co-re.html
>  [2] https://nakryiko.com/posts/bpf-portability-and-co-re/

Choose [2], it's slightly more updated, but otherwise is the same as [1].

>  [3] https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhance=
ment.html

It's up to you, but I wouldn't bother reading the BTF dedup
description in order to understand BTF in general :)

>
> > As for BTF on a per-packet basis. This means that BTF itself is not
> > known at the BPF program verification time, so there will be some sort
> > of if/else if/else conditions to handle all recognized BTF IDs? Is
> > that right?
>
> I do want libbpf CO-RE and BPF program verification to work.  I'm
> asking for a BPF-program that can supply multiple BTF struct layouts
> and get all of them CO-RE offset adjusted.
>
> The XDP/BPF-prog itself have if/else conditions on BPF-IDs to handle
> all the BPF IDs it knows.  When loading the BPF-prog the offset
> relocation are done for the code (as usual I presume).

Ok, so assuming kernel/driver somehow defines these two C structs:

struct xdp_meta_1 { int x; char y[32]; } __attribute__((preserve_access_ind=
ex));

struct xdp_meta_2 { void *z; int q[4]; } __attribute__((preserve_access_ind=
ex));

on BPF program side, you should be able to do something like this:

int xdp_btf_id =3D xdp_ctx->btf_id;
void *xdp_meta =3D xdp_ctx->meta;

if (xdp_btf_id =3D=3D bpf_core_type_id_kernel(struct xdp_meta_1)) {
    struct xdp_meta_1 *m =3D xdp_meta;

    return m->x + m->y[7] * 3;
} else if (xdp_btf_id =3D=3D bpf_core_type_id_kernel(struct xdp_meta_2)) {
    struct xdp_meta_2 *m =3D xdp_meta;

    return m->z - m->q[2];
} else {
    /* we don't know what metadata layout we are working with */
    return XDP_DROP;
}

What I'm struggling a bit is how xdp_meta_1 and xdp_meta_2 come to be,
how they get to users building BPF application, etc. For example, if
those xdp_meta_x structs are dumped on the target kernel and the
program is compiled right there, you don't really need CO-RE because
you know exact layout and you are compiling on the fly BCC-style.

I guess one way to allow pre-compilation and still let hardware define
the actual memory layout would be to have a pre-defined struct
xdp_meta___mega for BPF program, something like:

struct xdp_meta___mega { int x; char y[32]; void *z; int q[4]; }
__attribute__((preserve_access_index));

I.e., it defines all potentially possible fields. But then driver
knows that only, say, x and q are actually present, so in kernel we
have

struct xdp_meta { int q[4]; int x; }

With that, libbpf will match local xdp_meta___mega (___suffix is
ignored) to actual kernel definition, x and q offsets will be
relocated. If BPF program is trying to access y or z, though, it will
result in an error. CO-RE also allows to check the presence of y and z
and deal with that, so you have flexibility to do "feature detection"
right in BPF code:

if (bpf_core_field_exists(m->z)) {
    return m->z;
} else {
    /* deal with lack of m->z */
}

Hopefully that gives a bit clearer picture of what CO-RE is about. I
guess I can also suggest reading [0] for a few more uses of CO-RE,
just for general understanding.

  [0] https://nakryiko.com/posts/bpf-tips-printk/

>
> Maybe it is worth pointing out, that the reason for requiring the
> BPF-prog to check the BPF-ID match, is to solve the netdev HW feature
> update problem.  I'm basically evil and say we can update the netdev HW
> features anytime, because it is the BPF programmers responsibility to
> check if BTF info changed (after prog was loaded). (The BPF programmer
> can solve this via requesting all the possible BTF IDs the driver can
> change between, or choose she is only interested in a single variant).

Ok, see above, if you know all possible BTF IDs ahead of time, then
yes, you can do this. You'll pay the price of doing a bunch of if/else
for BTF ID comparison, of course, but not the price of accessing those
fields.

>
> By this, I'm trying to avoid loading an XDP-prog locks down what
> hardware features can be enabled/disabled.  It would be sad running
> tcpdump (-j adapter_unsynced) that request for HW RX-timestamp is
> blocked due to XDP being loaded.
>
>
> > Fake but specific code would help (at least me) to actually join the
> > discussion. Thanks.
>
> I agree, I actually want to code-up a simple example that use BTF CO-RE
> and then try to follow the libbpf code that adjust the offsets.  I
> admit I need to understand BTF better myself, before I ask for
> new/advanced features ;-)
>
> Thanks Andrii for giving us feedback, I do need to learn more about BTF
> myself to join the discussion myself.

You are welcome. I left a few breadcrumbs above, I hope that helps a bit.

>
>
> > >
> > > Let me describe a possible/proposed packet flow (feel free to
> > > disagree):
> > >
> > >  When driver RX e.g. a PTP packet it knows HW is configured for
> > > PTP-TS and when it sees a TS is available, then it chooses a code
> > > path that use the BTF layout that contains RX-TS. To communicate
> > > what BTF-type the XDP-metadata contains, it simply store the BTF-ID
> > > in xdp_buff->btf_id.
> > >
> > >  When redirecting the xdp_buff is converted to xdp_frame, and also
> > > contains the btf_id member. When converting xdp_frame to SKB, then
> > > netcore-code checks if this BTF-ID have been registered, if so
> > > there is a (callback or BPF-hook) registered to handle this
> > > BTF-type that transfer the fields from XDP-metadata area into SKB
> > > fields.
> > >
> > >  The XDP-prog also have access to this ctx->btf_id and can
> > > multiplex on this in the BPF-code itself. Or use other methods like
> > > parsing PTP packet and extract TS as expected BTF offset in XDP
> > > metadata (perhaps add a sanity check if metadata-size match).
> > >
> > >
> > > I talked to AF_XDP people (Magnus, Bj=C3=B8rn and William) about this
> > > idea, and they pointed out that AF_XDP also need to know what
> > > BTF-layout is used. As Magnus wrote in other thread; there is only
> > > 32-bit left in AF_XDP descriptor option. We could store the BTF-ID
> > > in this field, but it would block for other use-cases. Bj=C3=B8rn cam=
e
> > > up with the idea of storing the BTF-ID in the BTF-layout itself,
> > > but as the last-member (to have fixed offset to check in userspace
> > > AF_XDP program). Then we only need to use a single bit in AF_XDP
> > > descriptor option to say XDP-metadata is BTF described.
> > >
> > > In the AF_XDP userspace program, the programmers can have a similar
> > > callback system per known BTF-ID. This way they can compile
> > > efficient code per ID via requesting the BTF layout from the
> > > kernel. (Hint: `bpftool btf dump id 42 format c`).
> > >
> > > Please let me know if this it the right or wrong direction?
>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>
