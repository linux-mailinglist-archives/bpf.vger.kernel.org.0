Return-Path: <bpf+bounces-30353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEB78CCA4C
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 03:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDA21C21173
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 01:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF6C1C20;
	Thu, 23 May 2024 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="sKs1szHq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D717F7
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716426798; cv=none; b=SfEo/jS4YqLE5BaUKxoL1TAberL5lCBKbY473HoMn4tagEzYo2MXtvjD5raEz5Tqlqa9HGWieTE30S4DfOqhEsyHCV29TcZigQo3rlyORzH678oArBBgcIjC8Uzk/kp4bJniee9w+QXZJe3d+Yi/8Ymzb18vWhi50BtU+BNWFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716426798; c=relaxed/simple;
	bh=2SKcrlnBytKF0j4pQGaWoT9a0uQYVGGqNJxBxGDLBow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvNk7bFArE4+HJRkWiF/n3bDA5B5rpORezA1aTPJIK6OKu4/pxSDez/3WZgI81yLVIV5NQ4SKfEzCcCW9FE+e58GyuhQxLeTth8NMD+IcOQzGAN/NtVxfIvM68K+1B8TayjGM4gcy5MRlcuZFgoZRgrh9pfb/9n1KN+T+RG3Tko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=sKs1szHq; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62027fcf9b1so12439207b3.0
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 18:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1716426796; x=1717031596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lix3bwIsB89Scv4YFzgh7jCLHwNnugJ6sY5h3rwk76c=;
        b=sKs1szHq1yBlQbSB9QgRYWB6Ut1at0sSk//Ro/xka4OAiYXuTLH+BQuMq6E2AhpO6w
         rg0Nswu2G/qs3VdHHO//xqFWwqUuj0yd8+bXib263WU/mULn9nO5oqbiQ9YqzWiritlc
         a2+pdTuvm9+PBg50z6qhvxouaneq/jM5oqe0qsoJO7qZWTb4F/9a8ZoGeMV8UkwQkUz6
         Xgn0T4TRaKDUeUcD4ngC+uzAZSt+K0phZFo1WoFzuTFc4MPQp8UUidQLtTrTB7uPAikz
         8Kfu+8VaNYm4wvbJtcJR5fB3kNOf3NsoNIURRjuGwIhksYi53iNpHErrCI5wFHOvRaZA
         eO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716426796; x=1717031596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lix3bwIsB89Scv4YFzgh7jCLHwNnugJ6sY5h3rwk76c=;
        b=GqpZhV8OYS4vbwOByKLgLEd+KyE+SK2kMz1qDIsmCKbB0taFYb54NuL2+rA+MnCrCT
         shwGuN+Uz2fPtNnsXYySeCJwCrZl6PaSaSiDC22Z7GqkV3TpppLmVYf6nh2agcTH7Jma
         5wX1rM1QrfzzRyz6uoWDTNCq8ZhPs7NnM+wA+TLEZ9RtplkfabzJLCRwedkJV0HFgxhD
         uHSTU0jfmSGTpcI11wNHZP1gH0pqInZiGxm+jHLWLYCtEP7NbvSWrYTV+GcpS9DRR5Yt
         IMBqdaINfOIQBOawIwPIMQpWv9Cx+TzdvSmJ/r6Se2N7AbgQy9rKZ+g1Vjb3iAodWL9E
         ebBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqcasDEZsZSHgEYvN0uXnAbQsMZKS9solSTXFj2wevh6Rx4M27RshWj/gTutP9t2ufsoOXhkM8SybvmdsyLApKvnex
X-Gm-Message-State: AOJu0Yy0pBtY/6hx9UqZXmWmjEouNhROABgi3GFIW/1u7pJliGoevxxu
	A1N84AmFNPpYrPwc/q2qobeufb1CihkPIEFRD0P0OUf4GN5RPyJPMajygrk6M863SVYDg2WDtU2
	vdNHlPBK8mB8G3qgZbKc/Y9p2ivGpEIqFUvEt
X-Google-Smtp-Source: AGHT+IGFG5871jyxjZ4Cty0k2DGee/T/CKj+rXiWsHJeLh8bsJNWzFvkpj6zYjn1yxsPEj7JnaX+DDsABUizNxUCzeM=
X-Received: by 2002:a0d:d50d:0:b0:627:a505:9295 with SMTP id
 00721157ae682-6283449e03fmr6643747b3.11.1716426795716; Wed, 22 May 2024
 18:13:15 -0700 (PDT)
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
 <CAOuuhY9b6WZd6eunVGr6QQ=sd7KLvx7OVn4ozzon3+ABRQaYeQ@mail.gmail.com>
In-Reply-To: <CAOuuhY9b6WZd6eunVGr6QQ=sd7KLvx7OVn4ozzon3+ABRQaYeQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 22 May 2024 21:13:04 -0400
Message-ID: <CAM0EoMmXYL6DYc8UogPpS1W2rXyT0Z8JTewLonb9Eze=ofsYOg@mail.gmail.com>
Subject: DSL vs low level language WAS(Re: On the NACKs on P4TC patches
To: Tom Herbert <tom@sipanda.io>
Cc: Chris Sommers <chris.sommers@keysight.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, "Limaye, Namrata" <namrata.limaye@intel.com>, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, "Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, 
	"Osinski, Tomasz" <tomasz.osinski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Khalid Manaa <khalidm@nvidia.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	"Jain, Vipin" <Vipin.Jain@amd.com>, "Daly, Dan" <dan.daly@intel.com>, 
	Andy Fingerhut <andy.fingerhut@gmail.com>, Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>, 
	"lwn@lwn.net" <lwn@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 8:54=E2=80=AFPM Tom Herbert <tom@sipanda.io> wrote:
>
> On Wed, May 22, 2024 at 5:09=E2=80=AFPM Chris Sommers
> <chris.sommers@keysight.com> wrote:
> >
> > > On Wed, May 22, 2024 at 6:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > >
> > > > Hi Jamal!
> > > >
> > > > On Tue, 21 May 2024 08:35:07 -0400 Jamal Hadi Salim wrote:
> > > > > At that point(v16) i asked for the series to be applied despite t=
he
> > > > > Nacks because, frankly, the Nacks have no merit. Paolo was not
> > > > > comfortable applying patches with Nacks and tried to mediate. In =
his
> > > > > mediation effort he asked if we could remove eBPF - and our answe=
r was
> > > > > no because after all that time we have become dependent on it and
> > > > > frankly there was no technical reason not to use eBPF.
> > > >
> > > > I'm not fully clear on who you're appealing to, and I may be missin=
g
> > > > some points. But maybe it will be more useful than hurtful if I cla=
rify
> > > > my point of view.
> > > >
> > > > AFAIU BPF folks disagree with the use of their subsystem, and they
> > > > point out that P4 pipelines can be implemented using BPF in the fir=
st
> > > > place.
> > > > To which you reply that you like (a highly dated type of) a netlink
> > > > interface, and (handwavey) ability to configure the data path SW or
> > > > HW via the same interface.
> > >
> > > It's not what I "like" , rather it is a requirement to support both
> > > s/w and h/w offload. The TC model is the traditional approach to
> > > deploy these models. I addressed the same comment you are making abov=
e
> > > in #1a and #1b  (https://urldefense.com/v3/__https://github.com/p4tc-=
dev/pushback-patches__;!!I5pVk4LIGAfnvw!kaZ6EmPxEqGLG8JMw-_L0BgYq48Pe25wj6p=
HMF6BVei5WsRgwMeLQupmvgvLyN-LgXacKBzzs0-w2zKP2A$).
> > >
> > > OTOH, "BPF folks disagree with the use of their subsystem" is a
> > > problematic statement. Is BPF infra for the kernel community or is it
> > > something the ebpf folks can decide, at their whim, to allow who they
> > > like to use or not. We are not changing any BPF code. And there's
> > > already a case where the interfaces are used exactly as we used them
> > > in the conntrack code i pointed to in the page (we literally copied
> > > that code). Why is it ok for conntrack code to use exactly the same
> > > approach but not us?
> > >
> > > > AFAICT there's some but not very strong support for P4TC,
> > >
> > > I dont agree. Paolo asked this question and afaik Intel, AMD (both
> > > build P4-native NICs) and the folks interested in the MS DASH project
> > > responded saying they are in support. Look at who is being Cced. A lo=
t
> > > of these folks who attend biweekly discussion calls on P4TC. Sample:
> > > https://urldefense.com/v3/__https://lore.kernel.org/netdev/IA0PR17MB7=
070B51A955FB8595FFBA5FB965E2@IA0PR17MB7070.namprd17.prod.outlook.com/__;!!I=
5pVk4LIGAfnvw!kaZ6EmPxEqGLG8JMw-_L0BgYq48Pe25wj6pHMF6BVei5WsRgwMeLQupmvgvLy=
N-LgXacKBzzs09TFzoQBw$
> > >
> > +1
> > > > and it
> > > > doesn't benefit or solve any problems of the broader networking sta=
ck
> > > > (e.g. expressing or configuring parser graphs in general)
> > > >
> > >
> >
> > Huh? As a DSL, P4 has already been proven to be an extremely effective =
and popular way to express parse graphs, stack manipulation, and stateful p=
rogramming. Yesterday, I used the P4TC dev branch to implement something in=
 one sitting, which includes parsing RoCEv2 network stacks. I just cut and =
pasted P4 code originally written for a P4 ASIC into a working P4TC example=
 to add functionality. It took mere seconds to compile and launch it, and a=
 few minutes to test it. I know of no other workflow which provides such qu=
ick turnaround and is so accessible. I'd like it to be as ubiquitous as eBP=
F itself.
>
> Chris,
>
> When you say "it took mere seconds to compile and launch" are you
> taking into account the ramp up time that it takes to learn P4 and
> become proficient to do something interesting? Considering that P4
> syntax is very different from typical languages than networking
> programmers are typically familiar with, this ramp up time is
> non-zero. OTOH, eBPF is ubiquitous because it's primarily programmed
> in Restricted C-- this makes it easy for many programmers since they
> don't have to learn a completely new language and so the ramp up time
> for the average networking programmer is much less for using eBPF.
>
> This is really the fundamental problem with DSLs, they require
> specialized skill sets in a programming language for a narrow use case
> (and specialized compilers, tool chains, debugging, etc)-- this means
> a DSL only makes sense if there is no other means to accomplish the
> same effects using a commodity language with perhaps a specialized
> library (it's not just in the networking realm, consider the
> advantages of using CUDA-C instead of a DLS for GPUs). Personally, I
> don't believe that P4 has yet to be proven necessary for programming a
> datapath-- for instance we can program a parser in declarative
> representation in C,
> https://netdevconf.info/0x16/papers/11/High%20Performance%20Programmable%=
20Parsers.pdf.
>
> So unless P4 is proven necessary, then I'm doubtful it will ever be a
> ubiquitous way to program the kernel-- it seems much more likely that
> people will continue to use C and eBPF, and for those users that want
> to use P4 they can use P4->eBPF compiler.
>

Tom,
I cant stop the distraction of this thread becoming a discussion on
the merits of DSL vs a lower level language (and I know you are not a
P4 fan) but please change the subject so we dont loose the main focus
which is a discussion on the patches. I have done it for you. Chris if
you wish to respond please respond under the new thread subject.

cheers,
jamal

cheers,
jamal

