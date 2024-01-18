Return-Path: <bpf+bounces-19788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B6783113C
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 03:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54ADA1F221F6
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DDE6FBC;
	Thu, 18 Jan 2024 02:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA2BaMyZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1CC63A4;
	Thu, 18 Jan 2024 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543490; cv=none; b=Pp3C35IDmnU+4Hm7N0Gs7LRYnL0083fCZWzyir902UJWuZgYoCHg4QNjDuf5ZR1H8iw9co5CqPFLLSFfV6HDYbX32ZoWonGvEmwnNsrF6iEkwS02z0iG5Sp84blmFNmA7HKWb8ZR5NV2GiOoUlAIiPnnsPMUvCPVq8NsKJllLcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543490; c=relaxed/simple;
	bh=XNIIq6PjrrNjsY11XjebC3Pu5vgGDdfjY33hybEPFtg=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=Ju+hV3UNZmUEJVwV5v/RHPlhofwxccCrTGm8jQpwhsZSwv+RAI1kabVH+qbO53LljmdYrORsGH+02r32QjPElj/CClGfAzbPgtGoW+gEylhXQwW89PnFuDCTLPt81Bz8OOZ+v3I9dGEne+bIVLKBZ9GrcRvy1K+Pcs3DHg4Lpfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA2BaMyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49848C433C7;
	Thu, 18 Jan 2024 02:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705543490;
	bh=XNIIq6PjrrNjsY11XjebC3Pu5vgGDdfjY33hybEPFtg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CA2BaMyZWcW//E9N/pitv8U2ATbyOQ6mwGVGbU1UaoUJcalwYQ8hRBXOeaj2VOgGX
	 reHmCT4l43M/VGtp27rrYVb87W4ytKRwRPD/3iaAyKUdRWeWMPhjddkUVtuvAfwUng
	 DcmYuKzBobzzJ7idQt/1znlTC2MygQzs42bxM7nEw/5MaPQCMaQp/Lry1IEFUa6BOL
	 Yvox0R04NYH+uIhntcSyNs6/9wTFsmQ9iRHhOYsgoYcBOCXtFhHiTj9d3Pgnl3uV71
	 3+ArXQW6A5Q8cNjEgJJolGs8QflwpGP7wDwZQb+bsZkx8SnLypuGwIlHmsq34CQb6B
	 KLcmzmLOKAKqg==
Date: Wed, 17 Jan 2024 18:04:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paolo
 Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, Hao Luo
 <haoluo@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Ronak Doshi
 <doshir@vmware.com>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@google.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 15/24] net: Use nested-BH locking for XDP
 redirect.
Message-ID: <20240117180447.2512335b@kernel.org>
In-Reply-To: <87ttnb6hme.fsf@toke.dk>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jan 2024 17:37:29 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> I am not contesting that latency is important, but it's a pretty
> fundamental trade-off and we don't want to kill throughput entirely
> either. Especially since this is global to the whole kernel; and there
> are definitely people who want to use XDP on an RT kernel and still
> achieve high PPS rates.
>=20
> (Whether those people really strictly speaking need to be running an RT
> kernel is maybe debatable, but it does happen).
>=20
> > I expected the lock operation (under RT) to always succeeds and not
> > cause any delay because it should not be contended. =20
>=20
> A lock does cause delay even when it's not contended. Bear in mind that
> at 10 Gbps line rate, we have a budget of 64 nanoseconds to process each
> packet (for 64-byte packets). So just the atomic op to figure out
> whether there's any contention (around 10ns on the Intel processors I
> usually test on) will blow a huge chunk of the total processing budget.
> We can't actually do the full processing needed in those 64 nanoseconds
> (not to mention the 6.4 nanoseconds we have available at 100Gbps), which
> is why it's essential to amortise as much as we can over multiple
> packets.
>=20
> This is all back-of-the-envelope calculations, of course. Having some
> actual numbers to look at would be great; I don't suppose you have a
> setup where you can run xdp-bench and see how your patches affect the
> throughput?

A potentially stupid idea which I have been turning in my head is=20
how we could get away from having the driver handle details of NAPI
budgeting. It's an source of bugs and endless review comments.

All drivers end up maintaining a counter of "how many packets have
I processed" and comparing that against the budget. Would it be crazy
if we put that inside napi_struct? Add a "budget" member inside
napi_struct as well, and:

struct napi_struct {
...
	// poll state
	unsigned int budget;
	unsigned int rx_used;
...
}

static inline bool napi_rx_has_budget(napi)
{
	return napi->budget > napi->rx_used;
}

poll(napi) // no budget
{
	while (napi_rx_has_budget(napi)) {
		napi_gro_receive(napi, skb); /* does napi->rx_used++ */
		// maybe add explicit napi_rx_count() if
		// driver did something funny with the frame.
	}
}

We can also create napi_tx_has_budget() so that people stop being
confused whether budget is for Tx or not. And napi_xdp_comp_has_budget()
so that people stop completing XDP in hard irq context (budget=3D=3D0)...

And we can pass napi into napi_consume_skb(), instead of, presumably
inexplicably to a newcomer, passing in budget.
And napi_complete_done() can lose the work_done argument, too.

Oh, and I'm bringing it up here, because CONFIG_RT can throw
in "need_resched()" into the napi_rx_has_budget(), obviously.

