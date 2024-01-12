Return-Path: <bpf+bounces-19462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA2882C4DA
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 18:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C211C225B5
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 17:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6874517BDD;
	Fri, 12 Jan 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hNvUKiVt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yhRGzsDZ"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A90E175A3;
	Fri, 12 Jan 2024 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Jan 2024 18:41:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705081299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSerJ1jiXzUOejSZwcpJCzNYxLNjbdJRxkU6ajmn+qM=;
	b=hNvUKiVtIx2Q8yYcInszUSrifOyzrx1yC7DMnctpPd1RCvkGGCe87JwyVd6Df1OCHJG3Jo
	WKJcVpew98o7k6XsyhsU6Up9WopBVpBHCRsEueszlWbuxy6paLWKV07AjjU7PecUHogMU5
	xsNi+qFd5KGXbU0uAaFzbVL94GYssifSnzLpBMCzARK2EMzzan98bxQjZy2a1Wu9D6jSGP
	wc7RsQTbrIIiuZ+KDUrf7924KkROskmvQ57YP7Wu2jI8E8VFs2OUdWAwZZu3VMtw1/HFuU
	PA0NUqhwLDlghjjJuTwc4vqpQ+b7f3NZFPk+k0mIi5Ijnt2Vc6LIl6DbLyhhGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705081299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSerJ1jiXzUOejSZwcpJCzNYxLNjbdJRxkU6ajmn+qM=;
	b=yhRGzsDZ2lGrIgwoEKmPL7pgDjALimrtmgPXUY7K98e5nSXwOUzgXaLDYZAtD2grtVHq++
	Q+A6E5QAfIWlXwCw==
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
Message-ID: <20240112174138.tMmUs11o@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-16-bigeasy@linutronix.de>
 <CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9U-4bgxjA@mail.gmail.com>
 <87r0iw524h.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87r0iw524h.fsf@toke.dk>

On 2024-01-04 20:29:02 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>=20
> >> @@ -3925,6 +3926,7 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qev=
ent *qe, struct Qdisc *sch, stru
> >>
> >>         fl =3D rcu_dereference_bh(qe->filter_chain);
> >>
> >> +       guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
> >>         switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
> >>         case TC_ACT_SHOT:
> >>                 qdisc_qstats_drop(sch);
> >
> > Here and in all other places this patch adds locks that
> > will kill performance of XDP, tcx and everything else in networking.
> >
> > I'm surprised Jesper and other folks are not jumping in with nacks.
> > We measure performance in nanoseconds here.
> > Extra lock is no go.
> > Please find a different way without ruining performance.
>=20
> I'll add that while all this compiles out as no-ops on !PREEMPT_RT, I do
> believe there are people who are using XDP on PREEMPT_RT kernels and
> still expect decent performance. And to achieve that it is absolutely
> imperative that we can amortise expensive operations (such as locking)
> over multiple packets.
>=20
> I realise there's a fundamental trade-off between the amount of
> amortisation and the latency hit that we take from holding locks for
> longer, but tuning the batch size (while still keeping some amount of
> batching) may be a way forward? I suppose Jakub's suggestion in the
> other part of the thread, of putting the locks around napi->poll(), is a
> step towards something like this.

The RT requirements are usually different. Networking as in CAN might be
important but Ethernet could only used for remote communication and so
"not" important. People complained that they need to wait for Ethernet
to be done until the CAN packet can be injected into the stack.
With that expectation you would like to pause Ethernet immediately and
switch over the CAN interrupt thread.

But if someone managed to setup XDP then it is likely to be important.
With RT traffic it is usually not the throughput that matters but the
latency. You are likely in the position to receive a packet, say every
1ms, and need to respond immediately. XDP would be used to inspect the
packet and either hand it over to the stack or process it.

I expected the lock operation (under RT) to always succeeds and not
cause any delay because it should not be contended. It should only
block if something with higher priority preempted the current interrupt
thread _and_ also happen to use XDP on the same CPU. In that case (XDP
is needed) it would flush the current user out of the locked section
before the higher-prio thread could take over. Doing bulk and allowing
the low-priority thread to complete would delay the high-priority
thread. Maybe I am too pessimistic here and having two XDP programs on
one CPU is unlikely to happen.

Adding the lock on per-NAPI basis would allow to batch packets.
Acquiring the lock only if XDP is supported would not block the CAN
drivers since they dont't support XDP. But sounds like a hack.

Daniel said netkit doesn't need this locking because it is not
supporting this redirect and it made me think. Would it work to make
the redirect structures part of the bpf_prog-structure instead of
per-CPU? My understanding is that eBPF's programs data structures are
part of it and contain locking allowing one eBPF program preempt
another one.
Having the redirect structures part of the program would obsolete
locking. Do I miss anything?

> -Toke

Sebastian

