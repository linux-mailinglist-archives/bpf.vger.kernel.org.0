Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70CC3B336C
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 18:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhFXQHP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 12:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229464AbhFXQHP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 12:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624550695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gmfoWcZwTaeCUKyxu2GkJJmWB1vAe4vpCSHCNlvY+ug=;
        b=Gz0swRkNbzM/jhuYzJO/aS3cD207J4Jz41JohlprBmuPbQ5AEO/seAM1FohCET8I1nRBJ/
        kaxHVWmkimMLkD7B2xNV3xxfGmGF46tPuOnUyDbVvrNe8dejTQVDa+zGeOVPHSI1Avgk4z
        vEhcD/+At/+GdwPiLEk3N5famtMAzBo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-IHtTQsuVMryb-tol1NFwpg-1; Thu, 24 Jun 2021 12:04:54 -0400
X-MC-Unique: IHtTQsuVMryb-tol1NFwpg-1
Received: by mail-ej1-f72.google.com with SMTP id de48-20020a1709069bf0b029048ae3ebecabso2164246ejc.16
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 09:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gmfoWcZwTaeCUKyxu2GkJJmWB1vAe4vpCSHCNlvY+ug=;
        b=nhJjuBDdRBsSqeHtvGLJIpks/YdWh7BlTF4pQgEvIooL8Ur3rcA166WzRYe6UBDbe8
         TN+l1lxxp3n3270OQb8YvBU+cit9PJvojmx0L6epdJ85rWlI5e+o3JvXjJJ6eFbf0ZsM
         sg6+Fm9zqqxmDXPnYTZ8HBsQ++7f2aVBNGrXNFkSF/9W/G41c1zpBTjnjjOltRRMbhvW
         VHrXMyO2tJzNW+HjBmp11w2krzfGecrJ2XEWDajeF+gUUJ0L5IlWW2k1jQvR2sf4phdz
         wgG4O0xirB1+C7FFfPiH7SjWJphdfxyOlLZCexSm0Lc7cq1VQB4pBPJ8WMVGJT4cmFKr
         kuqg==
X-Gm-Message-State: AOAM533D6CKsaq7d56xio8o17DGP6f+cDVWogaIbDDhlKbCzCrJ7M9xx
        0tWz3PmumSmfYa0tCa4BsqDRNlG4ia2JahFGg2pRZiiMyxyhjlT1LkCYxFtWjHqEb12ngUzdSG/
        b4TSNIbDbGgMz
X-Received: by 2002:a17:906:4b0a:: with SMTP id y10mr6163725eju.388.1624550693025;
        Thu, 24 Jun 2021 09:04:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6rIEV6VYEmWLNMBGnjJqLbMIgYb9TTU/bDxbNbUZIDQLCTWkipgKEIz6FWayOl5R1RLLH6A==
X-Received: by 2002:a17:906:4b0a:: with SMTP id y10mr6163678eju.388.1624550692571;
        Thu, 24 Jun 2021 09:04:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ce3sm1413692ejc.53.2021.06.24.09.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:04:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4AEC1180731; Thu, 24 Jun 2021 18:04:48 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Zvi Effron <zeffron@riotgames.com>
Cc:     Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        William Tu <u9012063@gmail.com>, xdp-hints@xdp-project.net
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
In-Reply-To: <CAC1LvL0i6mY2pAuNriwA_CWmxpO=VHoRHGfMK6ovp3LUt43g1g@mail.gmail.com>
References: <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
 <87fsy7gqv7.fsf@toke.dk>
 <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
 <20210528180214.3b427837@carbon>
 <60b12897d2e3f_1cf820896@john-XPS-13-9370.notmuch>
 <8735u3dv2l.fsf@toke.dk>
 <60b6cf5b6505e_38d6d208d8@john-XPS-13-9370.notmuch>
 <20210602091837.65ec197a@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YNGU4GhL8fZ0ErzS@localhost.localdomain> <874kdqqfnm.fsf@toke.dk>
 <YNLxtsasQSv+YR1w@localhost.localdomain> <87mtrfmoyh.fsf@toke.dk>
 <CAC1LvL0i6mY2pAuNriwA_CWmxpO=VHoRHGfMK6ovp3LUt43g1g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 24 Jun 2021 18:04:48 +0200
Message-ID: <878s2zmeov.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Zvi Effron via xdp-hints <xdp-hints@xdp-project.net> writes:

> On Thu, Jun 24, 2021 at 5:23 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:
>>
>> > On Tue, Jun 22, 2021 at 01:53:33PM +0200, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> Michal Swiatkowski <michal.swiatkowski@linux.intel.com> writes:
>> >>
>> >> > On Wed, Jun 02, 2021 at 09:18:37AM -0700, Jakub Kicinski wrote:
>> >> >> On Tue, 01 Jun 2021 17:22:51 -0700 John Fastabend wrote:
>> >> >> > > If we do this, the BPF program obviously needs to know which f=
ields are
>> >> >> > > valid and which are not. AFAICT you're proposing that this sho=
uld be
>> >> >> > > done out-of-band (i.e., by the system administrator manually e=
nsuring
>> >> >> > > BPF program config fits system config)? I think there are a co=
uple of
>> >> >> > > problems with this:
>> >> >> > >
>> >> >> > > - It requires the system admin to coordinate device config wit=
h all of
>> >> >> > >   their installed XDP applications. This is error-prone, espec=
ially as
>> >> >> > >   the number of applications grows (say if different container=
s have
>> >> >> > >   different XDP programs installed on their virtual devices).
>> >> >> >
>> >> >> > A complete "system" will need to be choerent. If I forward into =
a veth
>> >> >> > device the orchestration component needs to ensure program sendi=
ng
>> >> >> > bits there is using the same format the program installed there =
expects.
>> >> >> >
>> >> >> > If I tailcall/fentry into another program that program the calle=
e and
>> >> >> > caller need to agree on the metadata protocol.
>> >> >> >
>> >> >> > I don't see any way around this. Someone has to manage the netwo=
rk.
>> >> >>
>> >> >> FWIW I'd like to +1 Toke's concerns.
>> >> >>
>> >> >> In large deployments there won't be a single arbiter. Saying there
>> >> >> is seems to contradict BPF maintainers' previous stand which lead
>> >> >> to addition of bpf_links for XDP.
>> >> >>
>> >> >> In practical terms person rolling out an NTP config change may not
>> >> >> be aware that in some part of the network some BPF program expects
>> >> >> descriptor not to contain time stamps. Besides features may depend
>> >> >> or conflict so the effects of feature changes may not be obvious
>> >> >> across multiple drivers in a heterogeneous environment.
>> >> >>
>> >> >> IMO guarding from obvious mis-configuration provides obvious value.
>> >> >
>> >> > Hi,
>> >> >
>> >> > Thanks for a lot of usefull information about CO-RE. I have read
>> >> > recommended articles, but still don't understand everything, so sor=
ry if
>> >> > my questions are silly.
>> >> >
>> >> > As introduction, I wrote small XDP example using CO-RE (autogenerat=
ed
>> >> > vmlinux.h and getting rid of skeleton etc.) based on runqslower
>> >> > implementation. Offset reallocation of hints works great, I built C=
O-RE
>> >> > application, added new field to hints struct, changed struct layout=
 and
>> >> > without rebuilding application everything still works fine. Is it w=
orth
>> >> > to add XDP sample using CO-RE in kernel or this isn't good place for
>> >> > this kind of sample?
>> >> >
>> >> > First question not stricte related to hints. How to get rid of #def=
ine
>> >> > and macro when I am using generated vmlinux.h? For example I wanted=
 to
>> >> > use htons macro and ethtype definition. They are located in headers=
 that
>> >> > also contains few struct definition. Because of that I have redefin=
ition
>> >> > error when I am trying to include them (redefinition in vmlinux.h a=
nd
>> >> > this included file). What can I do with this besides coping definit=
ions
>> >> > to bpf code?
>> >>
>> >> One way is to only include the structs you actually need from vmlinux=
.h.
>> >> You can even prune struct members, since CO-RE works just fine with
>> >> partial struct definitions as long as the member names match.
>> >>
>> >> Jesper has an example on how to handle this here:
>> >> https://github.com/netoptimizer/bpf-examples/blob/ktrace01-CO-RE.publ=
ic/headers/vmlinux_local.h
>> >>
>> >
>> > I see, thanks, I will take a look at other examples.
>> >
>> >> > I defined hints struct in driver code, is it right place for that? =
All
>> >> > vendors will define their own hints struct or the idea is to have o=
ne
>> >> > big hints struct with flags informing about availability of each fi=
elds?
>> >> >
>> >> > For me defining it in driver code was easier because I can have used
>> >> > module btf to generate vmlinux.h with hints struct inside. However =
this
>> >> > break portability if other vendors will have different struct name =
etc,
>> >> > am I right?
>> >>
>> >> I would expect the easiest is for drivers to just define their own
>> >> structs and maybe have some infrastructure in the core to let userspa=
ce
>> >> discover the right BTF IDs to use for a particular netdev. However, as
>> >> you say it's not going to work if every driver just invents their own
>> >> field names, so we'll need to coordinate somehow. We could do this by
>> >> convention, though, it'll need manual intervention to make sure the
>> >> semantics of identically-named fields match anyway.
>> >>
>> >> Cf the earlier discussion with how many BTF IDs each driver might
>> >> define, I think we *also* need a way to have flags that specify which
>> >> fields of a given BTF ID are currently used; and having some common
>> >> infrastructure for that would be good...
>> >>
>> >
>> > Sounds good.
>> >
>> > Sorry, but I feel that I don't fully understand the idea. Correct me if
>> > I am wrong:
>> >
>> > In building CO-RE application step we can defined big struct with
>> > all possible fields or even empty struct (?) and use
>> > bpf_core_field_exists.
>> >
>> > bpf_core_field_exists will be resolve before loading program by libbpf
>> > code. In normal case libbpf will look for btf with hints name in vmlin=
ux
>> > of running kernel and do offset rewrite and exsistence check. But as t=
he
>> > same hints struct will be define in multiple modules we want to add mo=
re
>> > logic to libbpf to discover correct BTF ID based on netdev on which pr=
ogram
>> > will be loaded?
>>
>> I would expect that the program would decide ahead-of-time which BTF IDs
>> it supports, by something like including the relevant structs from
>> vmlinux.h. And then we need the BTF ID encoded into the packet metadata
>> as well, so that it is possible to check at run-time which driver the
>> packet came from (since a packet can be redirected, so you may end up
>> having to deal with multiple formats in the same XDP program).
>>
>> Which would allow you to write code like:
>>
>> if (ctx->has_driver_meta) {
>>   /* this should be at a well-known position, like first (or last) in me=
ta area */
>>   __u32 *meta_btf_id =3D ctx->data_meta;
>>
>>   if (*meta_btf_id =3D=3D BTF_ID_MLX5) {
>>     struct meta_mlx5 *meta =3D ctx->data_meta;
>>     /* do something with meta */
>>   } else if (meta_btf_id =3D=3D BTF_ID_I40E) {
>>     struct meta_i40e *meta =3D ctx->data_meta;
>>     /* do something with meta */
>>   } /* etc */
>> }
>>
>> and libbpf could do relocations based on the different meta structs,
>> even removing the code for the ones that don't exist on the running
>> kernel.
>>
>> -Toke
>>
>
> How does putting the BTF ID and the driver metadata into the XDP metadata
> section interact with programs that are already using the metadata section
> for other purposes. For example, programs that use the XDP metadata to pa=
ss
> information through BPF tail calls?
>
> Would this break existing programs that aren't aware of the new driver
> metadata? Do we need to make driver metadata opt-in at XDP program
> load?

Well, XDP applications would be free to just ignore the driver-provided
metadata and overwrite it with its own data? And I guess any application
that doesn't know about it will just implicitly do that? :)

-Toke

