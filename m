Return-Path: <bpf+bounces-30031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7468C9FC8
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 17:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860F51F21C45
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 15:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0997713777A;
	Mon, 20 May 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Bo0qlp5V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9624E137762
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219308; cv=none; b=J/A9ngflh8kc8i06aR8ABuo0BtJqKPtvROa8IctycJvlGceWbWhzdMwibxKKQIkbRY0dgyvxxXTGTeO1eyY1rOTN4/bZxctZI9l6Cy08VkSFwLzg9dUbYzleQ3vwVKYWFGO12cblYWhXHpxQuNmlHsU+ZwnVh9CuMzLQJz6cGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219308; c=relaxed/simple;
	bh=MSxu+HGaY9QQr+D8gjg097hWj2cKWOCRnwai5jbXaSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fS2IgAbutbBAPGwsM7BChRNXtjvhxmbjB5q7OqRqxwJooNfi6ME3fz8915Yu13n0U4Yy+YZd83Ynv6GCJosY4Bt2JpwBHDAPMYhOR3zP7b8VRAxn5f7fuYnotF67UM9ti/dG2NShWC1y/VRCUkeFb/eABh8qqJbfPzgs3ElT3b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Bo0qlp5V; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6153d85053aso16753207b3.0
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1716219305; x=1716824105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8NxCwhYu5RmY6sB2ta4dWVpE5LLZaG45BsTVcPnVcE=;
        b=Bo0qlp5V6S5a+PJwcQ477yXwjQeUsltpnX/F2J3qQYN9MOEBTr3Apw4M36Vp8Eomh+
         klhmpkv6rev2PP/Cec7GLeMR49FQC7Vj54KAh5X+DDHt8nBpK66zMbfNk6qFmvIwrgDY
         oJLlRlJrqaqmjPgwg+fLDCLfUGgN85vdhFqlRW4ItgTHqugOPqHdfHMqfZYTancVJ6Cw
         LBOVuoHqLd8igB+zlcHe8Nqz/8ADQRDrAw5dPBwYo2BZvRYdEw72x/6RRJ7kaN/0RVCw
         7e0WTCsSquFT278au6WvG28+LU987vRO5m7rYBsPrmv2qjZGt/RQRrjD2PHzqtowGBPb
         acZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716219305; x=1716824105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8NxCwhYu5RmY6sB2ta4dWVpE5LLZaG45BsTVcPnVcE=;
        b=ZmzqRbYvE/BPWvbCYTqVgNzV4F5dXUB80foMbyt0OFTYKhR0IqJ269a4sF604iThIZ
         rlkCY4mQq4vCRqNyFJw7ES3bco8Zd9y5UjXvkfrhc3/cxXv7QlS57Z7XCO/SyRYnlum8
         wwCgIov2igaDLGekRo8diyrDBD+4KyQYk0ELooVakAU6roB/iiBzEOOgiOLfuiO70lz+
         4d6CMi1XTTcIYc6R9o4ykclC33FS0f3x4mLISaMvb2adKKgMnHRQwvay8PBIUsOeE0hE
         q7irkRXdTY+TARrgjLG5smd2/waI7yixVtgQQZbe6pId+fybosbi6YN/qbC7HGPG7Jl8
         /akw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ6I9/npzzy7LsxEKgdQoiAI7/Gnmt/XHNJ7s6BWhcmMyy3e+XSFwdtSlMHlooi6FhfKOg34T69ReVNmiUT7B90mkq
X-Gm-Message-State: AOJu0YzwfgOdcQ7MQUuLvkKn1OYZy34hZ66FrVreej9Wep+G39JvWE0J
	iFRJIw3BcISpi+lk4+yCKXyN0oZsSKLLu38h9ZWn6Zth8ehRnPBVC3TYzvoRbrccprRZNc8JdJO
	9m78mW/qhSRqzRXqmxT/CYnqEV1JioKdGfELD
X-Google-Smtp-Source: AGHT+IGHdg6HaR73XeTStF9zXMs16M7jkyhc80uaYmxslGmzdOW7IqjXVye5sLRLMSz1gV/Dj+0I+upwUSZjizR2ljg=
X-Received: by 2002:a81:6905:0:b0:615:3858:d154 with SMTP id
 00721157ae682-627af8a4b66mr29719887b3.30.1716219304005; Mon, 20 May 2024
 08:35:04 -0700 (PDT)
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
 <82ee1013ca0164053e9fb1259eaf676343c430e8.camel@redhat.com>
 <CAADnVQLugkg+ahAapskRaE86=RnwpY8v=Nre8pn=sa4fTEoTyA@mail.gmail.com> <CAM0EoM=2wHem54vTeVq4H1W5pawYuHNt-aS9JyG8iQORbaw5pA@mail.gmail.com>
In-Reply-To: <CAM0EoM=2wHem54vTeVq4H1W5pawYuHNt-aS9JyG8iQORbaw5pA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 20 May 2024 11:34:52 -0400
Message-ID: <CAM0EoMmCz5usVSLq_wzR3s7UcaKifa-X58zr6hkPXuSBnwFX3w@mail.gmail.com>
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

On Fri, Apr 26, 2024 at 2:03=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Fri, Apr 26, 2024 at 1:43=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Apr 26, 2024 at 10:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com=
> wrote:
> > >
> > > On Fri, 2024-04-26 at 13:12 -0400, Jamal Hadi Salim wrote:
> > > > On Fri, Apr 19, 2024 at 2:01=E2=80=AFPM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> > > > >
> > > > > On Fri, Apr 19, 2024 at 1:20=E2=80=AFPM Paolo Abeni <pabeni@redha=
t.com> wrote:
> > > > > >
> > > > > > On Fri, 2024-04-19 at 08:08 -0400, Jamal Hadi Salim wrote:
> > > > > > > On Thu, Apr 11, 2024 at 12:24=E2=80=AFPM Jamal Hadi Salim <jh=
s@mojatatu.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Apr 11, 2024 at 10:07=E2=80=AFAM Paolo Abeni <paben=
i@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, 2024-04-10 at 10:01 -0400, Jamal Hadi Salim wrote=
:
> > > > > > > > > > The only change that v16 makes is to add a nack to patc=
h 14 on kfuncs
> > > > > > > > > > from Daniel and John. We strongly disagree with the nac=
k; unfortunately I
> > > > > > > > > > have to rehash whats already in the cover letter and ha=
s been discussed over
> > > > > > > > > > and over and over again:
> > > > > > > > >
> > > > > > > > > I feel bad asking, but I have to, since all options I hav=
e here are
> > > > > > > > > IMHO quite sub-optimal.
> > > > > > > > >
> > > > > > > > > How bad would be dropping patch 14 and reworking the rest=
 with
> > > > > > > > > alternative s/w datapath? (I guess restoring it from olde=
st revision of
> > > > > > > > > this series).
> > > > > > > >
> > > > > > > >
> > > > > > > > We want to keep using ebpf  for the s/w datapath if that is=
 not clear by now.
> > > > > > > > I do not understand the obstructionism tbh. Are users allow=
ed to use
> > > > > > > > kfuncs as part of infra or not? My understanding is yes.
> > > > > > > > This community is getting too political and my worry is tha=
t we have
> > > > > > > > corporatism creeping in like it is in standards bodies.
> > > > > > > > We started by not using ebpf. The same people who are objec=
ting now
> > > > > > > > went up in arms and insisted we use ebpf. As a member of th=
is
> > > > > > > > community, my motivation was to meet them in the middle by
> > > > > > > > compromising. We invested another year to move to that midd=
le ground.
> > > > > > > > Now they are insisting we do not use ebpf because they dont=
 like our
> > > > > > > > design or how we are using ebpf or maybe it's not a use cas=
e they have
> > > > > > > > any need for or some other politics. I lost track of the mo=
ving goal
> > > > > > > > posts. Open source is about solving your itch. This code is=
 entirely
> > > > > > > > on TC, zero code changed in ebpf core. The new goalpost is =
based on
> > > > > > > > emotional outrage over use of functions. The whole thing is=
 getting
> > > > > > > > extremely toxic.
> > > > > > > >
> > > > > > >
> > > > > > > Paolo,
> > > > > > > Following up since no movement for a week now;->
> > > > > > > I am going to give benefit of doubt that there was miscommuni=
cation or
> > > > > > > misunderstanding for all the back and forth that has happened=
 so far
> > > > > > > with the nackers. I will provide a summary below on the main =
points
> > > > > > > raised and then provide responses:
> > > > > > >
> > > > > > > 1) "Use maps"
> > > > > > >
> > > > > > > It doesnt make sense for our requirement. The reason we are u=
sing TC
> > > > > > > is because a) P4 has an excellent fit with TC match action pa=
radigm b)
> > > > > > > we are targeting both s/w and h/w and the TC model caters wel=
l for
> > > > > > > this. The objects belong to TC, shared between s/w, h/w and c=
ontrol
> > > > > > > plane (and netlink is the API). Maybe this diagram would help=
:
> > > > > > > https://github.com/p4tc-dev/docs/blob/main/images/why-p4tc/p4=
tc-runtime-pipeline.png
> > > > > > >
> > > > > > > While the s/w part stands on its own accord (as elaborated ma=
ny
> > > > > > > times), for TC which has offloads, the s/w twin is introduced=
 before
> > > > > > > the h/w equivalent. This is what this series is doing.
> > > > > > >
> > > > > > > 2) "but ... it is not performant"
> > > > > > > This has been brought up in regards to netlink and kfuncs. Pe=
rformance
> > > > > > > is a lower priority to P4 correctness and expressibility.
> > > > > > > Netlink provides us the abstractions we need, it works with T=
C for
> > > > > > > both s/w and h/w offload and has a lot of knowledge base for
> > > > > > > expressing control plane APIs. We dont believe reinventing al=
l that
> > > > > > > makes sense.
> > > > > > > Kfuncs are a means to an end - they provide us the gluing we =
need to
> > > > > > > have an ebpf s/w datapath to the TC objects. Getting an extra
> > > > > > > 10-100Kpps is not a driving factor.
> > > > > > >
> > > > > > > 3) "but you did it wrong, here's how you do it..."
> > > > > > >
> > > > > > > I gave up on responding to this - but do note this sentiment =
is a big
> > > > > > > theme in the exchanges and consumed most of the electrons. We=
 are
> > > > > > > _never_ going to get any consensus with statements like "tc a=
ctions
> > > > > > > are a mistake" or "use tcx".
> > > > > > >
> > > > > > > 4) "... drop the kfunc patch"
> > > > > > >
> > > > > > > kfuncs essentially boil down to function calls. They don't re=
quire any
> > > > > > > special handling by the eBPF verifier nor introduce new seman=
tics to
> > > > > > > eBPF. They are similar in nature to the already existing kfun=
cs
> > > > > > > interacting with other kernel objects such as nf_conntrack.
> > > > > > > The precedence (repeated in conferences and email threads mul=
tiple
> > > > > > > times) is: kfuncs dont have to be sent to ebpf list or review=
ed by
> > > > > > > folks in the ebpf world. And We believe that rule applies to =
us as
> > > > > > > well. Either kfuncs (and frankly ebpf) is infrastructure glue=
 or it's
> > > > > > > not.
> > > > > > >
> > > > > > > Now for a little rant:
> > > > > > >
> > > > > > > Open source is not a zero-sum game. Ebpf already coexists wit=
h
> > > > > > > netfilter, tc, etc and various subsystems happily.
> > > > > > > I hope our requirement is clear and i dont have to keep justi=
fying why
> > > > > > > P4 or relitigate over and over again why we need TC. Open sou=
rce is
> > > > > > > about scratching your itch and our itch is totally contained =
within
> > > > > > > TC. I cant help but feel that this community is getting way t=
oo
> > > > > > > pervasive with politics and obscure agendas. I understand age=
ndas, I
> > > > > > > just dont understand the zero-sum thinking.
> > > > > > > My view is this series should still be applied with the nacks=
 since it
> > > > > > > sits entirely on its own silo within networking/TC (and has n=
othing to
> > > > > > > do with ebpf).
> > > > > >
> > > > > > It's really hard for me - meaning I'll not do that - applying a=
 series
> > > > > > that has been so fiercely nacked, especially given that the oth=
er
> > > > > > maintainers are not supporting it.
> > > > > >
> > > > > > I really understand this is very bad for you.
> > > > > >
> > > > > > Let me try to do an extreme attempt to find some middle ground =
between
> > > > > > this series and the bpf folks.
> > > > > >
> > > > > > My understanding is that the most disliked item is the lifecycl=
e for
> > > > > > the objects allocated via the kfunc(s).
> > > > > >
> > > > > > If I understand correctly, the hard requirement on bpf side is =
that any
> > > > > > kernel object allocated by kfunc must be released at program un=
load
> > > > > > time. p4tc postpone such allocation to recycle the structure.
> > > > > >
> > > > > > While there are other arguments, my reading of the past few ite=
rations
> > > > > > is that solving the above node should lift the nack, am I corre=
ct?
> > > > > >
> > > > > > Could p4tc pre-allocate all the p4tc_table_entry_act_bpf_kern e=
ntries
> > > > > > and let p4a_runt_create_bpf() fail if the pool is empty? would =
that
> > > > > > satisfy the bpf requirement?
> > > > >
> > > > > Let me think about it and weigh the consequences.
> > > > >
> > > >
> > > > Sorry, was busy evaluating. Yes, we can enforce the memory allocati=
on
> > > > constraints such that when the ebpf program is removed any entries
> > > > added by said ebpf program can be removed from the datapath.
> > >
> > > I suggested the such changes based on my interpretation of this long
> > > and complex discussion, I can have missed some or many relevant point=
s.
> > > @Alexei: could you please double check the above and eventually,
> > > hopefully, confirm that such change would lift your nacked-by?
> >
> > No. The whole design is broken.
> > Remembering what was allocated by kfunc and freeing it later
> > is not fixing the design at all.
>
> Can you be a little less vague?
> We are dealing with multiple domains here _including hw offloads_ and
> as mentioned already, a few times now, for that reason these objects
> belong to the P4TC domain. If it wasnt clear this diagram explains the
> design:
> https://github.com/p4tc-dev/docs/blob/main/images/why-p4tc/p4tc-runtime-p=
ipeline.png
> IOW, P4 objects(to be specific table entries in this discussion) may
> be shared between s/w and/or h/w.
> Note: there is no allocation done by the kfunc - it will just pick
> from a fixed pool of pre-allocated entries. Where is the "design
> broken" considering all this?

Ok, not that i was expecting an answer and i think i have waited long enoug=
h.

Frankly my agreement to make the change and the time spent to validate
were just an attempt to make an effort for a compromise (as we have
done many many times) - but really that approach works against our
requirements to control the aging/deletion/replacement policy. I dont
believe there's any good faith from the nackers. For that reason that
offer is off the table.
It should be noted our changes that Alexei is objecting to is more
tame than for example
https://elixir.bootlin.com/linux/latest/source/net/netfilter/nf_conntrack_b=
pf.c#L318
We didnt see Alexeis nack on that code.

I am not asking to be given speacial treatment but it is clear we have
a hole in the process currently. All i am asking for is fair
treatment. At this point, given that Paolo says the patches cant be
applied because of 3 cross-subsystem nacks, my suggestion on how we
resolve this is to appoint a third person arbitrator. This person
cannot be part of the TC or eBPF collective and has to be agreed to by
both parties.

Hopefully this will introduce some new set of rules that will help the
maintainers resolve such issues should they surface in the future.

I will collect all the other issues raised and my responses and create
a web page so things dont get lost in the noise. I will post then and
maybe send to a wider audience.

cheers,
jamal



> cheers,
> jamal

