Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4B4395B7C
	for <lists+bpf@lfdr.de>; Mon, 31 May 2021 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhEaNVJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 May 2021 09:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232063AbhEaNTo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 31 May 2021 09:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622467084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yz5X0LBA6H3vlwxwHbBOmjNCyN/rMI34oPLh1UP/mQU=;
        b=WnfCE9RCo0FIyoSPglmkinynvVCm72welz6hE+khy3jRd6h1ql7E7N1E5HDjMCFclO1vgg
        BVdsBPSyk6qRebMBFt3nfUIgWdiaZJXaocIt/y4YiXWXkWIgNx/8kuOj//lhlF8nJKDuwW
        l2zCCsCO+nd03jCVPNBQFGqItDRo2bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-RzioQuTDPAWTtu6WlyCq-g-1; Mon, 31 May 2021 09:18:02 -0400
X-MC-Unique: RzioQuTDPAWTtu6WlyCq-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16898180FD6A;
        Mon, 31 May 2021 13:18:01 +0000 (UTC)
Received: from carbon (unknown [10.36.110.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEF7310023B5;
        Mon, 31 May 2021 13:17:52 +0000 (UTC)
Date:   Mon, 31 May 2021 15:17:48 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>,
        XDP-hints working-group <xdp-hints@xdp-project.net>,
        brouer@redhat.com
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
Message-ID: <20210531151748.39fc5aa6@carbon>
In-Reply-To: <8735u3dv2l.fsf@toke.dk>
References: <20210526125848.1c7adbb0@carbon>
        <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
        <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch>
        <CAEf4Bza3m5dwZ_d0=zAWR+18f5RUjzv9=1NbhTKAO1uzWg_fzQ@mail.gmail.com>
        <60aeeb5252147_19a622085a@john-XPS-13-9370.notmuch>
        <CAEf4Bzb1OZHpHYagbVs7s9tMSk4wrbxzGeBCCBHQ-qCOgdu6EQ@mail.gmail.com>
        <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
        <87fsy7gqv7.fsf@toke.dk>
        <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
        <20210528180214.3b427837@carbon>
        <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
        <8735u3dv2l.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 31 May 2021 13:03:14 +0200
Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:

> John Fastabend <john.fastabend@gmail.com> writes:
>=20
> > Jesper Dangaard Brouer wrote:
> >
> > [...]
> >
> > I'll try to respond to both Toke and Jesper here and make it coherent so
> > we don't split this thread yet again.
> >
> > Wish me luck.
> >
> > @Toke "react" -> "not break" hopefully gives you my opinion on this.
> >
> > @Toke "five fields gives 32 different metadata formats" OK let me take
> > five fields,
> >
> >  struct meta {
> >    __u32 f1;
> >    __u32 f2;
> >    __u32 f3;
> >    __u32 f4;
> >    __u32 f5;
> >  }
> >
> > I'm still confused why the meta data would change just because the feat=
ure
> > is enabled or disabled. I've written drivers before and I don't want to
> > move around where I write f1 based on some combination of features f2,f=
3,f4,f5

Just be be clear:  I'm not suggesting drivers need to dynamically write
at different offsets.  Adding this BTF-flexibility make is possible,
but in practice the driver need to be smart about this.  I think we all
understand this would kill performance and create too complex drivers.

Drivers and hardware have a natural need to place info at fixed offsets.
The hole exercise is to create a layer between drivers and BPF+netstack
via BTF that can express flexibility.  That BTF can express this
flexibility doesn't mean that the drivers/hardware all of a sudden need
to be as flexible.

Drivers will continue to place info at fixed offsets (likely make sense
to have a big struct with unions and everything). I'm suggesting that
the driver will tell the "flex-layer" via BTF which-members-are-what by
setting a BTF-ID that "describe" this.
(Hint, drivers have knowledge like what HW features bits are enabled
that can be translated into a given BTF-ID.  Potentially drivers can
update this BTF-ID when setup events via ethtool occurs)

To avoid the combinations explode, the driver can choose to limit these
via e.g. always include the vlan_id but set it to zero even when
vlan-offloads are turned off.  Drivers can also *choose* to have a
single and very advanced BTF-layout with bitfields and everything (as
the BTF-side is superflexible and support this).  Again the drivers
should be moderate and not implement a combination explosion of BTF-IDs
just because BTF allowed this high level of flexibility.


> > state of enabled/disabled. If features are mutual exclusive I can build=
 a
> > sensible union. If its possible for all fields to enabled then I just l=
ay
> > them out like above. =20
>=20
> The assumption that the layout would be changing as the features were
> enabled came from a discussion I had with Jesper where he pointed out
> that zeroing out the fields that were not active comes with a measurable
> performance impact. So changing the struct layout to only include the
> fields that are currently used is a way to make sure we don't hurt
> performance.
>=20
> If I'm understanding you correctly, what you propose instead is that we
> just keep the struct layout the same and only write the data that we
> have, leaving the other fields as uninitialised (so essentially
> garbage), right?
>=20
> If we do this, the BPF program obviously needs to know which fields are
> valid and which are not. AFAICT you're proposing that this should be
> done out-of-band (i.e., by the system administrator manually ensuring
> BPF program config fits system config)? I think there are a couple of
> problems with this:
>=20
> - It requires the system admin to coordinate device config with all of
>   their installed XDP applications. This is error-prone, especially as
>   the number of applications grows (say if different containers have
>   different XDP programs installed on their virtual devices).
>=20
> - It has synchronisation issues. Say I have an XDP program with optional
>   support for hardware timestamps and a software fallback. It gets
>   installed in software fallback mode; then the admin has to make sure
>   to enable the hardware timestamps before switching the application
>   into the mode where it will read that metadata field (and the opposite
>   order when disabling the hardware mode).

IMHO this synchronization issue is problematic.  E.g. when turning off
HW-timestamping, userspace BPF-application have to be quick, as it need
to disable BPF-prog global-variable BEFORE hardware stops setting
HW-TS, else BPF-prog will think HW-TS is on and read garbage. (There is
a similar issue for in-flight packets when turning this on).

Today enable/disable of HW-TS happens via a socket API. Do you imagine
the BPF-prog need to catch these events (turning HW-TS off) and then
update the BPF-prog global-variable?
=20
> Also, we need to be able to deal with different metadata layouts on
> different packets in the same program. Consider the XDP program
> running on a veth device inside a container above: if this gets
> packets redirected into it from different NICs with different
> layouts, it needs to be able to figure out which packet came from
> where.
>=20
> With this in mind I think we have to encode the metadata format into
> the packet metadata itself somehow. This could just be a matter of
> including the BTF ID as part of the struct itself, so that your
> example could essentially do:
>=20
>   if (data->meta_btf_id =3D=3D timestamp_id) {
>     struct timestamp_meta *meta =3D data->meta_data;
>     // do stuff
>   } else {
>     struct normal_meta *meta =3D data->meta_data;
>   }
>=20
>=20
> and then, to avoid drivers having to define different layouts we could
> essentially have the two metadata structs be:
>=20
>  struct normal_meta {
>   u32 rxhash;
>   u32 padding;
>   u8 vlan;
>  };
>=20
> and
>=20
>  struct timestamp_meta {
>    u32 rxhash;
>    u32 timestamp;
>    u8 vlan;
>  };

This aligns well with my above suggestion to name a member differently
like "padding" in above.

Another way to "remove" members is the change the metadata size.
This way the BPF program cannot access it.  Notice, that is why I had
my timestamp info in the top of the struct in my example.  The driver
code is of-cause simply written such that the offsets are not dynamic (I
hope this is also clear to others, else feel free to poke me to explain
better...).

> This still gets us exponential growth in the number of metadata
> structs, but at least we could create tooling to auto-generate the
> BTF for the variants so the complexity is reduced to just consuming a
> lot of BTF IDs.
>=20
> Alternatively we could have an explicit bitmap of valid fields, like:
>=20
>  struct all_meta {
>    u32 _valid_field_bitmap;
>    u32 rxhash;
>    u32 timestamp;
>    u8 vlan;
>  };
>=20
> and if a program reads all_meta->timestamp CO-RE could transparently
> insert a check of the relevant field in the bitmap first. My immediate
> feeling is that this last solution would be nicer: We'd still need to
> include the packet BTF ID in the packet data to deal with case where
> packets are coming from different interfaces, but we'd avoid having
> lots of different variants with separate BTF IDs. I'm not sure what
> it would take to teach CO-RE to support such a scheme, though...
>=20
> WDYT?

Keeping above intact, as I (also) want to hear what John thinks.

--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

