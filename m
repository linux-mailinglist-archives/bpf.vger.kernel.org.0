Return-Path: <bpf+bounces-30343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 224878CC957
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 01:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9909282C74
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 23:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2A41494B6;
	Wed, 22 May 2024 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="JUdz3Dmz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FBF80C04
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716419019; cv=none; b=mJmgxPSvNk272RnFtFlwQK/dmfIZ3FSbm1YNacqQJtCHnbMqJKMZBhD4WzfwnsdE2JR21K12OHQwZ7fc5TtgDHY7eoY/flmlL/pMwe2sgVgH/YOV2GiGqHc0RdcYZL27Pduqdzx22bUPfwcNKWNNdoKOs34jf40Yiv1o/XamvhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716419019; c=relaxed/simple;
	bh=6JnRfOUTXPOqxN0RZeaMz/x6ygj/VkQ/oWDRETDPK5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdozciJvRlex4tAT1JNBEIydG566/OrADFpO5lhKqTiqc9HOqGAiRUFx3o13kGKRMCd3AsrcSLq4ljz41T6C1O+Mi3xZ/GgAImKZHIeeS0pu3ifwHJ204cje4s+iBfqmp+Yr2nCBQBAqYnUhcTJpHKJG/dv63k3V/uBSkPz/UGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=JUdz3Dmz; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-628c1f09f5cso2174767b3.1
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 16:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1716419016; x=1717023816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5mjy3aKB+H5UlrlmRHA+Kx1ufZA6V8d9nt7uDVjCn4=;
        b=JUdz3DmzR+kW1qYIaHAlElnGeY9a6iPyyavQZ7XS329gWDRahJJD6qNVT561uSU8C7
         9uKKtbDEmR3nJfdeeQLqLq05K1nlDg3DmNGxqA09aF6Jy99jJJAxxaOmAV7Rwau4Px8+
         io4yvenv2vm8MuNf4X99AFpgMsS21+VVJkQ5igTl8KFMgz4eB4oLz/vAHqfhKnaWytwQ
         xWhFytSI2jT7GJegPbDqfrWJlChCrFZrcgNakSwBhDy8vSryEKUKMQu9Aa2PelxGhPPW
         B8aIVIEU8q/IqbbJ8edQEFbW8RF6j/Q5gSVspgzBrsh8QTevFj1AkPDQOMetjSmhHKSa
         Iqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716419016; x=1717023816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5mjy3aKB+H5UlrlmRHA+Kx1ufZA6V8d9nt7uDVjCn4=;
        b=m/Dg8puYoT8UnnA4vE/uzbIyJeHD64LwBo/qeRVZGT39Jz0PtKkweM44en34Cmhfix
         7b+EONMzn0xiVCJlfVcwMEGGWSclzavkeWCXaHKEsS9/G6w5PFhy68wLrX4bvEfKZMhW
         90IDxcmds3RpVF1Bw4ePrgmsjYxnHoLfPCOqcPTjiizOniP9oRKb5tU6zRjTGAg0SeqZ
         ljrkDSGSa7HoT6qTeEWYs8xz3CCqydPNhi0hG4elLNr/irLHgpVSN+/+owgCO1tOdVN/
         YkhZHc/VVReUqetED1NS7fGjQq0k7z1qmMdYx6ZcNE4NGfmI5Ojz7UOyv/VfjDCxSx8w
         hBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp9XsbAOaQMhRFrh+1KKBhRbcl78D0A/V3OX49G2FmGW5iZb/q3hcgQndOVJtUYQe49ep8vPfrDy07r599Sh9n/zHV
X-Gm-Message-State: AOJu0YyqWDvmvVyjDouAVniFgPPIxAuoMu3rnujcmIuWlNuFU4tWrkhy
	Fxa+vZ/ZZMS0Poz7Hu1lkaO2M+6GT/Hd3/jmmdMrmBirila7imTj2i9Mun7ujdkrn883QQYkMvn
	JSJ2hF/a40pxe5YIphPrhORyHH+uU5Iyll4iW
X-Google-Smtp-Source: AGHT+IE32zJbirVoB/b8oseDN5EeMiTJ7Pk/b0T44Ur/WkUq8PCxIM8L6EH3ngBU70ZPJjCvz3vQ/JkvLvuh09i8buU=
X-Received: by 2002:a81:6d90:0:b0:627:96bd:b28 with SMTP id
 00721157ae682-627e4873f3amr38788367b3.46.1716419016178; Wed, 22 May 2024
 16:03:36 -0700 (PDT)
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
 <CAM0EoMmsB5jHZ=4oJc_Yzm=RFDUHWh9yexdG6_bPFS4_CFuiog@mail.gmail.com> <20240522151933.6f422e63@kernel.org>
In-Reply-To: <20240522151933.6f422e63@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 22 May 2024 19:03:24 -0400
Message-ID: <CAM0EoMmFrp5X5OzMbum5i_Bjng7Bhtk1YvWpacW6FV6Oy-3avg@mail.gmail.com>
Subject: Re: On the NACKs on P4TC patches
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Network Development <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, "Limaye, Namrata" <namrata.limaye@intel.com>, 
	tom Herbert <tom@sipanda.io>, Marcelo Ricardo Leitner <mleitner@redhat.com>, 
	"Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, "Osinski, Tomasz" <tomasz.osinski@intel.com>, 
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, Khalid Manaa <khalidm@nvidia.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	"Jain, Vipin" <Vipin.Jain@amd.com>, "Daly, Dan" <dan.daly@intel.com>, 
	Andy Fingerhut <andy.fingerhut@gmail.com>, Chris Sommers <chris.sommers@keysight.com>, 
	Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 6:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Hi Jamal!
>
> On Tue, 21 May 2024 08:35:07 -0400 Jamal Hadi Salim wrote:
> > At that point(v16) i asked for the series to be applied despite the
> > Nacks because, frankly, the Nacks have no merit. Paolo was not
> > comfortable applying patches with Nacks and tried to mediate. In his
> > mediation effort he asked if we could remove eBPF - and our answer was
> > no because after all that time we have become dependent on it and
> > frankly there was no technical reason not to use eBPF.
>
> I'm not fully clear on who you're appealing to, and I may be missing
> some points. But maybe it will be more useful than hurtful if I clarify
> my point of view.
>
> AFAIU BPF folks disagree with the use of their subsystem, and they
> point out that P4 pipelines can be implemented using BPF in the first
> place.
> To which you reply that you like (a highly dated type of) a netlink
> interface, and (handwavey) ability to configure the data path SW or
> HW via the same interface.

It's not what I "like" , rather it is a requirement to support both
s/w and h/w offload. The TC model is the traditional approach to
deploy these models. I addressed the same comment you are making above
in #1a and #1b  (https://github.com/p4tc-dev/pushback-patches).

OTOH, "BPF folks disagree with the use of their subsystem" is a
problematic statement. Is BPF infra for the kernel community or is it
something the ebpf folks can decide, at their whim, to allow who they
like to use or not. We are not changing any BPF code. And there's
already a case where the interfaces are used exactly as we used them
in the conntrack code i pointed to in the page (we literally copied
that code). Why is it ok for conntrack code to use exactly the same
approach but not us?

> AFAICT there's some but not very strong support for P4TC,

I dont agree. Paolo asked this question and afaik Intel, AMD (both
build P4-native NICs) and the folks interested in the MS DASH project
responded saying they are in support. Look at who is being Cced. A lot
of these folks who attend biweekly discussion calls on P4TC. Sample:
https://lore.kernel.org/netdev/IA0PR17MB7070B51A955FB8595FFBA5FB965E2@IA0PR=
17MB7070.namprd17.prod.outlook.com/

> and it
> doesn't benefit or solve any problems of the broader networking stack
> (e.g. expressing or configuring parser graphs in general)
>

I am not sure where the parser thing comes from - the parser is
generated as eBPF.

> So from my perspective, the submission is neither technically strong
> enough, nor broadly useful enough to consider making questionable precede=
nts
> for, i.e. to override maintainers on how their subsystems are extended.

I believe as a community nobody should just have the power to nack
things just because - as i stated in the page, not even Linus. That
code doesnt touch anything to do with eBPF maintainers (meaning things
they have to fix when an issue shows up) neither does it "extend" as
you state any ebpf code and it is all part of the networking
subsystem. Sure,  anybody has the right to nack but  I contend that
nacks should be based on technical reasons. I have listed all the
objections in that page and how i have responded to them over time.
Someone needs to look at those objectively and say if they are valid.
The arguement made so far(By Paolo and now by you)  is "we cant
override maintainers on how their subsystems are used" then we are in
uncharted territory, thats why i am asking for arbitration.

cheers,
jamal

