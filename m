Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278143B3253
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 17:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFXPOJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 11:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhFXPOI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Jun 2021 11:14:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C30C061574
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 08:11:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id s15so8990255edt.13
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X+wkXAtQsHBDfmIg3aI8RsYXOMVy1xyy8S060DX48fE=;
        b=bnhFKcE/P7kpfoF4Kp+Em/I4Pw3NexpZ9kBgeHx4yjPTOOokO4k4lZvIDxHFO8ieXG
         sJLidrIZeQVzDb+B6h4hgIYvsl6RfkSftYDmyvQPgvG0jTluqX532/+3COEU7yOcW8X+
         02EimPO9o+GUYOxZQr4AC2nQ96695JfgAGgB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X+wkXAtQsHBDfmIg3aI8RsYXOMVy1xyy8S060DX48fE=;
        b=c0cvJCXzI3OpNmotD1EfS7Ehj9yCzXIUXZKwLCRU4OAAC35of4reOhgAt67NyDBkMK
         8ez4R5HB/i5OT1UQbAe6FFRdLom/DEMvFKC0WexgreR2PD1fNcdZnk+xJokj6Saf+crq
         KgM1FM2kb9RGWOJK6XMarf5wi3khledMSir+zlLDQ/s4bdyg5BnwJNPKj0LQuz6CJsQi
         ycu865PhD3HDlMuYK9eFGsuTp6O8ZD1F6lRE0AMajjU49wl1yEzF1P7peh0ufrh9g/3T
         /HrX5LOk6h7kys1M483smzp6dcDMShbpd3dQ9z9u2/RXtJWonGs4eRUsK4M1yrgTWAah
         eL4Q==
X-Gm-Message-State: AOAM530EyaKwo0f34b3cqDjzaGS56C/5Lt2WBvUzLgaOT+317uxFH6ai
        9kAA9nVOTbv3LXf674paZu3YgVOcV8cSH4iizIxbYw==
X-Google-Smtp-Source: ABdhPJzQDEAm49zw6ly/j6RU+yQoY9xI0T1eVqcuugJGikXmE8gEzYFR2H2U5+K+0WZmOI3yp1+zdQR6V7AjHx2UDvo=
X-Received: by 2002:aa7:cc87:: with SMTP id p7mr7810336edt.82.1624547507645;
 Thu, 24 Jun 2021 08:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
 <87fsy7gqv7.fsf@toke.dk> <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
 <20210528180214.3b427837@carbon> <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
 <8735u3dv2l.fsf@toke.dk> <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
 <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YNGU4GhL8fZ0ErzS@localhost.localdomain> <874kdqqfnm.fsf@toke.dk>
 <YNLxtsasQSv+YR1w@localhost.localdomain> <87mtrfmoyh.fsf@toke.dk>
In-Reply-To: <87mtrfmoyh.fsf@toke.dk>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Thu, 24 Jun 2021 08:11:36 -0700
Message-ID: <CAC1LvL0i6mY2pAuNriwA_CWmxpO=VHoRHGfMK6ovp3LUt43g1g@mail.gmail.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 24, 2021 at 5:23 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:
>
> > On Tue, Jun 22, 2021 at 01:53:33PM +0200, Toke H=C3=B8iland-J=C3=B8rgen=
sen wrote:
> >> Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:
> >>
> >> > On Wed, Jun 02, 2021 at 09:18:37AM -0700, Jakub Kicinski wrote:
> >> >> On Tue, 01 Jun 2021 17:22:51 -0700 John Fastabend wrote:
> >> >> > > If we do this, the BPF program obviously needs to know which fi=
elds are
> >> >> > > valid and which are not. AFAICT you're proposing that this shou=
ld be
> >> >> > > done out-of-band (i.e., by the system administrator manually en=
suring
> >> >> > > BPF program config fits system config)? I think there are a cou=
ple of
> >> >> > > problems with this:
> >> >> > >
> >> >> > > - It requires the system admin to coordinate device config with=
 all of
> >> >> > >   their installed XDP applications. This is error-prone, especi=
ally as
> >> >> > >   the number of applications grows (say if different containers=
 have
> >> >> > >   different XDP programs installed on their virtual devices).
> >> >> >
> >> >> > A complete "system" will need to be choerent. If I forward into a=
 veth
> >> >> > device the orchestration component needs to ensure program sendin=
g
> >> >> > bits there is using the same format the program installed there e=
xpects.
> >> >> >
> >> >> > If I tailcall/fentry into another program that program the callee=
 and
> >> >> > caller need to agree on the metadata protocol.
> >> >> >
> >> >> > I don't see any way around this. Someone has to manage the networ=
k.
> >> >>
> >> >> FWIW I'd like to +1 Toke's concerns.
> >> >>
> >> >> In large deployments there won't be a single arbiter. Saying there
> >> >> is seems to contradict BPF maintainers' previous stand which lead
> >> >> to addition of bpf_links for XDP.
> >> >>
> >> >> In practical terms person rolling out an NTP config change may not
> >> >> be aware that in some part of the network some BPF program expects
> >> >> descriptor not to contain time stamps. Besides features may depend
> >> >> or conflict so the effects of feature changes may not be obvious
> >> >> across multiple drivers in a heterogeneous environment.
> >> >>
> >> >> IMO guarding from obvious mis-configuration provides obvious value.
> >> >
> >> > Hi,
> >> >
> >> > Thanks for a lot of usefull information about CO-RE. I have read
> >> > recommended articles, but still don't understand everything, so sorr=
y if
> >> > my questions are silly.
> >> >
> >> > As introduction, I wrote small XDP example using CO-RE (autogenerate=
d
> >> > vmlinux.h and getting rid of skeleton etc.) based on runqslower
> >> > implementation. Offset reallocation of hints works great, I built CO=
-RE
> >> > application, added new field to hints struct, changed struct layout =
and
> >> > without rebuilding application everything still works fine. Is it wo=
rth
> >> > to add XDP sample using CO-RE in kernel or this isn't good place for
> >> > this kind of sample?
> >> >
> >> > First question not stricte related to hints. How to get rid of #defi=
ne
> >> > and macro when I am using generated vmlinux.h? For example I wanted =
to
> >> > use htons macro and ethtype definition. They are located in headers =
that
> >> > also contains few struct definition. Because of that I have redefini=
tion
> >> > error when I am trying to include them (redefinition in vmlinux.h an=
d
> >> > this included file). What can I do with this besides coping definiti=
ons
> >> > to bpf code?
> >>
> >> One way is to only include the structs you actually need from vmlinux.=
h.
> >> You can even prune struct members, since CO-RE works just fine with
> >> partial struct definitions as long as the member names match.
> >>
> >> Jesper has an example on how to handle this here:
> >> https://github.com/netoptimizer/bpf-examples/blob/ktrace01-CO-RE.publi=
c/headers/vmlinux_local.h
> >>
> >
> > I see, thanks, I will take a look at other examples.
> >
> >> > I defined hints struct in driver code, is it right place for that? A=
ll
> >> > vendors will define their own hints struct or the idea is to have on=
e
> >> > big hints struct with flags informing about availability of each fie=
lds?
> >> >
> >> > For me defining it in driver code was easier because I can have used
> >> > module btf to generate vmlinux.h with hints struct inside. However t=
his
> >> > break portability if other vendors will have different struct name e=
tc,
> >> > am I right?
> >>
> >> I would expect the easiest is for drivers to just define their own
> >> structs and maybe have some infrastructure in the core to let userspac=
e
> >> discover the right BTF IDs to use for a particular netdev. However, as
> >> you say it's not going to work if every driver just invents their own
> >> field names, so we'll need to coordinate somehow. We could do this by
> >> convention, though, it'll need manual intervention to make sure the
> >> semantics of identically-named fields match anyway.
> >>
> >> Cf the earlier discussion with how many BTF IDs each driver might
> >> define, I think we *also* need a way to have flags that specify which
> >> fields of a given BTF ID are currently used; and having some common
> >> infrastructure for that would be good...
> >>
> >
> > Sounds good.
> >
> > Sorry, but I feel that I don't fully understand the idea. Correct me if
> > I am wrong:
> >
> > In building CO-RE application step we can defined big struct with
> > all possible fields or even empty struct (?) and use
> > bpf_core_field_exists.
> >
> > bpf_core_field_exists will be resolve before loading program by libbpf
> > code. In normal case libbpf will look for btf with hints name in vmlinu=
x
> > of running kernel and do offset rewrite and exsistence check. But as th=
e
> > same hints struct will be define in multiple modules we want to add mor=
e
> > logic to libbpf to discover correct BTF ID based on netdev on which pro=
gram
> > will be loaded?
>
> I would expect that the program would decide ahead-of-time which BTF IDs
> it supports, by something like including the relevant structs from
> vmlinux.h. And then we need the BTF ID encoded into the packet metadata
> as well, so that it is possible to check at run-time which driver the
> packet came from (since a packet can be redirected, so you may end up
> having to deal with multiple formats in the same XDP program).
>
> Which would allow you to write code like:
>
> if (ctx->has_driver_meta) {
>   /* this should be at a well-known position, like first (or last) in met=
a area */
>   __u32 *meta_btf_id =3D ctx->data_meta;
>
>   if (*meta_btf_id =3D=3D BTF_ID_MLX5) {
>     struct meta_mlx5 *meta =3D ctx->data_meta;
>     /* do something with meta */
>   } else if (meta_btf_id =3D=3D BTF_ID_I40E) {
>     struct meta_i40e *meta =3D ctx->data_meta;
>     /* do something with meta */
>   } /* etc */
> }
>
> and libbpf could do relocations based on the different meta structs,
> even removing the code for the ones that don't exist on the running
> kernel.
>
> -Toke
>

How does putting the BTF ID and the driver metadata into the XDP metadata
section interact with programs that are already using the metadata section
for other purposes. For example, programs that use the XDP metadata to pass
information through BPF tail calls?

Would this break existing programs that aren't aware of the new driver
metadata? Do we need to make driver metadata opt-in at XDP program load?

--Zvi
