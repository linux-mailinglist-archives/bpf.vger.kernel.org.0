Return-Path: <bpf+bounces-3223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A041F73AE1E
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 03:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595132817FF
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 01:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0426237D;
	Fri, 23 Jun 2023 01:03:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E9363
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 01:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E119C433C0;
	Fri, 23 Jun 2023 01:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687482200;
	bh=iHf4azkVY38aA+dvf79V6sYf9tJiFnPVprdxbc8Qtas=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=RTCjj1PS6m21+k8JHcWsfhIShN0Lke46U7JMzMwr72FLa7Caj7XdXx7SM2MNOwSu0
	 x5cuyL8JrXPwQyMcdeuMIvuv70yl9ZtTpP73RsRN0dIjAfTU/6R/8F4boPpIeh/lAC
	 LW8GZt11/ZXA653P48mago3Qyx2eNBXfff32HJ0eQeH6zVSUUUAUT6srMkTkbOakks
	 n2Z4m5+qzd7BWfWpNsPW+4mmEzqUH/oksyKtZw/JH0Ys9+fGcD1aD1h0vDogsk0JV0
	 IYWsW0pjlYSc5tb+6FMtu3TLl1IkForF72mWLkgvPfO7t9WfcybR9m7cEDYrEtSD62
	 jzjxeAPlTJoPg==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id EE1A327C0054;
	Thu, 22 Jun 2023 21:03:18 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Thu, 22 Jun 2023 21:03:18 -0400
X-ME-Sender: <xms:Vu-UZIk1G1cO8iVmmNXjVc5-lyLDLSZ1SWFzEZBSRfpv2mFRs0Su1Q>
    <xme:Vu-UZH398PilOXsjlaog4CIPFe9jYYX5eL_PN4YBHzTO0wdd8u0QV7cmtYfUo0Y-x
    y8StZCO4Sv70toPY1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegvddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduveffvdegvdefhfegjeejlefgtdffueekudfgkeduvdetvddu
    ieeluefgjeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:Vu-UZGqU9o4ZiSesygX9PeEliKWGAwCAX2wRAH8E71JnT_WzmcRdQA>
    <xmx:Vu-UZEnZ72prirRhAbjLnYGk3M4qn6Ecw6I8aaz1GoDeXVOSWq6JDw>
    <xmx:Vu-UZG3e5t4GEAYuyW1NvH205GH-EXpasBQGKz_Zms_JSSkOa_C4Og>
    <xmx:Vu-UZPngOMbY0tNlC2-WzM-bXaKbzQL7WBss01ny0twkT9JBO9d7gA>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7A6A231A0063; Thu, 22 Jun 2023 21:03:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <82b79e57-a0ad-4559-abc9-858e0f51fbba@app.fastmail.com>
In-Reply-To: 
 <CAEf4Bza9GvJ0vw2-0M8GKSXmOQ8VQCmeqEiQpMuZBjwqpA03vw@mail.gmail.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
 <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
 <bc4f99af-0c46-49b2-9f2d-9a01e6a03af3@app.fastmail.com>
 <5a75d1f0-4ed9-399c-4851-2df0755de9b5@redhat.com>
 <CAEf4Bza9GvJ0vw2-0M8GKSXmOQ8VQCmeqEiQpMuZBjwqpA03vw@mail.gmail.com>
Date: Thu, 22 Jun 2023 18:02:57 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
 "Maryam Tahhan" <mtahhan@redhat.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, "Kees Cook" <keescook@chromium.org>,
 "Christian Brauner" <brauner@kernel.org>, lennart@poettering.net,
 cyphar@cyphar.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Jun 22, 2023, at 11:40 AM, Andrii Nakryiko wrote:
> On Thu, Jun 22, 2023 at 10:38=E2=80=AFAM Maryam Tahhan <mtahhan@redhat=
.com> wrote:
>
> For CAP_BPF too broad. It is broad, yes. If you have good ideas how to
> break it down some more -- please propose. But this is all orthogonal,
> because the blocking problem is fundamental incompatibility of user
> namespaces (and their implied isolation and sandboxing of workloads)
> and BPF functionality, which is global by its very nature. The latter
> is unavoidable in principle.

How, exactly, is BPF global by its very nature?

The *implementation* has some issues with globalness.  Much of it should=
 be fixable.

>
> No matter how much you break down CAP_BPF, you can't enforce that BPF
> program won't interfere with applications in other containers. Or that
> it won't "spy" on them. It's just not what BPF can enforce in
> principle.

The WHOLE POINT of the verifier is to attempt to constrain what BPF prog=
rams can and can't do.  There are bugs -- I get that.  There are helper =
functions that are fundamentally global.  But, in the absence of verifie=
r bugs, BPF has actual boundaries to its functionality.

>
> So that comes back down to a question of trust and then controlled
> delegation of BPF functionality. You trust workload with BPF usage
> because you reviewed the BPF code, workload, testing, etc? Grant BPF
> token and let that container use limited subset of BPF. Employ BPF LSM
> to further restrict it beyond what BPF token can control.
>
> You cannot trust an application to not do something harmful? You
> shouldn't grant it either CAP_BPF in init namespace, nor BPF token in
> user namespace. That's it. Pick your poison.

I think what's lost here is hardening vs restricting intended functional=
ity.

We have access control to restrict intended functionality.  We have othe=
r (and generally fairly ad-hoc and awkward) ways to flip off functionali=
ty because we want to reduce exposure to any bugs in it.

BPF needs hardening -- this is well established.  Right now, this is acc=
omplished by restricting it to global root (effectively).  It should hav=
e access controls, too, but it doesn't.

>
> But all this cannot be mechanically decided or enforced. There has to
> be some humans involved in making these decisions. Kernel's job is to
> provide building blocks to grant and control BPF functionality to the
> extent that it is technically possible.
>

Exactly.  And it DOES NOT.  bpf maps, etc do not have sensible access co=
ntrols.  Things that should not be global are global.  I'm saying the ke=
rnel should fix THAT.  Once it's in a state that it's at least credible =
to allow BPF in a user namespace, than come up with a way to allow it.

> As for "something to isolate the pinned maps/progs by different apps
> (why not DAC rules?)", there is no such thing, as I've explained
> already.
>
> I can install sched_switch raw_tracepoint BPF program (if I'm allowed
> to), and that program has system-wide observability. It cannot be
> bound to an application.

Great, a real example!

Either:

(a) don't run this in a container.  Have a service for the container to =
request the help of this program.

(b) have a way to have root approve a particular program and expose *tha=
t* program to the container, and let the program have its own access con=
trols internally (e.g. only output info that belongs to that container).

> then what do we do when we switch from process A in container
> X to process B in container Y? Is that event belonging to container X?
> Or container Y?

I don't know, but you had better answer this question before you run thi=
s thing in a container, not just for security but for basic functionalit=
y.  If you haven't defined what your program is even supposed to do in a=
 container, don't run it there.


> Hopefully you can see where I'm going with this. And this is just one
> random tiny example. We can think up tons of other cases to prove BPF
> is not isolatable to any sort of "container".

No.  You have not come up with an example of why BPF is not isolatable t=
o a container.  You have come up with an example of why binding to a sch=
ed_switch raw tracepoint does not make sense in a container without addi=
tional mechanisms to give it well defined functionality and appropriate =
security.

Please stop conflating BPF (programs, maps, etc) with *attachments* of B=
PF programs to systemwide things.  They're both under the BPF umbrella. =
 They're not the same thing.

Passing a token into a container that allow that container to do things =
like loading its own programs *and attaching them to raw tracepoints* is=
 IMO a complete nonstarter.  It makes no sense.

