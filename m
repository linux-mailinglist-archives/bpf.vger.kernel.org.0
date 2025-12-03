Return-Path: <bpf+bounces-75954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063D4C9E4C7
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 09:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30C33A5D79
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 08:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8B72C21FE;
	Wed,  3 Dec 2025 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kk/XZp75";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6B2+T0Q8"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1235245019;
	Wed,  3 Dec 2025 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764751639; cv=none; b=gLyDFO4VNcMhlddSh+MPpetlERhcbpTwIpZJXxohZ40XCbTOK/64D0bpL3A4Cvtz0CAy2ZRABZy4UnZqkiKZBw+U5puOLUkrYFq1J2nD4R0Ts6jeD8/i1q5TRU0A7rKhu2PHDYyQwNrFdPWAHJIK8TrE7u/qZ3+r00BVJfvsi40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764751639; c=relaxed/simple;
	bh=ADK3Ayeg4WcQXxuws22v65U6ZbGl1rBpQy8nvECVAOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAMBNwIGg1wtLY640JU+zkJAmM6dJxRp8u6FBJCvKycn/ii9XPFg/8ReNRvbH9ai3E8KId88gCcY8FTHx3Z00erghhxOZcr8nb9bx+E3e+CxYSIyMQSOHOqBEUCEgYJoHua9ETZcDh5OXvrXa6J3/wgxF1BE5EJpx6CzitXAzyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kk/XZp75; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6B2+T0Q8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 3 Dec 2025 09:47:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764751630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/GRGsombs69lKO7dDXV9AxmBXZpYeIv4jXcexpDNGLw=;
	b=kk/XZp75ZCTN/3s8HzV1zsYz3H/HgIUDwh0mKesFVin5a76/Fg91ooqnWdxTlGZ0zsX623
	X8Un5hp1DXuss6Fxidw1iXBfNSAZXa4MYQfipWfZLUI/HM1VIcWADtfmTHu1NicQ/G3MrP
	4dlowT4r3Tr9Ag79g5b/JFVajOTlKm56d/5nPGAW6YaVo8rVw46bSpl+4Uxtn2uzlbDjHl
	UH3btmFYun48TqGubsdIMlrvySiL9diRxqUHlzFl9H+31XeA9vskVSthIFl4U/Yr1h043G
	1q/gT6BTHGjA4RkeA+7Gv3GluwWCI0ysw7zX3NxRu1K+X5CAJNs6vH7Tc2RPmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764751630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/GRGsombs69lKO7dDXV9AxmBXZpYeIv4jXcexpDNGLw=;
	b=6B2+T0Q8ZLgXtb8HyPPz5tWGEul/CHOGZHMqVxnh+uk/vPKG+EpIwVq3Nh7MWgP88IJr8x
	TEAV0zFbvYf1kTCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Jon Kohler <jon@nutanix.com>, Jason Wang <jasowang@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in
 tun_xdp_one
Message-ID: <20251203084708.FKvfWWxW@linutronix.de>
References: <20251125200041.1565663-1-jon@nutanix.com>
 <20251125200041.1565663-6-jon@nutanix.com>
 <CACGkMEsDCVKSzHSKACAPp3Wsd8LscUE0GO4Ko9GPGfTR0vapyg@mail.gmail.com>
 <CF8FF91A-2197-47F7-882B-33967C9C6089@nutanix.com>
 <c04b51c6-bc03-410e-af41-64f318b8960f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c04b51c6-bc03-410e-af41-64f318b8960f@kernel.org>

On 2025-12-02 18:32:23 [+0100], Jesper Dangaard Brouer wrote:
> > > > +                       napi_consume_skb(skb, 1);
> > >=20
> > > I wonder if this would have any side effects since tun_xdp_one() is
> > > not called by a NAPI.
> >=20
> > As far as I can tell, this napi_consume_skb is really just an artifact =
of
> > how it was named and how it was traditionally used.
> >=20
> > Now this is really just a napi_consume_skb within a bh disable/enable
> > section, which should meet the requirements of how that interface
> > should be used (again, AFAICT)
> >=20
>=20
> Yicks - this sounds super ugly.  Just wrapping napi_consume_skb() in bh
> disable/enable section and then assuming you get the same protection as
> NAPI is really dubious.
>=20
> Cc Sebastian as he is trying to cleanup these kind of use-case, to make
> kernel preemption work.

I am actually done with this.

Wrapping napi_consume_skb(, 1) in bh-disable basically does the trick if
called from outside-bh section as long as it is not an IRQ section. The
reason is that the skb-head is cached in a per-CPU cache which accessed
only within softirq/ NAPI context.
So you can "return" skbs in NET_TX and have some around in NET_RX.
Otherwise skb is returned directly to the slab allocator.
If this about skb recycling, you using page_pool might help. This
however also expects NAPI/ BH disabled context.

> > > > @@ -2576,13 +2583,24 @@ static int tun_sendmsg(struct socket *sock,=
 struct msghdr *m, size_t total_len)
> > > >                 rcu_read_lock();
> > > >                 bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
> > > >=20
> > > > -               for (i =3D 0; i < n; i++) {
> > > > +               num_skbs =3D napi_skb_cache_get_bulk(skbs, n);
> > >=20
> > > Its document said:
> > >=20
> > > """
> > > * Must be called *only* from the BH context.
> > > =E2=80=9C"=E2=80=9D
> > We=E2=80=99re in a bh_disable section here, is that not good enough?
>=20
> Again this feels very ugly and prone to painting ourselves into a
> corner, assuming BH-disabled sections have same protection as NAPI.
>=20
> (The napi_skb_cache_get/put function are operating on per CPU arrays
> without any locking.)

This is okay. NAPI means BH is disabled. Nothing more. There are a few
implications to it.
The default path is
 process-context (kernel or userland)
 * IRQ *
   -> irq is handled via its handler with disabled interrupts
   -> handler raises NET_RX aka NAPI
   -> irq core is done with IRQ handling and notices softirqs have been
      raised. Disables BH and starts handling softirqs with enabled
      interrupts before returning back before the interruption.
   -> softirqs are handled with with BH disabled.
   * IRQ * fires again.
     -> irq is handled as previously and NET_RX is set again.
     -> irq core returns back to previously handled softirqs
   -> Once NET_RX is done, softirq core would be done and return back
      but since it noticed that NET_RX is pending (again) it does
      another round.

This is how it normally works. If you disable-bh in process context
(either manually via local_bh_disable() or via spin_lock_bh()) then you
enter BH context. There is hardly a difference (in_serving_softirq()
will report a different value but this should not matter to anyone
outside the core code).
Any IRQ that raises NET_RX here will not lead to handling softirqs
because BH is disabled (this maps the "IRQ fires again" case from
above). This is delayed until local_bh_enable().

Therefore protecting the per-CPU array with local_bh_disable() is okay
but for PREEMPT_RT reasons, per-CPU data needs this
local_lock_nested_bh() around it (as napi_skb_cache_get/put does).

> --Jesper

Sebastian

