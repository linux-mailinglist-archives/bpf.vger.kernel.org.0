Return-Path: <bpf+bounces-3227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACA373AF16
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 05:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4CB28186F
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 03:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1418D7FC;
	Fri, 23 Jun 2023 03:29:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A3621
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 03:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC26C433C8;
	Fri, 23 Jun 2023 03:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687490957;
	bh=Lv5bVaFIGtH9XaLLlD4/tAG31KKm+pxiZFTnGBdWk8A=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=M6Nsx2wKoAqSawe5//uD/qShM5B0Cm8nlueG9Pu7LAphrRjnQSvS0MCpkVj1+sipZ
	 sjrDRE6crnC8w1kqAJN4zTYLEklLT+Z+aIgct2nCUjUH2eiL9DiXGXgBSDfd6ftX4w
	 7QkEw0NesXrmilF++CaePq/Z/vqc6/negcdyomKBy7NXSiJ7pXinfe03MJRXK8z9lC
	 sO1dhIYw2FK0VREDr6Hk5mBj5M1iWb1noLenocgRQ0LoIvk36jTqdjgybAqD6EtYgg
	 S/0ct9JOOSRKjIOZiVPEXFq679YSX90LSdWlBIn52oaeuxESukMN4F2fnaE2HWN+Dx
	 6PhyEghg21QTg==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id 24E9127C0054;
	Thu, 22 Jun 2023 23:29:16 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Thu, 22 Jun 2023 23:29:16 -0400
X-ME-Sender: <xms:ixGVZJlKkantH0aSybUIOmLbUykqNXBL4kluU3uDc_RflBnIGeWfnA>
    <xme:ixGVZE1V5HbG_xhyhjCRxsWShqLpYh36NniJZQbIUzbB9AowLXRH8MlQHE02XTwFS
    nnC76905ir4OSXBZfc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegfedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeetgeegtdefjeetkeeujeeiteelheetudevhfeugfevffdttefh
    uefgkeeufeejhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhhthhtphhtohgrmh
    grghhitghiphgrnhguphhorhhtrdihohhunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonh
    grlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhn
    vghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:ixGVZPrXNyQqVLS5ZJhkTJY4tE-F5mc831HcoSTPoLeBT2hjqUZeRw>
    <xmx:ixGVZJn9LMMYgUMsTay2oLVDMV754B_a6R3NI_tfBbbaE8KlUmnWZQ>
    <xmx:ixGVZH00Tzma6dEKD9c-AKWJ22IeSoaYAqUHnlMof-rAwP6w-aNt5A>
    <xmx:jBGVZMnM8XG8E2rHtT1cJYkTu1dl5GzNeGO_JvatjKjeB6fs6dsHgw>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 92F7831A0063; Thu, 22 Jun 2023 23:29:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <56ede337-4370-44c7-b461-806dabc6feee@app.fastmail.com>
In-Reply-To: 
 <CAEf4BzZz2yOkHZSuzpYd2Hv_6pxDJt2GdGVnd3yG8AUj0tSudw@mail.gmail.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
 <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
 <bc4f99af-0c46-49b2-9f2d-9a01e6a03af3@app.fastmail.com>
 <CAEf4BzZz2yOkHZSuzpYd2Hv_6pxDJt2GdGVnd3yG8AUj0tSudw@mail.gmail.com>
Date: Thu, 22 Jun 2023 20:28:55 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: "Maryam Tahhan" <mtahhan@redhat.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, "Kees Cook" <keescook@chromium.org>,
 "Christian Brauner" <brauner@kernel.org>, lennart@poettering.net,
 cyphar@cyphar.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023, at 12:05 PM, Andrii Nakryiko wrote:
> On Thu, Jun 22, 2023 at 9:50=E2=80=AFAM Andy Lutomirski <luto@kernel.o=
rg> wrote:
>>
>>
>>
>> On Thu, Jun 22, 2023, at 1:22 AM, Maryam Tahhan wrote:
>> > On 22/06/2023 00:48, Andrii Nakryiko wrote:
>> >>
>> >>>>> Giving a way to enable BPF in a container is only a small part =
of the overall task -- making BPF behave sensibly in that container seem=
s like it should also be necessary.
>> >>>> BPF is still a privileged thing. You can't just say that any
>> >>>> unprivileged application should be able to use BPF. That's why B=
PF
>> >>>> token is about trusting unpriv application in a controlled envir=
onment
>> >>>> (production) to not do something crazy. It can be enforced furth=
er
>> >>>> through LSM usage, but in a lot of cases, when dealing with inte=
rnal
>> >>>> production applications it's enough to have a proper application
>> >>>> design and rely on code review process to avoid any negative eff=
ects.
>> >>> We really shouldn=E2=80=99t be creating new kinds of privileged c=
ontainers that do uncontained things.
>> >>>
>> >>> If you actually want to go this route, I think you would do much =
better to introduce a way for a container manager to usefully proxy BPF =
on behalf of the container.
>> >> Please see Hao's reply ([0]) about his and Google's (not so rosy)
>> >> experiences with building and using such BPF proxy. We (Meta)
>> >> internally didn't go this route at all and strongly prefer not to.
>> >> There are lots of downsides and complications to having a BPF prox=
y.
>> >> In the end, this is just shuffling around where the decision about
>> >> trusting a given application with BPF access is being made. BPF pr=
oxy
>> >> adds lots of unnecessary logistical, operational, and development
>> >> complexity, but doesn't magically make anything safer.
>> >>
>> >>    [0] https://lore.kernel.org/bpf/CA+khW7h95RpurRL8qmKdSJQEXNYuqS=
WnP16o-uRZ9G0KqCfM4Q@mail.gmail.com/
>> >>
>> > Apologies for being blunt, but  the token approach to me seems to b=
e a
>> > work around providing the right level/classification for a pod/cont=
ainer
>> > in order to say you support unprivileged containers using eBPF. I t=
hink
>> > if your container needs to do privileged things it should have and =
be
>> > classified with the right permissions (privileges) to do what it ne=
eds
>> > to do.
>>
>> Bluntness is great.
>>
>> I think that this whole level/classification thing is utterly wrong. =
 Replace "BPF" with basically anything else, and you'll see how absurd i=
t is.
>
> BPF is not "anything else", it's important to understand that BPF is
> inherently not compratmentalizable. And it's vast and generic in its
> capabilities. This changes everything. So your analogies are
> misleading.
>

file descriptors are "vast and generic" -- you can open sockets, files, =
things in /proc, things in /sys, device nodes, etc.  They are infinitely=
 extensible.  They work in containers.

What is so special about BPF?

>>
>> "the token approach to me seems like a work around providing the righ=
t level/classification for a pod/container in order to say you support u=
nprivileged containers using files on disk"
>>
>> That's very 1990's.  Maybe 1980's.  Of *course* giving access to a fi=
lesystem has some inherent security exposure.  So we can give containers=
 access to *different* filesystems.  Or we can use ACLs.  Or MAC policy.=
  Or whatever.  We have many solutions, none of which are perfect, and w=
e're doing okay.
>>
>> "the token approach to me seems like a work around providing the righ=
t level/classification for a pod/container in order to say you support u=
nprivileged containers using the network"
>>
>> The network is a big deal.  For some reason, it's cool these days to =
treat TCP as highly privileged.  You can get secrets from your favorite =
(or least favorite) cloud provider with unauthenticated HTTP to a magic =
IP and port.  You can bypass a whole lot of authenticating/authorizing p=
roxies with unauthenticated HTTP (no TLS!) if you're on the right networ=
k.
>>
>> This is IMO obnoxious, but we deal with it by having network namespac=
es and firewalls and rather outdated port <=3D 1024 rules.
>>
>> "the token approach to me seems like a work around providing the righ=
t level/classification for a pod/container in order to say you support u=
nprivileged containers using BPF"
>>
>> My response is: what's wrong with BPF?  BPF has maps and programs and=
 such, and we could easily apply 1990's style ownership and DAC rules to=
 them.
>
> Can you apply DAC rules to which kernel events BPF program can be run
> on? Can you apply DAC rules to which in-kernel data structures a BPF
> program can look at and make sure that it doesn't access a
> task/socket/etc that "belongs" to some other container/user/etc?

No, of course.

If you have a BPF program that is granted the ability to read kernel dat=
a structures or to run in response to global events like this, it's basi=
cally a kernel module.  It may be subject to a verifier that imposes muc=
h stronger type safety than a kernel module is subject to, but it's stil=
l effectively a kernel module.

We don't give containers special tokens that let them load arbitrary mod=
ules.  We should not give them special tokens that let them do things wi=
th BPF that are functionally equivalent to loading arbitrary kernel modu=
les.

But we do have ways that kernel modules (which are "vast and generic", t=
oo) can expose their functionality safely to containers.  BPF can learn =
to do this.

>
> Can we limit XDP or AF_XDP BPF programs from seeing and controlling
> network traffic that will be eventually routed to a container that XDP
> program "should not" have access to? Without making everything so slow
> that it's useless?

Of course you can -- assign an entire NIC or virtual function to a conta=
iner, and let the XDP program handle that.  Or a vlan or a macvlan or wh=
atever.  (I'm assuming XDP can be scoped like this.  I'm not that famili=
ar with the details.)

>
>> I even *wrote the code*.
>
> Did you submit it upstream for review and wide discussion?

Yes.

> Did you
> test it and integrate it with production workloads to prove that your
> solution is actually a viable real-world solution and not a toy?

I did test it.  I did not integrate it with production workloads.

> Writing the code doesn't mean solving the problem.

Of course not.  My code was a little step in the right direction.  The B=
PF community was apparently not interested in it.=20

>
>> But for some reason, the BPF community wants to bury its head in the =
sand, pretend it's 1980, declare that BPF is too privileged to have acce=
ss control, and instead just have a complicated switch to turn it on and=
 off in different contexts.
>
> I won't speak on behalf of the entire BPF community, but I'm trying to
> explain that BPF cannot be reasonably sandboxed and has to be
> privileged due to its global nature. And I haven't yet seen any
> realistic counter-proposal to change that. And it's not about
> ownership of the BPF map or BPF program, it's way beyond that..
>

It's really really hard to have a useful discussion about a security mod=
el when have, as what appears to be an axiom, that a security model can'=
t be created.

If you actually feel this way, then I think you should not be advocating=
 for allowing unprivileged containers to do the things that you think ca=
n't have a security model.

I'm saying that I think there *can* be a security model.  But until the =
maintainers start to believe that, there won't be one.

