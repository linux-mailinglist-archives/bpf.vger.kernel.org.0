Return-Path: <bpf+bounces-30350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F698CCA32
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 02:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BC31F22A21
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 00:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1F91860;
	Thu, 23 May 2024 00:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b="T/VNGJIU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FD7A34
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 00:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716425694; cv=none; b=VGZbPWQ9gdv8nZzF9KfRp18JNpOIg1NKEaEPXnY8cpuyzp6uWNkfPE8cR/zEtD0rM09W+Cx1e5SVWjspem9SdkSupAEUuvM67Zqdb7v9Jbzd+T1W9Uyqs2oD/h3+5xnLFosTkB0pPHT/7/frIdwHMX/1JCjTv4j98/5/UyLED0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716425694; c=relaxed/simple;
	bh=O1WHjZJymFnGRouBJaPdjzV5wjlbGyIE+SCp4B78YRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaTYXXpCwSE8jZuDLzlLRXNNeHwraiqCtItr0MpqPUO0s5T5RylsFIQOLiBu69IMTb2dY215/YRTs6bwO8gQc+O/iJXJlhQ+GoIi3aMuDVhG/IVzwWdCMgeksGCi+xn6276QC+jkr6QT1p7yHh1D1jOGkhkAlc6ec9HRVkss6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io; spf=pass smtp.mailfrom=sipanda.io; dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b=T/VNGJIU; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipanda.io
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4df550a4d4fso1638874e0c.2
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 17:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sipanda-io.20230601.gappssmtp.com; s=20230601; t=1716425691; x=1717030491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgj4UmFTr180aw+Q9LOrencRDZA3L6tGCCpIwP02e/g=;
        b=T/VNGJIUGHzpqa+GsdECSZkdPuOyQkUEee41mLUihCtY375wBv68zj16ZOo9zriB2e
         KAxk+2E2kgJa4ZK+EUSWJHBH7clqhPgauZQzkBC5xahf9Crf42i9vRbZ4XUbhdo+RFIf
         xDQWqJRqFYpFN2QaY6E/AEvjiC6gNpJBilJG2FIGqqpNLhrnDYaGudsWJyccoSsspRr0
         hRXXbS8UMGdDd4CqyrCZBkVx9wvM3NRVaBBnSsgm8uq0LBYc4ZyC9xZDNImsctt+Ez/p
         9l3lum4zGJTGr4ht3z0KJ/GiSwBCd4d/6KNuey2J4fXQ6jVlqlTEDERjhqXROKn4VV9G
         KBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716425691; x=1717030491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgj4UmFTr180aw+Q9LOrencRDZA3L6tGCCpIwP02e/g=;
        b=vZ84NNdXxbPeI04FnO2S/lDiwCeb1LMdzoOF1GbKV1ilKr+phL0jPsYFXm07aLWDhW
         sGm6RRNrZmLEm5Hzd6YJFGpPJU+utmh+f4aS0vh7yEk9q4uLzkCxP64KdGVoiOJduhWV
         YDZnXKeGrXZQuNnGPLHt/hXuPDcSb6zUTr6Ki8aO6x8YzsatPpc0R6E6bSI2/uB40Q6U
         igbY4DUSRy4xKjcBTo8OaCn16Hchw0eT2cwSKSIwZZIV2e0wqyOY2ga0Q0TSow2Ir7B9
         GXOUV47bKeudApQ4g3UONihYDiOXp3D/Qr6Tbc/A6RElgumwbWhk7WUzds2gKx6G5s80
         lb4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzdtaAcTPnKq3zrZKa/kPYnVWGvUa0637euKbrbVZQm45TCtjz/k5+PFB+D7JuZqjLmZe+oaf9PYH5NCY6CfuY8A+u
X-Gm-Message-State: AOJu0Yx3/DTVHiVaRajSHq9RUitkCDu9ees5PEtmpPFm+zz8rzPSVxAj
	V0wRz3b40BYl22T3lsHEYpL7wg3Y3eIYpG9VoQPRbpgCDbV5RuezSKfZNj+I6lASZyq0UEVyyxt
	lpgBSA5wo8JK4/efzPJ26xIlCzdpBo6aSQinQKA==
X-Google-Smtp-Source: AGHT+IFVzPRkwAhHK0CMph+h3235lUDV2e5htJVe7dQOMJ9f+PovoOXaKnXTRbHdAYMEG0hmim4xuU3UQSsREUlxDhg=
X-Received: by 2002:a05:6122:2218:b0:4df:7ba8:5c73 with SMTP id
 71dfb90a1353d-4e21862b088mr3833224e0c.14.1716425690827; Wed, 22 May 2024
 17:54:50 -0700 (PDT)
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
 <CAADnVQLugkg+ahAapskRaE86=RnwpY8v=Nre8pn=sa4fTEoTyA@mail.gmail.com>
 <CAM0EoM=2wHem54vTeVq4H1W5pawYuHNt-aS9JyG8iQORbaw5pA@mail.gmail.com>
 <CAM0EoMmCz5usVSLq_wzR3s7UcaKifa-X58zr6hkPXuSBnwFX3w@mail.gmail.com>
 <CAM0EoMmsB5jHZ=4oJc_Yzm=RFDUHWh9yexdG6_bPFS4_CFuiog@mail.gmail.com>
 <20240522151933.6f422e63@kernel.org> <CAM0EoMmFrp5X5OzMbum5i_Bjng7Bhtk1YvWpacW6FV6Oy-3avg@mail.gmail.com>
 <SN6PR17MB211069668AF4C8031B116B9D96EB2@SN6PR17MB2110.namprd17.prod.outlook.com>
In-Reply-To: <SN6PR17MB211069668AF4C8031B116B9D96EB2@SN6PR17MB2110.namprd17.prod.outlook.com>
From: Tom Herbert <tom@sipanda.io>
Date: Wed, 22 May 2024 17:54:39 -0700
Message-ID: <CAOuuhY9b6WZd6eunVGr6QQ=sd7KLvx7OVn4ozzon3+ABRQaYeQ@mail.gmail.com>
Subject: Re: On the NACKs on P4TC patches
To: Chris Sommers <chris.sommers@keysight.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Network Development <netdev@vger.kernel.org>, 
	"Chatterjee, Deb" <deb.chatterjee@intel.com>, Anjali Singhai Jain <anjali.singhai@intel.com>, 
	"Limaye, Namrata" <namrata.limaye@intel.com>, Marcelo Ricardo Leitner <mleitner@redhat.com>, 
	"Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, "Osinski, Tomasz" <tomasz.osinski@intel.com>, 
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, Khalid Manaa <khalidm@nvidia.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	"Jain, Vipin" <Vipin.Jain@amd.com>, "Daly, Dan" <dan.daly@intel.com>, 
	Andy Fingerhut <andy.fingerhut@gmail.com>, Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>, 
	"lwn@lwn.net" <lwn@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 5:09=E2=80=AFPM Chris Sommers
<chris.sommers@keysight.com> wrote:
>
> > On Wed, May 22, 2024 at 6:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > Hi Jamal!
> > >
> > > On Tue, 21 May 2024 08:35:07 -0400 Jamal Hadi Salim wrote:
> > > > At that point(v16) i asked for the series to be applied despite the
> > > > Nacks because, frankly, the Nacks have no merit. Paolo was not
> > > > comfortable applying patches with Nacks and tried to mediate. In hi=
s
> > > > mediation effort he asked if we could remove eBPF - and our answer =
was
> > > > no because after all that time we have become dependent on it and
> > > > frankly there was no technical reason not to use eBPF.
> > >
> > > I'm not fully clear on who you're appealing to, and I may be missing
> > > some points. But maybe it will be more useful than hurtful if I clari=
fy
> > > my point of view.
> > >
> > > AFAIU BPF folks disagree with the use of their subsystem, and they
> > > point out that P4 pipelines can be implemented using BPF in the first
> > > place.
> > > To which you reply that you like (a highly dated type of) a netlink
> > > interface, and (handwavey) ability to configure the data path SW or
> > > HW via the same interface.
> >
> > It's not what I "like" , rather it is a requirement to support both
> > s/w and h/w offload. The TC model is the traditional approach to
> > deploy these models. I addressed the same comment you are making above
> > in #1a and #1b  (https://urldefense.com/v3/__https://github.com/p4tc-de=
v/pushback-patches__;!!I5pVk4LIGAfnvw!kaZ6EmPxEqGLG8JMw-_L0BgYq48Pe25wj6pHM=
F6BVei5WsRgwMeLQupmvgvLyN-LgXacKBzzs0-w2zKP2A$).
> >
> > OTOH, "BPF folks disagree with the use of their subsystem" is a
> > problematic statement. Is BPF infra for the kernel community or is it
> > something the ebpf folks can decide, at their whim, to allow who they
> > like to use or not. We are not changing any BPF code. And there's
> > already a case where the interfaces are used exactly as we used them
> > in the conntrack code i pointed to in the page (we literally copied
> > that code). Why is it ok for conntrack code to use exactly the same
> > approach but not us?
> >
> > > AFAICT there's some but not very strong support for P4TC,
> >
> > I dont agree. Paolo asked this question and afaik Intel, AMD (both
> > build P4-native NICs) and the folks interested in the MS DASH project
> > responded saying they are in support. Look at who is being Cced. A lot
> > of these folks who attend biweekly discussion calls on P4TC. Sample:
> > https://urldefense.com/v3/__https://lore.kernel.org/netdev/IA0PR17MB707=
0B51A955FB8595FFBA5FB965E2@IA0PR17MB7070.namprd17.prod.outlook.com/__;!!I5p=
Vk4LIGAfnvw!kaZ6EmPxEqGLG8JMw-_L0BgYq48Pe25wj6pHMF6BVei5WsRgwMeLQupmvgvLyN-=
LgXacKBzzs09TFzoQBw$
> >
> +1
> > > and it
> > > doesn't benefit or solve any problems of the broader networking stack
> > > (e.g. expressing or configuring parser graphs in general)
> > >
> >
>
> Huh? As a DSL, P4 has already been proven to be an extremely effective an=
d popular way to express parse graphs, stack manipulation, and stateful pro=
gramming. Yesterday, I used the P4TC dev branch to implement something in o=
ne sitting, which includes parsing RoCEv2 network stacks. I just cut and pa=
sted P4 code originally written for a P4 ASIC into a working P4TC example t=
o add functionality. It took mere seconds to compile and launch it, and a f=
ew minutes to test it. I know of no other workflow which provides such quic=
k turnaround and is so accessible. I'd like it to be as ubiquitous as eBPF =
itself.

Chris,

When you say "it took mere seconds to compile and launch" are you
taking into account the ramp up time that it takes to learn P4 and
become proficient to do something interesting? Considering that P4
syntax is very different from typical languages than networking
programmers are typically familiar with, this ramp up time is
non-zero. OTOH, eBPF is ubiquitous because it's primarily programmed
in Restricted C-- this makes it easy for many programmers since they
don't have to learn a completely new language and so the ramp up time
for the average networking programmer is much less for using eBPF.

This is really the fundamental problem with DSLs, they require
specialized skill sets in a programming language for a narrow use case
(and specialized compilers, tool chains, debugging, etc)-- this means
a DSL only makes sense if there is no other means to accomplish the
same effects using a commodity language with perhaps a specialized
library (it's not just in the networking realm, consider the
advantages of using CUDA-C instead of a DLS for GPUs). Personally, I
don't believe that P4 has yet to be proven necessary for programming a
datapath-- for instance we can program a parser in declarative
representation in C,
https://netdevconf.info/0x16/papers/11/High%20Performance%20Programmable%20=
Parsers.pdf.

So unless P4 is proven necessary, then I'm doubtful it will ever be a
ubiquitous way to program the kernel-- it seems much more likely that
people will continue to use C and eBPF, and for those users that want
to use P4 they can use P4->eBPF compiler.

Tom
>
> > I am not sure where the parser thing comes from - the parser is
> > generated as eBPF.
> >
> > > So from my perspective, the submission is neither technically strong
> > > enough, nor broadly useful enough to consider making questionable pre=
cedents
> > > for, i.e. to override maintainers on how their subsystems are extende=
d.
> I disagree vehemently on the "broadly useful enough" comment.
> >
> > I believe as a community nobody should just have the power to nack
> > things just because - as i stated in the page, not even Linus. That
> > code doesnt touch anything to do with eBPF maintainers (meaning things
> > they have to fix when an issue shows up) neither does it "extend" as
> > you state any ebpf code and it is all part of the networking
> > subsystem. Sure,  anybody has the right to nack but  I contend that
> > nacks should be based on technical reasons. I have listed all the
> > objections in that page and how i have responded to them over time.
> > Someone needs to look at those objectively and say if they are valid.
> > The arguement made so far(By Paolo and now by you)  is "we cant
> > override maintainers on how their subsystems are used" then we are in
> > uncharted territory, thats why i am asking for arbitration.
> >
> > cheers,
> > jamal
> Maintainers: I am perplexed and dismayed that this is getting so much pus=
hback. None of the objections, regardless of their merits (or not) seem to =
outweigh the potential benefits to end-users. I am extremely interested in =
using P4TC, it adds a lot of value and reuses so much existing Linux infra.=
 The custom extern model is compelling. The control plane CRUDXPS will tie =
nicely into P4Runtime and TDI. I have an application which needs to run pur=
ely in SW - no HW offload, so prior suggestions to wait for it to "approve"=
 this is frustrating.  I could use this yesterday. Furthermore, as an activ=
e contributor to sonic-dash, where we model the pipeline in P4, I can state=
 that P4TC could be a compelling alternative to bmv2, which is slow, long i=
n the tooth and lacks PNA support.
>
> I beseech the NACKers to take a deep breath, reevaluate any entrenched po=
sitions and consider how much goodness this will add, even if this is not y=
our preference for implementing datapaths. It doesn't have to be. That can =
and should be decided by the larger community. This could open the door to =
thousands of creative developers who are comfortable in P4 but not adept in=
 low-level networking code. P4 had a significant impact on democratizing ne=
twork programming, and that was just on bmv2 and Tofino, which is EOL. Maki=
ng performant and powerful P4TC ubiquitous on virtually any Linux server co=
uld have a similar effect, just like eBPF opened a lot of doors to non-kern=
el programmers to do interesting things. Be a part of that transformation!

