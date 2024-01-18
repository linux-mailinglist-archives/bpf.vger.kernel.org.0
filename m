Return-Path: <bpf+bounces-19797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 070E18314CF
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 09:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC33B2650F
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 08:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332DD2560C;
	Thu, 18 Jan 2024 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ULUlXTuq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8X0vlXbx"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDDA25602;
	Thu, 18 Jan 2024 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566479; cv=none; b=gowrD6a7tSWy8KbuIvJTMaBxbiJ81t5fAcxnlwjyN60RnN6SfLZS9yiqKO9kSGZgNSfsEkVLdeVbsa30doq2BSbgQP9JEEje/njP9LSiqRiE39VdjGR05Rx856UT9IiVvqRad4ehauGWHoNNlP41e6WZ/ozMnRTf4B7hTjZ7gow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566479; c=relaxed/simple;
	bh=FqDaDFZqHBr+6WdyMt/QodCMIwP8ih8bcOQuBWFD+a4=;
	h=Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=gdxsxUd5XeFWoCkZsV5Bvw8oMh7BfxLGfDCjY3ZKp1Mr+3xOPhdcyAgjDaYbi/bzzbydpT0bspAT03VAl+oXmoNTVLW8i3jNtY5iBSeNA/wuUvUofYfq8g8rx73qrLjquMjxADKbMIlO6/KIMcN6HN/2CuH6S8+GLRlNZfPvXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ULUlXTuq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8X0vlXbx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jan 2024 09:27:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705566476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FqDaDFZqHBr+6WdyMt/QodCMIwP8ih8bcOQuBWFD+a4=;
	b=ULUlXTuqug9vx2pHul8nknoShdT3GMPzErH5ysd7s1ozlosDBVdHLNVD/xkJgENWLVD0IE
	VXZCtDIHyQ8rsg2SxI12zJKRPGA+f8P/tP/R44ZZt5rpmFBzGB+++joNOxOOnDR3TK5nX9
	3hJZiXd/0ELV8ISAflvIgJIc5SHPbcRxu3BpDKYRUi0cPy9pareqe7+1G3lvGmx8kLKfR5
	oyYq0l7ll4+fnkKun+xy3+ZfpR50ONPQc1RbzldkWUbCSjmfRfG2/ui9H8X55wd5M30JXJ
	8f9QOHa4hwHULaLSYAPusjOdcNKrdmwT8HcumuPSsPqC1MeQ8zMv8A79UF/oRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705566476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FqDaDFZqHBr+6WdyMt/QodCMIwP8ih8bcOQuBWFD+a4=;
	b=8X0vlXbxI3eFXc5LIwJRggK1eV2OY9uO4RMh/qUdkwHa4UTEkUDb46oQ3rsgCkJqN7LfBP
	DEBQdp/o3cm8knCg==
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
Message-ID: <20240118082754.9L_QFIgU@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-16-bigeasy@linutronix.de>
 <CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9U-4bgxjA@mail.gmail.com>
 <87r0iw524h.fsf@toke.dk>
 <20240112174138.tMmUs11o@linutronix.de>
 <87ttnb6hme.fsf@toke.dk>
 <20240117180447.2512335b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117180447.2512335b@kernel.org>

On 2024-01-17 18:04:47 [-0800], Jakub Kicinski wrote:
> Oh, and I'm bringing it up here, because CONFIG_RT can throw
> in "need_resched()" into the napi_rx_has_budget(), obviously.

need_resched() does not work on PREEMPT_RT the way you think. This
context (the NAPI poll callback) is preemptible and (by default) runs at
SCHED_FIFO 50 (within a threaded IRQ) so a context switch can happen at
any time by a task with higher priority.
If threadA gets preempted and owns a lock that threadB, with higher
priority, wants then threadA will get back on CPU, inherit the priority
of the threadB and continue to run until it releases the lock.

If this is the per-CPU BH lock (which I want to remove) then it will
continue until all softirqs complete.

Sebastian

