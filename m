Return-Path: <bpf+bounces-31431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 314F98FC940
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 12:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557CB1C23742
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 10:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E5A191489;
	Wed,  5 Jun 2024 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f0VA1AQm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yZypw/nj"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA911419B3;
	Wed,  5 Jun 2024 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717584094; cv=none; b=r/Qvebz8KFW2fNjcK3YjDl5cT1u3zLFvBQAeH8kIMPp+SkDVabA/bsX8LEMmbRcV8+3C7f0jMIC3+bN3NGNNdbFWTENQDFYI0rj5xLP/NA+bM8RJg17jNqwZ6Kb3ov4vMpnbt3B/9QXoFBZe73ADOw+V6y8TfPr/7P7V9hiMCgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717584094; c=relaxed/simple;
	bh=eZQAlktM5sSKOc7xl8T3yZmnjfD+pXJcgSGCDo7IsQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnIGhCZ/xhTVoE6qMvWPsETEdUlHGN0CEHTaTHbWoCjEOiR3EjWYcqNuzukpqnNA5FYhEpR/6wr5a88oIkgUMCdQYLQ/x7gmzmRYE51itGxdKLHNJBn1rmKyi2XcX7pbgkDsEcbf1N9ltQ8ciR78DOfP9ywU7U7Iyx5zSCS7SS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f0VA1AQm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yZypw/nj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Jun 2024 12:41:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717584090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZQAlktM5sSKOc7xl8T3yZmnjfD+pXJcgSGCDo7IsQI=;
	b=f0VA1AQmVNcMwcRa5YaQYwKiAr5rkg4NbxEipsKHFs38o82t8YNFLI4Ig1+vNkg8JNF1Ed
	Mx7JA99sS2SZPh8IeKsZcyq/GrLxp8qPSJTXlOJ8+DOrimCXpdxjmS/KkBAG/fu2oPILJI
	gPiBdIfzoDuKqTTU5VI9ZyVrLNN4Af+Dvt2Gd1vvSscasFjScmClscbJH6ZIHP/3RCssy6
	vxvgGppLbydNrc5hfzWJtk+vSig6n9XAJ6EcIKbvbtuQ45A9zIQp42qg5E//043zUPT+7Y
	8xhBCUb85LEthBTKikEJBvARPAaoFEFBbuNUO02NLT9oZYcl6Wu+3EiBupWzrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717584090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZQAlktM5sSKOc7xl8T3yZmnjfD+pXJcgSGCDo7IsQI=;
	b=yZypw/njS7m/PwTo/T6mVZkHvCFP+7xq63jdVHnq9duU2SdlWhQw3UJSVUUGulhgwdaWSC
	BaQmkGyphk0gqRDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
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
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v3 net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240605104128.Nn9Cp0CB@linutronix.de>
References: <20240529162927.403425-1-bigeasy@linutronix.de>
 <20240529162927.403425-15-bigeasy@linutronix.de>
 <87y17sfey6.fsf@toke.dk>
 <20240531103807.QjzIOAOh@linutronix.de>
 <9afab1bb-43d6-4f17-b45d-7f4569d9db70@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9afab1bb-43d6-4f17-b45d-7f4569d9db70@kernel.org>

On 2024-06-05 12:28:08 [+0200], Jesper Dangaard Brouer wrote:
>=20
> Hmm, but how will this affect performance?

As I wrote in the changelog for v4, I haven't notice a difference. I
tried to move bpf_net_ctx_set() from cpu_map_bpf_prog_run() to
cpu_map_kthread_run() to have this assignment only once and I didn't see
a difference/ I couldn't tell the two kernels apart.

This is what I have been using for testing

| xdp-bench redirect-cpu --cpu 3 --remote-action drop eth1 -e

in case I was changing the wrong part=E2=80=A6

> --Jesper

Sebastian

