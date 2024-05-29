Return-Path: <bpf+bounces-30844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 414598D39A0
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDFB1C237B6
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DF516D325;
	Wed, 29 May 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b="06NFnUGN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C14015991E
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993969; cv=none; b=Q7m3YvuaPc4+Map03CWvq1qaw9w/BsFM7NAYaUrnIhvE6qSJPX9/lQ8tYrJ0TmAixmWUmcIOAGSlq11g1H4yS1vB+ddvpFHbKJ3QWDo4wuL/eebKloHkwcOBddpqGLb0w6R/REqHSnBqHWvwyWwKKLQKhvfxOjaBH92oDRXSeH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993969; c=relaxed/simple;
	bh=jTFJX5ygXManrVPo7jFKHmmxsj4KGQPf0jYEnmCKq4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXM253J0nSof7omnCwvmezlTczCWDbh4bMeRCbV3ByYzauaYkxwUqb3RC+XoKQSAaUw7HoSlLqT3dQo2mH/6EootRz4I9oMLkTmjWTIG7pLgko65O1MXPTZrLYfkYXEyt+n8fbe2z5ZPTaajqd08l3a3vc/9m8S7Xqb+MJldCz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io; spf=pass smtp.mailfrom=sipanda.io; dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b=06NFnUGN; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipanda.io
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4e160984c30so16348e0c.0
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sipanda-io.20230601.gappssmtp.com; s=20230601; t=1716993966; x=1717598766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeUkByrB2bKwWVqcV594jcVOkO/b5ZoFelw/41++usE=;
        b=06NFnUGNqW3FC/nH/hlZTjxB6nc+5+/1/TK++sbclncSj+bo95bgOgYtw4uuCut3nq
         OpE6dVqqmLivqeev0aCl8vLOFiYg5oG6Bm4JzXBTuiu0GLMEehGwPUaaXa3R/ng2/csj
         T4mvrRa5Rr/ygHZhQUQIcK8VghaLXfGTmSAjXChT4TQ3PDDmU9PIy/0hzKVmPXDP42Xc
         dhmZ9/MqJb01OeBEfqR6l+EspGn22TYKLId1lL2coERqUrPgbjjez0bWUhvAyyyMCdY9
         pSXbUhwC1jXlowTQ5T4IZxJ0QO06LRyLQTQjdEHTsK5s+rLdRPyKNY/vQiQMkaWvIrEa
         98gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716993966; x=1717598766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeUkByrB2bKwWVqcV594jcVOkO/b5ZoFelw/41++usE=;
        b=goDkOGAbr1Mthqlu422EPmz9A5Y2D+38NijMv24hRd04YG9XMPzimN4RyJyfkgtqs6
         QcH4YNQ2cEQ4gVjEsd4QRrzIGPBQw7zTB8L2g2x8vKp+mqBHAFnBxTXOzitn0zONRCLR
         vWNCKl1A0GutMczmlnfThjdjhBH9bfM+gJPXPKLhRhkS2ACxoIQwTeoKCtof5zv/poz6
         GvL7nF9Se396Yu7tdP9ITtaLKqEl0R2cJhxkUIacCtr63qaQd96XoyR7rjW4WYNgUs3q
         M063uOryuJtmar7HYH0kW74os8mxUTkmoJ5ogJHwJca+vd8iIMNkPQstmQUf3xNLRAuy
         IK0A==
X-Forwarded-Encrypted: i=1; AJvYcCWdvkPAWepYyjTK7uHIxvNEKbqwHnY5HU688EZZk+5sDThj5LgOkWNdW1dAYF4j0zZXSO7HFpSTfWFZ08kOv3sh9ZRa
X-Gm-Message-State: AOJu0Yyuq+7nNP5pkDpl0+val/Gs4BaY534AaijpBAnopDJShFn5zpdu
	zVLc8NNfqVfvp/0ExeusFuXfSoqtOde7qWM+2IoufYU7R8yf5FTafpiFiGUdjjofL+JDup3Lb8/
	cY+V1R5j2ZeMA9weoR5buwEEcWaBpf+UbGUi+9A==
X-Google-Smtp-Source: AGHT+IEVq5ZPcHkkF/9k7KeMqkVsggkUHIlipBP2tyvPRMGFoNN9DL3CvEkTuncShwX/qYOn4JBZOLvpVDVyoTwJBUc=
X-Received: by 2002:a05:6122:91d:b0:4b9:e8bd:3b2 with SMTP id
 71dfb90a1353d-4e97b9579fdmr1718397e0c.2.1716993966208; Wed, 29 May 2024
 07:46:06 -0700 (PDT)
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
In-Reply-To: <CAM0EoMnyn9Bfufar5rv6cbRRTHKCaZ1q-b93T2EWUKcBv_ibNw@mail.gmail.com>
From: Tom Herbert <tom@sipanda.io>
Date: Wed, 29 May 2024 07:45:55 -0700
Message-ID: <CAOuuhY_w6FVVhKA7iVjvXFm697Bvo=WUyiBpFbuWqiZL7KPyqQ@mail.gmail.com>
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

On Wed, May 29, 2024 at 4:01=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
>
>
> On Tue, May 28, 2024 at 7:43=E2=80=AFPM Chris Sommers <chris.sommers@keys=
ight.com> wrote:
>>
>> > On Tue, May 28, 2024 at 3:17=E2=80=AFPM Singhai, Anjali
>> > <anjali.singhai@intel.com> wrote:
>> > >
>> > > >From: John Fastabend <john.fastabend@gmail.com>
>> > > >Sent: Tuesday, May 28, 2024 1:17 PM
>> > >
>> > > >Jain, Vipin wrote:
>> > > >> [AMD Official Use Only - AMD Internal Distribution Only]
>> > > >>
>> > > >> My apologies, earlier email used html and was blocked by the list=
...
>> > > >> My response at the bottom as "VJ>"
>> > > >>
>> > > >> ________________________________________
>> > >
>> > > >Anjali and Vipin is your support for HW support of P4 or a Linux SW=
 implementation of P4. If its for HW support what drivers would we want to =
support? Can you describe how to program >these devices?
>> > >
>> > > >At the moment there hasn't been any movement on Linux hardware P4 s=
upport side as far as I can tell. Yes there are some SDKs and build kits fl=
oating around for FPGAs. For example >maybe start with what drivers in kern=
el tree run the DPUs that have this support? I think this would be a produc=
tive direction to go if we in fact have hardware support in the works.
>> > >
>> > > >If you want a SW implementation in Linux my opinion is still pushin=
g a DSL into the kernel datapath via qdisc/tc is the wrong direction. Mappi=
ng P4 onto hardware blocks is fundamentally >different architecture from ma=
pping
>> > > >P4 onto general purpose CPU and registers. My opinion -- to handle =
this you need a per architecture backend/JIT to compile the P4 to native in=
structions.
>> > > >This will give you the most flexibility to define new constructs, b=
est performance, and lowest overhead runtime. We have a P4 BPF backend alre=
ady and JITs for most architectures I don't >see the need for P4TC in this =
context.
>> > >
>> > > >If the end goal is a hardware offload control plane I'm skeptical w=
e even need something specific just for SW datapath. I would propose a devl=
ink or new infra to program the device directly >vs overhead and complexity=
 of abstracting through 'tc'. If you want to emulate your device use BPF or=
 user space datapath.
>> > >
>> > > >.John
>> > >
>> > >
>> > > John,
>> > > Let me start by saying production hardware exists i think Jamal post=
ed some links but i can point you to our hardware.
>> > > The hardware devices under discussion are capable of being abstracte=
d using the P4 match-action paradigm so that's why we chose TC.
>> > > These devices are programmed using the TC/netlink interface i.e the =
standard TC control-driver ops apply. While it is clear to us that the P4TC=
 abstraction suffices, we are currently discussing details that will cater =
for all vendors in our biweekly meetings.
>> > > One big requirement is we want to avoid the flower trap - we dont wa=
nt to be changing kernel/user/driver code every time we add new datapaths.
>> > > We feel P4TC approach is the path to add Linux kernel support.
>> > >
>> > > The s/w path is needed as well for several reasons.
>> > > We need the same P4 program to run either in software or hardware or=
 in both using skip_sw/skip_hw. It could be either in split mode or as an e=
xception path as it is done today in flower or u32. Also it is common now i=
n the P4 community that people define their datapath using their program an=
d will write a control application that works for both hardware and softwar=
e datapaths. They could be using the software datapath for testing as you s=
aid but also for the split/exception path. Chris can probably add more comm=
ents on the software datapath.
>>
>> Anjali, thanks for asking. Agreed, I like the flexibility of accommodati=
ng a variety of platforms depending upon performance requirements and inten=
ded target system. For me, flexibility is important. Some solutions need an=
 inline filter and P4-TC makes it so easy. The fact I will be able to get H=
W offload means I'm not performance bound. Some other solutions might need =
DPDK implementation, so P4-DPDK is a choice there as well, and there are ac=
celeration options. Keeping much of the dataplane design in one language (P=
4) makes it easier for more developers to create products without having to=
 be platform-level experts. As someone who's worked with P4 Tofino, P4-TC, =
bmv2, etc. I can authoritatively state that all have their proper place.
>> >
>> > Hi Anjali,
>> >
>> > Are there any use cases of P4-TC that don't involve P4 hardware? If
>> > someone wanted to write one off datapath code for their deployment and
>> > they didn't have P4 hardware would you suggest that they write they're
>> > code in P4-TC? The reason I ask is because I'm concerned about the
>> > performance of P4-TC. Like John said, this is mapping code that is
>> > intended to run in specialized hardware into a CPU, and it's also
>> > interpreted execution in TC. The performance numbers in
>> > https://urldefense.com/v3/__https://github.com/p4tc-dev/docs/blob/main=
/p4-conference-2023/2023P4WorkshopP4TC.pdf__;!!I5pVk4LIGAfnvw!mHilz4xBMimnf=
apDG8BEgqOuPw_Mn-KiMHb-aNbl8nB8TwfOfSleeIANiNRFQtTc5zfR0aK1TE2J8lT2Fg$
>> > seem to show that P4-TC has about half the performance of XDP. Even
>> > with a lot of work, it's going to be difficult to substantially close
>> > that gap.
>>
>> AFAIK P4-TC can emit XDP or eBPF code depending upon the situation, some=
one more knowledgeable should chime in.
>> However, I don't agree that comparing the speeds of XDP vs. P4-TC should=
 even be a deciding factor.
>> If P4-TC is good enough for a lot of applications, that is fine by me an=
d over time it'll only get better.
>> If we held back every innovation because it was slower than something el=
se, progress would suffer.
>> >
>
>
> Yes, XDP can be emitted based on compiler options (and was a motivation f=
actor in considering use of eBPF). Tom's comment above seems to confuse the=
 fact that XDP tends to be faster than TC with eBPF as the fault of P4TC.
> In any case this statement falls under: https://github.com/p4tc-dev/pushb=
ack-patches?tab=3Dreadme-ov-file#2b-comment-but--it-is-not-performant

Jamal,

From that: "My response has always consistently been: performance is a
lower priority to P4 correctness and expressibility." That might be
true for P4, but not for the kernel. CPU performance is important, and
your statement below that justifies offloads on the basis that "no
general purpose CPU will save you" confirms that. Please be more
upfront about what  the performance is like including performance
numbers in the cover letter for the next patch set. This is the best
way to avoid confusion and rampant speculation, and if performance
isn't stellar being open about it in the community is the best way to
figure out how to improve it.
>
> On Tom's theory that the vendors are going to push inferior s/w for the s=
ake of selling h/w: we are not in the 90s anymore and there's no vendor con=
spiracy theory here: a single port can do 100s of Gbps, and of course if yo=
u want to do high speed you need to offload, no general purpose CPU will sa=
ve you.

Let's not pretend that offloads are a magic bullet that just makes
everything better, if that were true then we'd all be using TOE by
now! There are a myriad of factors to consider whether offloading is
worth it. What is "high speed", is this small packets or big packets,
are we terminating TCP, are we doing some sort of fast/slow path split
which might work great in the lab but on the Internet can become a DOS
vector? What's the application? Are we just trying to offload parts of
the datapath, TCP, RDMA, memcached, ML reduce operations? Are we
trying to do line rate encryption, compression, trying to do a billion
PCB lookups a second? Are we taking into account continuing
advancements in the CPU that have in the past made offloads obsolete
(for instance, AES instructions pretty much obsoleted initial attempts
to obsolete IPsec)? How simple is the programming model, how
debuggable is it, what's the TCO?

I do believe offload is part of the solution. And the good news is
that programmable devices facilitate that. IMO, our challenge is to
create a facility in the kernel to kernel offloads in a much better
way (I don't believe there's disagreement with these points).

Tom





>
> cheers,
> jamal
>
>>
>> > The risk if we allow this into the kernel is that a vendor might be
>> > tempted to point to P4-TC performance as a baseline to justify to
>> > customers that they need to buy specialized hardware to get
>> > performance, whereas if XDP was used maybe they don't need the
>> > performance and cost of hardware.
>>
>> I really don't buy this argument, it's FUD. Let's judge P4-TC on its mer=
its, not prejudge it as a ploy to sell vendor hardware.
>>
>> > Note, this scenario already happened
>> > once before, when the DPDK joined LF they made bogus claims that they
>> > got a 100x performance over the kernel-- had they put at least the
>> > slightest effort into tuning the kernel that would have dropped the
>> > delta by an order of magnitude, and since then we've pretty much
>> > closed the gap (actually, this is precisely what motivated the
>> > creation of XDP so I guess that story had a happy ending!) . There are
>> > circumstances where hardware offload may be warranted, but it needs to
>> > be honestly justified by comparing it to an optimized software
>> > solution-- so in the case of P4, it should be compared to well written
>> > XDP code for instance, not P4-TC.
>>
>> I strongly disagree that it "it needs to be honestly justified by compar=
ing it to an optimized software solution."
>> Says who? This is no more factual than saying "C or golang need to be ju=
dged by comparing it to assembly language."
>> Today the gap between C and assembly is small, but way back in my career=
, C was way slower.
>> Over time optimizing compilers have closed the gap. Who's to say P4 tech=
nologies won't do the same?
>> P4-TC can be judged on its own merits for its utility and productivity. =
I can't stress enough that P4 is very productive when applied to certain pr=
oblems.
>>
>> Note, P4-BMv2 has been used by thousands of developers, researchers and =
students and it is relatively slow. Yet that doesn't deter users.
>> There is a Google Summer of Code project to add PNA support, rather ambi=
tious. However, P4-TC already partially supports PNA and the gap is closing=
.
>> I feel like P4-TC could replace the use of BMv2 in a lot of applications=
 and if it were upstreamed, it'd eventually be available on all Linux machi=
nes. The ability to write custom externs
>> is very compelling. Eventual HW offload using the same code will be game=
-changing. Bmv2 is a big c++ program and somewhat intimidating to dig into =
to make enhancements, especially at the architectural level.
>> There is no HW offload path, and it's not really fast, so it remains mai=
nly a researchy-thing and will stay that way. P4-TC could span the needs fr=
om research to production in SW, and performant production with HW offload.
>> >
>> > Tom
>> >
>> > >
>> > >
>> > > Anjali
>> >

