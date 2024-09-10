Return-Path: <bpf+bounces-39547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9391B9745E0
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 00:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D713281A36
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 22:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7256D1ABEBB;
	Tue, 10 Sep 2024 22:22:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B351917E3;
	Tue, 10 Sep 2024 22:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006930; cv=none; b=TKmKhoKl/WYlS4BNvQ/LqDsR4inJJbJwj1U9KzngXa7onO3vg7MO3uRWfPtvAZcx/zNQRw6aBqJTb63nmm38SbYJijwHbRmftJ/v/Ge1tMyD/JLuOS4+L55Ebg/wg4yFl+KOsnWt6ymMCJ717Q3rBHSbmid5NcC1innjWIDfxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006930; c=relaxed/simple;
	bh=UtL5BjmdXLGd0AEVqxERJo5BFzbUysyLUH/ujTqsGWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxVDnDs4onXjBacSuwkAFfgjjoD4gFzLOV98UE+gS/bthxo7IsawWG6Omu/DLHa+Gi+RATiJWaOtT5PvNZQWkNpIuh07AMZjgt4U8BmlIv3YB1mplxPusJHARldq9g9IymSFAxCt+XkrGF4Di/qbTFsxlqjMxSUkBJuRLSeiJuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438E3C4CEC3;
	Tue, 10 Sep 2024 22:22:08 +0000 (UTC)
Date: Tue, 10 Sep 2024 18:22:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>, Linux
 trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh
 <kpsingh@chromium.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Florent Revest
 <revest@chromium.org>, Puranjay Mohan <puranjay@kernel.org>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
Message-ID: <20240910182209.65ab3452@gandalf.local.home>
In-Reply-To: <CAEf4BzZRV6h5nitTyQ_zah6wWMBZD6QQBbTCWyPVzkPpS42sgg@mail.gmail.com>
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
	<CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
	<20240910145431.20e9d2e5@gandalf.local.home>
	<CAEf4BzZRV6h5nitTyQ_zah6wWMBZD6QQBbTCWyPVzkPpS42sgg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Sep 2024 13:29:57 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Tue, Sep 10, 2024 at 11:54=E2=80=AFAM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> >
> > On Tue, 10 Sep 2024 11:23:29 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > =20
> > > Does Linus have to be in CC to get any reply here? Come on, it's been
> > > almost a full week. =20
> >
> > Just FYI, an email like this does piss people off. You are getting upset
> > for waiting "almost a full week"? A full week is what we tell people to=
 =20
>=20
> A full week to get a response to a question? Yes, I find it way too
> long. I didn't ask for some complicated code review, did I? I don't
> know who "we" are and where "we" tell people, but I disagree that one
> week is acceptable latency to coordinate stuff like this across
> multiple subsystems.

Why do I have to answer to you? Once I saw the "ARM64" in the subject, it
immediately went down in priority and honesty, I didn't even read it as I'm
not the ARM64 maintainer. I did skim it to see if my name was mentioned as
I usually try to do with emails, but when it wasn't I ignored it.

>=20
> "pointing out"? You and Masami are maintainers of linux-trace tree,
> and rethook is part of that. Masami's original code was the one in

Yes, but I don't touch arm code. Masami sometimes does (as is the case
here), but it is when we work with the arm maintainers.

> question and I did expect a rather quick reply from him. If not
> Masami, then you would have a context as well. Who else should I be
> asking?

The arm64 maintainers as they are the ones that maintain that code.

>=20
> If ARM64 folks somehow have more context, it wouldn't be that hard to
> mention and redirect, instead of ghosting my email.

You should know they have more context because they are the actual
maintainers. I shouldn't have to point that out to you.

 $ wget -O /tmp/t.patch https://lore.kernel.org/bpf/164338038439.2429999.17=
564843625400931820.stgit@devnote2/raw
 $ ./scripts/get_maintainer.pl t.patch
Catalin Marinas <catalin.marinas@arm.com> (maintainer:ARM64 PORT (AARCH64 A=
RCHITECTURE),commit_signer:2/6=3D33%)
Will Deacon <will@kernel.org> (maintainer:ARM64 PORT (AARCH64 ARCHITECTURE)=
,commit_signer:5/6=3D83%)
Puranjay Mohan <puranjay@kernel.org> (commit_signer:5/6=3D83%,authored:3/6=
=3D50%,added_lines:30/255=3D12%)
Mark Rutland <mark.rutland@arm.com> (commit_signer:4/6=3D67%,authored:2/6=
=3D33%,added_lines:105/255=3D41%,removed_lines:47/49=3D96%)
"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com> (commit_signer:2/=
6=3D33%)
chenqiwu <qiwuchen55@gmail.com> (authored:1/6=3D17%,added_lines:120/255=3D4=
7%)
linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 AR=
CHITECTURE))
linux-kernel@vger.kernel.org (open list)
bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))

Neither my name nor Masami's shows up.

>=20
> >
> > Funny part is, I was just about to start reviewing Masami's fprobe patc=
hes
> > when I read this. Now I feel reluctant to. I'll do it anyway because th=
ey
> > are Masami's patches, but if they were yours, I would have pushed it of=
f a
> > week or two with that attitude. =20
>=20
> (I'll ignore all the personal stuff)

Maybe you shouldn't ignore it. If you think you can get answers by jumping
immediately to "I'm going to tell on you to Linus", you may want to rethink
your approach. A simple "Hey Steve and Masami, what's going on?" would be
the "human" thing to do. Especially since you appear to be mad at us for
not replying to an email about code we do not maintain.

Sorry, but you're not my boss, I don't have to reply to any of your emails.

>=20
> You are probably talking about [0]. But I was asking about [1], i.e.,
> adding HAVE_RETHOOK support to ARM64. Despite all your emotions above,
> can I still get a meaningful answer as for why that wasn't landed and
> what prevents it from landing right now before Masami's 20-patch
> series lands?
>=20
>   [0] https://lore.kernel.org/linux-trace-kernel/172398527264.293426.2050=
093948411376857.stgit@devnote2/
>   [1] https://lore.kernel.org/bpf/164338038439.2429999.175648436254009318=
20.stgit@devnote2/
>=20
> >
> > Again, just letting you know.

Because [1] isn't something I maintain. So I ignored it.

 arch/arm64/Kconfig                            |    1=20
 arch/arm64/include/asm/stacktrace.h           |    2 -
 arch/arm64/kernel/probes/Makefile             |    1=20
 arch/arm64/kernel/probes/rethook.c            |   25 +++++++
 arch/arm64/kernel/probes/rethook_trampoline.S |   87 +++++++++++++++++++++=
++++
 arch/arm64/kernel/stacktrace.c                |    7 ++

None of that would go through my tree unless an arm64 maintainer asked.

In fact, I need a bunch of acks from all maintainers of the architectures
that are touched by [0] before I can pull it in. Which means it will likely
not make this merge window.

-- Steve

