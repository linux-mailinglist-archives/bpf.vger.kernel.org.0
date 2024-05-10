Return-Path: <bpf+bounces-29492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E21E8C29CB
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 20:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7334B23D87
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 18:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B832C683;
	Fri, 10 May 2024 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="AQClqLbh"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8778F1BDD3;
	Fri, 10 May 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365475; cv=none; b=oU/BxZky7fPoxoZl+WYWtFMEvgjBUsurABUvumzv9fEyCz+tjQ7pqCF1jrOZ/Fx5jlf7aGh3tbWdUUFy184mAz212pkdGGJLcsluBCKDGfp/CNaf+rtlWOIq324aYyu5vFKokXSbIStRv8WgfZ9WxvmwkrpdgKtmDt/+Wf5bVCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365475; c=relaxed/simple;
	bh=Sodupjyz/UTgYwBl3W3Y82c8ysbojClXP6VQyeeJH6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBb6di0zDd2ohgTkzUPyPHlb+/3PsrMVt3GESEo8p6wD8uJ97/YlJ9Zv2HEWdawlQ4qkq45TKNTHKxCE4cfeMBree7eKcfxH6NMUSgz1Fbk04/lmUeJWwEIFMOQjnKxet+4ebbi8yerfQ2841Tuv+tw3kBA8M8tJYANa6mVPrT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=AQClqLbh; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66FB0281218;
	Fri, 10 May 2024 20:24:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1715365470; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ybmvvQyExEwEgsu2RTsdpAgQWSkXrD6bkqceyhjyk3k=;
	b=AQClqLbhftsrsi/Sui+eXyyuxaFbm7Jy7wpyx53OqD7Mt+jHHF63RTUDBfJz2VCGOHwztX
	eUKagC8zsDpojQRGCy/8oto2Zio/+6BqsXaVG473Ub7G8Xkw25LBuBlktMBqhNtHjGYsPb
	KTUYW7bAj23aNNnQY8Kzdg5k+scytXM237fwpXrrrlMEHdFfRfrFwPgErpJ3WWr1H1Fwvk
	h09rCWApQFn1JpuGEB1LAzKX8HWkBuTJwGGftsHLlTtFVs4G35K7i1pHJYc7NL02/6al4K
	wKlIL0dP9cm5aFYpUAsPzEKU8cDtsPVRmCZaUAE5JuC/FUkMWOM6fc5v04vf1A==
Message-ID: <e14eb023-e309-4647-9c6b-d6a81cb20ade@cachyos.org>
Date: Fri, 10 May 2024 20:24:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, joshdon@google.com,
 brho@google.com, pjt@google.com, derkling@google.com, haoluo@google.com,
 dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
 riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
 andrea.righi@canonical.com, joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
References: <20240501151312.635565-1-tj@kernel.org>
Content-Language: en-US
From: Peter Jung <ptr1337@cachyos.org>
Organization: CachyOS
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


Hi everyone,

We (CachyOS [0]) want to support to proposal of sched_ext.
CachyOS is an archlinux based distribution, which improves the performance,
throughput and interactivity for the desktop but also on servers. We 
have a big
community, which likes testing new features on the kernel, GPU drivers,
frequency drivers, new locking technologies and schedulers.

[0]: https://cachyos.org/

For CachyOS, schedulers have always been a key matter. We have numerous
variants of kernels with different schedulers so that everyone can be
satisfied. So far, schedulers in the kernel have faced one problem, 
namely: 1
kernel = 1 scheduler. It was impossible to change the CPU scheduler without
restarting the computer and booting another kernel. scx-scheduler simply and
extremely successfully changes this approach and allows you to change
schedulers at runtime. The approach with a single default scheduler in the
kernel also leads to a problematic situation, because in our opinion it is
impossible to develop a single scheduler that is the optimal solution 
for all
possible tasks. Again, and in this case, scx-scheds makes this problem
obsolete.

The EEVDF Scheduler gives a good overall experience, but it currently lacks
good interactivity under load, specific scenarios like gaming and also the
latency. Rusty gives CachyOS currently a very good replacement for desktop
usage. We are planning to provide the Rusty Scheduler in the future as 
default.
The interactivity of Rusty is dramatically better than EEVDF, especially 
when a
heavy workload is running in the background, e.g. during compilation. 
Using the
desktop under such a workload can be very challenging for the default 
scheduler
and at rusty it is not even noticeable that during compilation is 
running. Also
in gaming scenarios rusty seems to provide excellent performance.

The LAVD Scheduler is integrated as default in our handheld variant and 
shows
very good impressive results in frame times as well as 1% lows. This 
gives our
user on the Handheld Edition a better experience.

It is also worth mentioning that our community takes an active part in
sched-ext testing and regularly reports bugs and suggestions for changes.
Cooperation with developers is also perfect - they immediately make 
corrections
if there are any regressions.

Regards,

Peter Jung
CachyOS

