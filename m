Return-Path: <bpf+bounces-23274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4288D86F64C
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 18:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E11D1C21F07
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49114745D5;
	Sun,  3 Mar 2024 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="mKSpHJfO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B337442E
	for <bpf@vger.kernel.org>; Sun,  3 Mar 2024 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709485224; cv=none; b=OdlySuzG1d819HMp3P6v2kqUfUeRHbwzh3q0k5IdT/+3+8YneSl9eya1zAIT07DwTXUcOOdLDHREReZhS/EV4RB5kVAVfHS6dPdfg772zxcK0IOpXCIXqrIK51xwFbDEGV3rOIet2bfILy3Mbo5hp9W81KgSGFedX15yOdOFJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709485224; c=relaxed/simple;
	bh=6hM86TZFlnW2rqg3g5DrdGIS8dUokaKQr8fUx+R7m1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9ObNYi7skN6Tgw47HoJhkqwEuQNZ7KdZNdTCkdZiwwc2t3ftBu+pZPCbHqySLo9WzAOZ1/xUUJ7PsiXqXXKRZRt8aG8TMdTSgOu+EWwzBNkI2qruu+ibW3fxI9jsCacROal8QLBVMfh+5iJcuKN4tmL3q6a7F/+zAIoc+qygQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=mKSpHJfO; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso3423684276.0
        for <bpf@vger.kernel.org>; Sun, 03 Mar 2024 09:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709485222; x=1710090022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtHIEqA95BLcb4KA1MqZLjqSfIrZVIkGKofkJStzLtQ=;
        b=mKSpHJfOckgHlvreZC3P4xGhTipm7XAeKHGW9HOgHWKqZpcg/52J+10lhHMRewZJsx
         XOO8bXCUTLqaUa6ICl/3W4JzbbyM0Ks09TxGItDpPMRRpihE3RnkhfGE3V4NqxyhypOA
         nF2RZsEtYaLAJb6/1hmZfYDHA+qWvwQHlZ9sIr0mTgUlRyyatTZY03t5ngF3ELzeAgUp
         Jabiv9RM0WHGMqDigtMSDsE3Ydi6E4ABdE+cTtGTW9I8ly08b6xDsTopLeKepxbRb8EP
         h03uUjw9w70z4rNtbPTkX1SLGyAS1/TEq1CbT6xTYVIGg0KAJff4pHZE4B7w/6Uq7R/n
         rQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709485222; x=1710090022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtHIEqA95BLcb4KA1MqZLjqSfIrZVIkGKofkJStzLtQ=;
        b=R24vUZV5Y1b330A5zIy4EHGZsiXtOZr0reg0KXgKkbf6C+7WEzMydWl6mzzERTMSLE
         y4DiHh7mZOi/x2L95n+yBS2o8+3vfhmRiEtUvV4SMwiqYChxxrSrLRmht6WaYXtUOhOU
         kdbzOMpeZkTLKiB+RxQRggy7emfy+WwFHtnp+YZE6LG783v+/h/WSBzHd4eQJmwmDPE4
         4Ey0CqM03EiSHLeHU5m0vxQ3WaKrYD0sy4g4XTlW4IM+I7q1qiLcfzs0bnUTXpNtWZdm
         IYbum0DSpt3J39B1wIUv3n7pzvXK3xltIKDMNyVDz1ard2TWpcaIqlrj68Y1EgHZW9/5
         24VA==
X-Forwarded-Encrypted: i=1; AJvYcCUnicJZkNNIBDq8ZFxw33T/F9F5JtAXm3BL2yk4x072LqaKzE6sqIHiIKYVkwv4Jo5Fcw9CS3dkc6kRfYPhBB6iRsjX
X-Gm-Message-State: AOJu0YzphVJXoBUBPuXEpwFIZcPGw6RY38/UFgT0SptQuzH03i52WgUV
	NlE6eTVVZBS6K8F0JioqVrjBZxmww+zVjlVA+T/p9BenIAMMbf4bcU4AalnSRl6l9yGCI1Y5SKd
	PqSwfTbHf5n33/6uKHuaTZgG5M04JBOxGOrPq
X-Google-Smtp-Source: AGHT+IGoksMYCiZy5fdgawjF9WK2nfCpbX+0kQIL6BvMzquQe1UE5bLi2kizxmD9P2BChB/nfjop278BMLgAmk/ZKrs=
X-Received: by 2002:a25:ae89:0:b0:dcd:65fa:ea06 with SMTP id
 b9-20020a25ae89000000b00dcd65faea06mr4529792ybj.24.1709485221863; Sun, 03 Mar
 2024 09:00:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
 <CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
 <65e106305ad8b_43ad820892@john.notmuch> <CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
 <CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
 <20240301090020.7c9ebc1d@kernel.org> <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
 <20240301173214.3d95e22b@kernel.org> <CAM0EoM=NEB25naGtz=YaOt6BDoiv4RpDw27Y=btMZAMGeYB5bg@mail.gmail.com>
 <CAM0EoM=8GG-zCaopaUDMkvqemrZQUtaVRTMrWA6z=xrdYxG9+g@mail.gmail.com> <20240302192747.371684fb@kernel.org>
In-Reply-To: <20240302192747.371684fb@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 3 Mar 2024 12:00:10 -0500
Message-ID: <CAM0EoMncuPvUsRwE+Ajojgg-8JD+1oJ7j2Rw+7oN60MjjAHV-g@mail.gmail.com>
Subject: Re: Hardware Offload discussion WAS(Re: [PATCH net-next v12 00/15]
 Introducing P4TC (series 1)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tom Herbert <tom@sipanda.io>, John Fastabend <john.fastabend@gmail.com>, 
	"Singhai, Anjali" <anjali.singhai@intel.com>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
	"Limaye, Namrata" <namrata.limaye@intel.com>, Marcelo Ricardo Leitner <mleitner@redhat.com>, 
	"Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, "Jain, Vipin" <Vipin.Jain@amd.com>, 
	"Osinski, Tomasz" <tomasz.osinski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Khalid Manaa <khalidm@nvidia.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Victor Nogueira <victor@mojatatu.com>, 
	"Tammela, Pedro" <pctammela@mojatatu.com>, "Daly, Dan" <dan.daly@intel.com>, 
	Andy Fingerhut <andy.fingerhut@gmail.com>, "Sommers, Chris" <chris.sommers@keysight.com>, 
	Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 10:27=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 2 Mar 2024 09:36:53 -0500 Jamal Hadi Salim wrote:
> > 2) Your point on:  "integrate later", or at least "fill in the gaps"
> > This part i am probably going to mumble on. I am going to consider
> > more than just doing ACLs/MAT via flower/u32 for the sake of
> > discussion.
> > True, "fill the gaps" has been our model so far. It requires kernel
> > changes, user space code changes etc justifiably so because most of
> > the time such datapaths are subject to standardization via IETF, IEEE,
> > etc and new extensions come in on a regular basis.  And sometimes we
> > do add features that one or two users or a single vendor has need for
> > at the cost of kernel and user/control extension. Given our work
> > process, any features added this way take a long time to make it to
> > the end user.
>
> What I had in mind was more of a DDP model. The device loads it binary
> blob FW in whatever way it does, then it tells the kernel its parser
> graph, and tables. The kernel exposes those tables to user space.
> All dynamic, no need to change the kernel for each new protocol.
>
> But that's different in two ways:
>  1. the device tells kernel the tables, no "dynamic reprogramming"
>  2. you don't need the SW side, the only use of the API is to interact
>     with the device
>
> User can still do BPF kfuncs to look up in the tables (like in FIB),
> but call them from cls_bpf.
>

This is not far off from what is envisioned today in the discussions.
The main issue is who loads the binary? We went from devlink to the
filter doing the loading. DDP is ethtool. We still need to tie a PCI
device/tc block to the "program" so we can do skip_sw and it works.
Meaning a device that is capable of handling multiple programs can
have multiple blobs loaded. A "program" is mapped to a tc filter and
MAT control works the same way as it does today (netlink/tc ndo).

A program in P4 has a name, ID and people have been suggesting a sha1
identity (or a signature of some kind should be generated by the
compiler). So the upward propagation could be tied to discovering
these 3 tuples from the driver. Then the control plane targets a
program via those tuples via netlink (as we do currently).

I do note, using the DDP sample space, currently whatever gets loaded
is "trusted" and really you need to have human knowledge of what the
NIC's parsing + MAT is to send the control. With P4 that is all
visible/programmable by the end user (i am not a proponent of vendors
"shipping" things or calling them for support) - so should be
sufficient to just discover what is in the binary and send the correct
control messages down.

> I think in P4 terms that may be something more akin to only providing
> the runtime API? I seem to recall they had some distinction...

There are several solutions out there (ex: TDI, P4runtime) - our API
is netlink and those could be written on top of netlink, there's no
controversy there.
So the starting point is defining the datapath using P4, generating
the binary blob and whatever constraints needed using the vendor
backend and for s/w equivalent generating the eBPF datapath.

> > At the cost of this sounding controversial, i am going
> > to call things like fdb, fib, etc which have fixed datapaths in the
> > kernel "legacy". These "legacy" datapaths almost all the time have
>
> The cynic in me sometimes thinks that the biggest problem with "legacy"
> protocols is that it's hard to make money on them :)

That's a big motivation without a doubt, but also there are people
that want to experiment with things. One of the craziest examples we
have is someone who created a P4 program for "in network calculator",
essentially a calculator in the datapath. You send it two operands and
an operator using custom headers, it does the math and responds with a
result in a new header. By itself this program is a toy but it
demonstrates that if one wanted to, they could have something custom
in hardware and/or kernel datapath.

cheers,
jamal

