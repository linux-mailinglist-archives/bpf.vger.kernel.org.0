Return-Path: <bpf+bounces-19796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B22E831325
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 08:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C6B1C227E0
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92262C154;
	Thu, 18 Jan 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xb8xY9VP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Skp4jtKn"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4FC947A;
	Thu, 18 Jan 2024 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563346; cv=none; b=ixkR6/7ZK1Y1nT7lm3YsyjJuG0f41iylbEU84v7wU8kODf00NikKRS3tEqYaZujoBkrDFJ3QfC2MgAszmOVzBwFwsxznT9HxKynKn8mX3UG3zNhuv3n1MPTQztYchlTJ96VdvZOuZjISYxlrf13sWbmpT4LI2S3cBejbxLNSUgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563346; c=relaxed/simple;
	bh=8hmAdEIcfL0v9wcLZ0431SoMcuZUtlch/gTPUp8R8qQ=;
	h=Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=Gymn8v1P0TqlW1rru0GuLDZKFP1LVntw38RhqcD2sutr1YFf+e68VcAwUAW35BFUsoMKlUgs4bjxUhloqL6uTd8Uy7Q4wL4gMbUSNlpjSxMduOo8uWAWvVQiL0gcySgYsOFp/EHfqaMZDBs7VNbr73H+Kbtmg25cQc8KN0ywwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xb8xY9VP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Skp4jtKn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jan 2024 08:35:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705563341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/SrWGWqFAeh0Q4NXPXuSzxRFfe/0QLjn7iAVq/bzjE=;
	b=Xb8xY9VPVGlZC+0QyCX3HfuFBe5M9F+tz0pdkLj3oZTgqR4tmZ9n4s9e21IQVo5tK8RFPB
	/FAZt+62WyFkD+HgJvOrcbZAsgpc7IHfUk1S76Iwo6ICt5bt+DrVU7de6cy+pgZUQ0MP7n
	NeehovYW/jpCoyeP/j3v9cxSBhcTvMSFYE3kxatMPiUx8nZY+cV+mvhp4jkHIlEIg7WWg8
	Yt0CWDmppz+3oxeBAidkP+VT2U5UcO3aYLIMXi3z9QJAGs6EciAZ+pEF3FgSCT7eWJZ5wi
	AH3aY702oiSHc1DIZies6lkRUmCtoBw9J7ofrWmyGNaoL08eUJyxmmKQFbzKhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705563341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/SrWGWqFAeh0Q4NXPXuSzxRFfe/0QLjn7iAVq/bzjE=;
	b=Skp4jtKnot55gcSMtLq/UrWu7lTfXeGcP1L+cK7QA43cdiWiuT4Z/sY+SwkBPZf1FZLnAu
	dQU730Md1RqVgfCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Cong Wang <xiyou.wangcong@gmail.com>, Hao Luo <haoluo@google.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Ronak Doshi <doshir@vmware.com>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 15/24] net: Use nested-BH locking for XDP
 redirect.
Message-ID: <20240118073540.GIobmYpD@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-16-bigeasy@linutronix.de>
 <CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9U-4bgxjA@mail.gmail.com>
 <87r0iw524h.fsf@toke.dk>
 <20240112174138.tMmUs11o@linutronix.de>
 <87ttnb6hme.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87ttnb6hme.fsf@toke.dk>

On 2024-01-17 17:37:29 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> This is all back-of-the-envelope calculations, of course. Having some
> actual numbers to look at would be great; I don't suppose you have a
> setup where you can run xdp-bench and see how your patches affect the
> throughput?

No but I probably could set it up.

> I chatted with Jesper about this, and he had an idea not too far from
> this: split up the XDP and regular stack processing in two stages, each
> with their individual batching. So whereas right now we're doing
> something like:
>=20
> run_napi()
>   bh_disable()
>   for pkt in budget:
>     act =3D run_xdp(pkt)
>     if (act =3D=3D XDP_PASS)
>       run_netstack(pkt)  // this is the expensive bit
>   bh_enable()
>=20
> We could instead do:
>=20
> run_napi()
>   bh_disable()
>   for pkt in budget:
>     act =3D run_xdp(pkt)
>     if (act =3D=3D XDP_PASS)
>       add_to_list(pkt, to_stack_list)
>   bh_enable()
>   // sched point
>   bh_disable()
>   for pkt in to_stack_list:
>     run_netstack(pkt)
>   bh_enable()
>=20
>=20
> This would limit the batching that blocks everything to only the XDP
> processing itself, which should limit the maximum time spent in the
> blocking state significantly compared to what we have today. The caveat
> being that rearranging things like this is potentially a pretty major
> refactoring task that needs to touch all the drivers (even if some of
> the logic can be moved into the core code in the process). So not really
> sure if this approach is feasible, TBH.

This does not work because bh_disable() does not disable scheduling.
Scheduling may happen. bh_disable() acquires a lock which is currently
the only synchronisation point between two say network driver doing
NAPI. And this what I want to get rid of.
Regarding expensive bit as in XDP_PASS: This doesn't need locking as per
proposal, just the REDIRECT piece.

> > Daniel said netkit doesn't need this locking because it is not
> > supporting this redirect and it made me think. Would it work to make
> > the redirect structures part of the bpf_prog-structure instead of
> > per-CPU? My understanding is that eBPF's programs data structures are
> > part of it and contain locking allowing one eBPF program preempt
> > another one.
> > Having the redirect structures part of the program would obsolete
> > locking. Do I miss anything?
>=20
> This won't work, unfortunately: the same XDP program can be attached to
> multiple interfaces simultaneously, and for hardware with multiple
> receive queues (which is most of the hardware that supports XDP), it can
> even run simultaneously on multiple CPUs on the same interface. This is
> the reason why this is all being kept in per-CPU variables today.

So I started hacking this and noticed yesterday and noticed that you can
run multiple bpf programs. This is how I learned that it won't work.
My plan B is now to move it into task_struct.=20

> -Toke
Sebastian

