Return-Path: <bpf+bounces-27956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FD28B3E86
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C24E1C2204F
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606A915ECDB;
	Fri, 26 Apr 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLpPpQvf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186C7E573;
	Fri, 26 Apr 2024 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714153396; cv=none; b=ZMHqQWS92gMtVTiwS9b1WRdk7GwE7btaDl+XirMBzOG0lL73B+vILrf0LLztMLBAKaEChtrQHO/MpyDqrdEPuza/qJf3pWhcN/oKMpLMtXSY/cc/+fUKFWRdle9nVlm9tYLpBRcjWP4cXs7mdInxJVEuGQgnyMcPOuqnFP36EiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714153396; c=relaxed/simple;
	bh=OaqNoW9sHsnSxCumGEHHxkv62jKeMVDQC6/c4kSymLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNXlNZv+/p94cyjt803xF44HNI/6WRWJVr9lxCoLTAyo5qubt1PqoYrcTHBrBY3wJddzPObVAtMTXHyLLZsC6sYG3zju/bXzy3/zeQ3F7u7+rmi5+mx/1IxKssT3ri4TL1fE/55Rt4vDCac/WOnM++aXgqo/T1mK2xuowGLg/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLpPpQvf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34af8b880e8so1555352f8f.0;
        Fri, 26 Apr 2024 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714153393; x=1714758193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV2TrC/VKc+lrOsrXtUi0AHFjqcBRr6JanPt3eeZ3Es=;
        b=fLpPpQvf3k1k5fN2D2oxL+uvg+6M7eM+rEZuTquHpERomORYoj/FGNqlBj5pArzIoT
         6wgpOJoreBLUCUe3LlsbL0B3CXtvpnoVlWZWz8SI7ZD00E3V+DtJ7O0t0rY3R8YaM8LY
         7Z3oJLOW6vg5vRwByt+5A8/CH/IpzG0nJ3+VaJtJOc8wbb5Ed9sA91NjLJQV6ZrjmcWx
         kXZ380aEpwoVXBw1vC2+wE0RJQ5g7AFE3263nYUPuNJS5Qqj1X0mU2sd9OUCEqGw3QxD
         CyOKXhpWFuJvQameWRHytgBxWID0XzRun4B1Gr+BqaoWZvY6H7URIR1a8qkxntPUEVku
         OV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714153393; x=1714758193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lV2TrC/VKc+lrOsrXtUi0AHFjqcBRr6JanPt3eeZ3Es=;
        b=vcS82kFoe9+NxWTaqoK4umYjEUyCq6oXmXV/NiUkymSu7V/RXQKzF3OF2zizdf7w9l
         HFJaX3qVV4c9Q3yz6eTBeKavwWX+L/i5uWX6JLj8hQBZeNFqRi1LhzrcWaqVfe4BbRkS
         YaYPKfI06fMTANDTy6fDGdQi4wMlDbTJJ+gtLboVEMxrc1fR+rnO+27eXXzm1uEmWxnk
         jaDMJRHDfFfnarCoh0hsEg7OkKGol5w5Lq3Ut/mW/znkXYqNMi6jrJNhCfdYleFEexxc
         lJznYt9FpNN4NYf1rgzXQJqb1eg7p9lDpFEf1zrdNk3OasaCk3yhP0vC45QInFIfOx3v
         DxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM0EhDgycBm4D2owfe80P4zckA8JNDgzoLjytl2R/+FYh2Me3AU5Payr8ISPRO3QjTRLq8c2IvVuIOPOvgza8H0g7E
X-Gm-Message-State: AOJu0YzIceVaYb7zGqMP0lL2AhQyKwluXFd8YsOQ7T6WcxZ9qDVW31Tl
	pe93ChGayPKCBIBS9XeLbQDVlu3txHxgllyL6o3vJCPW/2/L7bj1vuX44c3rC8JMmc/g+AfB/tD
	tR5IyD1NhYMA9Llc+ZQiEpMSMQag=
X-Google-Smtp-Source: AGHT+IGIzrC4/BJqnnQhkJeB52FxKG+16G33xS+EfHr4NoUr9vDd24+2q5YH2zrObXHM2LIc5xZrCCmAlpm7+eSKSpE=
X-Received: by 2002:a5d:63c7:0:b0:343:6c07:c816 with SMTP id
 c7-20020a5d63c7000000b003436c07c816mr2791432wrw.16.1714153393227; Fri, 26 Apr
 2024 10:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
 <87cf4830e2e46c1882998162526e108fb424a0f7.camel@redhat.com>
 <CAM0EoMkJwR0K-fF7qo0PfRw4Sf+=2L0L=rOcH5A2ELwagLrZMw@mail.gmail.com>
 <CAM0EoMmfDoZ9_ZdK-ZjHjFAjuNN8fVK+R57_UaFqAm=wA0AWVA@mail.gmail.com> <82ee1013ca0164053e9fb1259eaf676343c430e8.camel@redhat.com>
In-Reply-To: <82ee1013ca0164053e9fb1259eaf676343c430e8.camel@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 26 Apr 2024 10:43:01 -0700
Message-ID: <CAADnVQLugkg+ahAapskRaE86=RnwpY8v=Nre8pn=sa4fTEoTyA@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
To: Paolo Abeni <pabeni@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>, deb.chatterjee@intel.com, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, namrata.limaye@intel.com, tom@sipanda.io, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, 
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	khalidm@nvidia.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	victor@mojatatu.com, Pedro Tammela <pctammela@mojatatu.com>, Vipin.Jain@amd.com, 
	dan.daly@intel.com, andy.fingerhut@gmail.com, chris.sommers@keysight.com, 
	mattyk@nvidia.com, bpf <bpf@vger.kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 10:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Fri, 2024-04-26 at 13:12 -0400, Jamal Hadi Salim wrote:
> > On Fri, Apr 19, 2024 at 2:01=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Fri, Apr 19, 2024 at 1:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > > >
> > > > On Fri, 2024-04-19 at 08:08 -0400, Jamal Hadi Salim wrote:
> > > > > On Thu, Apr 11, 2024 at 12:24=E2=80=AFPM Jamal Hadi Salim <jhs@mo=
jatatu.com> wrote:
> > > > > >
> > > > > > On Thu, Apr 11, 2024 at 10:07=E2=80=AFAM Paolo Abeni <pabeni@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, 2024-04-10 at 10:01 -0400, Jamal Hadi Salim wrote:
> > > > > > > > The only change that v16 makes is to add a nack to patch 14=
 on kfuncs
> > > > > > > > from Daniel and John. We strongly disagree with the nack; u=
nfortunately I
> > > > > > > > have to rehash whats already in the cover letter and has be=
en discussed over
> > > > > > > > and over and over again:
> > > > > > >
> > > > > > > I feel bad asking, but I have to, since all options I have he=
re are
> > > > > > > IMHO quite sub-optimal.
> > > > > > >
> > > > > > > How bad would be dropping patch 14 and reworking the rest wit=
h
> > > > > > > alternative s/w datapath? (I guess restoring it from oldest r=
evision of
> > > > > > > this series).
> > > > > >
> > > > > >
> > > > > > We want to keep using ebpf  for the s/w datapath if that is not=
 clear by now.
> > > > > > I do not understand the obstructionism tbh. Are users allowed t=
o use
> > > > > > kfuncs as part of infra or not? My understanding is yes.
> > > > > > This community is getting too political and my worry is that we=
 have
> > > > > > corporatism creeping in like it is in standards bodies.
> > > > > > We started by not using ebpf. The same people who are objecting=
 now
> > > > > > went up in arms and insisted we use ebpf. As a member of this
> > > > > > community, my motivation was to meet them in the middle by
> > > > > > compromising. We invested another year to move to that middle g=
round.
> > > > > > Now they are insisting we do not use ebpf because they dont lik=
e our
> > > > > > design or how we are using ebpf or maybe it's not a use case th=
ey have
> > > > > > any need for or some other politics. I lost track of the moving=
 goal
> > > > > > posts. Open source is about solving your itch. This code is ent=
irely
> > > > > > on TC, zero code changed in ebpf core. The new goalpost is base=
d on
> > > > > > emotional outrage over use of functions. The whole thing is get=
ting
> > > > > > extremely toxic.
> > > > > >
> > > > >
> > > > > Paolo,
> > > > > Following up since no movement for a week now;->
> > > > > I am going to give benefit of doubt that there was miscommunicati=
on or
> > > > > misunderstanding for all the back and forth that has happened so =
far
> > > > > with the nackers. I will provide a summary below on the main poin=
ts
> > > > > raised and then provide responses:
> > > > >
> > > > > 1) "Use maps"
> > > > >
> > > > > It doesnt make sense for our requirement. The reason we are using=
 TC
> > > > > is because a) P4 has an excellent fit with TC match action paradi=
gm b)
> > > > > we are targeting both s/w and h/w and the TC model caters well fo=
r
> > > > > this. The objects belong to TC, shared between s/w, h/w and contr=
ol
> > > > > plane (and netlink is the API). Maybe this diagram would help:
> > > > > https://github.com/p4tc-dev/docs/blob/main/images/why-p4tc/p4tc-r=
untime-pipeline.png
> > > > >
> > > > > While the s/w part stands on its own accord (as elaborated many
> > > > > times), for TC which has offloads, the s/w twin is introduced bef=
ore
> > > > > the h/w equivalent. This is what this series is doing.
> > > > >
> > > > > 2) "but ... it is not performant"
> > > > > This has been brought up in regards to netlink and kfuncs. Perfor=
mance
> > > > > is a lower priority to P4 correctness and expressibility.
> > > > > Netlink provides us the abstractions we need, it works with TC fo=
r
> > > > > both s/w and h/w offload and has a lot of knowledge base for
> > > > > expressing control plane APIs. We dont believe reinventing all th=
at
> > > > > makes sense.
> > > > > Kfuncs are a means to an end - they provide us the gluing we need=
 to
> > > > > have an ebpf s/w datapath to the TC objects. Getting an extra
> > > > > 10-100Kpps is not a driving factor.
> > > > >
> > > > > 3) "but you did it wrong, here's how you do it..."
> > > > >
> > > > > I gave up on responding to this - but do note this sentiment is a=
 big
> > > > > theme in the exchanges and consumed most of the electrons. We are
> > > > > _never_ going to get any consensus with statements like "tc actio=
ns
> > > > > are a mistake" or "use tcx".
> > > > >
> > > > > 4) "... drop the kfunc patch"
> > > > >
> > > > > kfuncs essentially boil down to function calls. They don't requir=
e any
> > > > > special handling by the eBPF verifier nor introduce new semantics=
 to
> > > > > eBPF. They are similar in nature to the already existing kfuncs
> > > > > interacting with other kernel objects such as nf_conntrack.
> > > > > The precedence (repeated in conferences and email threads multipl=
e
> > > > > times) is: kfuncs dont have to be sent to ebpf list or reviewed b=
y
> > > > > folks in the ebpf world. And We believe that rule applies to us a=
s
> > > > > well. Either kfuncs (and frankly ebpf) is infrastructure glue or =
it's
> > > > > not.
> > > > >
> > > > > Now for a little rant:
> > > > >
> > > > > Open source is not a zero-sum game. Ebpf already coexists with
> > > > > netfilter, tc, etc and various subsystems happily.
> > > > > I hope our requirement is clear and i dont have to keep justifyin=
g why
> > > > > P4 or relitigate over and over again why we need TC. Open source =
is
> > > > > about scratching your itch and our itch is totally contained with=
in
> > > > > TC. I cant help but feel that this community is getting way too
> > > > > pervasive with politics and obscure agendas. I understand agendas=
, I
> > > > > just dont understand the zero-sum thinking.
> > > > > My view is this series should still be applied with the nacks sin=
ce it
> > > > > sits entirely on its own silo within networking/TC (and has nothi=
ng to
> > > > > do with ebpf).
> > > >
> > > > It's really hard for me - meaning I'll not do that - applying a ser=
ies
> > > > that has been so fiercely nacked, especially given that the other
> > > > maintainers are not supporting it.
> > > >
> > > > I really understand this is very bad for you.
> > > >
> > > > Let me try to do an extreme attempt to find some middle ground betw=
een
> > > > this series and the bpf folks.
> > > >
> > > > My understanding is that the most disliked item is the lifecycle fo=
r
> > > > the objects allocated via the kfunc(s).
> > > >
> > > > If I understand correctly, the hard requirement on bpf side is that=
 any
> > > > kernel object allocated by kfunc must be released at program unload
> > > > time. p4tc postpone such allocation to recycle the structure.
> > > >
> > > > While there are other arguments, my reading of the past few iterati=
ons
> > > > is that solving the above node should lift the nack, am I correct?
> > > >
> > > > Could p4tc pre-allocate all the p4tc_table_entry_act_bpf_kern entri=
es
> > > > and let p4a_runt_create_bpf() fail if the pool is empty? would that
> > > > satisfy the bpf requirement?
> > >
> > > Let me think about it and weigh the consequences.
> > >
> >
> > Sorry, was busy evaluating. Yes, we can enforce the memory allocation
> > constraints such that when the ebpf program is removed any entries
> > added by said ebpf program can be removed from the datapath.
>
> I suggested the such changes based on my interpretation of this long
> and complex discussion, I can have missed some or many relevant points.
> @Alexei: could you please double check the above and eventually,
> hopefully, confirm that such change would lift your nacked-by?

No. The whole design is broken.
Remembering what was allocated by kfunc and freeing it later
is not fixing the design at all.
Sorry.

