Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FC3394444
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 16:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhE1OhT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 10:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhE1OhT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 10:37:19 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611BDC061574
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 07:35:43 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id d25so4402860ioe.1
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=RVCfLlR9AJCKIEVDjBMLTdJHnBEqO6hgbC9ask8w04o=;
        b=haPUt9F0IJQtlaectEDAt87rd9moHP/0I5UPujwbgpFFzs73V9YQltxTkPvmWI9+na
         QzSnGx/MqCqlZaUY5MdksUNjIsiRo22yVV7mFbc9Z9JKuHxWKp83SA9dMPkvKce77rYU
         x8s709uJe/cKDCmyWwzmBDMGCq2Q4LUOFb183Ax2Vihb8DPwgERS8XrbAY2VfZSF2NEP
         ykpdRQysPxUt2laK3Z75ZMwirlMVfsgAH0EMZeKyNAPk0AKRGgzzzbt+s+06TZbFxBMr
         hzpFfs7efjWYmk3w+vWXHqZSTXScg7WH55liP5o+thBOWBQEsGYAf/P74TBBUJ671IC0
         3ewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=RVCfLlR9AJCKIEVDjBMLTdJHnBEqO6hgbC9ask8w04o=;
        b=ucipqv72cArPB5Sz6OldquoCnM41txL4TPWroPiOTNvwxdggVpLKoOeoXUZ7Rh8cIl
         sk8CokXPEgS/IM3ASD+W+pY6gnla6b4dIjqO/+vfdpw86Ca1vaCKcewB+k/KaSE3YRnd
         BmJLXbmSb8Y4Ltolby5slBWeLs4jkBjWhSPWYHuCwbWBqf2ugTIHG6Dn0S4CGqFvgEEv
         jwofFGwNxuW3g/LmM4qT6BgoiVr4yshJLvOvy6cDzRYloDIQjFUiw1Rmlm2h2716Jgs/
         t6GUp8ybUlpD5l7TaRAkN8gFqL9uDt0d6IzJyc8LqzeUrx73G3cGG80ds10oy6hBmefC
         dXMA==
X-Gm-Message-State: AOAM5305Hi/ElXnzi28Jy72iRznfOrRzMT+44SM2bEjS9FzS8FsaifaT
        7saQwrZB4sJZ2FlEdgs4uaM=
X-Google-Smtp-Source: ABdhPJxxsIrq9pnmliYtoQ8+/sH4noV9GStOLToiyGq9KJPk9FzvHB6CgIMYxKfpkQUs547DSemiZA==
X-Received: by 2002:a02:1989:: with SMTP id b131mr9110466jab.54.1622212542707;
        Fri, 28 May 2021 07:35:42 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id k8sm2679562iov.53.2021.05.28.07.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:35:42 -0700 (PDT)
Date:   Fri, 28 May 2021 07:35:34 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
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
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        William Tu <u9012063@gmail.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        xdp-hints@xdp-project.net
Message-ID: <60b0ffb63a21a_1cf82089e@john-XPS-13-9370.notmuch>
In-Reply-To: <87fsy7gqv7.fsf@toke.dk>
References: <20210526125848.1c7adbb0@carbon>
 <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com>
 <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch>
 <CAEf4Bza3m5dwZ_d0=zAWR+18f5RUjzv9=1NbhTKAO1uzWg_fzQ@mail.gmail.com>
 <60aeeb5252147_19a622085a@john-XPS-13-9370.notmuch>
 <CAEf4Bzb1OZHpHYagbVs7s9tMSk4wrbxzGeBCCBHQ-qCOgdu6EQ@mail.gmail.com>
 <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch>
 <87fsy7gqv7.fsf@toke.dk>
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> John Fastabend <john.fastabend@gmail.com> writes:
> =

> >> > > union and independent set of BTFs are two different things, I'll=
 let
> >> > > you guys figure out which one you need, but I replied how it cou=
ld
> >> > > look like in CO-RE world
> >> >
> >> > I think a union is sufficient and more aligned with how the
> >> > hardware would actually work.
> >> =

> >> Sure. And I think those are two orthogonal concerns. You can start
> >> with a single struct mynic_metadata with union inside it, and later
> >> add the ability to swap mynic_metadata with another
> >> mynic_metadata___v2 that will have a similar union but with a
> >> different layout.
> >
> > Right and then you just have normal upgrade/downgrade problems with
> > any struct.
> >
> > Seems like a workable path to me. But, need to circle back to the
> > what we want to do with it part that Jesper replied to.
> =

> So while this seems to be a viable path for getting libbpf to do all th=
e
> relocations (and thanks for hashing that out, I did not have a good gri=
p
> of the details), doing it all in userspace means that there is no way
> for the XDP program to react to changes once it has been loaded. So thi=
s
> leaves us with a selection of non-very-attractive options, IMO. I.e.,
> we would have to:

I don't really understand what this means 'having XDP program to
react to changes once it has been loaded.' What would a program look
like thats dynamic? You can always version your metadata and
write programs like this,

  if (meta->version =3D=3D VERSION1) {do_foo}
  else {do_bar}

And then have a headeer,

   struct meta {
     int version;
     union ...    // union of versions
   }

I fail to see how a program could 'react' dynamically. An agent could
load new programs dynamically into tail call maps of fentry with
the need handlers, which would work as well and avoid unions.

> =

> - have to block any modifications to the hardware config that would
>   change the metadata format; this will probably result in irate users

I'll need a concrete example if I swap out my parser block, I should
also swap out my BPF for my shiny new protocol. I don't see how a
user might write programs for things they've not configured hardware
for yet. Leaving aside knobs like VLAN on/off, VXLAN on/off, and
such which brings the next point.

> =

> - require XDP programs to deal with all possible metadata permutations
>   supported by that driver (by exporting them all via a BTF union or
>   similar); this means a potential for combinatorial explosion of confi=
g
>   options and as NICs become programmable themselves I'm not even sure
>   if it's possible for the driver to know ahead of time

I don't see the problem sorry. For current things that exist I can't
think up too many fields vlan, timestamp, checksum(?), pkt_type,
hash maybe.

For programmable pipelines (P4) then I don't see a problem with
reloading your program or swapping out a program. I don't see the
value of adding a new protocol for example dynamically. Surely
the hardware is going to get hit with a big reset anyways.

> =

> - throw up our hands and just let the user deal with it (i.e., to
>   nothing and so require XDP programs to be reloaded if the NIC config
>   changes); this is not very friendly and is likely to lead to subtle
>   bugs if an XDP program parses the metadata assuming it is in a
>   different format than it is

I'm not opposed to user error causing logic bugs.  If I give
users power to reprogram their NICs they should be capabable
of managing a few BPF programs. And if not then its a space
where a distro/vendor should help them with tooling.

> =

> Given that hardware config changes are not just done by ethtool, but
> also by things like running `tcpdump -j`, I really think we have to
> assume that they can be quite dynamic; which IMO means we have to solve=

> this as part of the initial design. And I have a hard time seeing how
> this is possible without involving the kernel somehow.

I guess here your talking about building an skb? Wouldn't it
use whatever logic it uses today to include the timestamp.
This is a bit of an aside from metadata in the BPF program.

Building timestamps into
skbs doesn't require BPF program to have the data. Or maybe
the point is an XDP variant of tcpdump would like timestamps.
But then it should be in the metadata IMO.

> =

> Unless I'm missing something? WDYT?

Distilling above down. I think we disagree on how useful
dynamic programs are because of two reasons. First I don't
see a large list of common attributes that would make the
union approach as painful as you fear. And two, I believe
users who are touching core hardware firmware need to also
be smart enough (or have smart tools) to swap out their
BPF programs in the correct order so as to not create
subtle races. I didn't do it here but if we agree walking
through that program swap flow with firmware update would
be useful.

> =

> -Toke
> =



