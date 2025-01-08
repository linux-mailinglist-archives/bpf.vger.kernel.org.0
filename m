Return-Path: <bpf+bounces-48230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43754A0568A
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 10:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173D2163A4F
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 09:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC211A01D4;
	Wed,  8 Jan 2025 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jUVmj+Z7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FOEJaTlZ"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2680218B495
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327807; cv=none; b=PWUXM40ChtlhNalQSn81tmOGTwUV1FvfPtODXN/oc+N07BY4XDu0rRV4bfe+KmZO61QSIqn3TeNaB/KNcV0sPCNPWggTA8Vpu3gjVSj6nG4dOyCrIGT0iNwrr7LKSlX0P5Ijowfjlfdu/+RnRMO8IyToZGWo+1bG5HWPN0YSILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327807; c=relaxed/simple;
	bh=7l83dhktf1TstnJa0w/Wnyn5Kd5sifBXWwzInLUacuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2qV93TJC0JUYc7twcSKeVRUeh2pW5pB5wiDclsAsCUB+ihFTXnLlLBlr5pdtvZwezQ9N1wUev+apkyX2p3WHRD8Y1nE6ud/neh51ZK1Reb2yFB2vciHP1bR/K8fNFX9xChlbXx68wlAzhNt92AeNa858nutRM5TNqFf8LQK7tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jUVmj+Z7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FOEJaTlZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 8 Jan 2025 10:16:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijN0bMPMb976G1pq/ZMrzWbok1+cDaflp5Tt32h3vOU=;
	b=jUVmj+Z7OkxhhzEjTCvTOUGf3yyHP22wLtK8UPYSWmeaBQaEQSvHbcvVi1wFPO+yUOX7qG
	9SixNdejvt9OxNeQf3SNEYLf3xwtUcY6u4AP7R0McPxKEE4FTXKaIsf5kv4VJ40siTjHTf
	zxMo3/RXEuZiqA+dmbw5qH3IQiP+tlTXCSvGXmpFc3sHXUye3/bz7z86KD96eV3FdQuWTM
	nTSs9uilopRk7WcnfMWWEPwMcwV64v8FjrKGBW9QQKRk7ksGS3VSINXNUXH1UqqSNWxDx/
	+pcKe291IyehZ7QzjOQpmc4bsiBurf9EaVgmC+gq7HJW+H/T17LgotEa7DJDsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijN0bMPMb976G1pq/ZMrzWbok1+cDaflp5Tt32h3vOU=;
	b=FOEJaTlZI30h8+J+1dWTiNvrYrHwaQMxP3t6iKTNVJXesQF3TLHGgslBqUBhJ83RSYDyGC
	JUpf2vMZnoJdzvBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, xukuohai@huawei.com,
	"houtao1@huawei.com" <houtao1@huawei.com>
Subject: Re: [PATCH bpf-next 0/7] Free htab element out of bucket lock
Message-ID: <20250108091643.FjZcvyLV@linutronix.de>
References: <20250107085559.3081563-1-houtao@huaweicloud.com>
 <9b4ebbaf-dd3c-85a4-2d17-18b8805ea5fb@huaweicloud.com>
 <9685012a-1332-95a1-a8ef-dfd25f5cd072@huaweicloud.com>
 <20250108072906.chgNtc8S@linutronix.de>
 <2728739a-5c6a-acbe-2231-7dd1c52d5826@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2728739a-5c6a-acbe-2231-7dd1c52d5826@huaweicloud.com>

On 2025-01-08 17:06:06 [+0800], Hou Tao wrote:
> Hi,
Hi,

> On 1/8/2025 3:29 PM, Sebastian Andrzej Siewior wrote:
> > On 2025-01-08 09:24:02 [+0800], Hou Tao wrote:
> >> @Sebastian
> >> Is it possible that softirq_expiry_lock is changed to a raw-spin-lock
> >> instead ?
> > No. The point is to PI-boost the timer-task by the task that is
> > canceling the timer. This is possible if the timer-task got preempted by
> > the canceling task - both can't be migrated to another CPU and if the
> > canceling task has higher priority then it will continue to spin and
> > live lock the system.
> > Making the expire lock raw would also force every timer to run with
> > disabled interrupts which would not allow to acquire any spinlock_t
> > locks.
> 
> Thanks for the explanation. However I still can not understand why
> making the expire lock raw will force every timer to run with disabled
> interrupt. 

I'm sorry. Not disabled interrupts but preemption. hrtimer_run_softirq()
acquires the lock via hrtimer_cpu_base_lock_expiry() and holds it while
during __hrtimer_run_queues() -> __run_hrtimer(). Only
hrtimer_cpu_base::lock is dropped before the timer is invoked.
If preemption is disabled you can not acquire a spinlock_t.

>            In my simple understanding, hrtimer_cpu_base_lock_expiry()
> doesn't disable the irq. Do you mean if change the expire lock to raw,
> it also needs to disable the irq to prevent something from happening,
> right ? 
No, see the above, it should clear things up.

>         Also does the raw spinlock have the PI-boost functionality ?

No. Blocking on a raw_spinlock_t means to spin until it is its turn to
acquire the lock.
The spinlock_t becomes a rt_mutex on PREEMPT_RT and blocking on a lock
means: give current priority to lock owner (= Priority Inheritance) + go
to sleep until lock becomes available.

Sebastian

