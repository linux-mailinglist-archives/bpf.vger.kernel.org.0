Return-Path: <bpf+bounces-27952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEC58B3DA7
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DDA1C230A6
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 17:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691A315B978;
	Fri, 26 Apr 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="VPLBmivR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F9715AD89
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151552; cv=none; b=qIZ4gStkWzrk+D6Rd6RC7FnfEtCdZEJW7J4GnjZYNlGFETlR5Sq02eT+QIMDTvSfhq6Xg6Xi19I6h1VhvoINH8tOVg0RJ+msaK0nHpsof7u/Y0gpoRaW+uBGayAmJLj2DEkBNkdR4WnDtTyInkw2XRLlLAzzyJGsZCk7eoAJdZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151552; c=relaxed/simple;
	bh=8le8AOiUF4XShDRyL//11qap1YksJ2uMZn28bMd3utg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBSWQHJz2meQdfQjFjD3q0aI8KK1zB4fRs36yTUhjGkns8lnFxoYfyYJ+5sbq+kRR2zVvxpfadHeMB8WZcg2MZpJMZuj912PfyFFNQOkNtq7mQ2+aMIWPqRNNl5bRBQlgOC2tghalK1oba23Xt0dptj/KPoSCnFwRGAwGaISGus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=VPLBmivR; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61ae4743d36so24339677b3.2
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 10:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1714151549; x=1714756349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8QzGoGmXVJB8xQEravlNnVdd1KB5UO19cCDFD+j6iY=;
        b=VPLBmivRiWuh+YYOIgbRo03c7bcervC0v/NrKrFJA3OMhitRnR6p1byE4dhT0eYOEP
         qmhnJwzmg4BXvf4mwPc1Ea104k85Xli1d1Yae83TUvolfow2yYtFzhsSEzVX6kxMf9sv
         yv669vMXfjoG+zlAVaVLqy/eDGRaroOHcb0TDBR2PANAaMjRZBjSioEeDr/hL9MSyCdS
         BNgSIjgyY6e+ZX9crNJwpq4pi31QPbuWPyCHzZE2LQpClNlBBn1476gayeQyFcu1a8sW
         AS3Mt58PL6qyhUd0hZqWQwONfIAQgp3rnDTZr5uA2pDL7oM25a+2scx6o243joPjxfAA
         9sSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714151549; x=1714756349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8QzGoGmXVJB8xQEravlNnVdd1KB5UO19cCDFD+j6iY=;
        b=nNsXJ3FdcasYT9Ghzmn71QOSVYYuk78+v6YxnGnnGyNRVEPG3wyt70WzDbp8wqhHIR
         Ca8qklKYC+BPE97JTXSL1ci4oToHXUUGC0BnnaKaTiXBtUohcOXYLmMOpXhUCY9oyrF+
         55pDGFD7SgmazPKApqlPSKTCWbigVIeXDycrxpD1BmlpkHxMfrh1Kwpt+NsqwbI8mUEL
         YBvysliUREZdPAOgFXSx7Xf1bYp9fAJ4vCpFGcdJKDoiHFzQPCUhhPdm74lv2H9A0sC/
         N6b6Oi79M1syYRN8b4v9JICnReMWjMo+JuRTrj9ZeiYLUWkfgs8WEItyHL82QbyrkrEX
         TYhA==
X-Forwarded-Encrypted: i=1; AJvYcCWOM4sJvd5vld3EFHl1pkb3KYsfOodudFPq2YH/QLY+ZCt0juaLKtSZb6g04H0Zb9al687Ju4ZwCJZI23MuK+9qcJKO
X-Gm-Message-State: AOJu0YwI+MQn4YVm0k8owguqfK/ODb9HZIyBi1vM8bFgAN5DgRylBaBY
	8JsMKPSyoXsg2HWOSBCmBQthpcrJTQY0jjrb/2hBLVXO3jL/bL5ex2zI4WlYbvI7AJfUA3yUxlB
	kdoxGf3LGckZINefD1M0vkEewGUj6ZZTswKEu
X-Google-Smtp-Source: AGHT+IE/Xd0wJM5xFVyE4bG55HyuddOD+VU6/xSegjPGwwfMYM/4YtCRjJAORCheau15QdizbsNW87MkxA/0Y214lbo=
X-Received: by 2002:a05:690c:e:b0:61b:91e3:f954 with SMTP id
 bc14-20020a05690c000e00b0061b91e3f954mr3594141ywb.8.1714151547373; Fri, 26
 Apr 2024 10:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
 <87cf4830e2e46c1882998162526e108fb424a0f7.camel@redhat.com> <CAM0EoMkJwR0K-fF7qo0PfRw4Sf+=2L0L=rOcH5A2ELwagLrZMw@mail.gmail.com>
In-Reply-To: <CAM0EoMkJwR0K-fF7qo0PfRw4Sf+=2L0L=rOcH5A2ELwagLrZMw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 26 Apr 2024 13:12:14 -0400
Message-ID: <CAM0EoMmfDoZ9_ZdK-ZjHjFAjuNN8fVK+R57_UaFqAm=wA0AWVA@mail.gmail.com>
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

On Fri, Apr 19, 2024 at 2:01=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Fri, Apr 19, 2024 at 1:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On Fri, 2024-04-19 at 08:08 -0400, Jamal Hadi Salim wrote:
> > > On Thu, Apr 11, 2024 at 12:24=E2=80=AFPM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> > > >
> > > > On Thu, Apr 11, 2024 at 10:07=E2=80=AFAM Paolo Abeni <pabeni@redhat=
.com> wrote:
> > > > >
> > > > > On Wed, 2024-04-10 at 10:01 -0400, Jamal Hadi Salim wrote:
> > > > > > The only change that v16 makes is to add a nack to patch 14 on =
kfuncs
> > > > > > from Daniel and John. We strongly disagree with the nack; unfor=
tunately I
> > > > > > have to rehash whats already in the cover letter and has been d=
iscussed over
> > > > > > and over and over again:
> > > > >
> > > > > I feel bad asking, but I have to, since all options I have here a=
re
> > > > > IMHO quite sub-optimal.
> > > > >
> > > > > How bad would be dropping patch 14 and reworking the rest with
> > > > > alternative s/w datapath? (I guess restoring it from oldest revis=
ion of
> > > > > this series).
> > > >
> > > >
> > > > We want to keep using ebpf  for the s/w datapath if that is not cle=
ar by now.
> > > > I do not understand the obstructionism tbh. Are users allowed to us=
e
> > > > kfuncs as part of infra or not? My understanding is yes.
> > > > This community is getting too political and my worry is that we hav=
e
> > > > corporatism creeping in like it is in standards bodies.
> > > > We started by not using ebpf. The same people who are objecting now
> > > > went up in arms and insisted we use ebpf. As a member of this
> > > > community, my motivation was to meet them in the middle by
> > > > compromising. We invested another year to move to that middle groun=
d.
> > > > Now they are insisting we do not use ebpf because they dont like ou=
r
> > > > design or how we are using ebpf or maybe it's not a use case they h=
ave
> > > > any need for or some other politics. I lost track of the moving goa=
l
> > > > posts. Open source is about solving your itch. This code is entirel=
y
> > > > on TC, zero code changed in ebpf core. The new goalpost is based on
> > > > emotional outrage over use of functions. The whole thing is getting
> > > > extremely toxic.
> > > >
> > >
> > > Paolo,
> > > Following up since no movement for a week now;->
> > > I am going to give benefit of doubt that there was miscommunication o=
r
> > > misunderstanding for all the back and forth that has happened so far
> > > with the nackers. I will provide a summary below on the main points
> > > raised and then provide responses:
> > >
> > > 1) "Use maps"
> > >
> > > It doesnt make sense for our requirement. The reason we are using TC
> > > is because a) P4 has an excellent fit with TC match action paradigm b=
)
> > > we are targeting both s/w and h/w and the TC model caters well for
> > > this. The objects belong to TC, shared between s/w, h/w and control
> > > plane (and netlink is the API). Maybe this diagram would help:
> > > https://github.com/p4tc-dev/docs/blob/main/images/why-p4tc/p4tc-runti=
me-pipeline.png
> > >
> > > While the s/w part stands on its own accord (as elaborated many
> > > times), for TC which has offloads, the s/w twin is introduced before
> > > the h/w equivalent. This is what this series is doing.
> > >
> > > 2) "but ... it is not performant"
> > > This has been brought up in regards to netlink and kfuncs. Performanc=
e
> > > is a lower priority to P4 correctness and expressibility.
> > > Netlink provides us the abstractions we need, it works with TC for
> > > both s/w and h/w offload and has a lot of knowledge base for
> > > expressing control plane APIs. We dont believe reinventing all that
> > > makes sense.
> > > Kfuncs are a means to an end - they provide us the gluing we need to
> > > have an ebpf s/w datapath to the TC objects. Getting an extra
> > > 10-100Kpps is not a driving factor.
> > >
> > > 3) "but you did it wrong, here's how you do it..."
> > >
> > > I gave up on responding to this - but do note this sentiment is a big
> > > theme in the exchanges and consumed most of the electrons. We are
> > > _never_ going to get any consensus with statements like "tc actions
> > > are a mistake" or "use tcx".
> > >
> > > 4) "... drop the kfunc patch"
> > >
> > > kfuncs essentially boil down to function calls. They don't require an=
y
> > > special handling by the eBPF verifier nor introduce new semantics to
> > > eBPF. They are similar in nature to the already existing kfuncs
> > > interacting with other kernel objects such as nf_conntrack.
> > > The precedence (repeated in conferences and email threads multiple
> > > times) is: kfuncs dont have to be sent to ebpf list or reviewed by
> > > folks in the ebpf world. And We believe that rule applies to us as
> > > well. Either kfuncs (and frankly ebpf) is infrastructure glue or it's
> > > not.
> > >
> > > Now for a little rant:
> > >
> > > Open source is not a zero-sum game. Ebpf already coexists with
> > > netfilter, tc, etc and various subsystems happily.
> > > I hope our requirement is clear and i dont have to keep justifying wh=
y
> > > P4 or relitigate over and over again why we need TC. Open source is
> > > about scratching your itch and our itch is totally contained within
> > > TC. I cant help but feel that this community is getting way too
> > > pervasive with politics and obscure agendas. I understand agendas, I
> > > just dont understand the zero-sum thinking.
> > > My view is this series should still be applied with the nacks since i=
t
> > > sits entirely on its own silo within networking/TC (and has nothing t=
o
> > > do with ebpf).
> >
> > It's really hard for me - meaning I'll not do that - applying a series
> > that has been so fiercely nacked, especially given that the other
> > maintainers are not supporting it.
> >
> > I really understand this is very bad for you.
> >
> > Let me try to do an extreme attempt to find some middle ground between
> > this series and the bpf folks.
> >
> > My understanding is that the most disliked item is the lifecycle for
> > the objects allocated via the kfunc(s).
> >
> > If I understand correctly, the hard requirement on bpf side is that any
> > kernel object allocated by kfunc must be released at program unload
> > time. p4tc postpone such allocation to recycle the structure.
> >
> > While there are other arguments, my reading of the past few iterations
> > is that solving the above node should lift the nack, am I correct?
> >
> > Could p4tc pre-allocate all the p4tc_table_entry_act_bpf_kern entries
> > and let p4a_runt_create_bpf() fail if the pool is empty? would that
> > satisfy the bpf requirement?
>
> Let me think about it and weigh the consequences.
>

Sorry, was busy evaluating. Yes, we can enforce the memory allocation
constraints such that when the ebpf program is removed any entries
added by said ebpf program can be removed from the datapath.

> > Otherwise could p4tc force free the p4tc_table_entry_act_bpf_kern at
> > unload time?
>
> This one wont work for us unfortunately. If we have entries added by
> the control plane with skip_sw just because the ebpf program is gone
> doesnt mean they disappear.

Just to clarify (the figure
https://github.com/p4tc-dev/docs/blob/main/images/why-p4tc/p4tc-runtime-pip=
eline.png
should help) :
For P4 table objects, there are 3 types of entries: 1) created by
control path for s/w datapath with skip_hw 2) created by control path
for h/w datapath with skip_sw and 3) dynamically created by s/w
datapath (ebpf) not far off from conntrack.
The only ones we can remove when the ebpf program goes away are from #3.

cheers,
jamal

