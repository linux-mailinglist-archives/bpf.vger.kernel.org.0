Return-Path: <bpf+bounces-30784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0A38D25A0
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 22:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0EEB28363E
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 20:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6870613541F;
	Tue, 28 May 2024 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy5CLpCw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890F12FB2;
	Tue, 28 May 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927438; cv=none; b=MkUGS9T3oyCEem/SKevj58GA/doXri/VIui69Q3pQHsJGqz8Xurd3s/ERL0w9IG3HZMKci8TOKPrGX01Hw8WFS6HyStgB0qfTyst1Qb3vc2Osjgoj7lSjHJuw1L8qHeHD+RX4HdZOjy2MwFteQg82Hvcg79JugAbLE0abMpaGXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927438; c=relaxed/simple;
	bh=9Y+P2KpKHW1U7yLlmRN2EvaFeljAXuogWsp5LEzvlW8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=P7aONBvxKIXwLRUC6QyKLz1aPd2/jLYqtb1+57pTbEc3rpBJFOKtST0u3ahRJrRssrv/GM8YnWvNp0JeLnVeBMaIa09uzZLq+Xl2RFlB3esJ3NONY79ADN0OjNqlU5sRrZ+o1yChjvc2BdaMLtsvC+t3BwZvvLEbYtQPetrLHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy5CLpCw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f6bddf57f6so1285777b3a.0;
        Tue, 28 May 2024 13:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716927436; x=1717532236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y+P2KpKHW1U7yLlmRN2EvaFeljAXuogWsp5LEzvlW8=;
        b=Cy5CLpCw+/PkSm2GQItPgL1t7rbQiIF2J74iHMsYqRP/jxuo9Ywu5ghJsAsqSWiTAd
         lzZArPVwV0TiQVuzJUG327aOS8MA7Hpv8wdCltgBMwkoMKE02OkBZ3Oo+JcobybDyuqr
         9DNB8DE29c71itUpMz7MuDAdwaFDh59WGtxAL++b8CfuGc8ZQuUy25jfXqSJQTH72zIH
         EMjVjqNwxAGspM4XvTuO+JQ5qWDg2KJkf0m1yph3us9gmR01/xweKsHrNIEk9ISyfZTu
         cebNiad0EIs3BVQJpxoQAltuG37sWqzZyGKicDk1lp9JAr7Po8op8HGvo3hncNGSRqdO
         89HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716927436; x=1717532236;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Y+P2KpKHW1U7yLlmRN2EvaFeljAXuogWsp5LEzvlW8=;
        b=E0VJGafj/XMZtkuKqlj/xzK/cSTdoo2RlLuiZVYXyQAa/RR4nyxtwu/IbatvXj2kc0
         6Zvsj1rBIkUerWSODGq1KUMB121xj+hdv4t1lJGt+b6HVfNkwto1Vi+agbRoMToWQxcX
         HFSqnwqjTPauNoW38eiyr5EEZE4zigl5H2VckThMmE7TUMe+KgjErvrnzC4XBYTynY35
         6fLYnOK17z/+uqmd1kPZdYPCCWeixMrXTh6wABWNWQBn7zOAXEWRnd0tFv8JuR6AT2+8
         uClSl4y6a1PeDU81UpbdBQDxUBWxRdy3SR4UByfScCinPMGB1jH/5MzBOU1wu3E+Y5BQ
         Gh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwRdaAj4cv2tD8bFGSg1GUPB/NfY5eBaCRlSzryRimitZq3Is2/JWtYaVr4dhzs/rpN1dFD0XK5uRjv4+PtOPT78pR8VJilE5gagMdJvJnHSk7+LEl5llpyBtK
X-Gm-Message-State: AOJu0YxMBCabJ0BAig8+9THbNPkvgyXV3V1eTD4mxg8r4txa++AHJk/l
	EM4mJhlmw6GA8So8kLCPbArB8QBqGYRdpbqa+0ueRnzmeVQg/NmV
X-Google-Smtp-Source: AGHT+IHNnAskNR+easnKIdoqAkGbqU5hQUmA0TRuc7hnD2fLHEopNJFsvFFODYWZYIZZMV4gJ6Jexw==
X-Received: by 2002:a05:6a20:978e:b0:1b1:d519:6cce with SMTP id adf61e73a8af0-1b212e3548amr11775583637.57.1716927435796;
        Tue, 28 May 2024 13:17:15 -0700 (PDT)
Received: from localhost ([98.97.41.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc05e1fasm6789241b3a.70.2024.05.28.13.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:17:15 -0700 (PDT)
Date: Tue, 28 May 2024 13:17:12 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: "Jain, Vipin" <Vipin.Jain@amd.com>, 
 "Singhai, Anjali" <anjali.singhai@intel.com>, 
 "Hadi Salim, Jamal" <jhs@mojatatu.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Network Development <netdev@vger.kernel.org>, 
 "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
 "Limaye, Namrata" <namrata.limaye@intel.com>, 
 tom Herbert <tom@sipanda.io>, 
 Marcelo Ricardo Leitner <mleitner@redhat.com>, 
 "Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, 
 "Osinski, Tomasz" <tomasz.osinski@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Cong Wang <xiyou.wangcong@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Vlad Buslov <vladbu@nvidia.com>, 
 Simon Horman <horms@kernel.org>, 
 Khalid Manaa <khalidm@nvidia.com>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Victor Nogueira <victor@mojatatu.com>, 
 "Tammela, Pedro" <pctammela@mojatatu.com>, 
 "Daly, Dan" <dan.daly@intel.com>, 
 Andy Fingerhut <andy.fingerhut@gmail.com>, 
 "Sommers, Chris" <chris.sommers@keysight.com>, 
 Matty Kadosh <mattyk@nvidia.com>, 
 bpf <bpf@vger.kernel.org>, 
 "lwn@lwn.net" <lwn@lwn.net>
Message-ID: <66563bc85f5d0_2f7f2087@john.notmuch>
In-Reply-To: <MW4PR12MB719209644426A0F5AE18D2E897F62@MW4PR12MB7192.namprd12.prod.outlook.com>
References: <20240410140141.495384-1-jhs@mojatatu.com>
 <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
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
 <20240522151933.6f422e63@kernel.org>
 <CAM0EoMmFrp5X5OzMbum5i_Bjng7Bhtk1YvWpacW6FV6Oy-3avg@mail.gmail.com>
 <CO1PR11MB499350FC06A5B87E4C770CCE93F42@CO1PR11MB4993.namprd11.prod.outlook.com>
 <MW4PR12MB71927C9E4B94871B45F845DF97F52@MW4PR12MB7192.namprd12.prod.outlook.com>
 <MW4PR12MB719209644426A0F5AE18D2E897F62@MW4PR12MB7192.namprd12.prod.outlook.com>
Subject: Re: On the NACKs on P4TC patches
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jain, Vipin wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> =

> My apologies, earlier email used html and was blocked by the list...
> My response at the bottom as "VJ>"
> =

> ________________________________________
> From: Jain, Vipin <Vipin.Jain@amd.com>
> Sent: Friday, May 24, 2024 2:28 PM
> To: Singhai, Anjali <anjali.singhai@intel.com>; Hadi Salim, Jamal <jhs@=
mojatatu.com>; Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>; Alexei Starovoitov <alexei.starovo=
itov@gmail.com>; Network Development <netdev@vger.kernel.org>; Chatterjee=
, Deb <deb.chatterjee@intel.com>; Limaye, Namrata <namrata.limaye@intel.c=
om>; tom Herbert <tom@sipanda.io>; Marcelo Ricardo Leitner <mleitner@redh=
at.com>; Shirshyad, Mahesh <Mahesh.Shirshyad@amd.com>; Osinski, Tomasz <t=
omasz.osinski@intel.com>; Jiri Pirko <jiri@resnulli.us>; Cong Wang <xiyou=
.wangcong@gmail.com>; David S. Miller <davem@davemloft.net>; Eric Dumazet=
 <edumazet@google.com>; Vlad Buslov <vladbu@nvidia.com>; Simon Horman <ho=
rms@kernel.org>; Khalid Manaa <khalidm@nvidia.com>; Toke H=C3=B8iland-J=C3=
=B8rgensen <toke@redhat.com>; Victor Nogueira <victor@mojatatu.com>; Tamm=
ela, Pedro <pctammela@mojatatu.com>; Daly, Dan <dan.daly@intel.com>; Andy=
 Fingerhut <andy.fingerhut@gmail.com>; Sommers, Chris <chris.sommers@keys=
ight.com>; Matty Kadosh <mattyk@nvidia.com>; bpf <bpf@vger.kernel.org>; l=
wn@lwn.net <lwn@lwn.net>
> Subject: Re: On the NACKs on P4TC patches
> =

> [AMD Official Use Only - AMD Internal Distribution Only]
> =

> =

> I can ascertain (from AMD) that we have stated interest in, and are in =
full support of P4TC.
> =

> Happy to elaborate more if needed.
> =

> Thank you,
> Vipin Jain
> Sr Fellow Engineer, AMD
> ________________________________________
> From: Singhai, Anjali <anjali.singhai@intel.com>
> Sent: Wednesday, May 22, 2024 5:30 PM
> To: Hadi Salim, Jamal <jhs@mojatatu.com>; Jakub Kicinski <kuba@kernel.o=
rg>
> Cc: Paolo Abeni <pabeni@redhat.com>; Alexei Starovoitov <alexei.starovo=
itov@gmail.com>; Network Development <netdev@vger.kernel.org>; Chatterjee=
, Deb <deb.chatterjee@intel.com>; Limaye, Namrata <namrata.limaye@intel.c=
om>; tom Herbert <tom@sipanda.io>; Marcelo Ricardo Leitner <mleitner@redh=
at.com>; Shirshyad, Mahesh <Mahesh.Shirshyad@amd.com>; Osinski, Tomasz <t=
omasz.osinski@intel.com>; Jiri Pirko <jiri@resnulli.us>; Cong Wang <xiyou=
.wangcong@gmail.com>; David S. Miller <davem@davemloft.net>; Eric Dumazet=
 <edumazet@google.com>; Vlad Buslov <vladbu@nvidia.com>; Simon Horman <ho=
rms@kernel.org>; Khalid Manaa <khalidm@nvidia.com>; Toke H=C3=B8iland-J=C3=
=B8rgensen <toke@redhat.com>; Victor Nogueira <victor@mojatatu.com>; Tamm=
ela, Pedro <pctammela@mojatatu.com>; Jain, Vipin <Vipin.Jain@amd.com>; Da=
ly, Dan <dan.daly@intel.com>; Andy Fingerhut <andy.fingerhut@gmail.com>; =
Sommers, Chris <chris.sommers@keysight.com>; Matty Kadosh <mattyk@nvidia.=
com>; bpf <bpf@vger.kernel.org>; lwn@lwn.net <lwn@lwn.net>
> Subject: RE: On the NACKs on P4TC patches
> =

> Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> =

> =

> On Wed, May 22, 2024 at 6:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> =

> >> AFAICT there's some but not very strong support for P4TC,
> =

> On Wed, May 22, 2024 at 4:04=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com > wrote:
> >I dont agree. Paolo asked this question and afaik Intel, AMD (both bui=
ld P4-native NICs) and the folks interested in the MS DASH project >respo=
nded saying they are in support. Look at who is being Cced. A lot of thes=
e folks who attend biweekly discussion calls on P4TC. >Sample:
> >https://lore.kernel.org/netdev/IA0PR17MB7070B51A955FB8595FFBA5FB965E2@=
IA0PR17MB7070.namprd17.prod.outlook.com/
> =

> FWIW, Intel is in full support of P4TC as we have stated several times =
in the past.

> VJ> I can ascertain (from AMD) that we have stated interest in, and are=
 in full support of P4TC. Happy to elaborate more if needed.
> VJ> Thanks, Vipin

Anjali and Vipin is your support for HW support of P4 or a Linux SW imple=
mentation
of P4. If its for HW support what drivers would we want to support? Can y=
ou
describe how to program these devices?

At the moment there hasn't been any movement on Linux hardware P4 support=
 side
as far as I can tell. Yes there are some SDKs and build kits floating aro=
und for
FPGAs. For example maybe start with what drivers in kernel tree run the D=
PUs that
have this support? I think this would be a productive direction to go if =
we in
fact have hardware support in the works.

If you want a SW implementation in Linux my opinion is still pushing a DS=
L
into the kernel datapath via qdisc/tc is the wrong direction. Mapping P4
onto hardware blocks is fundamentally different architecture from mapping=

P4 onto general purpose CPU and registers. My opinion -- to handle this y=
ou
need a per architecture backend/JIT to compile the P4 to native instructi=
ons.
This will give you the most flexibility to define new constructs, best
performance, and lowest overhead runtime. We have a P4 BPF backend alread=
y
and JITs for most architectures I don't see the need for P4TC in this
context.

If the end goal is a hardware offload control plane I'm skeptical we
even need something specific just for SW datapath. I would propose
a devlink or new infra to program the device directly vs overhead and
complexity of abstracting through 'tc'. If you want to emulate your
device use BPF or user space datapath.

.John=

