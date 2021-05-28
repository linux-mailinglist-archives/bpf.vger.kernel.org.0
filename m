Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83275394589
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 18:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhE1QEE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 12:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229608AbhE1QEE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 May 2021 12:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622217748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NoHXeF5DxN+8/tz/dqz6KRM+snbaETb5MXev3Z0YBMk=;
        b=DrRmmpg6xQB2L2rnnH61gNDR6TTeYv1bggLUTyd9kQ0Gmu8Ho2LZD7iDlNczGA9IFyXebY
        mWTq2NibX7mZHnq1JODwkeC2tx3UUJV7Ghck1l0Tukl4OwxASr1AfRS5x0jDOcirQpbifp
        5wlfS2RvhwTpS7g6i206sDUkUyk2Kx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-tWtN9gHsPvmz42iutTb1Kw-1; Fri, 28 May 2021 12:02:24 -0400
X-MC-Unique: tWtN9gHsPvmz42iutTb1Kw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21DFA1007467;
        Fri, 28 May 2021 16:02:23 +0000 (UTC)
Received: from carbon (unknown [10.36.110.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79390BA63;
        Fri, 28 May 2021 16:02:15 +0000 (UTC)
Date:   Fri, 28 May 2021 18:02:14 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net,
        brouer@redhat.com
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
Message-ID: <20210528180214.3b427837@carbon>
In-Reply-To: <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
References: <20210526125848.1c7adbb0@carbon>
        <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
        <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch>
        <CAEf4Bza3m5dwZ_d0=zAWR+18f5RUjzv9=1NbhTKAO1uzWg_fzQ@mail.gmail.com>
        <60aeeb5252147_19a622085a@john-XPS-13-9370.notmuch>
        <CAEf4Bzb1OZHpHYagbVs7s9tMSk4wrbxzGeBCCBHQ-qCOgdu6EQ@mail.gmail.com>
        <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
        <87fsy7gqv7.fsf@toke.dk>
        <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 28 May 2021 07:35:34 -0700
John Fastabend <john.fastabend@gmail.com> wrote:

> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > John Fastabend <john.fastabend@gmail.com> writes:
> >  =20
> > >> > > union and independent set of BTFs are two different things, I'll=
 let
> > >> > > you guys figure out which one you need, but I replied how it cou=
ld
> > >> > > look like in CO-RE world =20
> > >> >
> > >> > I think a union is sufficient and more aligned with how the
> > >> > hardware would actually work. =20
> > >>=20
> > >> Sure. And I think those are two orthogonal concerns. You can start
> > >> with a single struct mynic_metadata with union inside it, and later
> > >> add the ability to swap mynic_metadata with another
> > >> mynic_metadata___v2 that will have a similar union but with a
> > >> different layout. =20
> > >
> > > Right and then you just have normal upgrade/downgrade problems with
> > > any struct.
> > >
> > > Seems like a workable path to me. But, need to circle back to the
> > > what we want to do with it part that Jesper replied to. =20
> >=20
> > So while this seems to be a viable path for getting libbpf to do all the
> > relocations (and thanks for hashing that out, I did not have a good grip
> > of the details), doing it all in userspace means that there is no way
> > for the XDP program to react to changes once it has been loaded. So this
> > leaves us with a selection of non-very-attractive options, IMO. I.e.,
> > we would have to: =20
>=20
> I don't really understand what this means 'having XDP program to
> react to changes once it has been loaded.' What would a program look
> like thats dynamic? You can always version your metadata and
> write programs like this,
>=20
>   if (meta->version =3D=3D VERSION1) {do_foo}
>   else {do_bar}
>=20
> And then have a headeer,
>=20
>    struct meta {
>      int version;
>      union ...    // union of versions
>    }
>=20
> I fail to see how a program could 'react' dynamically. An agent could
> load new programs dynamically into tail call maps of fentry with
> the need handlers, which would work as well and avoid unions.
>=20
> >=20
> > - have to block any modifications to the hardware config that would
> >   change the metadata format; this will probably result in irate users =
=20
>=20
> I'll need a concrete example if I swap out my parser block, I should
> also swap out my BPF for my shiny new protocol. I don't see how a
> user might write programs for things they've not configured hardware
> for yet. Leaving aside knobs like VLAN on/off, VXLAN on/off, and
> such which brings the next point.
>=20
> >=20
> > - require XDP programs to deal with all possible metadata permutations
> >   supported by that driver (by exporting them all via a BTF union or
> >   similar); this means a potential for combinatorial explosion of config
> >   options and as NICs become programmable themselves I'm not even sure
> >   if it's possible for the driver to know ahead of time =20
>=20
> I don't see the problem sorry. For current things that exist I can't
> think up too many fields vlan, timestamp, checksum(?), pkt_type,
> hash maybe.
>=20
> For programmable pipelines (P4) then I don't see a problem with
> reloading your program or swapping out a program. I don't see the
> value of adding a new protocol for example dynamically. Surely
> the hardware is going to get hit with a big reset anyways.
>=20
> >=20
> > - throw up our hands and just let the user deal with it (i.e., to
> >   nothing and so require XDP programs to be reloaded if the NIC config
> >   changes); this is not very friendly and is likely to lead to subtle
> >   bugs if an XDP program parses the metadata assuming it is in a
> >   different format than it is =20
>=20
> I'm not opposed to user error causing logic bugs.  If I give
> users power to reprogram their NICs they should be capabable
> of managing a few BPF programs. And if not then its a space
> where a distro/vendor should help them with tooling.
>=20
> >=20
> > Given that hardware config changes are not just done by ethtool, but
> > also by things like running `tcpdump -j`, I really think we have to
> > assume that they can be quite dynamic; which IMO means we have to solve
> > this as part of the initial design. And I have a hard time seeing how
> > this is possible without involving the kernel somehow. =20
>=20
> I guess here your talking about building an skb? Wouldn't it
> use whatever logic it uses today to include the timestamp.
> This is a bit of an aside from metadata in the BPF program.
>=20
> Building timestamps into
> skbs doesn't require BPF program to have the data. Or maybe
> the point is an XDP variant of tcpdump would like timestamps.
> But then it should be in the metadata IMO.

It sounds like we are all agreeing that the HW RX timestamp should be
stored in the XDP-metadata area right?=20

As I understand, John don't like multiple structs, but want a single
struct, so lets create below simple struct that the driver code fills
out before calling our XDP-prog:

 struct meta {
	u32 timestamp_type;
	u64 rx_timestamp;
	u32 rxhash32;
	u32 version;
 };

This NIC is configured for PTP, but hardware can only do rx_timestamp
for PTP packets (like ixgbe).  (Assume both my XDP-prog and PTP
userspace prog want to see this HW TS).

What should I do as a driver developer to tell XDP-prog that the HW
rx_timestamp is not valid for this packet ?

 1. Always clear 'rx_timestamp' + 'timestamp_type' for non-PTP packets?
 2. or, set version to something else ?

I don't like option 1, because it will slowdown the normal none-PTP
packets, that doesn't need this timestamp.



Now I want to redirect this packet into a veth.  The veth device could
be running an XDP-prog, that also want to look at this timestamp info.
How can the veth XDP-prog know howto interpret metadata area. What if I
stored the bpf_id in the version fields in the struct?.

(Details: I also need this timestamp info transferred to xdp_frame,
because when redirecting into a veth (container) then I want this
timestamp set on the SKB to survive. I wonder how can I know what the
BTF-layout, guess it would be useful to have btf_id at this point)

> >=20
> > Unless I'm missing something? WDYT? =20
>=20
> Distilling above down. I think we disagree on how useful
> dynamic programs are because of two reasons. First I don't
> see a large list of common attributes that would make the
> union approach as painful as you fear. And two, I believe
> users who are touching core hardware firmware need to also
> be smart enough (or have smart tools) to swap out their
> BPF programs in the correct order so as to not create
> subtle races. I didn't do it here but if we agree walking
> through that program swap flow with firmware update would
> be useful.

Hmm, I sense we are perhaps talking past each-other(?).  I am not
talking about firmware upgrades.  I'm arguing that enable/disable of HW
RX-timestamps will change the XDP-metadata usage dynamically runtime.
This is simply a normal userspace program that cause this changes e.g.
running 'tcpdump -j'.

--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

