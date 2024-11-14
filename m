Return-Path: <bpf+bounces-44838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D1D9C8756
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 11:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE681F22108
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 10:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A62B1F8F10;
	Thu, 14 Nov 2024 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AhL/2Gve";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ovuE8Y+m"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B27A1F8F02;
	Thu, 14 Nov 2024 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578996; cv=none; b=ssBDX67WA6NwmbS9d+DHDTBpNp0oRVJD4Vf0CnFcOLWx7i6Oepcqac0NBF68ynUG82SSFvOrlYXKwT+SBhR64UrDqx8UXkHUeVkGXPtpunor0mKfLmya/GDHTHudNE0R7MWOYDlbpPnP/4rZ/XLQBVp/QKyKe6/1yncPeyuXd4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578996; c=relaxed/simple;
	bh=j8/bDpeWMxzFyIBUMAW1K7Nkzc2G+SHXLJZy1z8VPtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foNLq6cJszixzYVL5shTsZLOGOi+Pr1NXJwFsCJeqq7tETdXNU4adDS7J0TdC/w3fi3Zu65WekX5Ie/8uF9dQGR+JgKpS2MhxmaVdwosAZsGbSCM6lM78hFdf3msFu9JbXPRuY0H5NhY5rYN9dl0oekMtxMAR70cniGOwFLTy1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AhL/2Gve; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ovuE8Y+m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Nov 2024 11:09:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731578987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4rhu1rOyXbmFKCWkfY+2TotSXX7WMQkDT9IBgiSvNc=;
	b=AhL/2GveqCJpSpZuvQsj5ghGqrVWFhPzXwCmwe8TCBNJPMBfCV9lvZSSNa/U8aKcDRjUNq
	VRecRC6hYkncpzi28MeBh/CjiP+cb/F0Bpr45gGkTmPeeYFfePMkoXvYLZfCS7ds6IDueO
	+ML5pdw1UaN9wkCUq1at1m9Ld6uUfDZ/N6C2CjXTLC/WZRcFaNzBoN2rXU8dzZnl2yw+ga
	/jvm5iA4sDar5007p38ulLQIf3wGgHvWxUjIoIuZwPgi0dBtAGep+wTNvU7W4PKs2M9e8v
	2qQ2/EZ2vhpgYnhKr04tGLx1rjKYpTu+UgBSF/EJWcNWQmPTI5/Vk3Yx/L2ttA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731578987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4rhu1rOyXbmFKCWkfY+2TotSXX7WMQkDT9IBgiSvNc=;
	b=ovuE8Y+mje/KzO5huf9Oa6KS1A0AzBvYojD/oc+fJiiqsyryH6r82+Lme2b6jNrJTiR0T8
	bSQkonZIRA6olSBw==
From: Sebastian Sewior <bigeasy@linutronix.de>
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	clrkwllms@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
Subject: Re: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
Message-ID: <20241114100945.VWuTi7kg@linutronix.de>
References: <20241108063214.578120-1-kunwu.chan@linux.dev>
 <CAADnVQJ8KzVdScXM=qhdT4jMrZLBPpgd+pf1Fqyc-9TFnfabAg@mail.gmail.com>
 <78012426-80d2-4d77-23c4-ae000148fadd@huaweicloud.com>
 <CAADnVQK_FptUD17REjtT1wnRyxZ2dx6sZuePsJQES-q27NKKLA@mail.gmail.com>
 <ab0abca0-57b3-b379-0070-4625395c6707@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab0abca0-57b3-b379-0070-4625395c6707@huaweicloud.com>

On 2024-11-10 10:08:00 [+0800], Hou Tao wrote:
> >> well. However, after changing the kmalloc and its variants to bpf memory
> >> allocator, I think the switch to raw_spinlock_t will be safe. I have
> >> already written a draft patch set. Will post after after polishing and
> >> testing it. WDYT ?
> > Switching lpm to bpf_mem_alloc would address the issue.
> > Why do you want a switch to raw_spin_lock as well?
> > kfree_rcu() is already done outside of the lock.
> 
> After switching to raw_spinlock_t, the lpm trie could be used under
> interrupt context even under PREEMPT_RT.

I would have to dig why the lock has been moved away from raw_spinlock_t
and why we need it back and what changed since. I have some vague memory
that there was a test case which added plenty of items and cleaning it
up created latency spikes.
Note that interrupts are threaded on PREEMPT_RT. Using it in "interrupt
context" would mean you need this in the primary handler/ hardirq.

Sebastian

