Return-Path: <bpf+bounces-19823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A157831DA7
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 17:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC681F21E3E
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 16:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864962C1B9;
	Thu, 18 Jan 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7TeO9Dy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A6928DD8;
	Thu, 18 Jan 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705595896; cv=none; b=uTmVzUvbMvNaC0i2+hgwpLE4eP2YloLDzjUnxLmU1tcLtI8Lw3GalRsGqR2Yz6vz367RqsVZQiHK2wsT5Oeg/1FNeveerKOf1rInrtLlr41eG2s1HDOkPbAitLiccJq5MOHY2wwUUBDOgoXCUZw4pvgAwVCtM3i/iXF2J5WgDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705595896; c=relaxed/simple;
	bh=jRTphcK/e9x4FUHAULwLsMzMToQ7/evgU0hqPmIiM2w=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=HtA1QIbnHdg4jvYfKEnznCw5Z1TGW//eiQeyWPYQ87uXdtwh67xJca+jDX03HTpz2uMsBqUxYOE3G+OYMcnB4RDahJS7sXaRpAZtEO9wlez65U+84trt+mUp8+8FmfpYjgSbwilvTYIErnch6JL7Dnbs0YBUVLWPYDt1IyC//w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7TeO9Dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0107C433C7;
	Thu, 18 Jan 2024 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705595895;
	bh=jRTphcK/e9x4FUHAULwLsMzMToQ7/evgU0hqPmIiM2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U7TeO9DyYiaYySuxIASAJyxlq3vtKIJKKXHNz0ART1KyEBafmJLUZTt1lKUV9vN3/
	 yHE+oPLxoErQXKEL5PI4qnAOnrfz+gHw0LZcmbqfgIFLWUc3Nal6QrA8YxEfPhn3ON
	 FNfTljnkrTGE3SnpBFGytjHJM5dI8/bO3pw7TUSd56nFAl32aB1qNxpSHj9IWdtDUc
	 A9CBber0mDs2dbR8NjsFANQQQJmeIfx7MoBgvcm9hxnn0lGzK6Hz2Jm0ZMxgVE3TbL
	 CB73O2cBxJ4KCd5UHeMWGoGhguWmEv43jQFvbhj7O0yrhom0WV0RCxiDaRGdd5062g
	 loRGxHxsh4/Mw==
Date: Thu, 18 Jan 2024 08:38:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Boqun
 Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Cong
 Wang <xiyou.wangcong@gmail.com>, Hao Luo <haoluo@google.com>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Jiri Pirko <jiri@resnulli.us>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Ronak Doshi <doshir@vmware.com>, Song Liu
 <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, VMware PV-Drivers
 Reviewers <pv-drivers@vmware.com>, Yonghong Song <yonghong.song@linux.dev>,
 bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 15/24] net: Use nested-BH locking for XDP
 redirect.
Message-ID: <20240118083812.1b91ba88@kernel.org>
In-Reply-To: <20240118082754.9L_QFIgU@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
	<20231215171020.687342-16-bigeasy@linutronix.de>
	<CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9U-4bgxjA@mail.gmail.com>
	<87r0iw524h.fsf@toke.dk>
	<20240112174138.tMmUs11o@linutronix.de>
	<87ttnb6hme.fsf@toke.dk>
	<20240117180447.2512335b@kernel.org>
	<20240118082754.9L_QFIgU@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jan 2024 09:27:54 +0100 Sebastian Andrzej Siewior wrote:
> On 2024-01-17 18:04:47 [-0800], Jakub Kicinski wrote:
> > Oh, and I'm bringing it up here, because CONFIG_RT can throw
> > in "need_resched()" into the napi_rx_has_budget(), obviously.  
> 
> need_resched() does not work on PREEMPT_RT the way you think. This
> context (the NAPI poll callback) is preemptible and (by default) runs at
> SCHED_FIFO 50 (within a threaded IRQ) so a context switch can happen at
> any time by a task with higher priority.
> If threadA gets preempted and owns a lock that threadB, with higher
> priority, wants then threadA will get back on CPU, inherit the priority
> of the threadB and continue to run until it releases the lock.
> 
> If this is the per-CPU BH lock (which I want to remove) then it will
> continue until all softirqs complete.

So there's no way for a process to know on RT that someone with higher
prio is waiting for it to release its locks? :(

