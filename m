Return-Path: <bpf+bounces-27961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1826F8B3ED6
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 20:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989741F23465
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 18:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EF816D32A;
	Fri, 26 Apr 2024 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="pYuafX7X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4BA16ABC0
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714154645; cv=none; b=NJITpeRytI9ZKIKApiF+3pZkFEojzSInnNGbF1QRJgVRkF/t61tuDEI9zq1hUzo4yDdU1wLh2CVc7BfyA0QwxAVlXncZPBXUvTq72w6z2aWA7sZYF77nIjaYSVD4KQ/ipJi6iS9J6zjLr/p1dJxFxcFEXnTxU3cCJnLMn18SDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714154645; c=relaxed/simple;
	bh=It6nyOgHJmSYXT63E1ahCVwba2IRZxETnbEU1tl+aGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzLy4p4E8cYEFjzu18uNaXKzUrUAL4vNH5uTX/AGKzcqAlvWcDQsr/qHeC/xPe+9c6ShXMVWUpdxwIR6YURAGl3KgBNzGc3pXAUtFYCASF9gWoLxka+/vfpAo5vFVdAQ3I6QjUtmZWseKg+IjEU4dtFQHUsyY7cYc0eeCXQ/Zec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=pYuafX7X; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61bb638697aso4631537b3.1
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1714154642; x=1714759442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt7x3ZNOIdfZ9bSfJUvQXfH4e1zNpT++nXdMnCIn/x8=;
        b=pYuafX7X6/pLXUL6UxyrPS5ZSt2BhwQSs7DQ7sQ0Tnr/AKFIybHIoiECOs54Ep/Evq
         xWDsjbp3yO6fLdsTvAfnNTFKGIBksA2xMuUFGRR2ZKwUnSK1Cs7pIvUm4LoJ/ZbIm/xq
         ymLsqRBwsGV65Fea+lJ9xgns2nVTAIzP5nRo+oWRqhrV4JnOio6MMs2G0yfr55Rr1cka
         Rf5dfSQH3KiNL+q3AWZbpKezQisy/T9pyR1GvOCsDI0AouvLxOh5NH5fERGz0NRVQ6p9
         Cl8LK/fGBwiom7N9FIklddnGwm1pwfJBOktOFx/QwZQaF5p3NvVx426rGydyIFEwQLWX
         jKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714154642; x=1714759442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zt7x3ZNOIdfZ9bSfJUvQXfH4e1zNpT++nXdMnCIn/x8=;
        b=lQHOopNMzt4mpq6KnyDzRLXMVpioRsDQBlCkeVXeUkc4G6LYEg0ymIMpxlp5t+IWnF
         gI9cD/+QuGMn5TJ5ZhQCpWgegEsC/U6ocEEwpWLI0ikFMo8ngFiwALVInSEoBkNR9Eaq
         MDhibTBvC6A/Vg95j0JWhIsoCvhnOeJuqC2N3CEPXxmn+uRggv/tI0xfBxs8H856JpWW
         g1bSNircqZDTxohCT/g2Ookml7Wk9G8dKlvZ4seh8rv3MZa75lPheDCKVoSaolORgkUL
         uBwFXvqcTSHpn/nswmzgEX2KE2icW68fU3e7ZPYhbhBDDp4FliGgCfZO9TxOtgI/n751
         20NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFC2OKgrbvU6Cg258ubnugcChfRBSaZU/tpruWeh7BZR82W+ONoNQRghCkRMFjm1UWgP5eISW52PqfH+XQjsL77zHc
X-Gm-Message-State: AOJu0Yzj+sEPd+HZk6yTcjj2iAFw+5qNyFgoKMiA8hgnuaH88zJscucq
	uZEmmckmkfvxp2TYy4mLlfTwK6KddhvtVb8rnhwFMYPsz8/C9V0CirtjOMYr5w6N2sQIUWfbWZH
	u6LaPEgXJH+AReVdOya47i80rmJosbtRwsItU
X-Google-Smtp-Source: AGHT+IG379VOj3ZaggCA6idsh7BG5Ix1FeUqdxonaeOSNhl+OfFK7ryiR7Y+nj8y4gQTS/zrvjkkrrt61DFJYVZhNWw=
X-Received: by 2002:a05:690c:ed6:b0:61a:dfce:4563 with SMTP id
 cs22-20020a05690c0ed600b0061adfce4563mr3794138ywb.38.1714154642305; Fri, 26
 Apr 2024 11:04:02 -0700 (PDT)
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
 <CAM0EoMmfDoZ9_ZdK-ZjHjFAjuNN8fVK+R57_UaFqAm=wA0AWVA@mail.gmail.com>
 <82ee1013ca0164053e9fb1259eaf676343c430e8.camel@redhat.com> <CAADnVQLugkg+ahAapskRaE86=RnwpY8v=Nre8pn=sa4fTEoTyA@mail.gmail.com>
In-Reply-To: <CAADnVQLugkg+ahAapskRaE86=RnwpY8v=Nre8pn=sa4fTEoTyA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 26 Apr 2024 14:03:50 -0400
Message-ID: <CAM0EoM=2wHem54vTeVq4H1W5pawYuHNt-aS9JyG8iQORbaw5pA@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Network Development <netdev@vger.kernel.org>, deb.chatterjee@intel.com, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, namrata.limaye@intel.com, tom@sipanda.io, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, 
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	khalidm@nvidia.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	victor@mojatatu.com, Pedro Tammela <pctammela@mojatatu.com>, Vipin.Jain@amd.com, 
	dan.daly@intel.com, andy.fingerhut@gmail.com, chris.sommers@keysight.com, 
	mattyk@nvidia.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 1:43=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 26, 2024 at 10:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > On Fri, 2024-04-26 at 13:12 -0400, Jamal Hadi Salim wrote:
> > > On Fri, Apr 19, 2024 at 2:01=E2=80=AFPM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Fri, Apr 19, 2024 at 1:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.=
com> wrote:
> > > > >
> > > > > On Fri, 2024-04-19 at 08:08 -0400, Jamal Hadi Salim wrote:
> > > > > > On Thu, Apr 11, 2024 at 12:24=E2=80=AFPM Jamal Hadi Salim <jhs@=
mojatatu.com> wrote:
> > > > > > >
> > > > > > > On Thu, Apr 11, 2024 at 10:07=E2=80=AFAM Paolo Abeni <pabeni@=
redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, 2024-04-10 at 10:01 -0400, Jamal Hadi Salim wrote:
> > > > > > > > > The only change that v16 makes is to add a nack to patch =
14 on kfuncs
> > > > > > > > > from Daniel and John. We strongly disagree with the nack;=
 unfortunately I
> > > > > > > > > have to rehash whats already in the cover letter and has =
been discussed over
> > > > > > > > > and over and over again:
> > > > > > > >
> > > > > > > > I feel bad asking, but I have to, since all options I have =
here are
> > > > > > > > IMHO quite sub-optimal.
> > > > > > > >
> > > > > > > > How bad would be dropping patch 14 and reworking the rest w=
ith
> > > > > > > > alternative s/w datapath? (I guess restoring it from oldest=
 revision of
> > > > > > > > this series).
> > > > > > >
> > > > > > >
> > > > > > > We want to keep using ebpf  for the s/w datapath if that is n=
ot clear by now.
> > > > > > > I do not understand the obstructionism tbh. Are users allowed=
 to use
> > > > > > > kfuncs as part of infra or not? My understanding is yes.
> > > > > > > This community is getting too political and my worry is that =
we have
> > > > > > > corporatism creeping in like it is in standards bodies.
> > > > > > > We started by not using ebpf. The same people who are objecti=
ng now
> > > > > > > went up in arms and insisted we use ebpf. As a member of this
> > > > > > > community, my motivation was to meet them in the middle by
> > > > > > > compromising. We invested another year to move to that middle=
 ground.
> > > > > > > Now they are insisting we do not use ebpf because they dont l=
ike our
> > > > > > > design or how we are using ebpf or maybe it's not a use case =
they have
> > > > > > > any need for or some other politics. I lost track of the movi=
ng goal
> > > > > > > posts. Open source is about solving your itch. This code is e=
ntirely
> > > > > > > on TC, zero code changed in ebpf core. The new goalpost is ba=
sed on
> > > > > > > emotional outrage over use of functions. The whole thing is g=
etting
> > > > > > > extremely toxic.
> > > > > > >
> > > > > >
> > > > > > Paolo,
> > > > > > Following up since no movement for a week now;->
> > > > > > I am going to give benefit of doubt that there was miscommunica=
tion or
> > > > > > misunderstanding for all the back and forth that has happened s=
o far
> > > > > > with the nackers. I will provide a summary below on the main po=
ints
> > > > > > raised and then provide responses:
> > > > > >
> > > > > > 1) "Use maps"
> > > > > >
> > > > > > It doesnt make sense for our requirement. The reason we are usi=
ng TC
> > > > > > is because a) P4 has an excellent fit with TC match action para=
digm b)
> > > > > > we are targeting both s/w and h/w and the TC model caters well =
for
> > > > > > this. The objects belong to TC, shared between s/w, h/w and con=
trol
> > > > > > plane (and netlink is the API). Maybe this diagram would help:
> > > > > > https://github.com/p4tc-dev/docs/blob/main/images/why-p4tc/p4tc=
-runtime-pipeline.png
> > > > > >
> > > > > > While the s/w part stands on its own accord (as elaborated many
> > > > > > times), for TC which has offloads, the s/w twin is introduced b=
efore
> > > > > > the h/w equivalent. This is what this series is doing.
> > > > > >
> > > > > > 2) "but ... it is not performant"
> > > > > > This has been brought up in regards to netlink and kfuncs. Perf=
ormance
> > > > > > is a lower priority to P4 correctness and expressibility.
> > > > > > Netlink provides us the abstractions we need, it works with TC =
for
> > > > > > both s/w and h/w offload and has a lot of knowledge base for
> > > > > > expressing control plane APIs. We dont believe reinventing all =
that
> > > > > > makes sense.
> > > > > > Kfuncs are a means to an end - they provide us the gluing we ne=
ed to
> > > > > > have an ebpf s/w datapath to the TC objects. Getting an extra
> > > > > > 10-100Kpps is not a driving factor.
> > > > > >
> > > > > > 3) "but you did it wrong, here's how you do it..."
> > > > > >
> > > > > > I gave up on responding to this - but do note this sentiment is=
 a big
> > > > > > theme in the exchanges and consumed most of the electrons. We a=
re
> > > > > > _never_ going to get any consensus with statements like "tc act=
ions
> > > > > > are a mistake" or "use tcx".
> > > > > >
> > > > > > 4) "... drop the kfunc patch"
> > > > > >
> > > > > > kfuncs essentially boil down to function calls. They don't requ=
ire any
> > > > > > special handling by the eBPF verifier nor introduce new semanti=
cs to
> > > > > > eBPF. They are similar in nature to the already existing kfuncs
> > > > > > interacting with other kernel objects such as nf_conntrack.
> > > > > > The precedence (repeated in conferences and email threads multi=
ple
> > > > > > times) is: kfuncs dont have to be sent to ebpf list or reviewed=
 by
> > > > > > folks in the ebpf world. And We believe that rule applies to us=
 as
> > > > > > well. Either kfuncs (and frankly ebpf) is infrastructure glue o=
r it's
> > > > > > not.
> > > > > >
> > > > > > Now for a little rant:
> > > > > >
> > > > > > Open source is not a zero-sum game. Ebpf already coexists with
> > > > > > netfilter, tc, etc and various subsystems happily.
> > > > > > I hope our requirement is clear and i dont have to keep justify=
ing why
> > > > > > P4 or relitigate over and over again why we need TC. Open sourc=
e is
> > > > > > about scratching your itch and our itch is totally contained wi=
thin
> > > > > > TC. I cant help but feel that this community is getting way too
> > > > > > pervasive with politics and obscure agendas. I understand agend=
as, I
> > > > > > just dont understand the zero-sum thinking.
> > > > > > My view is this series should still be applied with the nacks s=
ince it
> > > > > > sits entirely on its own silo within networking/TC (and has not=
hing to
> > > > > > do with ebpf).
> > > > >
> > > > > It's really hard for me - meaning I'll not do that - applying a s=
eries
> > > > > that has been so fiercely nacked, especially given that the other
> > > > > maintainers are not supporting it.
> > > > >
> > > > > I really understand this is very bad for you.
> > > > >
> > > > > Let me try to do an extreme attempt to find some middle ground be=
tween
> > > > > this series and the bpf folks.
> > > > >
> > > > > My understanding is that the most disliked item is the lifecycle =
for
> > > > > the objects allocated via the kfunc(s).
> > > > >
> > > > > If I understand correctly, the hard requirement on bpf side is th=
at any
> > > > > kernel object allocated by kfunc must be released at program unlo=
ad
> > > > > time. p4tc postpone such allocation to recycle the structure.
> > > > >
> > > > > While there are other arguments, my reading of the past few itera=
tions
> > > > > is that solving the above node should lift the nack, am I correct=
?
> > > > >
> > > > > Could p4tc pre-allocate all the p4tc_table_entry_act_bpf_kern ent=
ries
> > > > > and let p4a_runt_create_bpf() fail if the pool is empty? would th=
at
> > > > > satisfy the bpf requirement?
> > > >
> > > > Let me think about it and weigh the consequences.
> > > >
> > >
> > > Sorry, was busy evaluating. Yes, we can enforce the memory allocation
> > > constraints such that when the ebpf program is removed any entries
> > > added by said ebpf program can be removed from the datapath.
> >
> > I suggested the such changes based on my interpretation of this long
> > and complex discussion, I can have missed some or many relevant points.
> > @Alexei: could you please double check the above and eventually,
> > hopefully, confirm that such change would lift your nacked-by?
>
> No. The whole design is broken.
> Remembering what was allocated by kfunc and freeing it later
> is not fixing the design at all.

Can you be a little less vague?
We are dealing with multiple domains here _including hw offloads_ and
as mentioned already, a few times now, for that reason these objects
belong to the P4TC domain. If it wasnt clear this diagram explains the
design:
https://github.com/p4tc-dev/docs/blob/main/images/why-p4tc/p4tc-runtime-pip=
eline.png
IOW, P4 objects(to be specific table entries in this discussion) may
be shared between s/w and/or h/w.
Note: there is no allocation done by the kfunc - it will just pick
from a fixed pool of pre-allocated entries. Where is the "design
broken" considering all this?

cheers,
jamal

