Return-Path: <bpf+bounces-27218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CD28AAE1F
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 14:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F4B1F2223C
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 12:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD67E84FB3;
	Fri, 19 Apr 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jk8z5RW5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBD7F7C7
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713528516; cv=none; b=dFBQSIS7SifbX+8n+RA8FRYbDwNkcAERxU0HLQomQsp+kv8SJgixLoRVu+dPVKXqH5IV9Olmf5HGBz11Yx7Xx5N3vznb6Wi42/N7/D7UWw/xTT1V059iWmZba6ZPTHPRW3gL5wcZfJ1ZSpiwr65UaiNrFiOxCv+OkchX9PeeUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713528516; c=relaxed/simple;
	bh=TPwZWr+fvsIrciadHC7iMjk2+n0Mu/ePTKE4tE12few=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAV1vAmuvEM87hEh2jqyjSR736dkZ/T7WFpGgL0w5p1S0n/QWkOdPNyE1ESIFVBOPfT984LGkYRKnpBPLtROS7uazAEvT4bHZhqqsVTBccCm9aKzA3r0oajE/D4aBaT9C/GB7pysr9Y3ugK8ACD9VyNBhMv0j78SRpg3/4W+O7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=jk8z5RW5; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de467733156so1865714276.0
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 05:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1713528510; x=1714133310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rr+OMVO5d5MvCdE3P+I4S9XZRIo21TTh8S1kyZgJ53s=;
        b=jk8z5RW5hgpd/GtJybWhsK3eVk1ZZXBmM2pxDr8PQNW2CvfnwpOBErdU+3G2EFe1sl
         x7kG7rLPyPCDEUiNnd8uSjjShx1++G3E88ql/4RUigEDNv1OfQXNjpzzTB4+2ULWf1fc
         Q02vLyO+VxQcbaM/ld9lvRxXFtdRINPMPzKJ+pF2nIaL6utRujqsuMKPVf5Mi2ooDxxf
         eFy6Gk+W66DTsnPKZ1qkDaTpv6YJocl1Q8NaAkm0nQ3vP2r+mzkdFWt54JTSGeSwE00D
         nbanWci4oCufsa16IMRXSpsshTUGixL/IXjWNbCFFexo/nE1vmYpne6lPgw2o/lLS7v8
         pMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713528510; x=1714133310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rr+OMVO5d5MvCdE3P+I4S9XZRIo21TTh8S1kyZgJ53s=;
        b=S/WY0ZbqpQxqNe7W9bdivKhpj6zrM3CB0m+AABO0qC6xrpzLL97ljgnMo8Zqb9eFwk
         6wD1H+euSGfswzAh3i3MohP18GkwLO+RSORnN3mCd/P5VxZOrLP74O0iwjgQ1RUhq+PO
         8ms/QANhc10uxHvInuByWYA/M9B+If2ux6kkIruNGwjg87kvAoXOpIGsmPa7qQtJ4KOW
         BDm3mu+0vNeZeORBAB0NnTZSErCwMQh9ZPWUjmZUliMePv3hSKQ+dPrWOzYJ9W9oWdtl
         03reHggI+QW6a2dbyuHC234yg/vvNSz9dNOadt9Pw2CdLQUFadzA4/RP0hUq2+6OBEzq
         iw1w==
X-Forwarded-Encrypted: i=1; AJvYcCWi9uUEiRSeJvb+Ji07Dc/2He7SDBx7F6AtoIFi+AP7367fGixmYjTqS1jrwnNoGn5RLLsCCO/HtpNhijb/nPZSf+HY
X-Gm-Message-State: AOJu0YwZpqClZAYeEXcdzQhHJJEQOQFtfAhvUj+/16DwbACXb49AWRpY
	bT4IuMaZ4ktvILgFyXpj63i2s+jxtv5ouvcfjHfaaVMRh5EN8cDuSG+X36j5HHX4lYlKpQgMcgD
	C5my7SLvmB/zjg46EmqbcHEeGtZgmR9JbISHD
X-Google-Smtp-Source: AGHT+IFrs0x5TSC4YT1Qyhv88pMESj9mT65SnYFIqtW9G6G0q4pBcESAjoC6QdjLo9IWA9hluz4ZwCYtQFlfM4kziuY=
X-Received: by 2002:a25:c541:0:b0:dd0:aa2c:4da5 with SMTP id
 v62-20020a25c541000000b00dd0aa2c4da5mr2008966ybe.6.1713528510570; Fri, 19 Apr
 2024 05:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
In-Reply-To: <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 19 Apr 2024 08:08:19 -0400
Message-ID: <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, 
	toke@redhat.com, victor@mojatatu.com, pctammela@mojatatu.com, 
	Vipin.Jain@amd.com, dan.daly@intel.com, andy.fingerhut@gmail.com, 
	chris.sommers@keysight.com, mattyk@nvidia.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:24=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Thu, Apr 11, 2024 at 10:07=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > On Wed, 2024-04-10 at 10:01 -0400, Jamal Hadi Salim wrote:
> > > The only change that v16 makes is to add a nack to patch 14 on kfuncs
> > > from Daniel and John. We strongly disagree with the nack; unfortunate=
ly I
> > > have to rehash whats already in the cover letter and has been discuss=
ed over
> > > and over and over again:
> >
> > I feel bad asking, but I have to, since all options I have here are
> > IMHO quite sub-optimal.
> >
> > How bad would be dropping patch 14 and reworking the rest with
> > alternative s/w datapath? (I guess restoring it from oldest revision of
> > this series).
>
>
> We want to keep using ebpf  for the s/w datapath if that is not clear by =
now.
> I do not understand the obstructionism tbh. Are users allowed to use
> kfuncs as part of infra or not? My understanding is yes.
> This community is getting too political and my worry is that we have
> corporatism creeping in like it is in standards bodies.
> We started by not using ebpf. The same people who are objecting now
> went up in arms and insisted we use ebpf. As a member of this
> community, my motivation was to meet them in the middle by
> compromising. We invested another year to move to that middle ground.
> Now they are insisting we do not use ebpf because they dont like our
> design or how we are using ebpf or maybe it's not a use case they have
> any need for or some other politics. I lost track of the moving goal
> posts. Open source is about solving your itch. This code is entirely
> on TC, zero code changed in ebpf core. The new goalpost is based on
> emotional outrage over use of functions. The whole thing is getting
> extremely toxic.
>

Paolo,
Following up since no movement for a week now;->
I am going to give benefit of doubt that there was miscommunication or
misunderstanding for all the back and forth that has happened so far
with the nackers. I will provide a summary below on the main points
raised and then provide responses:

1) "Use maps"

It doesnt make sense for our requirement. The reason we are using TC
is because a) P4 has an excellent fit with TC match action paradigm b)
we are targeting both s/w and h/w and the TC model caters well for
this. The objects belong to TC, shared between s/w, h/w and control
plane (and netlink is the API). Maybe this diagram would help:
https://github.com/p4tc-dev/docs/blob/main/images/why-p4tc/p4tc-runtime-pip=
eline.png

While the s/w part stands on its own accord (as elaborated many
times), for TC which has offloads, the s/w twin is introduced before
the h/w equivalent. This is what this series is doing.

2) "but ... it is not performant"
This has been brought up in regards to netlink and kfuncs. Performance
is a lower priority to P4 correctness and expressibility.
Netlink provides us the abstractions we need, it works with TC for
both s/w and h/w offload and has a lot of knowledge base for
expressing control plane APIs. We dont believe reinventing all that
makes sense.
Kfuncs are a means to an end - they provide us the gluing we need to
have an ebpf s/w datapath to the TC objects. Getting an extra
10-100Kpps is not a driving factor.

3) "but you did it wrong, here's how you do it..."

I gave up on responding to this - but do note this sentiment is a big
theme in the exchanges and consumed most of the electrons. We are
_never_ going to get any consensus with statements like "tc actions
are a mistake" or "use tcx".

4) "... drop the kfunc patch"

kfuncs essentially boil down to function calls. They don't require any
special handling by the eBPF verifier nor introduce new semantics to
eBPF. They are similar in nature to the already existing kfuncs
interacting with other kernel objects such as nf_conntrack.
The precedence (repeated in conferences and email threads multiple
times) is: kfuncs dont have to be sent to ebpf list or reviewed by
folks in the ebpf world. And We believe that rule applies to us as
well. Either kfuncs (and frankly ebpf) is infrastructure glue or it's
not.

Now for a little rant:

Open source is not a zero-sum game. Ebpf already coexists with
netfilter, tc, etc and various subsystems happily.
I hope our requirement is clear and i dont have to keep justifying why
P4 or relitigate over and over again why we need TC. Open source is
about scratching your itch and our itch is totally contained within
TC. I cant help but feel that this community is getting way too
pervasive with politics and obscure agendas. I understand agendas, I
just dont understand the zero-sum thinking.
My view is this series should still be applied with the nacks since it
sits entirely on its own silo within networking/TC (and has nothing to
do with ebpf).

cheers,
jamal

