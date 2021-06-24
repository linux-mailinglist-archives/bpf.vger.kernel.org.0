Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8723B2FC5
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 15:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhFXNK3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 09:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFXNK3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Jun 2021 09:10:29 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A3C061574
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 06:08:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s14so3849569pfg.0
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=se+PGkzeNyn7tbhEGqFcJ1oNABKdMvCZshRc4NKF6Mw=;
        b=C2Vht/YSp+Z+8Gkdpr+zBqld8wbTjuU+PuizstetYcBbGqePcnE0XoE5JEg6OF+dH8
         H7I95tL0Zy+U/UvbTZczB+VL6AUUVVLcDfFbg7wEtlMTCMrdwLYzsvfpABlfiK7mI10l
         x29p062tD4EuI5uBNzK9fcWFJs2Eb/KJTvNeRMaArQwBD9RmZ4f7WfGPbubKsHd9LPDf
         BKurcR4Nsre6VI1DmRuUe+ScKutEZXU5zBuws2r2gVJcikrVcR+CSoQ1mjeRv+sY9lfo
         TBeZzY7/nhO+7SpvpinPj6NoOx0/d+2kgzlhBYVfJtwhXsgcTdAakmfiw+RpK5YXQFHI
         rsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=se+PGkzeNyn7tbhEGqFcJ1oNABKdMvCZshRc4NKF6Mw=;
        b=peNRcid3cQj7LBcqYE1Qgibh9//91MATX5DaHKxnNxTRtVd6YZ+4fYNmozdzu4+zLp
         zFRqdCATJTJfXeh1NDhZ8PYDzP1kHMpBW2NpCQBVU465ujuIxFqaRSfg1iwc04VO4/8j
         Q3ys1eHjHfZAhGt+a8cAGMF9hpR3O3i4gSkLuevDevV8OPrzNHCvrGoW9PLOLbFwTN5n
         FnLiVJ+0RqGdchs/JbIDMJN2MpnYNORa4xsvMPaVyk51xWOabsAt5priYPpYk9JYSpiD
         LB/95KwOHPipqxOSgb9LCf2w6EmbMXlvItaklYQ0i2cDDUgUXlHH/oPFGSsl3mAQ5ONN
         +uvg==
X-Gm-Message-State: AOAM531s5RreQ4gqcPnNzUirn/ya614uOrX9fTtRIeSdGwzkry1EdsyH
        ZRKqdl4x5EIOE2+ec18wRVBhDDJ0Xl1ga07EVyY=
X-Google-Smtp-Source: ABdhPJzihQRhs7Enr4iQR3w1LBYgfYXXXCgCdMuKC+OQ/ftNc0qjhUy+CaQ4ldsVxbXdpxxx4UDqlaPXVSSXEsoWSmY=
X-Received: by 2002:aa7:824a:0:b029:2ec:89ee:e798 with SMTP id
 e10-20020aa7824a0000b02902ec89eee798mr5123775pfn.12.1624540089532; Thu, 24
 Jun 2021 06:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
 <87fsy7gqv7.fsf@toke.dk> <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
 <20210528180214.3b427837@carbon> <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
 <8735u3dv2l.fsf@toke.dk> <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
 <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YNGU4GhL8fZ0ErzS@localhost.localdomain> <874kdqqfnm.fsf@toke.dk>
 <YNLxtsasQSv+YR1w@localhost.localdomain> <87mtrfmoyh.fsf@toke.dk>
In-Reply-To: <87mtrfmoyh.fsf@toke.dk>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Thu, 24 Jun 2021 15:07:58 +0200
Message-ID: <CAJ8uoz2jgEJUb7Yj25HUrVX66PDde2o74GHsq21SdUtQESRkPw@mail.gmail.com>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 24, 2021 at 2:23 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
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

Just wondering how this will carry over to user-space and AF_XDP since
it sees the same metadata area as XDP? AFAIK, dynamic linkers today
cannot relocate structs or remove members, but I am not up-to-date
with the latest here so might be completely wrong. And it would be
good not to have to recompile a user-space binary just because a new
NIC came out with a new BTF ID and layout, but with the same metadata
member name and format as previous NICs/BTF IDs. But I do not know how
to solve these things in user-space at the moment (except to have
fixed locations for a common set of metadata, but that is what we are
trying to avoid), so any hints and suggestions are highly appreciated.

> -Toke
>
