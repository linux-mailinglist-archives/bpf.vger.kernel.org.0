Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8C53B3425
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 18:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhFXQse (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 12:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229721AbhFXQsd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 12:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624553174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RfJmb6yjUV7FBUewM8InD9bxO6DEu+4ds7nCwNanAIo=;
        b=er80rdHb2X8ivW2lgQSQfnBURdv6GfsM4/27RAwD2c3rJjTQMITI9fCTvgIFz8LGwid1Vk
        /3c1t2eC4irlr0M113BIB0DikX/SgUarVVHjKEmhHvEz8f7ombIEPMGUb0OXOlY+w9JCHY
        yA1l+jiTFHxwHbgy1rBgcqaFKPqY1e8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-T8YtXgwWPwOc8R5j52E-_Q-1; Thu, 24 Jun 2021 12:46:12 -0400
X-MC-Unique: T8YtXgwWPwOc8R5j52E-_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DE9C800D62;
        Thu, 24 Jun 2021 16:46:11 +0000 (UTC)
Received: from carbon (unknown [10.36.110.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D43160871;
        Thu, 24 Jun 2021 16:46:01 +0000 (UTC)
Date:   Thu, 24 Jun 2021 18:45:58 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc:     Zvi Effron <zeffron@riotgames.com>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net,
        brouer@redhat.com
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
Message-ID: <20210624184558.041e06b3@carbon>
In-Reply-To: <878s2zmeov.fsf@toke.dk>
References: <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
        <87fsy7gqv7.fsf@toke.dk>
        <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
        <20210528180214.3b427837@carbon>
        <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
        <8735u3dv2l.fsf@toke.dk>
        <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
        <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <YNGU4GhL8fZ0ErzS@localhost.localdomain>
        <874kdqqfnm.fsf@toke.dk>
        <YNLxtsasQSv+YR1w@localhost.localdomain>
        <87mtrfmoyh.fsf@toke.dk>
        <CAC1LvL0i6mY2pAuNriwA_CWmxpO=VHoRHGfMK6ovp3LUt43g1g@mail.gmail.com>
        <878s2zmeov.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 24 Jun 2021 18:04:48 +0200
Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:

> Zvi Effron via xdp-hints <xdp-hints@xdp-project.net> writes:
>=20
> > On Thu, Jun 24, 2021 at 5:23 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote: =20
> >>
> >> Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:
> >> =20
> >> > On Tue, Jun 22, 2021 at 01:53:33PM +0200, Toke H=C3=B8iland-J=C3=B8r=
gensen wrote: =20
> >> >> Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:
> >> >> =20
> >> >> > On Wed, Jun 02, 2021 at 09:18:37AM -0700, Jakub Kicinski wrote: =
=20
> >> >> >> On Tue, 01 Jun 2021 17:22:51 -0700 John Fastabend wrote: =20
> >> >> >> > > If we do this, the BPF program obviously needs to know which=
 fields are
> >> >> >> > > valid and which are not. AFAICT you're proposing that this s=
hould be
> >> >> >> > > done out-of-band (i.e., by the system administrator manually=
 ensuring
> >> >> >> > > BPF program config fits system config)? I think there are a =
couple of
> >> >> >> > > problems with this:
> >> >> >> > >
> >> >> >> > > - It requires the system admin to coordinate device config w=
ith all of
> >> >> >> > >   their installed XDP applications. This is error-prone, esp=
ecially as
> >> >> >> > >   the number of applications grows (say if different contain=
ers have
> >> >> >> > >   different XDP programs installed on their virtual devices)=
. =20
> >> >> >> >
> >> >> >> > A complete "system" will need to be choerent. If I forward int=
o a veth
> >> >> >> > device the orchestration component needs to ensure program sen=
ding
> >> >> >> > bits there is using the same format the program installed ther=
e expects.
> >> >> >> >
> >> >> >> > If I tailcall/fentry into another program that program the cal=
lee and
> >> >> >> > caller need to agree on the metadata protocol.
> >> >> >> >
> >> >> >> > I don't see any way around this. Someone has to manage the net=
work. =20
> >> >> >>
> >> >> >> FWIW I'd like to +1 Toke's concerns.
> >> >> >>
> >> >> >> In large deployments there won't be a single arbiter. Saying the=
re
> >> >> >> is seems to contradict BPF maintainers' previous stand which lead
> >> >> >> to addition of bpf_links for XDP.
> >> >> >>
> >> >> >> In practical terms person rolling out an NTP config change may n=
ot
> >> >> >> be aware that in some part of the network some BPF program expec=
ts
> >> >> >> descriptor not to contain time stamps. Besides features may depe=
nd
> >> >> >> or conflict so the effects of feature changes may not be obvious
> >> >> >> across multiple drivers in a heterogeneous environment.
> >> >> >>
> >> >> >> IMO guarding from obvious mis-configuration provides obvious val=
ue. =20
> >> >> >
> >> >> > Hi,
> >> >> >
> >> >> > Thanks for a lot of usefull information about CO-RE. I have read
> >> >> > recommended articles, but still don't understand everything, so s=
orry if
> >> >> > my questions are silly.
> >> >> >
> >> >> > As introduction, I wrote small XDP example using CO-RE (autogener=
ated
> >> >> > vmlinux.h and getting rid of skeleton etc.) based on runqslower
> >> >> > implementation. Offset reallocation of hints works great, I built=
 CO-RE
> >> >> > application, added new field to hints struct, changed struct layo=
ut and
> >> >> > without rebuilding application everything still works fine. Is it=
 worth
> >> >> > to add XDP sample using CO-RE in kernel or this isn't good place =
for
> >> >> > this kind of sample?
> >> >> >
> >> >> > First question not stricte related to hints. How to get rid of #d=
efine
> >> >> > and macro when I am using generated vmlinux.h? For example I want=
ed to
> >> >> > use htons macro and ethtype definition. They are located in heade=
rs that
> >> >> > also contains few struct definition. Because of that I have redef=
inition
> >> >> > error when I am trying to include them (redefinition in vmlinux.h=
 and
> >> >> > this included file). What can I do with this besides coping defin=
itions
> >> >> > to bpf code? =20
> >> >>
> >> >> One way is to only include the structs you actually need from vmlin=
ux.h.
> >> >> You can even prune struct members, since CO-RE works just fine with
> >> >> partial struct definitions as long as the member names match.
> >> >>
> >> >> Jesper has an example on how to handle this here:
> >> >> https://github.com/netoptimizer/bpf-examples/blob/ktrace01-CO-RE.pu=
blic/headers/vmlinux_local.h

Above links to my experimental "learning-by-doing" branch.  I've
created a PR to merge this officially here:
 https://github.com/xdp-project/bpf-examples/pull/24/

> >> >
> >> > I see, thanks, I will take a look at other examples.
> >> > =20
> >> >> > I defined hints struct in driver code, is it right place for that=
? All
> >> >> > vendors will define their own hints struct or the idea is to have=
 one
> >> >> > big hints struct with flags informing about availability of each =
fields?
> >> >> >
> >> >> > For me defining it in driver code was easier because I can have u=
sed
> >> >> > module btf to generate vmlinux.h with hints struct inside. Howeve=
r this
> >> >> > break portability if other vendors will have different struct nam=
e etc,
> >> >> > am I right? =20
> >> >>
> >> >> I would expect the easiest is for drivers to just define their own
> >> >> structs and maybe have some infrastructure in the core to let users=
pace
> >> >> discover the right BTF IDs to use for a particular netdev. However,=
 as
> >> >> you say it's not going to work if every driver just invents their o=
wn
> >> >> field names, so we'll need to coordinate somehow. We could do this =
by
> >> >> convention, though, it'll need manual intervention to make sure the
> >> >> semantics of identically-named fields match anyway.
> >> >>
> >> >> Cf the earlier discussion with how many BTF IDs each driver might
> >> >> define, I think we *also* need a way to have flags that specify whi=
ch
> >> >> fields of a given BTF ID are currently used; and having some common
> >> >> infrastructure for that would be good...
> >> >> =20
> >> >
> >> > Sounds good.
> >> >
> >> > Sorry, but I feel that I don't fully understand the idea. Correct me=
 if
> >> > I am wrong:
> >> >
> >> > In building CO-RE application step we can defined big struct with
> >> > all possible fields or even empty struct (?) and use
> >> > bpf_core_field_exists.
> >> >
> >> > bpf_core_field_exists will be resolve before loading program by libb=
pf
> >> > code. In normal case libbpf will look for btf with hints name in vml=
inux
> >> > of running kernel and do offset rewrite and exsistence check. But as=
 the
> >> > same hints struct will be define in multiple modules we want to add =
more
> >> > logic to libbpf to discover correct BTF ID based on netdev on which =
program
> >> > will be loaded? =20
> >>
> >> I would expect that the program would decide ahead-of-time which BTF I=
Ds
> >> it supports, by something like including the relevant structs from
> >> vmlinux.h. And then we need the BTF ID encoded into the packet metadata
> >> as well, so that it is possible to check at run-time which driver the
> >> packet came from (since a packet can be redirected, so you may end up
> >> having to deal with multiple formats in the same XDP program).
> >>
> >> Which would allow you to write code like:
> >>
> >> if (ctx->has_driver_meta) {
> >>   /* this should be at a well-known position, like first (or last) in =
meta area */
> >>   __u32 *meta_btf_id =3D ctx->data_meta;
> >>
> >>   if (*meta_btf_id =3D=3D BTF_ID_MLX5) {
> >>     struct meta_mlx5 *meta =3D ctx->data_meta;
> >>     /* do something with meta */
> >>   } else if (meta_btf_id =3D=3D BTF_ID_I40E) {
> >>     struct meta_i40e *meta =3D ctx->data_meta;
> >>     /* do something with meta */
> >>   } /* etc */
> >> }
> >>
> >> and libbpf could do relocations based on the different meta structs,
> >> even removing the code for the ones that don't exist on the running
> >> kernel.
> >>
> >> -Toke
> >> =20
> >
> > How does putting the BTF ID and the driver metadata into the XDP metada=
ta
> > section interact with programs that are already using the metadata sect=
ion
> > for other purposes. For example, programs that use the XDP metadata to =
pass
> > information through BPF tail calls?
> >
> > Would this break existing programs that aren't aware of the new driver
> > metadata? Do we need to make driver metadata opt-in at XDP program
> > load? =20
>=20
> Well, XDP applications would be free to just ignore the driver-provided
> metadata and overwrite it with its own data? And I guess any application
> that doesn't know about it will just implicitly do that? :)

Remember to wrap your head around: That metadata area "grows" via minus
offset as ctx->data_meta points to area before ctx->data. See[1] where
bpf_xdp_adjust_meta() helper does a minus adjustment.

[1] https://github.com/torvalds/linux/blob/v5.13-rc7/samples/bpf/xdp2skb_me=
ta_kern.c#L41

Thus, AFAIK if the driver already added some metadata before your
XDP-prog, then this call[1] will just move ctx->data_meta some-more to
make room for *your* metadata (and driver metadata will be "after").
When using this metadata area, e.g.[2] then it will point to the
metadata you added.

[2] https://github.com/torvalds/linux/blob/v5.13-rc7/samples/bpf/xdp2skb_me=
ta_kern.c#L78

Notice, this is also the reason, we (Bj=C3=B8rn, Magnus + I) suggested that
the btf_id (for AF_XDP use-case) should be placed as the "last" element
in the metadata struct, as it will be located at (ctx->data - 4 bytes).

--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

