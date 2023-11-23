Return-Path: <bpf+bounces-15775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56E27F67B4
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 20:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24D31C20EC8
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 19:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F384CE0B;
	Thu, 23 Nov 2023 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b="vEBMb5po"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFA6D43
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 11:42:38 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-462bf380db8so392974137.3
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 11:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sipanda-io.20230601.gappssmtp.com; s=20230601; t=1700768558; x=1701373358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWJgw3aPVSq+8D52wYLj9ZUVgr5BEKBb6emdOqu32NE=;
        b=vEBMb5poc6BKJSro7nC6bip89GI8yp3s/BqnU+V2QM9HwW9cZnaaP1lH5WqsZEQnB/
         0wX7Lpk+v9RNcUsGCkZk28ccZGSnOY5G6JQpjKQPBQcF/2Elpn9ukPh+tzCH6G8xLDHF
         a1YEeHNtK4RC9PK0ZEd/on97BDd8tPIGmR4sJv4CV7fIBwkbzN3aCqopmPOUAeWHUg4F
         QqeD/saTiY2pcaeCls4xhk3h2vVMoetGO6CLKovmRHmInjDzSirHYnRU9ta7iO9c+tTI
         qyNlVzbavqcqtPQnIwsb6dYy1Wt9ZN6j32H3vn34g40wwJCa/4i970deJvALHTzBhgDk
         rRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700768558; x=1701373358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWJgw3aPVSq+8D52wYLj9ZUVgr5BEKBb6emdOqu32NE=;
        b=u0SkrFOl9eHsOBrJv6W59l++eoGETOPX9YAbjSOMVy4PzBWhnIFuN6u8EFY6CgJCu+
         Es1ezQilmf8D59UuElcbh9VQSI4BMOR7UGOHYH+jepU+pjdGvOP4GH++2pF2vCYY1bMP
         UU9rD9SiEgTrUdhbSRRegn689c/IzD0vUnndAgeO9dWZY82sGhFSft4GjepGkfjcjdcv
         7F2FKdVs6cIZIuo4/p+7TwBdhsyMHMKRbNbEelTqSkIrYLUaeTw+M0FFUGubKJO8rgdT
         BLO8OeSoPvY4W6k2cNi7Sie6Av4tTUA2urFqU8dnTR+RZNctVeCC4PF9mPAsTje4fHHD
         oHog==
X-Gm-Message-State: AOJu0YzdIHsOS/uXRJZkm87vWhEMtvWuj/shkWo8sJDR2zyUiLQBwwtG
	asQJOmwyIS3XeDWjXIrW8/2DK6MmZE8M0i21/yUDUQ==
X-Google-Smtp-Source: AGHT+IHZvaFF+cfz6vCuBd7iO/hQTtU1hnnks3N8dOIsf6KmA1HxY2DGl1/PxYYQiHCj1pIU4owsaLtPFMWDuQGdjXc=
X-Received: by 2002:a67:f64f:0:b0:45d:ad5d:41b4 with SMTP id
 u15-20020a67f64f000000b0045dad5d41b4mr580985vso.26.1700768557938; Thu, 23 Nov
 2023 11:42:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZV3JJQirPdZpbVIC@nanopsycho> <CAM0EoM=R1H1iGQDZs3m7tY7f++VWzPegvSdt=MfN0wvFXdT+Mg@mail.gmail.com>
 <ZV5I/F+b5fu58Rlg@nanopsycho> <CAM0EoM=RR6kcdHsGhFNUeDc96rSDa8S7SP7GQOeXrZBN_P7jtQ@mail.gmail.com>
 <ZV7y9JG0d4id8GeG@nanopsycho> <CAM0EoMkOvEnPmw=0qye9gWAqgbZjaTYZhiho=qmG1x4WiQxkxA@mail.gmail.com>
 <ZV9U+zsMM5YqL8Cx@nanopsycho> <CAM0EoMnFB0hgcVFj3=QN4114HiQy46uvYJKqa7=p2VqJTwqBsg@mail.gmail.com>
 <ZV9csgFAurzm+j3/@nanopsycho> <CAM0EoMkgD10dFvgtueDn7wjJTFTQX6_mkA4Kwr04Dnwp+S-u-A@mail.gmail.com>
 <ZV9vfYy42G0Fk6m4@nanopsycho> <CAM0EoMkC6+hJ0fb9zCU8bcKDjpnz5M0kbKZ=4GGAMmXH4_W8rg@mail.gmail.com>
 <0d1d37f9-1ef1-4622-409e-a976c8061a41@gmail.com> <20231123105305.7edeab94@kernel.org>
In-Reply-To: <20231123105305.7edeab94@kernel.org>
From: Tom Herbert <tom@sipanda.io>
Date: Thu, 23 Nov 2023 11:42:26 -0800
Message-ID: <CAOuuhY-MmuN6N9qp_TuyFoOEsxFz5oimtkzY5xHt_nxpoiFguQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
To: Jakub Kicinski <kuba@kernel.org>
Cc: Edward Cree <ecree.xilinx@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, deb.chatterjee@intel.com, 
	anjali.singhai@intel.com, Vipin.Jain@amd.com, namrata.limaye@intel.com, 
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, bpf@vger.kernel.org, 
	khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com, dan.daly@intel.com, 
	chris.sommers@keysight.com, john.andy.fingerhut@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 10:53=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 23 Nov 2023 17:53:42 +0000 Edward Cree wrote:
> > The kernel doesn't like to trust offload blobs from a userspace compile=
r,
> >  because it has no way to be sure that what comes out of the compiler
> >  matches the rules/tables/whatever it has in the SW datapath.
> > It's also a support nightmare because it's basically like each user
> >  compiling their own device firmware.
>

Hi Jakub,

> Practically speaking every high speed NIC runs a huge binary blob of FW.
> First, let's acknowledge that as reality.
>
Yes. But we're also seeing a trend for programmable NICs. It's an
interesting question as to how the kernel can leverage that
programmability for the benefit of the user.

> Second, there is no equivalent for arbitrary packet parsing in the
> kernel proper. Offload means take something form the host and put it
> on the device. If there's nothing in the kernel, we can't consider
> the new functionality an offload.

That's completely true, however I believe that eBPF has expanded our
definition of "what's in the kernel". For instance, we can do
arbitrary parsing in an XDP/eBPF program (in fact, it's still on my
list of things to do to rip out Flow dissector C code and replace it
with eBPF).

(https://netdevconf.info/0x15/slides/16/Flow%20dissector_PANDA%20parser.pdf=
,
https://www.youtube.com/watch?v=3DzVnmVDSEoXc&list=3DPLrninrcyMo3L-hsJv23hF=
yDGRaeBY1EJO)

>
> I understand that "we offload SW functionality" is our general policy,
> but we should remember why this policy is in place, and not
> automatically jump to the conclusion.
>
> >  At least normally with device firmware the driver side is talking to
> >  something with narrow/fixed semantics and went through upstream
> >  review, even if the firmware side is still a black box.
>
> We should be buildings things which are useful and open (as in
> extensible by people "from the street"). With that in mind, to me,
> a more practical approach would be to try to figure out a common
> and rigid FW interface for expressing the parsing graph.

Parse graphs are best represented by declarative representation, not
an imperative one. This is a main reason why I want to replace flow
dissector, a parser written in imperative C code is difficult to
maintain as evident by the myriad of bugs in that code (particularly
when people added support or uncommon protocols). P4 got this part
right, however I don't believe we need to boil the ocean by
programming the kernel in a new language. A better alternative is to
define an IR that contains for this purpose.  We do that in Common
Parser Language (CPL) which is a .json schema to describe parse
graphs. With an IR we can compile into arbitrary backends including
P4, eBPF, C, and even custom assembly instructions for parsing
(arbitrary font ends languages are facilitated as well).

(https://netdevconf.info/0x16/papers/11/High%20Performance%20Programmable%2=
0Parsers.pdf)

>
> But that's an interface going from the binary blob to the kernel.
>
> > Just to prove I'm not playing favourites: this is *also* a problem with
> >  eBPF offloads like Nanotubes, and I'm not convinced we have a viable
> >  solution yet.
>
> BPF offloads are actual offloads. Config/state is in the kernel,
> you need to pop it out to user space, then prove that it's what
> user intended.

Seems like offloading eBPF byte code and running a VM in the offload
device is pretty much considered a non-starter. But, what if we could
offload the _functionality_ of an eBPF program with confidence that
the functionality _exactly_ matches that of the eBPF program running
in the kernel? I believe that could be beneficial.

For instance, we all know that LRO never gained traction. The reason
is because each vendor does it however they want and no one can match
the exact functionality that SW GRO provides. It's not an offload of
kernel SW, so it's not viable. But, suppose we wrote GRO in some
program that could be compiled into eBPF and a device binary. Using
something like that hash technique I described, it seems like we could
properly do a kernel offload of GRO where the offload functionality
matches the software in the kernel.

Tom

