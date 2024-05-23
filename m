Return-Path: <bpf+bounces-30362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C6C8CCB37
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 05:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9262832AF
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 03:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E3533985;
	Thu, 23 May 2024 03:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b="ATuidPYX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0241750279
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 03:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716435312; cv=none; b=rt3ny0/COnyfE7EQ4eOVroMvS4RY90aN02B4C8GI18YHPSmUdUTF7vH4dbGPo5W7am6BP6c4PI/M2NO4MrT5ZBWMOfdKOUyiOX9cejJTaNNhqhrYcxEjWTePJL0FXOS5p53yrXNSYBYjyYoSATS/rDXc6OoFpc9jsS+o61cOYJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716435312; c=relaxed/simple;
	bh=oBGf6vt3RTHM7FXn1srDIybYLmEF4MZFFBbfs313abM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqihT+fwYKd98SUaHjCmCRbEfCG9mtaDsrN589eWxzMwLZWDA8+p8N5NLdGxi8ZtYtT0UUuuSjhQNwweB0RvwiNJfC+keVmwE/rJ+YZtTgWEmBhYrHXzxT5vAbVXbwEwqltqFSexMmZdGRfXt+z9MoX3bwXBzJ1GaAF1XxbtKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io; spf=pass smtp.mailfrom=sipanda.io; dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b=ATuidPYX; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipanda.io
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4df344eecd7so587475e0c.3
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 20:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sipanda-io.20230601.gappssmtp.com; s=20230601; t=1716435309; x=1717040109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f69QVyo+TVvJoU9bJvU+GUVUL+91NcSkTl/GGe0WaMM=;
        b=ATuidPYXaZLacpvRiW8Tr83ssTqO9MDp8EXVVFM5Y6r6Qu5GT4tMp9TRMWYXZp8ai3
         OFApauRaJBZi33pHpJrX3fg5GjpnvfyqQSj8+FGxPU8zjjSKmBNdqI8XZAw/TzJ+UZKR
         8ra+y+92Hv/9mLqb0tjDwNibBmyMoLLzgG2QaPiZ5jDC0Z7CNMMpLi5a+KQkxhD+FKsR
         Lah5+++dAgjZh2f8z//CLieb+yjkBu7pyVy3AE6q6NHFUIVydtN40lcQzs2ZFTVY9Gj9
         ZY7SHWxE76wRb7WXSL+Qgv04xABQTdlg7RGpALFb5aEBJTeFeR1JJ+ufY0OLR1MvwM/p
         VzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716435309; x=1717040109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f69QVyo+TVvJoU9bJvU+GUVUL+91NcSkTl/GGe0WaMM=;
        b=pwBnfTnRB5cl2WTYgXrpRMGZjHTKI6rT6ZWk/BUQCOSn6sfrvAzthM1Q6+/OqLohA5
         kDPAPgg7n47U3SJttTFd9Y9cvJp8oICtuBnz2SSD3UQZ+hC8MOuoMUxNDAzwNq15OHlk
         kAkBCKa8ZGog+YQyi0zSCvcZHmsrNyqJ3y7rrQVKQis63ewKqM7gICjURaciEBQfNMVy
         TJ677ElQGAE6W/+0OSeUOHFMV7WvVEhoD3AFKC5R4XO09IIBd8Uat8gW9Exi1dgsBmEs
         gmc4FGCFMKOiGAKMMtw3Q3Cp7f32TBkw3owNtRk6ushnO0hH9VFTApY7JTUflfpbI78d
         Ns7w==
X-Forwarded-Encrypted: i=1; AJvYcCXO9uRxv6MBaCHNzoXrvXF9d4PQUXL3yJYHv/N7hKBs9PgPyEFCr4CjL9kG4dwYUHBxknlbP//joSxg5P+SeLcS8EPf
X-Gm-Message-State: AOJu0YxgkObPCGYyt24G7qSyamcuSq+htvjkWuzeM1b60A44Y9zQosgq
	zjP5jWOUaeutTRrjtZdf19yriIHDKYeVJ4bfoqF4JkHXkDIPAEyidAIIwM6fEEKhMEKafzu1V0O
	erp2uaeqCDm/7HaP7mUPmzxNQO9AdnVvPN/XuaQ==
X-Google-Smtp-Source: AGHT+IGutc3aRxCOrfmymTRqRe9ooHPBdkYG4PoD1UKvQinng03m6VTkxGeD3SQWzCWekZP1TXWs2yTymZc8qv9NJ6U=
X-Received: by 2002:a05:6122:c9e:b0:4df:3558:5ba4 with SMTP id
 71dfb90a1353d-4e218571c17mr4520465e0c.6.1716435308734; Wed, 22 May 2024
 20:35:08 -0700 (PDT)
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
 <CAM0EoMmXYL6DYc8UogPpS1W2rXyT0Z8JTewLonb9Eze=ofsYOg@mail.gmail.com> <SN6PR17MB2110A8E11C444ABF8167D12296F42@SN6PR17MB2110.namprd17.prod.outlook.com>
In-Reply-To: <SN6PR17MB2110A8E11C444ABF8167D12296F42@SN6PR17MB2110.namprd17.prod.outlook.com>
From: Tom Herbert <tom@sipanda.io>
Date: Wed, 22 May 2024 20:34:57 -0700
Message-ID: <CAOuuhY9LOcuaP-fB+h+t6ABGvSTLvOfunSO14bADmc2NejAvjg@mail.gmail.com>
Subject: Re: DSL vs low level language WAS(Re: On the NACKs on P4TC patches
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

On Wed, May 22, 2024 at 7:30=E2=80=AFPM Chris Sommers
<chris.sommers@keysight.com> wrote:
>
> > On Wed, May 22, 2024 at 8:54=E2=80=AFPM Tom Herbert <mailto:tom@sipanda=
.io> wrote:
> > >
> > > On Wed, May 22, 2024 at 5:09=E2=80=AFPM Chris Sommers
> > > <mailto:chris.sommers@keysight.com> wrote:
> > > >
> > > > > On Wed, May 22, 2024 at 6:19=E2=80=AFPM Jakub Kicinski <mailto:ku=
ba@kernel.org> wrote:
> > > > > >
> > > > > > Hi Jamal!
> > > > > >
> > > > > > On Tue, 21 May 2024 08:35:07 -0400 Jamal Hadi Salim wrote:
> > > > > > > At that point(v16) i asked for the series to be applied despi=
te the
> > > > > > > Nacks because, frankly, the Nacks have no merit. Paolo was no=
t
> > > > > > > comfortable applying patches with Nacks and tried to mediate.=
 In his
> > > > > > > mediation effort he asked if we could remove eBPF - and our a=
nswer was
> > > > > > > no because after all that time we have become dependent on it=
 and
> > > > > > > frankly there was no technical reason not to use eBPF.
> > > > > >
> > > > > > I'm not fully clear on who you're appealing to, and I may be mi=
ssing
> > > > > > some points. But maybe it will be more useful than hurtful if I=
 clarify
> > > > > > my point of view.
> > > > > >
> > > > > > AFAIU BPF folks disagree with the use of their subsystem, and t=
hey
> > > > > > point out that P4 pipelines can be implemented using BPF in the=
 first
> > > > > > place.
> > > > > > To which you reply that you like (a highly dated type of) a net=
link
> > > > > > interface, and (handwavey) ability to configure the data path S=
W or
> > > > > > HW via the same interface.
> > > > >
> > > > > It's not what I "like" , rather it is a requirement to support bo=
th
> > > > > s/w and h/w offload. The TC model is the traditional approach to
> > > > > deploy these models. I addressed the same comment you are making =
above
> > > > > in #1a and #1b  (https://urldefense.com/v3/__https://github.com/p=
4tc-dev/pushback-patches__;!!I5pVk4LIGAfnvw!kaZ6EmPxEqGLG8JMw-_L0BgYq48Pe25=
wj6pHMF6BVei5WsRgwMeLQupmvgvLyN-LgXacKBzzs0-w2zKP2A$).
> > >> >
> > > > > OTOH, "BPF folks disagree with the use of their subsystem" is a
> > > > > problematic statement. Is BPF infra for the kernel community or i=
s it
> > > > > something the ebpf folks can decide, at their whim, to allow who =
they
> > > > > like to use or not. We are not changing any BPF code. And there's
> > > > > already a case where the interfaces are used exactly as we used t=
hem
> > > > > in the conntrack code i pointed to in the page (we literally copi=
ed
> > > > > that code). Why is it ok for conntrack code to use exactly the sa=
me
> > > > > approach but not us?
> > > > >
> > > > > > AFAICT there's some but not very strong support for P4TC,
> > > > >
> > > > > I dont agree. Paolo asked this question and afaik Intel, AMD (bot=
h
> > > > > build P4-native NICs) and the folks interested in the MS DASH pro=
ject
> > > > > responded saying they are in support. Look at who is being Cced. =
A lot
> > > > > of these folks who attend biweekly discussion calls on P4TC. Samp=
le:
> > > > > https://urldefense.com/v3/__https://lore.kernel.org/netdev/IA0PR1=
7MB7070B51A955FB8595FFBA5FB965E2@IA0PR17MB7070.namprd17.prod.outlook.com/__=
;!!I5pVk4LIGAfnvw!kaZ6EmPxEqGLG8JMw-_L0BgYq48Pe25wj6pHMF6BVei5WsRgwMeLQupmv=
gvLyN-LgXacKBzzs09TFzoQBw$
> > >> >
> > > > +1
> > > > > > and it
> > > > > > doesn't benefit or solve any problems of the broader networking=
 stack
> > > > > > (e.g. expressing or configuring parser graphs in general)
> > > > > >
> > > > >
> > > >
> > > > Huh? As a DSL, P4 has already been proven to be an extremely effect=
ive and popular way to express parse graphs, stack manipulation, and statef=
ul programming. Yesterday, I used the P4TC dev branch to implement somethin=
g in one sitting, which includes parsing RoCEv2 network stacks. I just cut =
and pasted P4 code originally written for a P4 ASIC into a working P4TC exa=
mple to add functionality. It took mere seconds to compile and launch it, a=
nd a few minutes to test it. I know of no other workflow which provides suc=
h quick turnaround and is so accessible. I'd like it to be as ubiquitous as=
 eBPF itself.
> > >
> > > Chris,
> > >
> > > When you say "it took mere seconds to compile and launch" are you
> > > taking into account the ramp up time that it takes to learn P4 and
> > > become proficient to do something interesting?
>
> Hi Tom, thanks for the dialog. To answer your question, it took seconds t=
o compile and deploy, not learn P4. Adding the parsing for several headers =
took minutes. If you want to compare learning curve, learning to write P4 c=
ode and let the framework handle all the painful low-level Linux details is=
 way easier than trying to learn how to write c code for Linux networking. =
It=E2=80=99s not even close. I=E2=80=99ve written C for 40 years, P4 for 7 =
years, and dabbled in eBPF so I can attest to the ease of learning and usin=
g P4. I=E2=80=99ve onboarded and mentored engineers who barely knew C, to d=
evelop complex networking products using P4, and built the automation APIs =
(REST, gRPC) to manage them. One person can develop an entire commercial pr=
oduct by themselves in months. P4 has expanded the reach of programmers suc=
h that both HW and SW engineers can easily learn P4 and become pretty adept=
 at it. I would not expect even experienced c programmers to be able to mas=
ter Linux internals very quickly. Writing a P4-TC program and injecting it =
via tc was like magic the first time.
>
> >> Considering that P4
> > > syntax is very different from typical languages than networking
> > > programmers are typically familiar with, this ramp up time is
> > > non-zero. OTOH, eBPF is ubiquitous because it's primarily programmed
> > > in Restricted C-- this makes it easy for many programmers since they
> > > don't have to learn a completely new language and so the ramp up time
> > > for the average networking programmer is much less for using eBPF.
>
> I think your statement about =E2=80=9Ctypical network programmers=E2=80=
=9D overlooks the fact that since P4 was introduced, it has been taught in =
many universities to teach networking and possibly enabled a whole new bree=
d of =E2=80=9Cnetwork engineers=E2=80=9D who can solve real problems withou=
t even knowing C programming. Without P4 they might never have gone this ro=
ute. A class in network stack programming using c would have so many prereq=
uisites to even get to parsing, compared to P4, where it could be demonstra=
ted in one lesson. These =E2=80=9Cnetworking programmers=E2=80=9D are not t=
ypical by your standards, but there are many such. They have just as much c=
laim to the title "network programmer=E2=80=9D as a C programmer. Similarly=
, an assembly language programmer is no less than a C or Python programmer.=
 People writing P4 are usually focused on applications, and it is very usef=
ul and productive for that. Why should someone have to learn low-level C or=
 eBPF to solve their problem?

Hio Chris,

You're comparing learning a completely new language versus programming
in a subset of an established language, they're really not comparable.
When one programs in Restricted-C they just need to understand what
features of C are supported.

>
> > >
> > > This is really the fundamental problem with DSLs, they require
> > > specialized skill sets in a programming language for a narrow use cas=
e
> > > (and specialized compilers, tool chains, debugging, etc)-- this means
> > > a DSL only makes sense if there is no other means to accomplish the
> > > same effects using a commodity language with perhaps a specialized
> > > library (it's not just in the networking realm, consider the
> > > advantages of using CUDA-C instead of a DLS for GPUs).
>
> A pretty strong opinion, but DSLs arise to fill a need and P4 did so. It'=
s still going strong.
>
> >> Personally, I
> > > don't believe that P4 has yet to be proven necessary for programming =
a
> > > datapath-- for instance we can program a parser in declarative
> > > representation in C,
> > > https://urldefense.com/v3/__https://netdevconf.info/0x16/papers/11/Hi=
gh*20Performance*20Programmable*20Parsers.pdf__;JSUl!!I5pVk4LIGAfnvw!m9zrSD=
vddfzSt_sMBjOEvqw31RzAwWlEDM4ah5IJ2kqsmq6XtPIVJd-1_ZoGWBXKLyda77RYLvGR83Gin=
w$.
>
> CPL (slide11) looks like a DSL wrapped in JSON to me. =E2=80=9CSolution: =
Common Parser Language (CPL); Parser representation in declarative .json=E2=
=80=9D So I am confused. It is either a new language a.k.a. DSL, or it's no=
t. Nothing against it, I'm sure it is great, but let's call it what it is.

Correct, it's not a new language. We've since renamed it Common Parser
Representation.

> We already have parser representations in declarative p4. And it's used a=
nd known worldwide. And has a respectable specification, any users and work=
ing groups. And it's formally provable (https://github.com/verified-network=
-toolchain/petr4)
>
> > >
> > > So unless P4 is proven necessary, then I'm doubtful it will ever be a
> > > ubiquitous way to program the kernel-- it seems much more likely that
> > > people will continue to use C and eBPF, and for those users that want
> > > to use P4 they can use P4->eBPF compiler.
>
> =E2=80=9Cubiquitous way to program the kernel=E2=80=9D =E2=80=93 is not m=
y goal. I don=E2=80=99t even want to know about the kernel when I am writin=
g p4 - it's just a means to an end. I want to manipulate packets on a Linux=
 host. P4DPDK, P4-eBPF, P4-TC =E2=80=93 all let me do that. I LOVE the fact=
 that P4-TC would be available in every Linux distro once upstreamed. It wo=
uld solve so many deployment issues, benefit from regression testing, etc. =
So much goodness
>
> " and for those users that want to use P4 they can use P4->eBPF compiler.=
" -I'd really like to choose for myself and not have someone make that choi=
ce for me. P4-TC checks all the boxes for me.

Sure, but this is a lot of kernel code and that will require support
and maintenance. It needs to be justified, and the fact that someone
wants it just to have a choice is, frankly, not much of a
justification. I think a justification needs to start with "Why isn't
P4->eBPF sufficient?" (the question has been raised several times, but
it still doesn't seem like there's a strong answer).

Tom
>
> Thanks for the point of view, it's healthy to debate.
> Cheers,
> Chris
>
> > >
> >
> > Tom,
> > I cant stop the distraction of this thread becoming a discussion on
> > the merits of DSL vs a lower level language (and I know you are not a
> > P4 fan) but please change the subject so we dont loose the main focus
> > which is a discussion on the patches. I have done it for you. Chris if
> > you wish to respond please respond under the new thread subject.
> >
> > cheers,
> > jamal
>

