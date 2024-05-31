Return-Path: <bpf+bounces-31009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C476B8D5FD1
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 12:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809E7288214
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD74155CBF;
	Fri, 31 May 2024 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F0heMktW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YN+uNLES"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46900155C8E;
	Fri, 31 May 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717151892; cv=none; b=TKYVd6bDWSG2ZyRwwS/8Uj0nYUjNwQSXO2xjOQDZeJDcuN2CZ/fxrl5qNKxesf5S5t2EExkPOlhWxJ6DAzCOwQHkUA7kJFtCGXFhNhQNUjQV6Io+SIYp+5IUdSVCjA+JTaUQItGY2sHLzrXhAuWjL/idntnuyt9mi9XwAZo7O58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717151892; c=relaxed/simple;
	bh=pHEsO2qn1rcaa/CVVCC1rJCGrocpF3xq2ymrPBC1hyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVa84WxKhoNcvFLGRU7mPDvTn3SYjw7Slnhf/Dyb+0WDQn2nuyX/CyEOOcdFGupdMLE4fV5FfWWjkhxhMRZAQGXCFB31ElW2VCIPcM9z/of7iyW2vZHOO5h7TNkhyZTs+7mbWNfMcVeSI9oStdRlHmsJcVw3tIdVSM2TnMdcvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F0heMktW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YN+uNLES; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 May 2024 12:38:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717151889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4acigBe027wOQx0luMaaon6tV311jRRizAmbiQqL3w=;
	b=F0heMktWAuN3lpcjkR+BkoYknS08e++75PnvWStPB9mL2ifxNdHcKz5weNkFgwFB1j84Qw
	QMYeUMqjHfYnQDfLmxfG2IMol2YmnIYoV9aDk3SIvCyO9iJc/PrYDZExR53KWU5eBit800
	A/8ur4BgPCXyYAcK0arCAFyxTYkLdMSj9Go2Y8rByOr4PvmyKltCd8K6hxKDc8uxbiMzhS
	O/0ecInyrCKM0d9uYSRkS3A/JOTNZ6Up+04k9Kl5vtbZutIm4rIE2mvgdJFOll5X/Ok3EF
	Wu1wiB8LMEdDeFz3DMTP32t5qruIRsjPHFSDeoImxEjZtLmkFDty3EdUcpWWnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717151889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4acigBe027wOQx0luMaaon6tV311jRRizAmbiQqL3w=;
	b=YN+uNLESzX+WmX/Q2l0gLeQmgehpBRHwNK7BGf1Ci7es9A7xJHTFdbLQVw8obMJK45/1gV
	40Y6OrLNtX5SqzCQ==
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
Subject: Re: [PATCH v3 net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240531103807.QjzIOAOh@linutronix.de>
References: <20240529162927.403425-1-bigeasy@linutronix.de>
 <20240529162927.403425-15-bigeasy@linutronix.de>
 <87y17sfey6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87y17sfey6.fsf@toke.dk>

On 2024-05-30 00:09:21 [+0200], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> [...]
> > @@ -240,12 +240,14 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_ma=
p_entry *rcpu, void **frames,
> >  				int xdp_n, struct xdp_cpumap_stats *stats,
> >  				struct list_head *list)
> >  {
> > +	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
> >  	int nframes;
>=20
> I think we need to zero-initialise all the context objects we allocate
> on the stack.
>=20
> The reason being that an XDP program can return XDP_REDIRECT without
> calling any of the redirect helpers first; which will lead to
> xdp_do_redirect() being called without any of the fields in struct
> bpf_redirect_info having being set. This can lead to a crash if the
> values happen to be the wrong value; and if we're not initialising the
> stack space used by this struct, we have no guarantees about what value
> they will end up with.

Okay, I can do that.

> >  void bpf_clear_redirect_map(struct bpf_map *map)
> >  {
> > -	struct bpf_redirect_info *ri;
> > -	int cpu;
> > -
> > -	for_each_possible_cpu(cpu) {
> > -		ri =3D per_cpu_ptr(&bpf_redirect_info, cpu);
> > -		/* Avoid polluting remote cacheline due to writes if
> > -		 * not needed. Once we pass this test, we need the
> > -		 * cmpxchg() to make sure it hasn't been changed in
> > -		 * the meantime by remote CPU.
> > -		 */
> > -		if (unlikely(READ_ONCE(ri->map) =3D=3D map))
> > -			cmpxchg(&ri->map, map, NULL);
> > -	}
> > +	/* ri->map is assigned in __bpf_xdp_redirect_map() from within a eBPF
> > +	 * program/ during NAPI callback. It is used during
> > +	 * xdp_do_generic_redirect_map()/ __xdp_do_redirect_frame() from the
> > +	 * redirect callback afterwards. ri->map is cleared after usage.
> > +	 * The path has no explicit RCU read section but the local_bh_disable=
()
> > +	 * is also a RCU read section which makes the complete softirq callba=
ck
> > +	 * RCU protected. This in turn makes ri->map RCU protected and it is
> > +	 * sufficient to wait a grace period to ensure that no "ri->map =3D=
=3D map"
> > +	 * exists. dev_map_free() removes the map from the list and then
> > +	 * invokes synchronize_rcu() after calling this function.
> > +	 */
> >  }
>=20
> With the zeroing of the stack variable mentioned above, I agree that
> this is not needed anymore, but I think we should just get rid of the
> function entirely and put a comment in devmap.c instead of the call to
> the (now empty) function.

I wasn't entirely sure if my reasoning is valid. In that case=E2=80=A6

> -Toke

Sebastian

