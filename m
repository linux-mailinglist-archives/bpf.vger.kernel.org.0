Return-Path: <bpf+bounces-54000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3C1A602B2
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 21:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666153B6A3B
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD431F4603;
	Thu, 13 Mar 2025 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hBcXu/3B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bGOfkoZE"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2375A126C1E;
	Thu, 13 Mar 2025 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897952; cv=none; b=rEXer3RGNlja6ARZzNYpfOEgJJ9Hv1RajJvUb8Wt484ZqeELkCkCBwfRnP/cYrdrSmdjP8AYD3F3SGEtzjdOiLiyS92Ixwk9PhE6bre/N1+1pz900MjnyCIBQg/YrefaJRjSOusohv2p/OqaQhr6rz63OVQ/O+Q9EBTW0Klj8ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897952; c=relaxed/simple;
	bh=tGFxbAWHCzT3GO8fUjsbGi94iRLOi13UnMzaKDpP8fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NY1id/DRjL42L+YyKOA1xuwRWfsEqxgGcm8CB4dbDGreROsTa/anDOjYOT/2Dp9gDkfSoIg82+nK9FZyUtwhCZMwA5TMz3pJ9ZfT2nORj5qDy8P8sj2oYRVR2WzeU/lz78yg+N9MUaSjOkk1If31tAFOu29RlT5h+dIFPE8qWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hBcXu/3B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bGOfkoZE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 21:32:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741897948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vk0S1hvnttnqNY5mzHQOJ/TqbFo4zrQpanr0L6iSdXM=;
	b=hBcXu/3BTR48oApNQ9rEj93OEa9TSLZ9duQkXYtiHD1b/jK4llolbtNjvV7+j9S7MCOllI
	s6jPj6SI6aEua848KzRKGfNb41ZfLFRdoLUcA2MzKm9SMSV4eRj4+3sT6U4OSZlLNVwnGQ
	XSiuXDx5wWdvm1ZL6V28r3RPpICnvRM1F942LadVqTnrmb5pfENcyiK+pxAcdwxPSTgKoc
	mGujJ5kbmSt/dry2Sz5b2Dk8bBIZVHODYI+A2FU14rh6zCNJZFD2ot488N2i2XTXNpXFt+
	sXtsQ2Gxyevc90B4GDucAm+au1sTTpXTBQpAYDz9CJWfV3kVEvqTH/ikVbiOFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741897948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vk0S1hvnttnqNY5mzHQOJ/TqbFo4zrQpanr0L6iSdXM=;
	b=bGOfkoZECdAeLD6OU0Ub+lb3KoMwDVZjQ7eWnFUIll71GBpGFaJNsWDximdiBgbb4lueIs
	OBhSO33+I2cvuqCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Use after free in BPF/ XDP during XDP_REDIRECT
Message-ID: <20250313203226.47_0q7b6@linutronix.de>
References: <20250313183911.SPAmGLyw@linutronix.de>
 <87ecz0u3w9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87ecz0u3w9.fsf@toke.dk>

On 2025-03-13 20:28:06 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>=20
> > Hi,
> >
> > Ricardo reported a KASAN related use after free
> > 	https://lore.kernel.org/all/20250226-20250204-kasan-slab-use-after-fre=
e-read-in-dev_map_enqueue__submit-v3-0-360efec441ba@igalia.com/
> >
> > in v6.6 stable and suggest a backport of commits
> > 	401cb7dae8130 ("net: Reference bpf_redirect_info via task_struct on PR=
EEMPT_RT.")
> > 	fecef4cd42c68 ("tun: Assign missing bpf_net_context.")
> > 	9da49aa80d686 ("tun: Add missing bpf_net_ctx_clear() in do_xdp_generic=
()")
> >
> > as a fix. In the meantime I have the syz reproducer+config and was able
> > to investigate.
> > It looks as if the syzbot starts a BPF program via xdp_test_run_batch()
> > which assigns ri->tgt_value via dev_hash_map_redirect() and the return =
code
> > isn't XDP_REDIRECT it looks like nonsense. So the print in
> > bpf_warn_invalid_xdp_action() appears once. Everything goes as planned.
> > Then the TUN driver runs another BPF program which returns XDP_REDIRECT
> > without setting ri->tgt_value. This appears to be a trick because it
> > invoked bpf_trace_printk() which printed four characters. Anyway, this
> > is enough to get xdp_do_redirect() going.
> >
> > The commits in questions do fix it because the bpf_redirect_info becomes
> > not only per-task but gets invalidated after the XDP context is left.
> >
> > Now that I understand it I would suggest something smaller instead as a
> > stable fix, (instead the proposed patches). Any objections to the
> > following:
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index be313928d272..1d906b7a541d 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -9000,8 +9000,12 @@ static bool xdp_is_valid_access(int off, int siz=
e,
> > =20
> >  void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_pr=
og *prog, u32 act)
> >  {
> > +	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
> >  	const u32 act_max =3D XDP_REDIRECT;
> > =20
> > +	ri->map_id =3D INT_MAX;
> > +	ri->map_type =3D BPF_MAP_TYPE_UNSPEC;
> > +
> >  	pr_warn_once("%s XDP return value %u on prog %s (id %d) dev %s, expec=
t packet loss!\n",
> >  		     act > act_max ? "Illegal" : "Driver unsupported",
> >  		     act, prog->aux->name, prog->aux->id, dev ? dev->name : "N/A");
>=20
> From your description above, this will fix the particular error
> encountered, but what happens if the initial return code is not in fact
> nonsense (so the warn_invalid_action) is not triggered?
>=20
> I.e.,
>=20
> bpf_redirect_map(...);
> return XDP_DROP;
>=20
> would still leave ri->map_id and ri->map_type set for the later tun
> driver invocation, no?

Right. So if it returns XDP_PASS or XDP_DROP instead of nonsense then
the buffer remains set. And another driver could use it.
But this would mean we would have to tackle each bpf_prog_run_xdp()
invocation and reset it afterwards=E2=80=A6 So maybe the backport instead? =
We
have
| $ git grep bpf_prog_run_xdp | wc -l
| 55

call sites.

> -Toke

Sebastian

