Return-Path: <bpf+bounces-30831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1AF8D3529
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 13:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D881C21B0F
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0C316937A;
	Wed, 29 May 2024 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zfcPeCqu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5015B12B
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981058; cv=none; b=E7i/0aLFNXfXlWWOX+jwcXOoNv+BFtk68osQ/G7TOopdTVoPu3DZqO404HktuhwGfkziYQKfu2VT2jSTVt6ihJWtE125mtPGuEJwqEfWMcSe6/kH1pqh6r88fPIM4ZJ3zoi/DaiMs+7DEtyB+FWstC00H03D5DbCmmkZKKe9tLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981058; c=relaxed/simple;
	bh=nxqTjljCvE3eJeFg1oTQL8Y2pVXJjcEuLsQGIg10+W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETTkgRB4xgI1fNAQcGZa2iruiMfB/F97iGs99wtagfFgwqdMaSGMV0HAo5HHQR/OdsQtIgr1WFRULv+uWKflhXG48dXA0+K2e0SN1H2mt8uuf+CmHNJonkm1lhw2NaEPyyzb2GjoEvoQEN9hmv2VXBGSvQc02iuUB/Krgz4mqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zfcPeCqu; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-df7719583d0so2108921276.1
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 04:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1716981056; x=1717585856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yIA3T3nf46uPcBF4Atl1zf/qE/OpogHvRn/CxCLmC8=;
        b=zfcPeCquJzsSaEPt8v78j9mgmYoRELSb5yQ92pXa449ha/NkDuUN4IwuV3KsigqANg
         OvpA/qQaj59jFChugKIHCbuy+o3/I49On8nAcfrwrvpg6VY5Z3aBi9Qt05u2G5lv+AFo
         grV2/pWdIVQ+589AfBqBYHIJfRQQ+V3GznvU+2GTrAyMBDtR0OD9b4Dsgrcak8g/QDp+
         nN/mxrVpURQ8zHtc9/m66WOge1GKwmvRFIFo0U6k2/EycLV0eteVXaoIcfEGJoADEX1f
         AVxfV+mu+FL7wbf1s8LcxGKF/IovJ8nHK020O04Jb2byarDw5FBd4hvoIACUxDYciwuY
         7z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716981056; x=1717585856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yIA3T3nf46uPcBF4Atl1zf/qE/OpogHvRn/CxCLmC8=;
        b=dGawEhG/h3TQtjAFJgQPRAXiDZ/ufXRHOJvm4pnczBiFv3JSMmk+ae3yC1zYOtvvwC
         xfN8Qfn3Ul9asoiFkxtFyWY6ZKe7WLneru8KU8rtDw37bOFDJHBcIWrQSgElX4kwfqQe
         yVpovAzRUdPBbwIpKTlLu1VKDLzD6UAkIvglgcixUC8UduWS+8gvylLBP1i51D5baKGa
         kRpr0F1Pzlpw7xYtq6sI8U6Q6d5IU6coc7YvC32orj2eSfc1r9AHjFsE8fHR5EsND4Rq
         kXaIUhjqsSG0vuSHJLPqgTMJr6V8cdlSSgUrjIt5pvSXoBBPAamq0uSCvtnickZH2zyt
         GMeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPtoq9TNDmkjBw+OYJxA7SazLkEBwggbjWt9rNcEZk8LO5WDPtlyxjULalm2rRvZmypUt9so6P5FwTXPvm1z0st4rv
X-Gm-Message-State: AOJu0YzrIHicRa6zoAPAQWlCKC2mKpCiCnxepmbmiezBGGUBINPqTm9f
	sCqvPGHZ6P8zfpBbcSLhnT6Qy9eA2HO2TwAMyZtKrc0fo8P8QIYyoVugUmebaDdExwKMQPGxEMv
	rW8D7hCTsXMj94WyyI6Tj2oz7eFSfE1kWZ5a4
X-Google-Smtp-Source: AGHT+IETLKHGyzZPvcMvExbdxZ3TTxf3geUv6cGG7dAK3qcjC78hnrHqjk4uuRoPTkooF1H2ROicZCYM7qRFyyiwnK4=
X-Received: by 2002:a25:8206:0:b0:de5:5706:b958 with SMTP id
 3f1490d57ef6-df7721c21demr14375373276.38.1716981055647; Wed, 29 May 2024
 04:10:55 -0700 (PDT)
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
 <CAOuuhY8wMG0+WvYx3RC++pebcRF4aW1zAW+vgAb3ap-8Q-139w@mail.gmail.com> <SN6PR17MB211087D7BF4ABCE2A8E4FA3D96F12@SN6PR17MB2110.namprd17.prod.outlook.com>
In-Reply-To: <SN6PR17MB211087D7BF4ABCE2A8E4FA3D96F12@SN6PR17MB2110.namprd17.prod.outlook.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 29 May 2024 07:10:44 -0400
Message-ID: <CAM0EoMk3fAn=ULevpo9R9v9rFV3-_JrSUTbBP-X0GWLEWL4M-w@mail.gmail.com>
Subject: Re: On the NACKs on P4TC patches
To: Chris Sommers <chris.sommers@keysight.com>
Cc: Tom Herbert <tom@sipanda.io>, "Singhai, Anjali" <anjali.singhai@intel.com>, 
	John Fastabend <john.fastabend@gmail.com>, "Jain, Vipin" <Vipin.Jain@amd.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Network Development <netdev@vger.kernel.org>, 
	"Chatterjee, Deb" <deb.chatterjee@intel.com>, "Limaye, Namrata" <namrata.limaye@intel.com>, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, "Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, 
	"Osinski, Tomasz" <tomasz.osinski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Khalid Manaa <khalidm@nvidia.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, "Tammela, Pedro" <pctammela@mojatatu.com>, 
	"Daly, Dan" <dan.daly@intel.com>, Andy Fingerhut <andy.fingerhut@gmail.com>, 
	Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>, "lwn@lwn.net" <lwn@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Not sure why my email was tagged as html and blocked, but here goes again:

On Tue, May 28, 2024 at 7:43=E2=80=AFPM Chris Sommers
<chris.sommers@keysight.com> wrote:
>
> > On Tue, May 28, 2024 at 3:17=E2=80=AFPM Singhai, Anjali
> > <anjali.singhai@intel.com> wrote:
> > >
> > > >From: John Fastabend <john.fastabend@gmail.com>
> > > >Sent: Tuesday, May 28, 2024 1:17 PM
> > >
> > > >Jain, Vipin wrote:
> > > >> [AMD Official Use Only - AMD Internal Distribution Only]
> > > >>
> > > >> My apologies, earlier email used html and was blocked by the list.=
..
> > > >> My response at the bottom as "VJ>"
> > > >>
> > > >> ________________________________________
> > >
> > > >Anjali and Vipin is your support for HW support of P4 or a Linux SW =
implementation of P4. If its for HW support what drivers would we want to s=
upport? Can you describe how to program >these devices?
> > >
> > > >At the moment there hasn't been any movement on Linux hardware P4 su=
pport side as far as I can tell. Yes there are some SDKs and build kits flo=
ating around for FPGAs. For example >maybe start with what drivers in kerne=
l tree run the DPUs that have this support? I think this would be a product=
ive direction to go if we in fact have hardware support in the works.
> > >
> > > >If you want a SW implementation in Linux my opinion is still pushing=
 a DSL into the kernel datapath via qdisc/tc is the wrong direction. Mappin=
g P4 onto hardware blocks is fundamentally >different architecture from map=
ping
> > > >P4 onto general purpose CPU and registers. My opinion -- to handle t=
his you need a per architecture backend/JIT to compile the P4 to native ins=
tructions.
> > > >This will give you the most flexibility to define new constructs, be=
st performance, and lowest overhead runtime. We have a P4 BPF backend alrea=
dy and JITs for most architectures I don't >see the need for P4TC in this c=
ontext.
> > >
> > > >If the end goal is a hardware offload control plane I'm skeptical we=
 even need something specific just for SW datapath. I would propose a devli=
nk or new infra to program the device directly >vs overhead and complexity =
of abstracting through 'tc'. If you want to emulate your device use BPF or =
user space datapath.
> > >
> > > >.John
> > >
> > >
> > > John,
> > > Let me start by saying production hardware exists i think Jamal poste=
d some links but i can point you to our hardware.
> > > The hardware devices under discussion are capable of being abstracted=
 using the P4 match-action paradigm so that's why we chose TC.
> > > These devices are programmed using the TC/netlink interface i.e the s=
tandard TC control-driver ops apply. While it is clear to us that the P4TC =
abstraction suffices, we are currently discussing details that will cater f=
or all vendors in our biweekly meetings.
> > > One big requirement is we want to avoid the flower trap - we dont wan=
t to be changing kernel/user/driver code every time we add new datapaths.
> > > We feel P4TC approach is the path to add Linux kernel support.
> > >
> > > The s/w path is needed as well for several reasons.
> > > We need the same P4 program to run either in software or hardware or =
in both using skip_sw/skip_hw. It could be either in split mode or as an ex=
ception path as it is done today in flower or u32. Also it is common now in=
 the P4 community that people define their datapath using their program and=
 will write a control application that works for both hardware and software=
 datapaths. They could be using the software datapath for testing as you sa=
id but also for the split/exception path. Chris can probably add more comme=
nts on the software datapath.
>
> Anjali, thanks for asking. Agreed, I like the flexibility of accommodatin=
g a variety of platforms depending upon performance requirements and intend=
ed target system. For me, flexibility is important. Some solutions need an =
inline filter and P4-TC makes it so easy. The fact I will be able to get HW=
 offload means I'm not performance bound. Some other solutions might need D=
PDK implementation, so P4-DPDK is a choice there as well, and there are acc=
eleration options. Keeping much of the dataplane design in one language (P4=
) makes it easier for more developers to create products without having to =
be platform-level experts. As someone who's worked with P4 Tofino, P4-TC, b=
mv2, etc. I can authoritatively state that all have their proper place.
> >
> > Hi Anjali,
> >
> > Are there any use cases of P4-TC that don't involve P4 hardware? If
> > someone wanted to write one off datapath code for their deployment and
> > they didn't have P4 hardware would you suggest that they write they're
> > code in P4-TC? The reason I ask is because I'm concerned about the
> > performance of P4-TC. Like John said, this is mapping code that is
> > intended to run in specialized hardware into a CPU, and it's also
> > interpreted execution in TC. The performance numbers in
> > https://urldefense.com/v3/__https://github.com/p4tc-dev/docs/blob/main/=
p4-conference-2023/2023P4WorkshopP4TC.pdf__;!!I5pVk4LIGAfnvw!mHilz4xBMimnfa=
pDG8BEgqOuPw_Mn-KiMHb-aNbl8nB8TwfOfSleeIANiNRFQtTc5zfR0aK1TE2J8lT2Fg$
> > seem to show that P4-TC has about half the performance of XDP. Even
> > with a lot of work, it's going to be difficult to substantially close
> > that gap.
>
> AFAIK P4-TC can emit XDP or eBPF code depending upon the situation, someo=
ne more knowledgeable should chime in.
> However, I don't agree that comparing the speeds of XDP vs. P4-TC should =
even be a deciding factor.
> If P4-TC is good enough for a lot of applications, that is fine by me and=
 over time it'll only get better.
> If we held back every innovation because it was slower than something els=
e, progress would suffer.

Yes, XDP can be emitted based on compiler options (and was a
motivation factor in considering use of eBPF). Tom's comment above
seems to confuse the fact that XDP tends to be faster than TC with
eBPF as the fault of P4TC.
In any case this statement falls under:
https://github.com/p4tc-dev/pushback-patches?tab=3Dreadme-ov-file#2b-commen=
t-but--it-is-not-performant

On Tom's theory that the vendors are going to push inferior s/w for
the sake of selling h/w  - I would argues that we are not in the 90s
anymore and I dont believe there's any vendor conspiracy theory here
;-> a single port can do 100s of Gbps, and of course if you want to do
high speed you need to offload, no general purpose CPU will save you.
And really the arguement that "offload=3Devil" holds no water anymore.

cheers,
jamal

