Return-Path: <bpf+bounces-53526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E62FFA55E19
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 04:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261FF1892E1B
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 03:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DB018DB0F;
	Fri,  7 Mar 2025 03:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BmqiE/j2"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43B1624F7;
	Fri,  7 Mar 2025 03:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317271; cv=none; b=RtIZ1li/oPbxNKNafW43FekggmGRWf1Ud4pwEJXCsQ72Lk9rqzXKL8BKzC2OR2gRJ+k7sKcatuGEUIeEXIa1+rBe+2qaDrO28Z7Zs6mrBdzastSLy13CtrONvx7CqR/r3wG8J3HmXEpARjjG5N+qd5GzE3Iq8/F22IC/pZFkT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317271; c=relaxed/simple;
	bh=kec/ZUX0c337OY5+3Qfv/Wzso7jxS+i54rJmgYWZoAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SanbUKg9rn0mUvikpJVvYAN9whXE1JW3QtFMFF8HxE/s2rYWQBJObYH2mlbTRVZOHVOInju/UOgGhARe5b5FEJvB0DPVtnmG7+C/z2t1yo82d9vXYR8YsjLHAuZnWQTnC1IlrHOEOBONJ2bxxLymHX5xrZg/NWdIFmJQYedMREo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BmqiE/j2; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P4ZhSMuUp5ciJ7ZKBTxn4R2bDhl4Z5FvcqcYWRY3lTw=; b=BmqiE/j2P25fEPowEG+0pXGse7
	1LoifTvEFV8tB3hMVR/7USepv5iuW7aKCdiwIJZdNadk8MDAUj7l2g5vxvVve0sjj41mhKYlVH8Ve
	N4s6QDjmG3d4NNmpmwWEXPMfe+Yhc8HuwjReGw+56BgRRJzlD+RSUKfZwTgQPDnT4/8xJ1jCrIJ9e
	tUbyxTTWur8tdYb7p/0brCBLIZoSM9OvntOdqrlhnULhDhMFKir7p4mVv1Jugq8TnZ08PPEOa2xpy
	H5aDXYCknIsLTziuJowETM5Q9Zr/zUK9nmu+erJk7KetiSVsl3EIRiGeTJnwhlfm2Nq+sZb/15tQ6
	9rbGEXTA==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tqOA9-005ALF-9H; Fri, 07 Mar 2025 04:14:19 +0100
Message-ID: <41631831-6486-4286-a399-23130d1f653a@igalia.com>
Date: Fri, 7 Mar 2025 12:14:12 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET sched_ext/for-6.15] sched_ext: Enhance built-in idle
 selection with preferred CPUs
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250306182544.128649-1-arighi@nvidia.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20250306182544.128649-1-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrea,

Thank you for submitting the patch set.

On 25. 3. 7. 03:18, Andrea Righi wrote:
> Many scx schedulers define their own concept of scheduling domains to
> represent topology characteristics, such as heterogeneous architectures
> (e.g., big.LITTLE, P-cores/E-cores), or to categorize tasks based on
> specific properties (e.g., setting the soft-affinity of certain tasks to a
> subset of CPUs).
> 
> Currently, there is no mechanism to share these domains with the built-in
> idle CPU selection policy. As a result, schedulers often implement their
> own idle CPU selection policies, which are typically similar to one
> another, leading to a lot of code duplication.
> 
> To address this, extend the built-in idle CPU selection policy introducing
> the concept of preferred CPUs.
> 
> With this concept, BPF schedulers can apply the built-in idle CPU selection
> policy to a subset of preferred CPUs, allowing them to implement their own
> scheduling domains while still using the topology optimizations
> optimizations of the built-in policy, preventing code duplication across

Typo here. There are two "optimizations".

> different schedulers.
> 
> To implement this, introduce a new helper kfunc scx_bpf_select_cpu_pref()
> that allows to specify a cpumask of preferred CPUs:
> 
> s32 scx_bpf_select_cpu_pref(struct task_struct *p,
> 			    const struct cpumask *preferred_cpus,
> 			    s32 prev_cpu, u64 wake_flags, u64 flags);
> 
> Moreover, introduce the new idle flag %SCX_PICK_IDLE_IN_PREF that can be
> used to enforce selection strictly within the preferred domain.
> 
> Example usage
> =============
> 
> s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
> 		   s32 prev_cpu, u64 wake_flags)
> {
> 	const struct cpumask *dom = task_domain(p) ?: p->cpus_ptr;
> 	s32 cpu;
> 
> 	/*
> 	 * Pick an idle CPU in the task's domain. If no CPU is found,
> 	 * extend the search outside the domain.
> 	 */
> 	cpu = scx_bpf_select_cpu_pref(p, dom, prev_cpu, wake_flags, 0);
> 	if (cpu >= 0) {
> 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
> 		return cpu;
> 	}
> 
> 	return prev_cpu;
> }
> 
> Results
> =======
> 
> Load distribution on a 4 sockets / 4 cores per socket system, simulated
> using virtme-ng, running a modified version of scx_bpfland that uses the
> new helper scx_bpf_select_cpu_pref() and 0xff00 as preferred domain:
> 
>   $ vng --cpu 16,sockets=4,cores=4,threads=1
> 
> Starting 12 CPU hogs to fill the preferred domain:
> 
>   $ stress-ng -c 12
>   ...
>      0[|||||||||||||||||||||||100.0%]   8[||||||||||||||||||||||||100.0%]
>      1[|                        1.3%]   9[||||||||||||||||||||||||100.0%]
>      2[|||||||||||||||||||||||100.0%]  10[||||||||||||||||||||||||100.0%]
>      3[|||||||||||||||||||||||100.0%]  11[||||||||||||||||||||||||100.0%]
>      4[|||||||||||||||||||||||100.0%]  12[||||||||||||||||||||||||100.0%]
>      5[||                       2.6%]  13[||||||||||||||||||||||||100.0%]
>      6[|                        0.6%]  14[||||||||||||||||||||||||100.0%]
>      7|                         0.0%]  15[||||||||||||||||||||||||100.0%]
> 
> Passing %SCX_PICK_IDLE_IN_PREF to scx_bpf_select_cpu_pref() to enforce
> strict selection on the preferred CPUs (with the same workload):
> 
>      0[                         0.0%]   8[||||||||||||||||||||||||100.0%]
>      1[                         0.0%]   9[||||||||||||||||||||||||100.0%]
>      2[                         0.0%]  10[||||||||||||||||||||||||100.0%]
>      3[                         0.0%]  11[||||||||||||||||||||||||100.0%]
>      4[                         0.0%]  12[||||||||||||||||||||||||100.0%]
>      5[                         0.0%]  13[||||||||||||||||||||||||100.0%]
>      6[                         0.0%]  14[||||||||||||||||||||||||100.0%]
>      7[                         0.0%]  15[||||||||||||||||||||||||100.0%]
> 
> Andrea Righi (4):
>        sched_ext: idle: Honor idle flags in the built-in idle selection policy
>        sched_ext: idle: Introduce the concept of preferred CPUs
>        sched_ext: idle: Introduce scx_bpf_select_cpu_pref()
>        selftests/sched_ext: Add test for scx_bpf_select_cpu_pref()
> 
>   kernel/sched/ext.c                                |   4 +-
>   kernel/sched/ext_idle.c                           | 235 ++++++++++++++++++----
>   kernel/sched/ext_idle.h                           |   3 +-
>   tools/sched_ext/include/scx/common.bpf.h          |   2 +
>   tools/sched_ext/include/scx/compat.h              |   1 +
>   tools/testing/selftests/sched_ext/Makefile        |   1 +
>   tools/testing/selftests/sched_ext/pref_cpus.bpf.c |  95 +++++++++
>   tools/testing/selftests/sched_ext/pref_cpus.c     |  58 ++++++
>   8 files changed, 354 insertions(+), 45 deletions(-)
>   create mode 100644 tools/testing/selftests/sched_ext/pref_cpus.bpf.c
>   create mode 100644 tools/testing/selftests/sched_ext/pref_cpus.c
> 


