Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A083941AE
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 13:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhE1LRz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 07:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54697 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230098AbhE1LRz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 May 2021 07:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622200579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RsQBB1OySVtb+0y8sdWKBK6Cgt5x56DXTYIJ2YIcBRs=;
        b=aeEnoThIOlKD9FIO0Y9AUrcmI/UTLkmK08gUrjYvl9jzFcLiJ9LMoU+UVfc1mG02Hm8Stk
        unJMY9hlkkUvSilpsDbL4343h41jon6fNVhCIbB3Dsg9aqzucuQ1JRJ2tfXk+pBYhaJmh8
        X63litcnpOEKOaC9tvilnuF777TvwA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-lcd0qnOkNVi4A10OXVUMAQ-1; Fri, 28 May 2021 07:16:18 -0400
X-MC-Unique: lcd0qnOkNVi4A10OXVUMAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A7D6188E3C2;
        Fri, 28 May 2021 11:16:16 +0000 (UTC)
Received: from carbon (unknown [10.36.110.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E10605F9C2;
        Fri, 28 May 2021 11:16:08 +0000 (UTC)
Date:   Fri, 28 May 2021 13:16:07 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, brouer@redhat.com
Cc:     BPF-dev-list <bpf@vger.kernel.org>, xdp-hints@xdp-project.net,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        William Tu <u9012063@gmail.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
Message-ID: <20210528131607.22f51b43@carbon>
In-Reply-To: <CAEf4BzZ+VSemxx7WFanw7DfLGN7w42G6ZC4dvOSB1zAsUgRQaw@mail.gmail.com>
References: <20210526125848.1c7adbb0@carbon>
        <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
        <20210526222023.44f9b3c6@carbon>
        <CAEf4BzZ+VSemxx7WFanw7DfLGN7w42G6ZC4dvOSB1zAsUgRQaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 26 May 2021 15:39:17 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, May 26, 2021 at 1:20 PM Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
> >
> > On Wed, 26 May 2021 12:12:09 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > =20
> > > On Wed, May 26, 2021 at 3:59 AM Jesper Dangaard Brouer
> > > <brouer@redhat.com> wrote: =20
> > > >
> > > > Hi All,
> > > >
> > > > I see a need for a driver to use different XDP metadata layout on a=
 per
> > > > packet basis. E.g. PTP packets contains a hardware timestamp. E.g. =
VLAN
> > > > offloading and associated metadata as only relevant for packets usi=
ng
> > > > VLANs. (Reserving room for every possible HW-hint is against the id=
ea
> > > > of BTF).
> > > >
> > > > The question is how to support multiple BTF types on per packet bas=
is?
> > > > (I need input from BTF experts, to tell me if I'm going in the wrong
> > > > direction with below ideas). =20
> > >
> > > I'm trying to follow all three threads, but still, can someone dumb it
> > > down for me and use few very specific examples to show how all this is
> > > supposed to work end-to-end. I.e., how the C definition for those
> > > custom BTF layouts might look like and how they are used in BPF
> > > programs, etc. I'm struggling to put all the pieces together, even
> > > ignoring all the netdev-specific configuration questions. =20
> >
> > I admit that this thread is pushing the boundaries and "ask" too much.
> > I think we need some steps in-between to get the ball rolling first.  I
> > myself need to learn more of what is possible today with BTF, before I
> > ask for more features and multiple simultaneous BTF IDs.
> >
> > I will go read Andrii's excellent docs [1]+[2] *again*, and perhaps[3].
> > Do you recommend other BTF docs? =20
>=20
> BTF in itself, at least as related to type definitions, is a super
> lightweight and straightforward DWARF replacement. I'd recommend to
> just play around with building a simple BPF code with various types
> defined (use `clang -target bpf -g`) and then dump BTF info in both
> raw format (just `bpftool btf dump file <path>` and in C format
> (`bpftool btf dump file <path> format c`). That should be plenty to
> get the feel for BTF.

I've played with this and I think I get this part now :-)

> As for how libbpf and BPF CO-RE use BTF, I guess the below blog post
> is a good start, I'm not sure we have another dedicated post
> describing how CO-RE relocations work.
>=20
> >
> >  [1] https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-porta=
bility-and-co-re.html
> >  [2] https://nakryiko.com/posts/bpf-portability-and-co-re/ =20
>=20
> Choose [2], it's slightly more updated, but otherwise is the same as [1].
>=20
> >  [3] https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhan=
cement.html =20
>=20
> It's up to you, but I wouldn't bother reading the BTF dedup
> description in order to understand BTF in general :)

Yes, I think I'll skip that dedup part ;-)

> > =20
> > > As for BTF on a per-packet basis. This means that BTF itself is not
> > > known at the BPF program verification time, so there will be some sort
> > > of if/else if/else conditions to handle all recognized BTF IDs? Is
> > > that right? =20
> >
> > I do want libbpf CO-RE and BPF program verification to work.  I'm
> > asking for a BPF-program that can supply multiple BTF struct layouts
> > and get all of them CO-RE offset adjusted.
> >
> > The XDP/BPF-prog itself have if/else conditions on BPF-IDs to handle
> > all the BPF IDs it knows.  When loading the BPF-prog the offset
> > relocation are done for the code (as usual I presume). =20
>=20
> Ok, so assuming kernel/driver somehow defines these two C structs:
>=20
> struct xdp_meta_1 { int x; char y[32]; } __attribute__((preserve_access_i=
ndex));
>=20
> struct xdp_meta_2 { void *z; int q[4]; } __attribute__((preserve_access_i=
ndex));
>=20
> on BPF program side, you should be able to do something like this:
>=20
> int xdp_btf_id =3D xdp_ctx->btf_id;
> void *xdp_meta =3D xdp_ctx->meta;
>=20
> if (xdp_btf_id =3D=3D bpf_core_type_id_kernel(struct xdp_meta_1)) {
>     struct xdp_meta_1 *m =3D xdp_meta;
>=20
>     return m->x + m->y[7] * 3;
> } else if (xdp_btf_id =3D=3D bpf_core_type_id_kernel(struct xdp_meta_2)) {
>     struct xdp_meta_2 *m =3D xdp_meta;
>=20
>     return m->z - m->q[2];
> } else {
>     /* we don't know what metadata layout we are working with */
>     return XDP_DROP;
> }

Yes, I think this is the gist of what I was thinking.

Cool that we have a bpf_core_type_id_kernel() macro (if others want to
follow in tools/lib/bpf/bpf_core_read.h).  That looks VERY helpful for
what I'm looking for.

 /*
  * Convenience macro to get BTF type ID of a target kernel's type that mat=
ches=20
  * specified local type.
  * Returns:
  *    - valid 32-bit unsigned type ID in kernel BTF;
  *    - 0, if no matching type was found in a target kernel BTF.
  */
 #define bpf_core_type_id_kernel(type)					    \
 	__builtin_btf_type_id(*(typeof(type) *)0, BPF_TYPE_ID_TARGET)


At what point in "time" is this bpf_core_type_id_kernel() resolved?


> What I'm struggling a bit is how xdp_meta_1 and xdp_meta_2 come to be,
> how they get to users building BPF application, etc. For example, if
> those xdp_meta_x structs are dumped on the target kernel and the
> program is compiled right there, you don't really need CO-RE because
> you know exact layout and you are compiling on the fly BCC-style.
>=20
> I guess one way to allow pre-compilation and still let hardware define
> the actual memory layout would be to have a pre-defined struct
> xdp_meta___mega for BPF program, something like:
>=20
> struct xdp_meta___mega { int x; char y[32]; void *z; int q[4]; }
> __attribute__((preserve_access_index));
>=20
> I.e., it defines all potentially possible fields. But then driver
> knows that only, say, x and q are actually present, so in kernel we
> have
>=20
> struct xdp_meta { int q[4]; int x; }
>=20
> With that, libbpf will match local xdp_meta___mega (___suffix is
> ignored) to actual kernel definition, x and q offsets will be
> relocated. If BPF program is trying to access y or z, though, it will
> result in an error.=20

Wow, this is also a cool trick that I didn't know we could do.
Having a 'xdp_meta_generic_common___mega' could be very useful.

> CO-RE also allows to check the presence of y and z
> and deal with that, so you have flexibility to do "feature detection"
> right in BPF code:
>=20
> if (bpf_core_field_exists(m->z)) {
>     return m->z;
> } else {
>     /* deal with lack of m->z */
> }

The bpf_core_field_exists() also look like an interesting and useful
feature.  I assume this bpf_core_field_exists() happens at libbpf
load-time, or even at BPF-syscall load-time. Right?


> Hopefully that gives a bit clearer picture of what CO-RE is about. I
> guess I can also suggest reading [0] for a few more uses of CO-RE,
> just for general understanding.

Thanks a lot for educating me :-)

>   [0] https://nakryiko.com/posts/bpf-tips-printk/
>=20
> >
> > Maybe it is worth pointing out, that the reason for requiring the
> > BPF-prog to check the BPF-ID match, is to solve the netdev HW feature
> > update problem.  I'm basically evil and say we can update the netdev HW
> > features anytime, because it is the BPF programmers responsibility to
> > check if BTF info changed (after prog was loaded). (The BPF programmer
> > can solve this via requesting all the possible BTF IDs the driver can
> > change between, or choose she is only interested in a single variant). =
=20
>=20
> Ok, see above, if you know all possible BTF IDs ahead of time, then
> yes, you can do this. You'll pay the price of doing a bunch of if/else
> for BTF ID comparison, of course, but not the price of accessing those
> fields.

It sounds great that this is basically already possible today.

I'm willing to pay the if/else for BTF ID comparison cost, only because
it solves the problem of allowing the kernel/driver to change the
BTF-layout for the XDP metadata area dynamically, AFTER the BPF-prog
have been loaded (and after all the nice libbpf relocations).

> >
> > By this, I'm trying to avoid loading an XDP-prog locks down what
> > hardware features can be enabled/disabled.  It would be sad running
> > tcpdump (-j adapter_unsynced) that request for HW RX-timestamp is
> > blocked due to XDP being loaded.

I think we need to included this as part of our XDP-hints design.  Yes,
there is an annoying overhead in the XDP-prog to check bpf_id's, but it
will be even more annoying/user-unfriendly to lock-down any hardware
changed when an XDP-prog is loaded.

If sysadm knows that nobody will ever run those commands that change
hardware state and affect XDP-metadata layout, then end-user can remove
this bpf_id check from their BPF-prog and get back the performance.


> > =20
> > > Fake but specific code would help (at least me) to actually join the
> > > discussion. Thanks. =20
> >
> > I agree, I actually want to code-up a simple example that use BTF CO-RE
> > and then try to follow the libbpf code that adjust the offsets.  I
> > admit I need to understand BTF better myself, before I ask for
> > new/advanced features ;-)
> >
> > Thanks Andrii for giving us feedback, I do need to learn more about BTF
> > myself to join the discussion myself. =20
>=20
> You are welcome. I left a few breadcrumbs above, I hope that helps a bit.

Thanks for all the breadcrumbs, really appreciate it!
... I'm trying to follow them, and the rabbit hole is deep :-)


> > =20
> > > >
> > > > Let me describe a possible/proposed packet flow (feel free to
> > > > disagree):
> > > >
> > > >  When driver RX e.g. a PTP packet it knows HW is configured for
> > > > PTP-TS and when it sees a TS is available, then it chooses a code
> > > > path that use the BTF layout that contains RX-TS. To communicate
> > > > what BTF-type the XDP-metadata contains, it simply store the BTF-ID
> > > > in xdp_buff->btf_id.
> > > >
> > > >  When redirecting the xdp_buff is converted to xdp_frame, and also
> > > > contains the btf_id member. When converting xdp_frame to SKB, then
> > > > netcore-code checks if this BTF-ID have been registered, if so
> > > > there is a (callback or BPF-hook) registered to handle this
> > > > BTF-type that transfer the fields from XDP-metadata area into SKB
> > > > fields.
> > > >
> > > >  The XDP-prog also have access to this ctx->btf_id and can
> > > > multiplex on this in the BPF-code itself. Or use other methods like
> > > > parsing PTP packet and extract TS as expected BTF offset in XDP
> > > > metadata (perhaps add a sanity check if metadata-size match).
> > > >
> > > >
> > > > I talked to AF_XDP people (Magnus, Bj=C3=B8rn and William) about th=
is
> > > > idea, and they pointed out that AF_XDP also need to know what
> > > > BTF-layout is used. As Magnus wrote in other thread; there is only
> > > > 32-bit left in AF_XDP descriptor option. We could store the BTF-ID
> > > > in this field, but it would block for other use-cases. Bj=C3=B8rn c=
ame
> > > > up with the idea of storing the BTF-ID in the BTF-layout itself,
> > > > but as the last-member (to have fixed offset to check in userspace
> > > > AF_XDP program). Then we only need to use a single bit in AF_XDP
> > > > descriptor option to say XDP-metadata is BTF described.
> > > >
> > > > In the AF_XDP userspace program, the programmers can have a similar
> > > > callback system per known BTF-ID. This way they can compile
> > > > efficient code per ID via requesting the BTF layout from the
> > > > kernel. (Hint: `bpftool btf dump id 42 format c`).
> > > >
> > > > Please let me know if this it the right or wrong direction? =20
--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

