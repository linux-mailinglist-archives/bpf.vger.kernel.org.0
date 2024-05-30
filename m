Return-Path: <bpf+bounces-30955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B06A18D51AB
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 20:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EF51C22CB5
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 18:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0A14C62B;
	Thu, 30 May 2024 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b="wec8k1gm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1B4B5A6
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717092994; cv=none; b=Sz8vq9HRedkZX49DovX4hdR+vExQluCRPQNlryTanqGOAqxphHnklk1Q8tix7CpGQa2R3Ku2xgpbb/d0YcoOqxCHJkGghQXKAptufBNClzLg+xzDUHK6Aoj/Z4itjwX9MkpxNc1gyGFZbrzhQT+PREMpwKh4PB8ej/1dCrgzAN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717092994; c=relaxed/simple;
	bh=16himVIUM5WZbaqOtCsFRmyuyf0IZKkLttIZutH+/Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T34UddpEXzHQIeNMl6/bGigZztZevY4dX1i8P+vYNDYPv0cWBSrPFLMMriLXmw7qpFBKu+dIXU5paEJ6M7gs2MZpQmScqmcCfL08PRU1l8ihtcgGPtiMIi0vOIHPAyIlZBM7GIzp22sktPtGrKWocqbiJyvBUpKXH75Lu/cCVV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io; spf=pass smtp.mailfrom=sipanda.io; dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b=wec8k1gm; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipanda.io
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4eaee52aefbso377237e0c.2
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 11:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sipanda-io.20230601.gappssmtp.com; s=20230601; t=1717092991; x=1717697791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBeB0Chy8abT3FEi7bCh6kG++EO2IHQPK6UcRwrHVPg=;
        b=wec8k1gmHXF0e2xugQQ01vwgmB9K85jEtxNgDDaTAD9DYGNsJ2GOrDn+W0QckVWmrE
         Xi2Rjsh8N1AbH3nj8AedUTsudHaHfzlS5cbwx18nZTEO3AaZsuoA9yM9hoYQy8YwwQNp
         E51hf4tkStmhUiKu5WCCy6UHPUg7NaYsMd5sg61uZx4aodwVNhk4IBiI/1Tq/0Z6xtUv
         elqGO6voQ58bEON1UTXAMrCdR7WFF+uliKes5/iCaBf0Rrdbe+CjsVs4bqhx9z/UpIU2
         FqZuWeNslPdMHZwS2XiI36BrFMv84M9RJscW2htRMFf4cVYXW30F5vt6kLE7R9auzxFo
         J0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717092991; x=1717697791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBeB0Chy8abT3FEi7bCh6kG++EO2IHQPK6UcRwrHVPg=;
        b=X6OA+MIV8sIIf/4ErWvRZ8J77+HJoIfLmvCvYco57QqEutfRj5xzo1LGEUzCYX8UHd
         moMRpvg/hvAsqh2qkAJUR087ckXFRgS1LLj6PhT0VCPyJnSFGwAQOqTUSE2OhWl5yFSp
         trQcD8mAbteBhGAZsG5YJdpO0iWH+n11pBxsWgw5S/nhKnMHOLDrVGhvLSrWkSWYyChV
         vbv9VLbbhxNROROFmHLHTmkTlZ3Lb74ZkpEqVhmglQXt72Ht6e54ozwXtbutXCjhECVd
         /43Dt+3CYWHJ4TaDdJOVtky81xqywJQuD4blXyaiK4Yg1NSUicksC54NNCzqis16h/u9
         mbBg==
X-Forwarded-Encrypted: i=1; AJvYcCVQbPpxypTe/PDADswLGrB0RlICLOlTmTadbWOkOPeAwQEWx4pQZ4L25MDPC59ZzlzZvbwEuyLwi423nvnIKhDJXyL0
X-Gm-Message-State: AOJu0YyHtV9CqgRwNZ2/KLZCBxLrbpLWjyUHf5WYHFSJKMpzGx2XHYMN
	f5TWlUq2HledFyq0lwEKZDZY0LF+lvjGz1AKq4qiM1zv8IakGPhH3TGTZJ3O/4xRP/LMXUfDwW/
	KsKQ/ngTczVegI0o15bVDJVeyX3dItlQRLkqtXg==
X-Google-Smtp-Source: AGHT+IE/lHRUkVd2qo1zVuQiyyJSNyS0d8Q38ZT9vXmHdH4oZQDASK501SM6XPpZONaYWLYSmKlC4Vv9L42+becJvMs=
X-Received: by 2002:a05:6122:d02:b0:4e9:7e39:cc9f with SMTP id
 71dfb90a1353d-4eaf23df9a6mr3326162e0c.11.1717092991254; Thu, 30 May 2024
 11:16:31 -0700 (PDT)
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
 <CAOuuhY8wMG0+WvYx3RC++pebcRF4aW1zAW+vgAb3ap-8Q-139w@mail.gmail.com>
 <SN6PR17MB211087D7BF4ABCE2A8E4FA3D96F12@SN6PR17MB2110.namprd17.prod.outlook.com>
 <CAM0EoMnyn9Bfufar5rv6cbRRTHKCaZ1q-b93T2EWUKcBv_ibNw@mail.gmail.com>
 <CAOuuhY_w6FVVhKA7iVjvXFm697Bvo=WUyiBpFbuWqiZL7KPyqQ@mail.gmail.com> <CAM0EoMndK_8ULpWf=wwMmmjYF+gFiHbmzn31vxwBBAY_q=1eUg@mail.gmail.com>
In-Reply-To: <CAM0EoMndK_8ULpWf=wwMmmjYF+gFiHbmzn31vxwBBAY_q=1eUg@mail.gmail.com>
From: Tom Herbert <tom@sipanda.io>
Date: Thu, 30 May 2024 11:16:20 -0700
Message-ID: <CAOuuhY_wZ1V_5yrUNOXv+uQrPS2nHRPmeUwsweYOnx-Z666nCg@mail.gmail.com>
Subject: Re: On the NACKs on P4TC patches
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Chris Sommers <chris.sommers@keysight.com>, 
	"Singhai, Anjali" <anjali.singhai@intel.com>, John Fastabend <john.fastabend@gmail.com>, 
	"Jain, Vipin" <Vipin.Jain@amd.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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

On Thu, May 30, 2024 at 9:59=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, May 29, 2024 at 10:46=E2=80=AFAM Tom Herbert <tom@sipanda.io> wro=
te:
> >
> > On Wed, May 29, 2024 at 4:01=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > >
> > >
> > > On Tue, May 28, 2024 at 7:43=E2=80=AFPM Chris Sommers <chris.sommers@=
keysight.com> wrote:
> > >>
> > >> > On Tue, May 28, 2024 at 3:17=E2=80=AFPM Singhai, Anjali
> > >> > <anjali.singhai@intel.com> wrote:
> > >> > >
> > >> > > >From: John Fastabend <john.fastabend@gmail.com>
> > >> > > >Sent: Tuesday, May 28, 2024 1:17 PM
> > >> > >
> > >> > > >Jain, Vipin wrote:
> > >> > > >> [AMD Official Use Only - AMD Internal Distribution Only]
> > >> > > >>
> > >> > > >> My apologies, earlier email used html and was blocked by the =
list...
> > >> > > >> My response at the bottom as "VJ>"
> > >> > > >>
> > >> > > >> ________________________________________
> > >> > >
> > >> > > >Anjali and Vipin is your support for HW support of P4 or a Linu=
x SW implementation of P4. If its for HW support what drivers would we want=
 to support? Can you describe how to program >these devices?
> > >> > >
> > >> > > >At the moment there hasn't been any movement on Linux hardware =
P4 support side as far as I can tell. Yes there are some SDKs and build kit=
s floating around for FPGAs. For example >maybe start with what drivers in =
kernel tree run the DPUs that have this support? I think this would be a pr=
oductive direction to go if we in fact have hardware support in the works.
> > >> > >
> > >> > > >If you want a SW implementation in Linux my opinion is still pu=
shing a DSL into the kernel datapath via qdisc/tc is the wrong direction. M=
apping P4 onto hardware blocks is fundamentally >different architecture fro=
m mapping
> > >> > > >P4 onto general purpose CPU and registers. My opinion -- to han=
dle this you need a per architecture backend/JIT to compile the P4 to nativ=
e instructions.
> > >> > > >This will give you the most flexibility to define new construct=
s, best performance, and lowest overhead runtime. We have a P4 BPF backend =
already and JITs for most architectures I don't >see the need for P4TC in t=
his context.
> > >> > >
> > >> > > >If the end goal is a hardware offload control plane I'm skeptic=
al we even need something specific just for SW datapath. I would propose a =
devlink or new infra to program the device directly >vs overhead and comple=
xity of abstracting through 'tc'. If you want to emulate your device use BP=
F or user space datapath.
> > >> > >
> > >> > > >.John
> > >> > >
> > >> > >
> > >> > > John,
> > >> > > Let me start by saying production hardware exists i think Jamal =
posted some links but i can point you to our hardware.
> > >> > > The hardware devices under discussion are capable of being abstr=
acted using the P4 match-action paradigm so that's why we chose TC.
> > >> > > These devices are programmed using the TC/netlink interface i.e =
the standard TC control-driver ops apply. While it is clear to us that the =
P4TC abstraction suffices, we are currently discussing details that will ca=
ter for all vendors in our biweekly meetings.
> > >> > > One big requirement is we want to avoid the flower trap - we don=
t want to be changing kernel/user/driver code every time we add new datapat=
hs.
> > >> > > We feel P4TC approach is the path to add Linux kernel support.
> > >> > >
> > >> > > The s/w path is needed as well for several reasons.
> > >> > > We need the same P4 program to run either in software or hardwar=
e or in both using skip_sw/skip_hw. It could be either in split mode or as =
an exception path as it is done today in flower or u32. Also it is common n=
ow in the P4 community that people define their datapath using their progra=
m and will write a control application that works for both hardware and sof=
tware datapaths. They could be using the software datapath for testing as y=
ou said but also for the split/exception path. Chris can probably add more =
comments on the software datapath.
> > >>
> > >> Anjali, thanks for asking. Agreed, I like the flexibility of accommo=
dating a variety of platforms depending upon performance requirements and i=
ntended target system. For me, flexibility is important. Some solutions nee=
d an inline filter and P4-TC makes it so easy. The fact I will be able to g=
et HW offload means I'm not performance bound. Some other solutions might n=
eed DPDK implementation, so P4-DPDK is a choice there as well, and there ar=
e acceleration options. Keeping much of the dataplane design in one languag=
e (P4) makes it easier for more developers to create products without havin=
g to be platform-level experts. As someone who's worked with P4 Tofino, P4-=
TC, bmv2, etc. I can authoritatively state that all have their proper place=
.
> > >> >
> > >> > Hi Anjali,
> > >> >
> > >> > Are there any use cases of P4-TC that don't involve P4 hardware? I=
f
> > >> > someone wanted to write one off datapath code for their deployment=
 and
> > >> > they didn't have P4 hardware would you suggest that they write the=
y're
> > >> > code in P4-TC? The reason I ask is because I'm concerned about the
> > >> > performance of P4-TC. Like John said, this is mapping code that is
> > >> > intended to run in specialized hardware into a CPU, and it's also
> > >> > interpreted execution in TC. The performance numbers in
> > >> > https://urldefense.com/v3/__https://github.com/p4tc-dev/docs/blob/=
main/p4-conference-2023/2023P4WorkshopP4TC.pdf__;!!I5pVk4LIGAfnvw!mHilz4xBM=
imnfapDG8BEgqOuPw_Mn-KiMHb-aNbl8nB8TwfOfSleeIANiNRFQtTc5zfR0aK1TE2J8lT2Fg$
> > >> > seem to show that P4-TC has about half the performance of XDP. Eve=
n
> > >> > with a lot of work, it's going to be difficult to substantially cl=
ose
> > >> > that gap.
> > >>
> > >> AFAIK P4-TC can emit XDP or eBPF code depending upon the situation, =
someone more knowledgeable should chime in.
> > >> However, I don't agree that comparing the speeds of XDP vs. P4-TC sh=
ould even be a deciding factor.
> > >> If P4-TC is good enough for a lot of applications, that is fine by m=
e and over time it'll only get better.
> > >> If we held back every innovation because it was slower than somethin=
g else, progress would suffer.
> > >> >
> > >
> > >
> > > Yes, XDP can be emitted based on compiler options (and was a motivati=
on factor in considering use of eBPF). Tom's comment above seems to confuse=
 the fact that XDP tends to be faster than TC with eBPF as the fault of P4T=
C.
> > > In any case this statement falls under: https://github.com/p4tc-dev/p=
ushback-patches?tab=3Dreadme-ov-file#2b-comment-but--it-is-not-performant
> >
> > Jamal,
> >
> > From that: "My response has always consistently been: performance is a
> > lower priority to P4 correctness and expressibility." That might be
> > true for P4, but not for the kernel. CPU performance is important, and
> > your statement below that justifies offloads on the basis that "no
> > general purpose CPU will save you" confirms that. Please be more
> > upfront about what  the performance is like including performance
> > numbers in the cover letter for the next patch set. This is the best
> > way to avoid confusion and rampant speculation, and if performance
> > isn't stellar being open about it in the community is the best way to
> > figure out how to improve it.
>
> I believe you are misreading those graphs or maybe you are mixing it
> with the original u32/pedit script approach? The tests are run at TC
> and XDP layers. Pay particular attention to the results of the
> handcoded/tuned eBPF datapath at TC and at XDP compared to analogous
> ones generated by the compiler. You will notice +/-5% or so
> differences. That is with the current compiler generated code. We are
> looking to improve that - but do note that is generated code, nothing
> to do with the kernel. As the P4 program becomes more complex (many
> tables, longer keys, more entries, more complex actions) then we
> become compute bound, so no difference really.
>
> Now having said that: yes - s/w performance is certainly _not our
> highest priority feature_ and that is not saying we dont care but as
> the text said If i am getting 2Mpps using handcoding vs 1.84Mpps using
> generated code(per those graphs) and i can generate code and execute
> it in 5 minutes (Chris who is knowledgeable in P4 was able to do it in
> less time), then _i pick the code generation any day of the week_.
> Tooling, tooling, tooling.
> To re-iterate, the most important requirement is the abstraction, meaning=
:
> I can take the same P4 program I am running in s/w and generate using
> a different backend for AMD or Intel offload equivalent and get
> several magnitude improvements in performance because it is now
> running in h/w. I still get to use the same application controlling
> either s/w and/or hardware, etc

Jamal,

I believe you're making contradictory points here. On one hand you're
saying that performance isn't a high priority and that it's enough to
get the abstraction right. On the other hand you seem to be making the
argument that we need hardware offload because performance of software
in a CPU is so bad. I can't rectify these statements.

Also, when you claim that hardware is going to deliver "several
magnitude improvements in performance" over an implementation that has
not been optimized for performance in a CPU, then you are heading down
the path of justifying hardware offload on the basis that it performs
better than baseline software which has not been at all optimized.
IMO, that is not valid justification and I believe it would be a
disservice to our users if they buy into hardware where a software
solution would have been sufficient had someone put in the effort to
optimize it.

>
> TBH, I am indifferent and could add some numbers but it is missing the
> emphasis of what we are trying to achieve, the cover letter is already
> half a novel - with the short attention span most people have it will
> be just muddying the waters.

This is putting code in the kernel that runs in the Linux networking
data path. It shouldn't be any surprise that we're asking for some
quantification and analysis of performance in the patch description.

Tom

>
> > >
> > > On Tom's theory that the vendors are going to push inferior s/w for t=
he sake of selling h/w: we are not in the 90s anymore and there's no vendor=
 conspiracy theory here: a single port can do 100s of Gbps, and of course i=
f you want to do high speed you need to offload, no general purpose CPU wil=
l save you.
> >
> > Let's not pretend that offloads are a magic bullet that just makes
> > everything better, if that were true then we'd all be using TOE by
> > now! There are a myriad of factors to consider whether offloading is
> > worth it. What is "high speed", is this small packets or big packets,
> > are we terminating TCP, are we doing some sort of fast/slow path split
> > which might work great in the lab but on the Internet can become a DOS
> > vector? What's the application? Are we just trying to offload parts of
> > the datapath, TCP, RDMA, memcached, ML reduce operations? Are we
> > trying to do line rate encryption, compression, trying to do a billion
> > PCB lookups a second? Are we taking into account continuing
> > advancements in the CPU that have in the past made offloads obsolete
> > (for instance, AES instructions pretty much obsoleted initial attempts
> > to obsolete IPsec)? How simple is the programming model, how
> > debuggable is it, what's the TCO?
> >
> > I do believe offload is part of the solution. And the good news is
> > that programmable devices facilitate that. IMO, our challenge is to
> > create a facility in the kernel to kernel offloads in a much better
> > way (I don't believe there's disagreement with these points).
> >
>
> This is about a MAT(match-action table) model whose offloads are
> covered via TC and is well understood and is very specific.
> We are not trying to solve "the world of offloads" which includes
> TOEs. P4 aware NICs are in the market and afaik those ASICs are not
> solving TOE. I thought you understand the scope but if not start by
> reading this: https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md
>
> cheers,
> jamal
>
> > Tom
> >
> >
> >
> >
> >
> > >
> > > cheers,
> > > jamal
> > >
> > >>
> > >> > The risk if we allow this into the kernel is that a vendor might b=
e
> > >> > tempted to point to P4-TC performance as a baseline to justify to
> > >> > customers that they need to buy specialized hardware to get
> > >> > performance, whereas if XDP was used maybe they don't need the
> > >> > performance and cost of hardware.
> > >>
> > >> I really don't buy this argument, it's FUD. Let's judge P4-TC on its=
 merits, not prejudge it as a ploy to sell vendor hardware.
> > >>
> > >> > Note, this scenario already happened
> > >> > once before, when the DPDK joined LF they made bogus claims that t=
hey
> > >> > got a 100x performance over the kernel-- had they put at least the
> > >> > slightest effort into tuning the kernel that would have dropped th=
e
> > >> > delta by an order of magnitude, and since then we've pretty much
> > >> > closed the gap (actually, this is precisely what motivated the
> > >> > creation of XDP so I guess that story had a happy ending!) . There=
 are
> > >> > circumstances where hardware offload may be warranted, but it need=
s to
> > >> > be honestly justified by comparing it to an optimized software
> > >> > solution-- so in the case of P4, it should be compared to well wri=
tten
> > >> > XDP code for instance, not P4-TC.
> > >>
> > >> I strongly disagree that it "it needs to be honestly justified by co=
mparing it to an optimized software solution."
> > >> Says who? This is no more factual than saying "C or golang need to b=
e judged by comparing it to assembly language."
> > >> Today the gap between C and assembly is small, but way back in my ca=
reer, C was way slower.
> > >> Over time optimizing compilers have closed the gap. Who's to say P4 =
technologies won't do the same?
> > >> P4-TC can be judged on its own merits for its utility and productivi=
ty. I can't stress enough that P4 is very productive when applied to certai=
n problems.
> > >>
> > >> Note, P4-BMv2 has been used by thousands of developers, researchers =
and students and it is relatively slow. Yet that doesn't deter users.
> > >> There is a Google Summer of Code project to add PNA support, rather =
ambitious. However, P4-TC already partially supports PNA and the gap is clo=
sing.
> > >> I feel like P4-TC could replace the use of BMv2 in a lot of applicat=
ions and if it were upstreamed, it'd eventually be available on all Linux m=
achines. The ability to write custom externs
> > >> is very compelling. Eventual HW offload using the same code will be =
game-changing. Bmv2 is a big c++ program and somewhat intimidating to dig i=
nto to make enhancements, especially at the architectural level.
> > >> There is no HW offload path, and it's not really fast, so it remains=
 mainly a researchy-thing and will stay that way. P4-TC could span the need=
s from research to production in SW, and performant production with HW offl=
oad.
> > >> >
> > >> > Tom
> > >> >
> > >> > >
> > >> > >
> > >> > > Anjali
> > >> >

