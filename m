Return-Path: <bpf+bounces-19824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F129E831DD2
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 17:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A513F289CBE
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889BB2C6AF;
	Thu, 18 Jan 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0SooyRW0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wTBlkSHL"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F662C1B2;
	Thu, 18 Jan 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596612; cv=none; b=fgwpnzDsGhUCeNSPVnReAOr2BPEWUqTHT1bMEjAmlmnkQKo36Sx8MJ/1nzI15G6Fktgr6+u6h46mkPOyJRYSN57KogOTxcZ4Mt/U6omT5O2BGjd1LFHPrP6AWB++Xjk52IBogScKrAjmSvbVsylczJh790V4yRTst6f1/w7EPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596612; c=relaxed/simple;
	bh=zdaadLxs4Ckkw6lRcG0g1ZosLJY36Mhsh/+4Lr+mqsc=;
	h=Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=UlT3Xco/r+nOytsv/iVY6vaBxxihBvb/39ko6pT8oBYSiJvHOUA4F0NeqaVHSlSGPcsLARdG7onV6QBcZjAVZIg3Lb22hrFjUNttU/HSYhc6Kk+PZ6hnp3Hc8jHBAJOfBY1CLjRWXUcK8aEeMNk1ILd3JhFzlr1MT+62LPmIoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0SooyRW0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wTBlkSHL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jan 2024 17:50:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705596607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdaadLxs4Ckkw6lRcG0g1ZosLJY36Mhsh/+4Lr+mqsc=;
	b=0SooyRW0vfUQ0Ad9+s1FhK4/U4HK8JGgPj+4WpPNQwkEkDquPz1HV2In8y8/4qKYXDbcSv
	fCi8Wi0EiD8JRYv88pNqCpaEFfenbDiDei95Hv8OXENgNRmd2A8EF8X87Kefr6WA+TMhNA
	RKVNnC+NTeVzd5O82Ocrh0ulUtN/IKj0DxXZHkAZK9ccVqiKXqkjSelFrDuEwQpftGNcJQ
	tN7EAvl+YbmRbN5GeOWsXmHWq4IZdu+w+gEv6AQV+yMvVa7ETs+gMe2gnecjVZq17Co1b3
	S7fOFjgvnogY2hCVMCptzCkQGoEo15JRDRO3o87wRqKWpSPG56j0LGRjYjMmxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705596607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdaadLxs4Ckkw6lRcG0g1ZosLJY36Mhsh/+4Lr+mqsc=;
	b=wTBlkSHLCsZKBgNRDbQ2CcK80b6axVIPWR1am1GIK42vzNe3az85EeOJNW48b36hCcl3AS
	nbOQRJEHgQ+wYMCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Cong Wang <xiyou.wangcong@gmail.com>, Hao Luo <haoluo@google.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Ronak Doshi <doshir@vmware.com>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 15/24] net: Use nested-BH locking for XDP
 redirect.
Message-ID: <20240118165006.5aWFm7Sv@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-16-bigeasy@linutronix.de>
 <CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9U-4bgxjA@mail.gmail.com>
 <87r0iw524h.fsf@toke.dk>
 <20240112174138.tMmUs11o@linutronix.de>
 <87ttnb6hme.fsf@toke.dk>
 <20240117180447.2512335b@kernel.org>
 <20240118082754.9L_QFIgU@linutronix.de>
 <20240118083812.1b91ba88@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240118083812.1b91ba88@kernel.org>

On 2024-01-18 08:38:12 [-0800], Jakub Kicinski wrote:
> > If this is the per-CPU BH lock (which I want to remove) then it will
> > continue until all softirqs complete.
>=20
> So there's no way for a process to know on RT that someone with higher
> prio is waiting for it to release its locks? :(

You could add a function to check if your current priority is inherited
=66rom someone else and if so start dropping the locks you think are
responsible for it.
I made a PoC that appears to work for timer_list timer which is one of
the softirqs. This made me realise that I need in more spots and I am
doing it for the wrong reasons=E2=80=A6

Sebastian

