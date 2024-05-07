Return-Path: <bpf+bounces-28814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 732DF8BE24A
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFE6B296CA
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 12:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EF8158A2D;
	Tue,  7 May 2024 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0skkp0I5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/JjfpUyS"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6C61DA3A;
	Tue,  7 May 2024 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085400; cv=none; b=O9UbCHMhltUXnJC2OcdDXELGa39cwmlM7ihrzF+kf43FZgjTeazt2GqkbTBoDnyC++7dgMvFJAkgwAf4zLlT8bxOo5RQgyMaB8FPTAKHzvjJsgki9t6LxnsOXtO1JdE+gfdta7c/1JuzXYbyTL6vVoBxB1vNO++eqnyeseBY8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085400; c=relaxed/simple;
	bh=9G2vBiJaAA3BQNwwiCWALPOb9+HbQdLD4X/2fudy6xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUTFAluWgoWHLDbLRMP8El7h8dQYQqJaDzgGjC4HuURXAgEHN/AzbXxQAwlLqhLqVxlQEwKVRvdmcwyMHcbHcI0PSmxR9mUqwxnuIwknyVA7nxNKD0+Ut387l+zi8LW2qUPO4geXWDv6UMNBwQ771z78zKjOLGC2wuzUYGyKiQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0skkp0I5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/JjfpUyS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 7 May 2024 14:36:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715085397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=abD/WEok7ruvAwEFcdpePsY8TlgCTElZkcX9i8JMXQc=;
	b=0skkp0I5Wkrm16f4vCYvhDeUv4Xe3PXz+RhPhsojzPdEIO0NiyUDKt6ug+dBNqMYInzZP1
	VeI8iSwX5Lyj9kwoUNCSclciGjCfQod+Bmkad4u5QFIx+jwC4dghdQ8PUpVEULXAHKnp0Y
	kNGRyGfkQjIH48axOYQdikSVAMK9wepxbHz6LOmRn99fKS5OKMD2/CntrvctCKHZc+KayC
	xXpUvIgSeh+6lqiRb6wNJBicC5X5sN8Tsr+dBwb63BakpsJSNuM3laxdao8djuRHrx+qMF
	cq62Ae7kKN0Wo4x8L3D6EY66UzW6EBAWUOVE4nWNnT/QlOKgj6GGyUc/jiGFDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715085397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=abD/WEok7ruvAwEFcdpePsY8TlgCTElZkcX9i8JMXQc=;
	b=/JjfpUySMWS2t+Eo2IHC62Dpq6h8Q0dExEHVXU13h2qbsd59k6fSl9dOokezH4jZhi8G/q
	oEqNaLi5OeIV4KCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
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
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240507123636.cTnT7TvU@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <20240503182957.1042122-15-bigeasy@linutronix.de>
 <87y18mohhp.fsf@toke.dk>
 <CAADnVQJkiwaYXUo+LyKoV96VFFCFL0VY5Jgpuv_0oypksrnciA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQJkiwaYXUo+LyKoV96VFFCFL0VY5Jgpuv_0oypksrnciA@mail.gmail.com>

On 2024-05-06 16:09:47 [-0700], Alexei Starovoitov wrote:
> > > On PREEMPT_RT the pointer to bpf_net_context is saved task's
> > > task_struct. On non-PREEMPT_RT builds the pointer saved in a per-CPU
> > > variable (which is always NODE-local memory). Using always the
> > > bpf_net_context approach has the advantage that there is almost zero
> > > differences between PREEMPT_RT and non-PREEMPT_RT builds.
> >
> > Did you ever manage to get any performance data to see if this has an
> > impact?
> >
> > [...]
> >
> > > +static inline struct bpf_net_context *bpf_net_ctx_get(void)
> > > +{
> > > +     struct bpf_net_context *bpf_net_ctx = this_cpu_read(bpf_net_context);
> > > +
> > > +     WARN_ON_ONCE(!bpf_net_ctx);
> >
> > If we have this WARN...
> >
> > > +static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
> > > +{
> > > +     struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
> > > +
> > > +     if (!bpf_net_ctx)
> > > +             return NULL;
> >
> > ... do we really need all the NULL checks?
> 
> Indeed.
> Let's drop all NULL checks, since they definitely add overhead.
> I'd also remove ifdef CONFIG_PREEMPT_RT and converge on single implementation:
> static inline struct bpf_net_context * bpf_net_ctx_get(void)
> {
>  return current->bpf_net_context;
> }

Okay, let me do that then.

Sebastian

