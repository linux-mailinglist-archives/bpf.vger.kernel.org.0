Return-Path: <bpf+bounces-30950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6288D505B
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 18:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31CF1F27621
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 16:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CBA3D57A;
	Thu, 30 May 2024 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="YT7hY0NO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C955F3B784
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088384; cv=none; b=S/EjtuGBKWQSiyiPE6CeAeaFk2J+irOApHDdRV4nLoVIc9dXKtZB3VOIBweiuC40t2mdap5wHP3ofx4WXcgJPdgLrBNHfYFt7Rr83AMb99U7W1DOFxYLVn8IpF+e4FWGoIXOH9QkTInOl6VYkA2d7Dus58Kn6sI1RTb40xxv4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088384; c=relaxed/simple;
	bh=OjirUdazWZRxoojlWDk4YFUuceJg33zpsvjV3slgDt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWnp8NjNItMg6FBZnLFhBt8vIKkXiaWq6w8X3Vl7BhVpYxRkhM6hYwU/pi7qQc+JlFV5OJIh5qnRqhII2aSlrcRANfBlOmqdjS5KYonXe57NnlkNQ4UOu8+kTai9nWvkVMhXkEbM0nkAJ/KiNbalVzhw675Xi8G/z54XOR+kIus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=YT7hY0NO; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfa52560cb3so1106077276.0
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1717088382; x=1717693182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj4PELlDRKUU47FnIOLmoX+lW1rHsATSLbP4pyCCdU8=;
        b=YT7hY0NO+wlPzLw1DQZfpv+86fCR0D58uR5vcubMREzE3JjCktLo2+6Xb8JAwJH+OB
         kJ90XVH4myGbnIGqI9M0ZNf3dpr4S1p2r5G/o0FqfYpmRR/pibtruBk3xu4CiKpJSXER
         c6lIY0ONHqP/7JnV9zIjjUcpRyd2eDHAn9qAHOd8AED1/bqhTwPUGdEpyGGHqgpU+V6z
         7kgODpL9FNkng/MeNKEYedRC9HP6gjxlVU8/wkS2hNBmZ8bwHTSd1yn1a7zYPPzbJmXy
         Ejk2BC898t9cVAGY4sD9oCGGEAwVlUOiG8sneauB9KHuIBwAAyuIXbcA3KWWEufmaWuH
         fSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717088382; x=1717693182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pj4PELlDRKUU47FnIOLmoX+lW1rHsATSLbP4pyCCdU8=;
        b=rdcEiORoDjFVpuBfd8mhi9gCr9c51BkeDEfej0Psq7qHSUZcRh7NII+noHND8Yo1+w
         J/7OErqNIiFg2h6FcYGv7W18nEqvwx210BjMB7jXl23j+i3L9EoRyK3DmJbhSss7s2JG
         ScoQMt5cPhjtd/CU8p2T4jSI1ilJOfCqDH0MqjnW0lnvozSGxr57uIcQaVN9Tg1KWMLY
         gHedyQTS1DQIBE8E9jWan4imqN8vVEym4WDF01krOI4viVtRUziP6UiJX1+EY+RZBV0n
         pz976hHSArSSJrkWA9Ohg5U6z3u9h/r/uOVOnya20HJL1sd5YT9Qfz5K0NOomHlIOT7H
         j1mA==
X-Forwarded-Encrypted: i=1; AJvYcCUjLQZudcYKQipXziGQYDIpBNS9XFokt0mm1V29w6xsfE8Fsz0wPc7uuhWcjoSPXnvNDzDRnaMhkYV/8pfdI4yeFnK9
X-Gm-Message-State: AOJu0YzT5YF4bvZGC8tE64GNM5uGdXzNwcJ+Wj78m2IWX8lFAJXzZL5T
	0n/k9spE06X5S1HI5KSVFSp5QL9Fx8t1z6UXTFsvVgfcXNkcjKEkSHG6OGJD0nH2u/UaqMd1gA9
	MQlCglKRG2p0d/oWX0gY5F5ye8aRm8ZCW+mj4
X-Google-Smtp-Source: AGHT+IEOpKmpoPrN9j8pWa2p6/b37a1ZYTRrJz0NlHKl1aW8cBjjNoSykowoHdtQpEB1JmAd8vS7CkA63BHPf1A6BIA=
X-Received: by 2002:a25:c546:0:b0:dfa:6f3a:b248 with SMTP id
 3f1490d57ef6-dfa6f3ab324mr132571276.65.1717088381564; Thu, 30 May 2024
 09:59:41 -0700 (PDT)
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
 <CAM0EoMnyn9Bfufar5rv6cbRRTHKCaZ1q-b93T2EWUKcBv_ibNw@mail.gmail.com> <CAOuuhY_w6FVVhKA7iVjvXFm697Bvo=WUyiBpFbuWqiZL7KPyqQ@mail.gmail.com>
In-Reply-To: <CAOuuhY_w6FVVhKA7iVjvXFm697Bvo=WUyiBpFbuWqiZL7KPyqQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 30 May 2024 12:59:30 -0400
Message-ID: <CAM0EoMndK_8ULpWf=wwMmmjYF+gFiHbmzn31vxwBBAY_q=1eUg@mail.gmail.com>
Subject: Re: On the NACKs on P4TC patches
To: Tom Herbert <tom@sipanda.io>
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

On Wed, May 29, 2024 at 10:46=E2=80=AFAM Tom Herbert <tom@sipanda.io> wrote=
:
>
> On Wed, May 29, 2024 at 4:01=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> >
> >
> > On Tue, May 28, 2024 at 7:43=E2=80=AFPM Chris Sommers <chris.sommers@ke=
ysight.com> wrote:
> >>
> >> > On Tue, May 28, 2024 at 3:17=E2=80=AFPM Singhai, Anjali
> >> > <anjali.singhai@intel.com> wrote:
> >> > >
> >> > > >From: John Fastabend <john.fastabend@gmail.com>
> >> > > >Sent: Tuesday, May 28, 2024 1:17 PM
> >> > >
> >> > > >Jain, Vipin wrote:
> >> > > >> [AMD Official Use Only - AMD Internal Distribution Only]
> >> > > >>
> >> > > >> My apologies, earlier email used html and was blocked by the li=
st...
> >> > > >> My response at the bottom as "VJ>"
> >> > > >>
> >> > > >> ________________________________________
> >> > >
> >> > > >Anjali and Vipin is your support for HW support of P4 or a Linux =
SW implementation of P4. If its for HW support what drivers would we want t=
o support? Can you describe how to program >these devices?
> >> > >
> >> > > >At the moment there hasn't been any movement on Linux hardware P4=
 support side as far as I can tell. Yes there are some SDKs and build kits =
floating around for FPGAs. For example >maybe start with what drivers in ke=
rnel tree run the DPUs that have this support? I think this would be a prod=
uctive direction to go if we in fact have hardware support in the works.
> >> > >
> >> > > >If you want a SW implementation in Linux my opinion is still push=
ing a DSL into the kernel datapath via qdisc/tc is the wrong direction. Map=
ping P4 onto hardware blocks is fundamentally >different architecture from =
mapping
> >> > > >P4 onto general purpose CPU and registers. My opinion -- to handl=
e this you need a per architecture backend/JIT to compile the P4 to native =
instructions.
> >> > > >This will give you the most flexibility to define new constructs,=
 best performance, and lowest overhead runtime. We have a P4 BPF backend al=
ready and JITs for most architectures I don't >see the need for P4TC in thi=
s context.
> >> > >
> >> > > >If the end goal is a hardware offload control plane I'm skeptical=
 we even need something specific just for SW datapath. I would propose a de=
vlink or new infra to program the device directly >vs overhead and complexi=
ty of abstracting through 'tc'. If you want to emulate your device use BPF =
or user space datapath.
> >> > >
> >> > > >.John
> >> > >
> >> > >
> >> > > John,
> >> > > Let me start by saying production hardware exists i think Jamal po=
sted some links but i can point you to our hardware.
> >> > > The hardware devices under discussion are capable of being abstrac=
ted using the P4 match-action paradigm so that's why we chose TC.
> >> > > These devices are programmed using the TC/netlink interface i.e th=
e standard TC control-driver ops apply. While it is clear to us that the P4=
TC abstraction suffices, we are currently discussing details that will cate=
r for all vendors in our biweekly meetings.
> >> > > One big requirement is we want to avoid the flower trap - we dont =
want to be changing kernel/user/driver code every time we add new datapaths=
.
> >> > > We feel P4TC approach is the path to add Linux kernel support.
> >> > >
> >> > > The s/w path is needed as well for several reasons.
> >> > > We need the same P4 program to run either in software or hardware =
or in both using skip_sw/skip_hw. It could be either in split mode or as an=
 exception path as it is done today in flower or u32. Also it is common now=
 in the P4 community that people define their datapath using their program =
and will write a control application that works for both hardware and softw=
are datapaths. They could be using the software datapath for testing as you=
 said but also for the split/exception path. Chris can probably add more co=
mments on the software datapath.
> >>
> >> Anjali, thanks for asking. Agreed, I like the flexibility of accommoda=
ting a variety of platforms depending upon performance requirements and int=
ended target system. For me, flexibility is important. Some solutions need =
an inline filter and P4-TC makes it so easy. The fact I will be able to get=
 HW offload means I'm not performance bound. Some other solutions might nee=
d DPDK implementation, so P4-DPDK is a choice there as well, and there are =
acceleration options. Keeping much of the dataplane design in one language =
(P4) makes it easier for more developers to create products without having =
to be platform-level experts. As someone who's worked with P4 Tofino, P4-TC=
, bmv2, etc. I can authoritatively state that all have their proper place.
> >> >
> >> > Hi Anjali,
> >> >
> >> > Are there any use cases of P4-TC that don't involve P4 hardware? If
> >> > someone wanted to write one off datapath code for their deployment a=
nd
> >> > they didn't have P4 hardware would you suggest that they write they'=
re
> >> > code in P4-TC? The reason I ask is because I'm concerned about the
> >> > performance of P4-TC. Like John said, this is mapping code that is
> >> > intended to run in specialized hardware into a CPU, and it's also
> >> > interpreted execution in TC. The performance numbers in
> >> > https://urldefense.com/v3/__https://github.com/p4tc-dev/docs/blob/ma=
in/p4-conference-2023/2023P4WorkshopP4TC.pdf__;!!I5pVk4LIGAfnvw!mHilz4xBMim=
nfapDG8BEgqOuPw_Mn-KiMHb-aNbl8nB8TwfOfSleeIANiNRFQtTc5zfR0aK1TE2J8lT2Fg$
> >> > seem to show that P4-TC has about half the performance of XDP. Even
> >> > with a lot of work, it's going to be difficult to substantially clos=
e
> >> > that gap.
> >>
> >> AFAIK P4-TC can emit XDP or eBPF code depending upon the situation, so=
meone more knowledgeable should chime in.
> >> However, I don't agree that comparing the speeds of XDP vs. P4-TC shou=
ld even be a deciding factor.
> >> If P4-TC is good enough for a lot of applications, that is fine by me =
and over time it'll only get better.
> >> If we held back every innovation because it was slower than something =
else, progress would suffer.
> >> >
> >
> >
> > Yes, XDP can be emitted based on compiler options (and was a motivation=
 factor in considering use of eBPF). Tom's comment above seems to confuse t=
he fact that XDP tends to be faster than TC with eBPF as the fault of P4TC.
> > In any case this statement falls under: https://github.com/p4tc-dev/pus=
hback-patches?tab=3Dreadme-ov-file#2b-comment-but--it-is-not-performant
>
> Jamal,
>
> From that: "My response has always consistently been: performance is a
> lower priority to P4 correctness and expressibility." That might be
> true for P4, but not for the kernel. CPU performance is important, and
> your statement below that justifies offloads on the basis that "no
> general purpose CPU will save you" confirms that. Please be more
> upfront about what  the performance is like including performance
> numbers in the cover letter for the next patch set. This is the best
> way to avoid confusion and rampant speculation, and if performance
> isn't stellar being open about it in the community is the best way to
> figure out how to improve it.

I believe you are misreading those graphs or maybe you are mixing it
with the original u32/pedit script approach? The tests are run at TC
and XDP layers. Pay particular attention to the results of the
handcoded/tuned eBPF datapath at TC and at XDP compared to analogous
ones generated by the compiler. You will notice +/-5% or so
differences. That is with the current compiler generated code. We are
looking to improve that - but do note that is generated code, nothing
to do with the kernel. As the P4 program becomes more complex (many
tables, longer keys, more entries, more complex actions) then we
become compute bound, so no difference really.

Now having said that: yes - s/w performance is certainly _not our
highest priority feature_ and that is not saying we dont care but as
the text said If i am getting 2Mpps using handcoding vs 1.84Mpps using
generated code(per those graphs) and i can generate code and execute
it in 5 minutes (Chris who is knowledgeable in P4 was able to do it in
less time), then _i pick the code generation any day of the week_.
Tooling, tooling, tooling.
To re-iterate, the most important requirement is the abstraction, meaning:
I can take the same P4 program I am running in s/w and generate using
a different backend for AMD or Intel offload equivalent and get
several magnitude improvements in performance because it is now
running in h/w. I still get to use the same application controlling
either s/w and/or hardware, etc

TBH, I am indifferent and could add some numbers but it is missing the
emphasis of what we are trying to achieve, the cover letter is already
half a novel - with the short attention span most people have it will
be just muddying the waters.

> >
> > On Tom's theory that the vendors are going to push inferior s/w for the=
 sake of selling h/w: we are not in the 90s anymore and there's no vendor c=
onspiracy theory here: a single port can do 100s of Gbps, and of course if =
you want to do high speed you need to offload, no general purpose CPU will =
save you.
>
> Let's not pretend that offloads are a magic bullet that just makes
> everything better, if that were true then we'd all be using TOE by
> now! There are a myriad of factors to consider whether offloading is
> worth it. What is "high speed", is this small packets or big packets,
> are we terminating TCP, are we doing some sort of fast/slow path split
> which might work great in the lab but on the Internet can become a DOS
> vector? What's the application? Are we just trying to offload parts of
> the datapath, TCP, RDMA, memcached, ML reduce operations? Are we
> trying to do line rate encryption, compression, trying to do a billion
> PCB lookups a second? Are we taking into account continuing
> advancements in the CPU that have in the past made offloads obsolete
> (for instance, AES instructions pretty much obsoleted initial attempts
> to obsolete IPsec)? How simple is the programming model, how
> debuggable is it, what's the TCO?
>
> I do believe offload is part of the solution. And the good news is
> that programmable devices facilitate that. IMO, our challenge is to
> create a facility in the kernel to kernel offloads in a much better
> way (I don't believe there's disagreement with these points).
>

This is about a MAT(match-action table) model whose offloads are
covered via TC and is well understood and is very specific.
We are not trying to solve "the world of offloads" which includes
TOEs. P4 aware NICs are in the market and afaik those ASICs are not
solving TOE. I thought you understand the scope but if not start by
reading this: https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md

cheers,
jamal

> Tom
>
>
>
>
>
> >
> > cheers,
> > jamal
> >
> >>
> >> > The risk if we allow this into the kernel is that a vendor might be
> >> > tempted to point to P4-TC performance as a baseline to justify to
> >> > customers that they need to buy specialized hardware to get
> >> > performance, whereas if XDP was used maybe they don't need the
> >> > performance and cost of hardware.
> >>
> >> I really don't buy this argument, it's FUD. Let's judge P4-TC on its m=
erits, not prejudge it as a ploy to sell vendor hardware.
> >>
> >> > Note, this scenario already happened
> >> > once before, when the DPDK joined LF they made bogus claims that the=
y
> >> > got a 100x performance over the kernel-- had they put at least the
> >> > slightest effort into tuning the kernel that would have dropped the
> >> > delta by an order of magnitude, and since then we've pretty much
> >> > closed the gap (actually, this is precisely what motivated the
> >> > creation of XDP so I guess that story had a happy ending!) . There a=
re
> >> > circumstances where hardware offload may be warranted, but it needs =
to
> >> > be honestly justified by comparing it to an optimized software
> >> > solution-- so in the case of P4, it should be compared to well writt=
en
> >> > XDP code for instance, not P4-TC.
> >>
> >> I strongly disagree that it "it needs to be honestly justified by comp=
aring it to an optimized software solution."
> >> Says who? This is no more factual than saying "C or golang need to be =
judged by comparing it to assembly language."
> >> Today the gap between C and assembly is small, but way back in my care=
er, C was way slower.
> >> Over time optimizing compilers have closed the gap. Who's to say P4 te=
chnologies won't do the same?
> >> P4-TC can be judged on its own merits for its utility and productivity=
. I can't stress enough that P4 is very productive when applied to certain =
problems.
> >>
> >> Note, P4-BMv2 has been used by thousands of developers, researchers an=
d students and it is relatively slow. Yet that doesn't deter users.
> >> There is a Google Summer of Code project to add PNA support, rather am=
bitious. However, P4-TC already partially supports PNA and the gap is closi=
ng.
> >> I feel like P4-TC could replace the use of BMv2 in a lot of applicatio=
ns and if it were upstreamed, it'd eventually be available on all Linux mac=
hines. The ability to write custom externs
> >> is very compelling. Eventual HW offload using the same code will be ga=
me-changing. Bmv2 is a big c++ program and somewhat intimidating to dig int=
o to make enhancements, especially at the architectural level.
> >> There is no HW offload path, and it's not really fast, so it remains m=
ainly a researchy-thing and will stay that way. P4-TC could span the needs =
from research to production in SW, and performant production with HW offloa=
d.
> >> >
> >> > Tom
> >> >
> >> > >
> >> > >
> >> > > Anjali
> >> >

