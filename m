Return-Path: <bpf+bounces-3370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF4173CB37
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 16:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9357C1C20978
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 14:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630BE53B1;
	Sat, 24 Jun 2023 14:00:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C1B1384
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 14:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E658C433C9;
	Sat, 24 Jun 2023 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687615209;
	bh=YTgGwjlRROUEiwgL3LEzShyv2rN/A0tvlo3LJxPJgCY=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=tgihjA2YblyCE6CCHd5Wj+LusbWgBOOOUI6qVLpJGzKq6RWuOVdr6NqKqprcwLyz7
	 KfeG+zTancWoiH5sBp8itOcuYnBpCg8JOiZxjjnVtU9Q+wgJxexfj7db+Kb6awQlub
	 h3+ybvgZiI25YBKDg6CxvBzYPRLNoBbE2luqSu7WGkD+eLl+K79dxKM+KFNsjD+XrD
	 lhIn6DfMhUZQc6COKw0LDZscITXC1LDkt9Qd7CnivJ/VLvnZBXlWiEhKVkC6AzHoDX
	 gf+Ey4R95Oa3pNkX+5Xf4JDiGLrAkuc7B7kEjbedoHCdW2vPmxPcXWtLDwvu5BxDPu
	 7ZJKGfU3usSSA==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id 0F68227C0054;
	Sat, 24 Jun 2023 10:00:08 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Sat, 24 Jun 2023 10:00:08 -0400
X-ME-Sender: <xms:5_aWZF2OgP91lIkC2ujz6GWwNo_7ibPyYqHzBV-sil_r_0PXv0OuZw>
    <xme:5_aWZMFHVnVys-ce5A51GLueqOUNUO7_vaGbepyLGfPChAc1uq4oQVlQaecH3h3sv
    RAxiHWU-xO4DHBrbqI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegjedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeefgefghfevvdehgeeuteelvdehkeehtdefhfdukedufeehueel
    geethffhiedtjeenucffohhmrghinhepshhighhplhgrnhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqd
    hluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:5_aWZF5LgPVdM1Xo6t38Pf3G17vr6GcITEltZyk61IpZ6cIBVqC5yA>
    <xmx:5_aWZC334Q518tPzVPQ1ekkpgLyozE89iaqZYS-XZNZuVZjpsTfX8Q>
    <xmx:5_aWZIFwCHrqLSqNOY_JQ3_ts93x_8_gYXiysh23dqiZRItBjMZJxg>
    <xmx:6PaWZGbHcPTtI8lFB_x3KrUGuFXu6UpPVFjJthjdMFB3stoxwAr3MA>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 61BF631A0063; Sat, 24 Jun 2023 10:00:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <fe47aeb6-dae8-43a6-bcb0-ada2ebf62e08@app.fastmail.com>
In-Reply-To: <173f0af7-e6e1-f4b7-e0a6-a91b7a4da5d7@iogearbox.net>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
 <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
 <bc4f99af-0c46-49b2-9f2d-9a01e6a03af3@app.fastmail.com>
 <5a75d1f0-4ed9-399c-4851-2df0755de9b5@redhat.com>
 <CAEf4Bza9GvJ0vw2-0M8GKSXmOQ8VQCmeqEiQpMuZBjwqpA03vw@mail.gmail.com>
 <82b79e57-a0ad-4559-abc9-858e0f51fbba@app.fastmail.com>
 <9b0e9227-4cf4-4acb-ba88-52f65b099709@app.fastmail.com>
 <173f0af7-e6e1-f4b7-e0a6-a91b7a4da5d7@iogearbox.net>
Date: Sat, 24 Jun 2023 06:59:46 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
 "Maryam Tahhan" <mtahhan@redhat.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, "Kees Cook" <keescook@chromium.org>,
 "Christian Brauner" <brauner@kernel.org>, lennart@poettering.net,
 cyphar@cyphar.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Jun 23, 2023, at 4:23 PM, Daniel Borkmann wrote:
> On 6/23/23 5:10 PM, Andy Lutomirski wrote:
>> On Thu, Jun 22, 2023, at 6:02 PM, Andy Lutomirski wrote:
>>> On Thu, Jun 22, 2023, at 11:40 AM, Andrii Nakryiko wrote:
>>>
>>>> Hopefully you can see where I'm going with this. And this is just o=
ne
>>>> random tiny example. We can think up tons of other cases to prove B=
PF
>>>> is not isolatable to any sort of "container".
>>>
>>> No.  You have not come up with an example of why BPF is not isolatab=
le
>>> to a container.  You have come up with an example of why binding to a
>>> sched_switch raw tracepoint does not make sense in a container witho=
ut
>>> additional mechanisms to give it well defined functionality and
>>> appropriate security.
>
> One big blocker for the case of BPF is not isolatable to a container a=
re
> CPU hardware bugs. There has been plenty of mitigation effort so that =
the
> flexibility cannot be abused as a tool e.g. discussed in [0], but ulti=
mately
> it's a cat and mouse game and vendors are also not really transparent.=
 So
> actual reasonable discussion can be resumed once CPU vendors gets their
> stuff fixed.
>
>    [0]=20
> https://popl22.sigplan.org/details/prisc-2022-papers/11/BPF-and-Spectr=
e-Mitigating-transient-execution-attacks
>

By this standard, shouldn=E2=80=99t we just give up?  Let everyone map /=
dev/mem readonly and stop pretending we can implement any form of access=
 control.

Of course, we don=E2=80=99t do this. We try pretty hard to squash bugs a=
nd keep programs from doing an end run around OS security.

>> Thinking about this some more:
>>=20
>> Suppose the goal is to allow a workload in a container to monitor its=
elf by attaching to a tracepoint (something in the scheduler, for exampl=
e).  The workload is in the container.  The tracepoint is global.  Kerne=
l memory is global unless something that is trusted and understands the =
containers is doing the reading.  And proxying BPF is a mess.
>
> Agree that proxy is a mess for various reasons stated earlier.
>
>> So here are a couple of possible solutions:
>>=20
>> (a) Improve BPF maps a bit so that BPF maps work well in containers. =
 It should be possible to create a map and share it (the file descriptor=
!) between the outside and the container without running into various sn=
ags.  (IIRC my patch series was a decent step in this direction,)  Now l=
oad the BPF program and attach it to the tracepoint outside the containe=
r but have it write its gathered data to the map that's in the container=
.  So you end up with a daemon outside the container that gets a request=
 like "help me monitor such-and-such by running BPF program such-and-suc=
h (where the BPF program code presumably comes from a library outside th=
e container", and the daemon arranges for the requesting container to ha=
ve access to the map it needs to get the data.
>
> I don't think it's very practical, meaning the vast majority of applic=
ations
> out there today are tightly coupled BPF code + user space application,=
 and in
> a lot of cases programs are dynamically created. This would require so=
mehow
> splitting up parts of your application to run outside the container in=
 hostns
> and other parts inside the container.. for the sake of the mentioned e=
xample
> it's something fairly static, but real-world applications look differe=
nt and
> are much more complex.
>

It sounds like you are describing a situation where there is a workload =
in a container, where the *entire container* is part of the TCB, but the=
 part of the workload that has the explicit right to read all of kernel =
memory (e.g. bpf_probe_read_kernel) is so tightly coupled to the contain=
er that no one outside the container wants to audit it.

And yet someone still wants to run it in a userns.
=20
This is IMO a rather bizarre situation.

If I were operating a large fleet, and I had teams developing software t=
o run in a container, I would not want to grant those containers this ri=
ght without strict controls, and I don=E2=80=99t mean on/off controls. I=
 would want strict auditing of *what exact BPF code* (including source) =
was run, and why, and who wrote it, and what the intended results are, a=
nd what limits access to the results, etc.  After all, we=E2=80=99re tal=
king about the right, BY DESIGN, to access PII, payment card information=
, medical information, information protected by any jurisdiction=E2=80=99=
s data control rights, etc. Literally everything.  This ability, as desc=
ribed, isn=E2=80=99t =E2=80=9Cthe right to use BPF.=E2=80=9D  It is the =
right to *read all secrets*, intentionally.  (And modify them, with bpf_=
probe_write_user, possibly subject to some constraints.)


If this series was about passing a =E2=80=9Cmay load kernel modules=E2=80=
=9D token around, I think it would get an extremely chilly reception, ev=
en though we have module signatures.  I don=E2=80=99t see anything about=
 BPF that makes BPF tokens more reasonable unless a real security model =
is developed first.

>> (b) Make a way to pass a pre-approved program into a container.  So a=
 daemon outside loads the program and does some new magic to say "make a=
n fd that can beused to attach this particular program to this particula=
r tracepoint" and pass that into the container.
>
> Same as above. Programs are in most cases very tightly coupled to the=20
> application
> itself. I'm not sure if the ask is to redesign/implement all the=20
> existing user
> space infra.
>
>> I think (a) is better.  In particular, if you have a workload with ma=
ny containers, and they all want to monitor the same tracepoint as it re=
lates to their container, you will get much better performance if a sing=
le BPF program does the monitoring and sends the data out to each contai=
ner as needed instead of having one copy of the program per container.
>>=20
>> For what it's worth, BPF tokens seem like they'll have the same perfo=
rmance problem -- without coordination, you can end up with N containers=
 generating N hooks all targeting the same global resource, resulting in=
 overhead that scales linearly with the number of containers.
>
> Worst case, sure, but it's not the point. These containers which would=20
> receive
> the tokens are part of your trusted compute base.. so its up to the=20
> specific
> applications and their surrounding infrastructure with regards to what=20
> problem
> they solve where and approved by operators/platform engs to deploy in=20
> your cluster.
> I don't particularly see that there's a performance problem. Andrii=20
> specifically
> mentioned /trusted unprivileged applications/.
>
>> And, again, I'm not an XDP expert, but if you have one NIC, and you a=
ttach N XDP programs to it, and each one is inspecting packets and sendi=
ng some to one particular container's AF_XDP socket, you are not going t=
o get good performance.  You want *one* XDP program fanning the packets =
out to the relevant containers.
>>=20
>> If this is hard right now, perhaps you could add new kernel mechanism=
s as needed to improve the situation.
>>=20
>> --Andy
>>

