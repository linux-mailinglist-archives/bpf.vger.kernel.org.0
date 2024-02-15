Return-Path: <bpf+bounces-22066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE40855D5E
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 10:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9757C28C113
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C2A13FFD;
	Thu, 15 Feb 2024 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="numNNyzH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7grj45p3"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C3134D3;
	Thu, 15 Feb 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987874; cv=none; b=JWdqvxOD9vxq+NhRlz+PGZMdxarI6Hn4P7CxYQnczpsBvBFN5znXSpE3jozbBDBEWqU6PX1bukjtDOVYFWvxz5mf36Vz5VEnRxwSJRdSTxkQQxzFzLm1P9Suz8dEnz3jEVZXS/tGZGopO9t8iZGj63fLlZhb44J5RO6ZhXwepe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987874; c=relaxed/simple;
	bh=GCpT6CXYqbGGLaAOGkXkfJ/a2YvRtUjhN61mhn++udc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biB0T/nmTQfHOtamzm81/kN0aSc2XWXuCV2WMnIoIYFCa5GMimtUbgwVmutoZkHQaulEHLiJlBfDjH/HpkDfRiGtQfusTXV95+JW0PZ7tibdS7zd4CO+WH0uHTlBAFkgd2nqxuROPWbR0JuqjgSxGG9uMD8q9Utj5I4WFAvm70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=numNNyzH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7grj45p3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Feb 2024 10:04:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707987870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AZdGOLLnzyQxUT703z+M77uxLasTsDovXub6Os9ovQ=;
	b=numNNyzHYxCv0LIEVOl7KD4/F40UbEEx6Q1S+u/zg63W4VNcSWfn7wROIKCYw1/R8DzyOC
	qhtO6egfEcwJ9lRo17no7sNhFP3dgzdg7Avvtg+d/ZSpBwotR3lrOsekDLaYyzcGEn2ydH
	RElwTJ+Xe7Zx02vV95U4U3+z1kqaNo0zE0Wib9dYhLT+/UxKCKsTg6agqN70ij3raj1lgx
	cpZoGUcXfjRcUph5HzalS+WYB7xhvc0piRR61uw2Ou4Y+OuLmQBPY/4XVlRnGKSH7JEtim
	wHm7/ePInAs4gKmrm4uYG5qLb6lU5KlNGIcRoJe3y7Ul5S62sHaSF4O6rT8EtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707987870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AZdGOLLnzyQxUT703z+M77uxLasTsDovXub6Os9ovQ=;
	b=7grj45p3lGo7L+bnWQKEOF8k/kPq4pUs0yPT4K58WHihzEmbaO0sDNsRq89KKWu1PRRrqf
	iBF6afCGIOce7hBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240215090428.3OW_j0S8@linutronix.de>
References: <20240213145923.2552753-1-bigeasy@linutronix.de>
 <20240213145923.2552753-2-bigeasy@linutronix.de>
 <87il2rdnxs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87il2rdnxs.fsf@toke.dk>

On 2024-02-14 17:13:03 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index de362d5f26559..c3f7d2a6b6134 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4044,12 +4048,16 @@ static __always_inline struct sk_buff *
> >  sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *de=
v)
> >  {
> >  	struct bpf_mprog_entry *entry =3D rcu_dereference_bh(dev->tcx_egress);
> > +	struct bpf_xdp_storage *xdp_store __free(xdp_storage_clear) =3D NULL;
> >  	enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_TC_EGRESS;
> > +	struct bpf_xdp_storage __xdp_store;
> >  	int sch_ret;
> > =20
> >  	if (!entry)
> >  		return skb;
> > =20
> > +	xdp_store =3D xdp_storage_set(&__xdp_store);
> > +
> >  	/* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
> >  	 * already set by the caller.
> >  	 */
>=20
>=20
> These, and the LWT code, don't actually have anything to do with XDP,
> which indicates that the 'xdp_storage' name misleading. Maybe
> 'bpf_net_context' or something along those lines? Or maybe we could just
> move the flush lists into bpf_redirect_info itself and just keep that as
> the top-level name?

I'm going to rename it for now as suggested for now. If it is a better
fit to include the lists into bpf_redirect_info then I will update
accordingly.

> -Toke

Sebastian

