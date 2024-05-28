Return-Path: <bpf+bounces-30800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3868D2879
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 01:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6164C28752F
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 23:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47B613E3F7;
	Tue, 28 May 2024 23:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b="muSoUy5p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE018EB8
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937314; cv=none; b=fM+owQ8uSEAt+pdK6/ki4LYWl7V9WwNTUE9LsAsTGt/aoSrSdF7tab0QghsrZ7i9TTMeNpKzKZTmXKNIm/Cdqvj3rBxVZakJdPCr7hYc87wY5vaouIctysRy8hYn8d9iYEqCm3k/sgdg2K9Iq9XtZ2mcijrFZBj0oajqWp+vkpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937314; c=relaxed/simple;
	bh=QnKbAdsj0rrqDv6RPN20FIHJZjQhqsf1c8PaZQ8+lbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMTS0o9guWb2oGwRauj/D+kGTTK3zEYZ5yokCuUB5qlwzHrhUgQNGmdtV1a4mOVdvlPHo9pslhTe/QgK8t+eDZa24X1CG+EHiMMPrJL6xEpVOi7QnyG2axnPinVTfkfMSet+1UX2SMXticr41VanspogJbOF0ZCu19OpIj5fFpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io; spf=pass smtp.mailfrom=sipanda.io; dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b=muSoUy5p; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipanda.io
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-24caa67cc01so642331fac.2
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 16:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sipanda-io.20230601.gappssmtp.com; s=20230601; t=1716937311; x=1717542111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnKbAdsj0rrqDv6RPN20FIHJZjQhqsf1c8PaZQ8+lbs=;
        b=muSoUy5pXWNKJgI0YRI45DYEi4moGIjXuS9AghU/nsqVzfCiLWAkaUv98eqalACxA5
         cs/is5SMQfMHLP6VUdKFnOm+XCBJ/uSqUwDR1FDRmCtyj2dm0VNzyc3F/81UOUsYLJN2
         cb0yPIowTMO3TbLjluw+DWWMiOeGUt8tVNX5DJ/rsUHWYUc3UOLBwqYZURV3yuW+8RCu
         CNuHLaJGRGTsgI+CqbDOenuhmwqUD39eUYJsc3cHfgiroArgOA4k5w03Ri2IIGEKTLWW
         34/iJbuWoGmNOK3/Sfxxe+WIe1x1R1WG1Xbupep+xIdXeZfkcy4Z6ZbFWqjJs1p7ZuPd
         UAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716937311; x=1717542111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnKbAdsj0rrqDv6RPN20FIHJZjQhqsf1c8PaZQ8+lbs=;
        b=t85HE3m/H6z9dqsedvKBaHSe53x1h2UQouCpwYFormGCfQMKCMe65XUnK2hQe52gWa
         U70WNg3ww/OZf7JZessGMxISW1aNuuD99dCqFyZVMBrGWLp9VFvC8/rrsxlAyROiJoZu
         YJ9+9y8h6Mqq9ZA0FDloSJihU5W0suSOx98yPYrfa1XZGVusxS3C9U1QJ5xgSVV57cA7
         Qz0dx3N9ynr2rpBc6UHveqnCXoQAVSSTTVI/8WcqUJImCr+luAN+VEC0/nAwuTfzjF5W
         tcRi4Rbl5yf0W7boZwxSnXMWcMvsyJEvMZYtD3WWeJNloUIgf5Srwz9mCAjXlFjwP27V
         pL8g==
X-Forwarded-Encrypted: i=1; AJvYcCVes3NHbDmXNv7pqidnvlbeyao20p7YRMKk3+tqhXJ8xrgUQGt/kvI9EfhMDrM77OmsaLCvUp98cq8u0BK+f5MEKLbj
X-Gm-Message-State: AOJu0YxFQr1hXUiZBBW6QhtoeWTX32G+F1fKaJbt+JDdGw8PU6/XAc2P
	9jTI8hyWrJ/UwF57EAmEA/fsjF4jgXoYpLIswVrzrMBeUycOHIzT7T6im1c57HPQyWVJdPdYVqh
	z5PBn5egKHMkBIyLMTfbbEBKMeRnfJ/TjS17Rzg==
X-Google-Smtp-Source: AGHT+IGsMnuvSOKjGlx1gHKtOcrmAqfb75pa2Sk/De6h7/J+i/Go8u1l+kAj+HFyU8ksEmMvy6t5e3wGI3cZldcOUYs=
X-Received: by 2002:a05:6870:2112:b0:24c:b769:3d22 with SMTP id
 586e51a60fabf-24cb7695855mr12879622fac.53.1716937311366; Tue, 28 May 2024
 16:01:51 -0700 (PDT)
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
 <CO1PR11MB499350FC06A5B87E4C770CCE93F42@CO1PR11MB4993.namprd11.prod.outlook.com>
 <MW4PR12MB71927C9E4B94871B45F845DF97F52@MW4PR12MB7192.namprd12.prod.outlook.com>
 <MW4PR12MB719209644426A0F5AE18D2E897F62@MW4PR12MB7192.namprd12.prod.outlook.com>
 <66563bc85f5d0_2f7f2087@john.notmuch> <CO1PR11MB49932999F5467416D4F7197693F12@CO1PR11MB4993.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB49932999F5467416D4F7197693F12@CO1PR11MB4993.namprd11.prod.outlook.com>
From: Tom Herbert <tom@sipanda.io>
Date: Tue, 28 May 2024 16:01:40 -0700
Message-ID: <CAOuuhY8wMG0+WvYx3RC++pebcRF4aW1zAW+vgAb3ap-8Q-139w@mail.gmail.com>
Subject: Re: On the NACKs on P4TC patches
To: "Singhai, Anjali" <anjali.singhai@intel.com>
Cc: John Fastabend <john.fastabend@gmail.com>, "Jain, Vipin" <Vipin.Jain@amd.com>, 
	"Hadi Salim, Jamal" <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Network Development <netdev@vger.kernel.org>, 
	"Chatterjee, Deb" <deb.chatterjee@intel.com>, "Limaye, Namrata" <namrata.limaye@intel.com>, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, "Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, 
	"Osinski, Tomasz" <tomasz.osinski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Khalid Manaa <khalidm@nvidia.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, "Tammela, Pedro" <pctammela@mojatatu.com>, 
	"Daly, Dan" <dan.daly@intel.com>, Andy Fingerhut <andy.fingerhut@gmail.com>, 
	"Sommers, Chris" <chris.sommers@keysight.com>, Matty Kadosh <mattyk@nvidia.com>, 
	bpf <bpf@vger.kernel.org>, "lwn@lwn.net" <lwn@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 3:17=E2=80=AFPM Singhai, Anjali
<anjali.singhai@intel.com> wrote:
>
> >From: John Fastabend <john.fastabend@gmail.com>
> >Sent: Tuesday, May 28, 2024 1:17 PM
>
> >Jain, Vipin wrote:
> >> [AMD Official Use Only - AMD Internal Distribution Only]
> >>
> >> My apologies, earlier email used html and was blocked by the list...
> >> My response at the bottom as "VJ>"
> >>
> >> ________________________________________
>
> >Anjali and Vipin is your support for HW support of P4 or a Linux SW impl=
ementation of P4. If its for HW support what drivers would we want to suppo=
rt? Can you describe how to program >these devices?
>
> >At the moment there hasn't been any movement on Linux hardware P4 suppor=
t side as far as I can tell. Yes there are some SDKs and build kits floatin=
g around for FPGAs. For example >maybe start with what drivers in kernel tr=
ee run the DPUs that have this support? I think this would be a productive =
direction to go if we in fact have hardware support in the works.
>
> >If you want a SW implementation in Linux my opinion is still pushing a D=
SL into the kernel datapath via qdisc/tc is the wrong direction. Mapping P4=
 onto hardware blocks is fundamentally >different architecture from mapping
> >P4 onto general purpose CPU and registers. My opinion -- to handle this =
you need a per architecture backend/JIT to compile the P4 to native instruc=
tions.
> >This will give you the most flexibility to define new constructs, best p=
erformance, and lowest overhead runtime. We have a P4 BPF backend already a=
nd JITs for most architectures I don't >see the need for P4TC in this conte=
xt.
>
> >If the end goal is a hardware offload control plane I'm skeptical we eve=
n need something specific just for SW datapath. I would propose a devlink o=
r new infra to program the device directly >vs overhead and complexity of a=
bstracting through 'tc'. If you want to emulate your device use BPF or user=
 space datapath.
>
> >.John
>
>
> John,
> Let me start by saying production hardware exists i think Jamal posted so=
me links but i can point you to our hardware.
> The hardware devices under discussion are capable of being abstracted usi=
ng the P4 match-action paradigm so that's why we chose TC.
> These devices are programmed using the TC/netlink interface i.e the stand=
ard TC control-driver ops apply. While it is clear to us that the P4TC abst=
raction suffices, we are currently discussing details that will cater for a=
ll vendors in our biweekly meetings.
> One big requirement is we want to avoid the flower trap - we dont want to=
 be changing kernel/user/driver code every time we add new datapaths.
> We feel P4TC approach is the path to add Linux kernel support.
>
> The s/w path is needed as well for several reasons.
> We need the same P4 program to run either in software or hardware or in b=
oth using skip_sw/skip_hw. It could be either in split mode or as an except=
ion path as it is done today in flower or u32. Also it is common now in the=
 P4 community that people define their datapath using their program and wil=
l write a control application that works for both hardware and software dat=
apaths. They could be using the software datapath for testing as you said b=
ut also for the split/exception path. Chris can probably add more comments =
on the software datapath.

Hi Anjali,

Are there any use cases of P4-TC that don't involve P4 hardware? If
someone wanted to write one off datapath code for their deployment and
they didn't have P4 hardware would you suggest that they write they're
code in P4-TC? The reason I ask is because I'm concerned about the
performance of P4-TC. Like John said, this is mapping code that is
intended to run in specialized hardware into a CPU, and it's also
interpreted execution in TC. The performance numbers in
https://github.com/p4tc-dev/docs/blob/main/p4-conference-2023/2023P4Worksho=
pP4TC.pdf
seem to show that P4-TC has about half the performance of XDP. Even
with a lot of work, it's going to be difficult to substantially close
that gap.

The risk if we allow this into the kernel is that a vendor might be
tempted to point to P4-TC performance as a baseline to justify to
customers that they need to buy specialized hardware to get
performance, whereas if XDP was used maybe they don't need the
performance and cost of hardware. Note, this scenario already happened
once before, when the DPDK joined LF they made bogus claims that they
got a 100x performance over the kernel-- had they put at least the
slightest effort into tuning the kernel that would have dropped the
delta by an order of magnitude, and since then we've pretty much
closed the gap (actually, this is precisely what motivated the
creation of XDP so I guess that story had a happy ending!) . There are
circumstances where hardware offload may be warranted, but it needs to
be honestly justified by comparing it to an optimized software
solution-- so in the case of P4, it should be compared to well written
XDP code for instance, not P4-TC.

Tom

>
>
> Anjali
>

