Return-Path: <bpf+bounces-66133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CD4B2E91C
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 02:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C78AA49B5
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 00:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925FB2D023;
	Thu, 21 Aug 2025 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pc35xtXI"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58E1CAA4
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 00:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734475; cv=none; b=nRxAr08b+q4jsLYtLDs8xYz1uFASdiDypOz1bmWCqsJx6hBzNvco1WbM9x5Xb8dpldqNnpnEwVGpO73/PXZEfA4BNEfhoyHe6evmA3lmqNa/L93wFaVhe2WSy/cCm3WmvWd3PDEjcfVo/PejktM1t6c5hzK1Irh8TrsIt/GcMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734475; c=relaxed/simple;
	bh=9GwdeRSYRRc6jjnwTgxa8sIi1AqdvoZOeo244RLhZ5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hBJ/B58gSZ+PwXdqsohOvOW+6ja/e3BiHQ6fkO98M8472asL2THi9rIpOvg6yYYU/ghfiybqHXdS+1JeIHL8yugSGOAADHTDuJtWV6OyBl7wVzduwYEDA/GfEFyZBOePQeKVF7VODZOPY4RzqQTKgNX8+dNxWGAMeBvri1lYIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pc35xtXI; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755734469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ger/qweYHHzaUe3FV4Wv14vSwD3CF++vJGGLP64KKcY=;
	b=pc35xtXIZlp2eACvENXjSMXLBYyW6kXDavibuV2c9ZWtE/1L58MNqp1IAVT9whMOGnnCxK
	yVFNSTpJOF0b688fs6q0QOEs5C23tZTm0+DPZaV9tex5GJLA1GQwqniu+DLj42mnKJo+pb
	lY2to00ZyhEojTxWBlpV6/lpNuOJKTs=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Suren Baghdasaryan
 <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko
 <mhocko@suse.com>,  David Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/14] mm: BPF OOM
In-Reply-To: <h2bmsuk7iq7i6hphp7vbaxndawwgjz42mhfntlcc2yt4u6but6@7xlre5c56xlq>
	(Shakeel Butt's message of "Wed, 20 Aug 2025 14:06:03 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<h2bmsuk7iq7i6hphp7vbaxndawwgjz42mhfntlcc2yt4u6but6@7xlre5c56xlq>
Date: Wed, 20 Aug 2025 17:01:00 -0700
Message-ID: <87ldndmtkz.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> On Mon, Aug 18, 2025 at 10:01:22AM -0700, Roman Gushchin wrote:
>> This patchset adds an ability to customize the out of memory
>> handling using bpf.
>> 
>> It focuses on two parts:
>> 1) OOM handling policy,
>> 2) PSI-based OOM invocation.
>> 
>> The idea to use bpf for customizing the OOM handling is not new, but
>> unlike the previous proposal [1], which augmented the existing task
>> ranking policy, this one tries to be as generic as possible and
>> leverage the full power of the modern bpf.
>> 
>> It provides a generic interface which is called before the existing OOM
>> killer code and allows implementing any policy, e.g. picking a victim
>> task or memory cgroup or potentially even releasing memory in other
>> ways, e.g. deleting tmpfs files (the last one might require some
>> additional but relatively simple changes).
>
> The releasing memory part is really interesting and useful. I can see
> much more reliable and targetted oom reaping with this approach.
>
>> 
>> The past attempt to implement memory-cgroup aware policy [2] showed
>> that there are multiple opinions on what the best policy is.  As it's
>> highly workload-dependent and specific to a concrete way of organizing
>> workloads, the structure of the cgroup tree etc,
>
> and user space policies like Google has very clear priorities among
> concurrently running workloads while many other users do not.
>
>> a customizable
>> bpf-based implementation is preferable over a in-kernel implementation
>> with a dozen on sysctls.
>
> +1
>
>> 
>> The second part is related to the fundamental question on when to
>> declare the OOM event. It's a trade-off between the risk of
>> unnecessary OOM kills and associated work losses and the risk of
>> infinite trashing and effective soft lockups.  In the last few years
>> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
>> systemd-OOMd [4]
>
> and Android's LMKD (https://source.android.com/docs/core/perf/lmkd) uses
> PSI too.
>
>> ). The common idea was to use userspace daemons to
>> implement custom OOM logic as well as rely on PSI monitoring to avoid
>> stalls. In this scenario the userspace daemon was supposed to handle
>> the majority of OOMs, while the in-kernel OOM killer worked as the
>> last resort measure to guarantee that the system would never deadlock
>> on the memory. But this approach creates additional infrastructure
>> churn: userspace OOM daemon is a separate entity which needs to be
>> deployed, updated, monitored. A completely different pipeline needs to
>> be built to monitor both types of OOM events and collect associated
>> logs. A userspace daemon is more restricted in terms on what data is
>> available to it. Implementing a daemon which can work reliably under a
>> heavy memory pressure in the system is also tricky.
>
> Thanks for raising this and it is really challenging on very aggressive
> overcommitted system. The userspace oom-killer needs cpu (or scheduling)
> and memory guarantees as it needs to run and collect stats to decide who
> to kill. Even with that, it can still get stuck in some global kernel
> locks (I remember at Google I have seen their userspace oom-killer which
> was a thread in borglet stuck on cgroup mutex or kernfs lock or
> something). Anyways I see a lot of potential of this BPF based
> oom-killer.
>
> Orthogonally I am wondering if we can enable actions other than killing.
> For example some workloads might prefer to get frozen or migrated away
> instead of being killed.

Absolutely, PSI events handling in the kernel (via BPF) opens a broad
range of possibilities. e.g. we can tune cgroup knobs, freeze/unfreeze
tasks, remove tmpfs files, promote/demote memory to other tiers, etc.
I was also thinking about tuning the readahead based on the memory
pressure.

Thanks!

