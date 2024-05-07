Return-Path: <bpf+bounces-28795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FAE8BE080
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 12:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C554B291E0
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 10:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797A815252B;
	Tue,  7 May 2024 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HqtKIhUt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="imj9h2Uv"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D57A1514E0;
	Tue,  7 May 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079457; cv=none; b=bx60woKEbIN3sOgoW2PZGe/mXFmRt0zZoAoN5kAUXt7pOsG4F7fjdt+gaxiuhKlSLKhrqQXWHpV4cGNaIloD/TuHq2MCCGR2VtNKBYiNoIwTh5XKm6xB8+DA0Q2gi2ql1Rhmd3nhyhpPCRRAWRdqBtSdnGrMcTzZvKgIkGXmpww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079457; c=relaxed/simple;
	bh=A+EbpdiyFTLCJ3WEbycqzxsvyAHs5tU3Bcv6dCovmgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7QpoehDzEySwD8QSD2KHMd4TsMdARRPAEc/8T80/7jIo01KZTsZFlYLOBerjPaZZHjKlfA3sGcSbCctdSfYAQwaxAZGs3XZa9tBoX/rbdRxvII64UQ8G1gyeyIJLnY4s/4TrZGdCDHGCgf/7EA6NXcsk1U4sgHHUgo28J0R9jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HqtKIhUt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=imj9h2Uv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 7 May 2024 12:57:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715079453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtwFIhzccD61Y5XV3lTrxYOfQYYlK18Tp/2FeKkbBUU=;
	b=HqtKIhUtF8OyNrOTCmcVyHiAtNPO/DVVwOlHFOYaOUNxrLqGxK5oHo/bgVp76D5qMTLvgW
	mPqghN6xR7roXt47nbFkK1qe7WIBwqV/FHZBDKXipHbtGeGoMdm9KNj3rbkCV0CvP0wku1
	xfjrOy9GrGGXEIXbsUeF9OQSeKll2cPaBJcccbd2MPi+VEgR1dC6ObtEFMKWY5C+PSLTk0
	8PIdIfP9epMp/jkZijs1k1XGNWBmweC8mWKhv2Zwy8eG6euJQuRIWjerhAlq3WFkxf2mdr
	VRi50OUWFr4CJXZBGwuknQ0x6GF7YW+g2Uge6xDUj4n13jhvx4BpKXn+E+B/xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715079453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtwFIhzccD61Y5XV3lTrxYOfQYYlK18Tp/2FeKkbBUU=;
	b=imj9h2UvjRZGt5Bo1myXZXD4GjNB0O0O5Ny3wMdw+lnDe5ER2DoHRzi8htxAo/RtwCxxFG
	QGH8XG4zDWuMHpAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
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
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240507105731.bjCHl0YH@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <20240503182957.1042122-15-bigeasy@linutronix.de>
 <87y18mohhp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87y18mohhp.fsf@toke.dk>

On 2024-05-06 21:41:38 [+0200], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > On PREEMPT_RT the pointer to bpf_net_context is saved task's
> > task_struct. On non-PREEMPT_RT builds the pointer saved in a per-CPU
> > variable (which is always NODE-local memory). Using always the
> > bpf_net_context approach has the advantage that there is almost zero
> > differences between PREEMPT_RT and non-PREEMPT_RT builds.
>=20
> Did you ever manage to get any performance data to see if this has an
> impact?

Not really. I would expect far away memory is more expensive.

I have just a 10G setup and after disabling IOMMU I got the "expected"
packet rate. Since the CPU usage was not 100% I always got that packet
rate. Lowering the CPU clock speed resulted in three (I think) rate
ranges depending on the invocation and I didn't figure out why. Since it
is always a range, I didn't see here if my changes had any impact since
the numbers were roughly the same.

With enabled IOMMU, its overhead was major so again I didn't see any
impact of my changes.

> [...]
>=20
> > +static inline struct bpf_net_context *bpf_net_ctx_get(void)
> > +{
> > +	struct bpf_net_context *bpf_net_ctx =3D this_cpu_read(bpf_net_context=
);
> > +
> > +	WARN_ON_ONCE(!bpf_net_ctx);
>=20
> If we have this WARN...
>=20
> > +static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
> > +{
> > +	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
> > +
> > +	if (!bpf_net_ctx)
> > +		return NULL;
>=20
> ... do we really need all the NULL checks?
>=20
> (not just here, but in the code below as well).
>=20
> I'm a little concerned that we are introducing a bunch of new branches
> in the XDP hot path. Which is also why I'm asking for benchmarks :)

We could hide the WARN behind CONFIG_DEBUG_NET. The only purpose is to
see the backtrace where the context is missing. Having just an error
somewhere will make it difficult to track.

The NULL check is to avoid a crash if the context is missing. You could
argue that this should be noticed in development and never hit
production. If so, then we get the backtrace from NULL-pointer
dereference and don't need the checks and WARN.

> [...]
>=20
> > +	/* ri->map is assigned in __bpf_xdp_redirect_map() from within a eBPF
> > +	 * program/ during NAPI callback. It is used during
> > +	 * xdp_do_generic_redirect_map()/ __xdp_do_redirect_frame() from the
> > +	 * redirect callback afterwards. ri->map is cleared after usage.
> > +	 * The path has no explicit RCU read section but the local_bh_disable=
()
> > +	 * is also a RCU read section which makes the complete softirq callba=
ck
> > +	 * RCU protected. This in turn makes ri->map RCU protocted and it is
>=20
> s/protocted/protected/
>=20
> > +	 * sufficient to wait a grace period to ensure that no "ri->map =3D=
=3D map"
> > +	 * exist.  dev_map_free() removes the map from the list and then
>=20
> s/exist/exists/

Thank you.

>=20
> -Toke

Sebastian

