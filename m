Return-Path: <bpf+bounces-29764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CFA8C679F
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 15:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4B51F22FA2
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564C713EFEE;
	Wed, 15 May 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FTi282HB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZGm6S6Vm"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539B11386AD;
	Wed, 15 May 2024 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780611; cv=none; b=h26hdF5aVmzOPDMno4D4FeHsVrFLJJ19SA2Ncm+kHmTFiBaRIwfluUqgjEiJnK3/c/2aiHoJjloVhM6fsSlec6HZwHZX/Huhd/+vCpbEiAz5gq15MY+ZV3zfDK5xDW7AitFI+GOUtLXYPlJQyI2cqwk+HoUB4DlVgLn21K3fRO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780611; c=relaxed/simple;
	bh=TRd4hhNnYO8xgPIyqCyl4FMG7ggnR9P6dr6VfxbM808=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txj/ebfL/NSobjOvihEqms9xBv5Ldo6Z0/kJAEfHRNREJEsNPxRDjz5lOp0SGgHCLqDQiNaH1qYJwoOw8i8k4/ybsX+L1hpQAFQYpD0hXwIB3O4oCsxOtkZxmgrIgMlJzFBffkr/PkpgAoNpSob+5OpC9eOVuOSWufhKJmoNojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FTi282HB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZGm6S6Vm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 May 2024 15:43:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715780608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdU69UoyhJ1zQ0SWWUqZX4B1Wd/oEqna6YOmzjb1SQg=;
	b=FTi282HBZPmh7c6WSn/S4W0VoXiezouodE+uKWxcNgMky5OxF8h3uS021U7PJHtAP39Mp5
	dWLAhTE1v4uYd7TcVk57La8G+rWUkM5OIKxDqEkSAIhzB3nAFpd6YhixeKpB/4oiKb4yJg
	1srE4D4+NwxIOoymWVuWDzQqjk1hn9ZKsMfPcvBIwmExIuDh2aD3Lx8tPhOl4krgup6CTe
	agYP4M79xR7awcNAyzbm80mTuKLCdEtQD6k0ck+ApCEU/d/nHp+2tKMZrXMZA8Tsr1QHGV
	ABEhsV09T6MHTvT6s1ZNycxEWWnuYOF+cxALNh1ZVyjYU1qQQf+p7+axJva5VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715780608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdU69UoyhJ1zQ0SWWUqZX4B1Wd/oEqna6YOmzjb1SQg=;
	b=ZGm6S6Vm9lEMBk7wMxLxmbVEvokYejJincM8TEVPpN2oaUje3MvkHH1NzflfDEs1mdQvSB
	Q+STKOt4MnoOH9Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 14/15 v2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240515134326.14x755Wb@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <20240503182957.1042122-15-bigeasy@linutronix.de>
 <87y18mohhp.fsf@toke.dk>
 <CAADnVQJkiwaYXUo+LyKoV96VFFCFL0VY5Jgpuv_0oypksrnciA@mail.gmail.com>
 <20240507123636.cTnT7TvU@linutronix.de>
 <93062ce7-8dfa-48a9-a4ad-24c5a3993b41@kernel.org>
 <20240510162121.f-tvqcyf@linutronix.de>
 <87le4cd2ws.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87le4cd2ws.fsf@toke.dk>

On 2024-05-14 13:54:43 [+0200], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1504,6 +1505,8 @@ struct task_struct {
> >  	/* Used for BPF run context */
> >  	struct bpf_run_ctx		*bpf_ctx;
> >  #endif
> > +	/* Used by BPF for per-TASK xdp storage */
> > +	struct bpf_net_context		*bpf_net_context;
>=20
> Okay, so if we are going the route of always putting this in 'current',
> why not just embed the whole struct bpf_net_context inside task_struct,
> instead of mucking about with the stack-allocated structures and
> setting/clearing of pointers?

The whole struct bpf_net_context has 112 bytes. task_struct has 12352
bytes in my debug-config or 7296 bytes with defconfig on x86-64. Adding
it unconditionally would grow task_struct by ~1% but it would make
things way easier: The NULL case goes away, the assignment and cleanup
goes away, the INIT_LIST_HEAD can be moved to fork(). If the size
increase is not an issue then why not. Let me prepare=E2=80=A6

> -Toke

Sebastian

