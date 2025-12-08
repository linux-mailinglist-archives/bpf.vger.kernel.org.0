Return-Path: <bpf+bounces-76279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDD5CACF2A
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 12:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE4AC30056A7
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBEE311958;
	Mon,  8 Dec 2025 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JBiQ5VQ6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f4e7aeUL"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7525CC74;
	Mon,  8 Dec 2025 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765191850; cv=none; b=s7ZklkAp/W1kTrKDwhVsuoHplJ8i4ffL8QThaK+ijdW/iSyjIKp69z4Mmdozxfp7BXdhdxkwW/iENBQQNXs+zMdXLm1zlvJwEG3GofTuzFv/ztoxQ9nlYI9PPgQl7hETSitA7+4mJZqt96YVcuMw6cuENxcdKaDnnsuV71IqrcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765191850; c=relaxed/simple;
	bh=D5kYLDqBc2dd9O7LheA8XmkiaPED6gUkHyFQpbXrP3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFrAomnXvjOKZswwje70lXt+9Kzcje/lf4+e4bdtIBGfg8J6CM2bBolrBZtWzkAfuUO2HeEn1TnAVKtP2odKRJYmjKcJFak1CWjxzLrDIyIWlSmAMVusdaKBPGbBCdYVDRbDpIAGlwLReGG+6EJuxqcsEha90zbkdD9WSGry5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JBiQ5VQ6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f4e7aeUL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 8 Dec 2025 12:04:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765191845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S865HUKaAnKR6N3b+ol6NvmkSfpRAwyGrtoPTmtdt88=;
	b=JBiQ5VQ65R75TKR0Ye9HvGwfOKkU6loT3pVOOCcBJGjUoQ77/2Vz9GBWr0rkVc4NPby3Ep
	SfDMNfZjiGcVm8UFOwLuzepLtyqFw9pnKYirCV7jLvWNXy23FoCISXHCSE7Ga+qfrl/PcQ
	39NxqI7AQn7Rbs4xOApJxQk35qzm8pKuab512v0DGWiDx20bmztAZMGA+BoHMiRhk4SN0n
	6y68UTaxxEcrweDcReZ8wL/ul16JwX7yA+ZwXThQXxEnMrwsK/E1QGS5PNIdCPCUa07qw3
	udg7nGlqYO337nHGUJstv0DUa5B5W5ellkvJgAOcaAPVS5NXTHDNMUmScgVXVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765191845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S865HUKaAnKR6N3b+ol6NvmkSfpRAwyGrtoPTmtdt88=;
	b=f4e7aeULGUe/jFNdRLl5Ui33OfLM0XPbKfN9U3nhP3ADEtLOmEQfIqz4agwzLYI2jZHGtL
	IEagF3NTBYlUuIAg==
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
	open list <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in
 tun_xdp_one
Message-ID: <20251208110404.qgMKQe77@linutronix.de>
References: <20251125200041.1565663-1-jon@nutanix.com>
 <20251125200041.1565663-6-jon@nutanix.com>
 <CACGkMEsDCVKSzHSKACAPp3Wsd8LscUE0GO4Ko9GPGfTR0vapyg@mail.gmail.com>
 <CF8FF91A-2197-47F7-882B-33967C9C6089@nutanix.com>
 <c04b51c6-bc03-410e-af41-64f318b8960f@kernel.org>
 <20251203084708.FKvfWWxW@linutronix.de>
 <CA37D267-2A2F-47FD-8BAF-184891FE1B7E@nutanix.com>
 <20251205075805.vW4ShQvN@linutronix.de>
 <3c1dac33-424f-4eda-83a9-60fb7f4b6c52@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3c1dac33-424f-4eda-83a9-60fb7f4b6c52@kernel.org>

On 2025-12-05 14:21:51 [+0100], Jesper Dangaard Brouer wrote:
>=20
>=20
> On 05/12/2025 08.58, Sebastian Andrzej Siewior wrote:
> > On 2025-12-03 15:35:24 [+0000], Jon Kohler wrote:
> > > Thanks, Sebastian - so if I=E2=80=99m reading this correct, it *is* f=
ine to do
> > > the two following patterns, outside of NAPI:
> > >=20
> > >     local_bh_disable();
> > >     skb =3D napi_build_skb(buf, len);
> > >     local_bh_enable();
> > >=20
> > >     local_bh_disable();
> > >     napi_consume_skb(skb, 1);
> > >     local_bh_enable();
> > >=20
> > > If so, I wonder if it would be cleaner to have something like
> > >     build_skb_bh(buf, len);
> > >=20
> > >     consume_skb_bh(skb, 1);
> > >=20
> > > Then have those methods handle the local_bh enable/disable, so that
> > > the toggle was a property of a call, not a requirement of the call?
> >=20
> > Having budget =3D 0 would be for non-NAPI users. So passing the 1 is
> > superfluous. You goal seems to be to re-use napi_alloc_cache. Right? And
> > this is better than skb_pool?
> >=20
> > There is already napi_alloc_skb() which expects BH to be disabled and
> > netdev_alloc_skb() (and friends) which do disable BH if needed. I don't
> > see an equivalent for non-NAPI users. Haven't checked if any of these
> > could replace your napi_build_skb().
> >=20
> > Historically non-NAPI users would be IRQ users and those can't do
> > local_bh_disable(). Therefore there is dev_kfree_skb_irq_reason() for
> > them. You need to delay the free for two reasons.
> > It seems pure software implementations didn't bother so far.
> >=20
> > It might make sense to do napi_consume_skb() similar to
> > __netdev_alloc_skb() so that also budget=3D0 users fill the pool if this
> > is really a benefit.
>=20
> I'm not convinced that this "optimization" will be an actual benefit on
> a busy system.  Let me explain the side-effect of local_bh_enable().

I'm arguing that this is the right thing to do, I am just saying that it
will not break anything as far as I am aware.

> Calling local_bh_enable() is adding a re-scheduling opportunity, e.g.
> for processing softirq.  For a benchmark this might not be noticeable as
> this is the main workload.  If there isn't any pending softirq this is
> also not noticeable.  In a more mixed workload (or packet storm) this
> re-scheduling will allow others to "steal" CPU cycles from you.

If there wouldn't be a bh/disable-enable then the context would be
process context and the softirq will be handled immediately.
Now it is "delayed" until the bh-enable.
The only advantage I see here is that the caller participates in
napi_alloc_cache.

> Thus, you might not actually save any cycles via this short BH-disable
> section.  I remember that I was saving around 19ns / 68cycles on a
> 3.6GHz E5-1650 CPU, by using this SKB recycle cache.  The cost of a re-
> scheduling event is like more.

It might expensive because you need to branch out, save/ restore
interrupts and check a few flags. This is something you wouldn't have to
do if you return it back to the memory allocator.

> My advice is to use the napi_* function when already running within a
>  BH-disabled section, as it makes sense to save those cycles
> (essentially reducing the time spend with BH-disabled).  Wrapping these
> napi_* function with BH-disabled just to use them outside NAPI feels
> wrong in so many ways.
>=20
> The another reason why these napi_* functions belongs with NAPI is that
> netstack NIC drivers will (almost) always do TX completion first, that
> will free/consume some SKBs, and afterwards do RX processing that need
> to allocate SKBs for the incoming data frames.  Thus, keeping a cache of
> SKBs just released/consumed makes sense.  (p.s. in the past we always
> bulk free'ed all SKBs in the napi cache when exiting NAPI, as they would
> not be cache hot for next round).

Right. That is why I asked if using a skb-pool would be an advantage
since you would have a fix pool of skb for TUN/XDP.

> --Jesper

Sebastian

