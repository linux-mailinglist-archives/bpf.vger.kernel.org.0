Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F163B2EDB
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 14:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFXMZ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 08:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32362 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229573AbhFXMZ1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 08:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624537388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bk5gTGN46GI98trCYcbMSxKLrEsnWSHlsMzFzO5YGXA=;
        b=SIUeJb8ZKtu6zj8r/7Gi20qUr54c4DXl1JFApjBcyP7j49A2o9A1RCxNlV9tn/6ZRmhFWi
        xYZDu6utRTeEJCm+p+IuQVoy2Q0tz2+9s4CtfEHIuwf0v7p6leBVN9KZ7dHu/fogEXR5Kt
        FRRCQF6x2pPY6lWemMPP35SByrfBljs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-NGsYeBCcOkCHT4bd9bzR9w-1; Thu, 24 Jun 2021 08:23:06 -0400
X-MC-Unique: NGsYeBCcOkCHT4bd9bzR9w-1
Received: by mail-ed1-f72.google.com with SMTP id r15-20020aa7da0f0000b02903946a530334so3230472eds.22
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 05:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bk5gTGN46GI98trCYcbMSxKLrEsnWSHlsMzFzO5YGXA=;
        b=UA2TnrEnzK+FdfiFIdfAx7EKHNmarr6/mzGAhTOX2PRcZ8DXJ8KRlD5mVOpovZrMrC
         WDnSYzVIoUMY5aK1PImOq9Jt9JER7KgWLgdHJTEegjzVVkYcaN7h7Qx5fZtvIr3oc+rC
         EGV1935W18RnjsyNLclVszENyGkeZiwhnKa2fOaALMmaD68JfcrFLcowBYFpOGUS6+02
         Xmx1m6swTI3T4BrDA5tokNDdfybxcAo06sZUqs2JxbUZ0iidTU4gu5HiphtllGJkCBWd
         BwsuzNEhjppzLKCSho9j5HUdknF9Z0kPOD/BydFX1sOYh8SzboXINHgBtLT44koHTjKs
         ZFFg==
X-Gm-Message-State: AOAM530of8Fal70zdpjYUt31MvBHnG3FpnQ/GKiU2lErmIe79/YISt9n
        h12xPwZ/aGI5Dx4IMU5pR1nIKCC31viJXjiHjFbdg72yoFQQ+nBUDpptJcmonHHEwmwnFspHVD2
        INldcSexARZg3
X-Received: by 2002:a17:906:58d4:: with SMTP id e20mr5052977ejs.461.1624537385423;
        Thu, 24 Jun 2021 05:23:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz08jEssUwwbwFCiDH9FO1gAKK9tAfx+k53Sum6xG28XdcFvOaIUQ/u4XDSgbFIiU+2m/sScA==
X-Received: by 2002:a17:906:58d4:: with SMTP id e20mr5052930ejs.461.1624537385017;
        Thu, 24 Jun 2021 05:23:05 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w2sm1131378ejn.118.2021.06.24.05.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 05:23:04 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3D8A2180731; Thu, 24 Jun 2021 14:23:02 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
In-Reply-To: <YNLxtsasQSv+YR1w@localhost.localdomain>
References: <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
 <87fsy7gqv7.fsf@toke.dk>
 <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
 <20210528180214.3b427837@carbon>
 <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
 <8735u3dv2l.fsf@toke.dk>
 <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
 <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YNGU4GhL8fZ0ErzS@localhost.localdomain> <874kdqqfnm.fsf@toke.dk>
 <YNLxtsasQSv+YR1w@localhost.localdomain>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 24 Jun 2021 14:23:02 +0200
Message-ID: <87mtrfmoyh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:

> On Tue, Jun 22, 2021 at 01:53:33PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:
>>=20
>> > On Wed, Jun 02, 2021 at 09:18:37AM -0700, Jakub Kicinski wrote:
>> >> On Tue, 01 Jun 2021 17:22:51 -0700 John Fastabend wrote:
>> >> > > If we do this, the BPF program obviously needs to know which fiel=
ds are
>> >> > > valid and which are not. AFAICT you're proposing that this should=
 be
>> >> > > done out-of-band (i.e., by the system administrator manually ensu=
ring
>> >> > > BPF program config fits system config)? I think there are a coupl=
e of
>> >> > > problems with this:
>> >> > >=20
>> >> > > - It requires the system admin to coordinate device config with a=
ll of
>> >> > >   their installed XDP applications. This is error-prone, especial=
ly as
>> >> > >   the number of applications grows (say if different containers h=
ave
>> >> > >   different XDP programs installed on their virtual devices).=20=
=20
>> >> >=20
>> >> > A complete "system" will need to be choerent. If I forward into a v=
eth
>> >> > device the orchestration component needs to ensure program sending
>> >> > bits there is using the same format the program installed there exp=
ects.
>> >> >=20
>> >> > If I tailcall/fentry into another program that program the callee a=
nd
>> >> > caller need to agree on the metadata protocol.
>> >> >=20
>> >> > I don't see any way around this. Someone has to manage the network.
>> >>=20
>> >> FWIW I'd like to +1 Toke's concerns.
>> >>=20
>> >> In large deployments there won't be a single arbiter. Saying there=20
>> >> is seems to contradict BPF maintainers' previous stand which lead=20
>> >> to addition of bpf_links for XDP.
>> >>=20
>> >> In practical terms person rolling out an NTP config change may not=20
>> >> be aware that in some part of the network some BPF program expects
>> >> descriptor not to contain time stamps. Besides features may depend=20
>> >> or conflict so the effects of feature changes may not be obvious=20
>> >> across multiple drivers in a heterogeneous environment.
>> >>=20
>> >> IMO guarding from obvious mis-configuration provides obvious value.
>> >
>> > Hi,
>> >
>> > Thanks for a lot of usefull information about CO-RE. I have read
>> > recommended articles, but still don't understand everything, so sorry =
if
>> > my questions are silly.
>> >
>> > As introduction, I wrote small XDP example using CO-RE (autogenerated
>> > vmlinux.h and getting rid of skeleton etc.) based on runqslower
>> > implementation. Offset reallocation of hints works great, I built CO-RE
>> > application, added new field to hints struct, changed struct layout and
>> > without rebuilding application everything still works fine. Is it worth
>> > to add XDP sample using CO-RE in kernel or this isn't good place for
>> > this kind of sample?
>> >
>> > First question not stricte related to hints. How to get rid of #define
>> > and macro when I am using generated vmlinux.h? For example I wanted to
>> > use htons macro and ethtype definition. They are located in headers th=
at
>> > also contains few struct definition. Because of that I have redefiniti=
on
>> > error when I am trying to include them (redefinition in vmlinux.h and
>> > this included file). What can I do with this besides coping definitions
>> > to bpf code?
>>=20
>> One way is to only include the structs you actually need from vmlinux.h.
>> You can even prune struct members, since CO-RE works just fine with
>> partial struct definitions as long as the member names match.
>>=20
>> Jesper has an example on how to handle this here:
>> https://github.com/netoptimizer/bpf-examples/blob/ktrace01-CO-RE.public/=
headers/vmlinux_local.h
>>=20
>
> I see, thanks, I will take a look at other examples.
>
>> > I defined hints struct in driver code, is it right place for that? All
>> > vendors will define their own hints struct or the idea is to have one
>> > big hints struct with flags informing about availability of each field=
s?
>> >
>> > For me defining it in driver code was easier because I can have used
>> > module btf to generate vmlinux.h with hints struct inside. However this
>> > break portability if other vendors will have different struct name etc,
>> > am I right?
>>=20
>> I would expect the easiest is for drivers to just define their own
>> structs and maybe have some infrastructure in the core to let userspace
>> discover the right BTF IDs to use for a particular netdev. However, as
>> you say it's not going to work if every driver just invents their own
>> field names, so we'll need to coordinate somehow. We could do this by
>> convention, though, it'll need manual intervention to make sure the
>> semantics of identically-named fields match anyway.
>>=20
>> Cf the earlier discussion with how many BTF IDs each driver might
>> define, I think we *also* need a way to have flags that specify which
>> fields of a given BTF ID are currently used; and having some common
>> infrastructure for that would be good...
>>=20
>
> Sounds good.=20
>
> Sorry, but I feel that I don't fully understand the idea. Correct me if
> I am wrong:
>
> In building CO-RE application step we can defined big struct with
> all possible fields or even empty struct (?) and use
> bpf_core_field_exists.=20
>
> bpf_core_field_exists will be resolve before loading program by libbpf
> code. In normal case libbpf will look for btf with hints name in vmlinux
> of running kernel and do offset rewrite and exsistence check. But as the
> same hints struct will be define in multiple modules we want to add more
> logic to libbpf to discover correct BTF ID based on netdev on which progr=
am
> will be loaded?

I would expect that the program would decide ahead-of-time which BTF IDs
it supports, by something like including the relevant structs from
vmlinux.h. And then we need the BTF ID encoded into the packet metadata
as well, so that it is possible to check at run-time which driver the
packet came from (since a packet can be redirected, so you may end up
having to deal with multiple formats in the same XDP program).

Which would allow you to write code like:

if (ctx->has_driver_meta) {
  /* this should be at a well-known position, like first (or last) in meta =
area */
  __u32 *meta_btf_id =3D ctx->data_meta;
=20=20
  if (*meta_btf_id =3D=3D BTF_ID_MLX5) {
    struct meta_mlx5 *meta =3D ctx->data_meta;
    /* do something with meta */
  } else if (meta_btf_id =3D=3D BTF_ID_I40E) {
    struct meta_i40e *meta =3D ctx->data_meta;
    /* do something with meta */
  } /* etc */
}

and libbpf could do relocations based on the different meta structs,
even removing the code for the ones that don't exist on the running
kernel.

-Toke

