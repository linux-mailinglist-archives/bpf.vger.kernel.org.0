Return-Path: <bpf+bounces-29163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EB68C0C09
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 09:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44DB5B21E3B
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 07:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAD01494D9;
	Thu,  9 May 2024 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="P2VJ968e"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E3A13C801;
	Thu,  9 May 2024 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240379; cv=none; b=OyryR2bOcJRVkgJSiLCGAKGUMWtJmJqtKTQgNhDdnfj8XVWo/7TDij9qFNoKE/zn5BMdpCQPOsjJa2Sj4U2n+Bg0CCQoGq36kSiKCcWvlH/o1TD3fQwXJP30ZF9AC/N9AOpRDHQfcBi+5qBZCW0kKpsSDXLkwCu0Udkt6q3B138=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240379; c=relaxed/simple;
	bh=NR+aHobmWpAYaS/hy8DzHoqrid+V4JMWYZ9tG8o70F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gM+ZIylXEj15cUE0R5hw7rPEnVbN+m+LjpDj/cwWJA6QPMNLNcTJvonw6kMaKAhsoOakRJXQVmx5eUGROtK7FS742edsfdcswBbzqCJ/BYyL9s2WA+1cxSHCeQ+/ArGNtFkpQ1qu9xUhC/caA2HKihTgtKrmRHPIzMTnRiTBbbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=P2VJ968e; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mY1s/3BUpSW1F3P6Unr2ROLBPmXhaw86B6iU+7jDLCE=; b=P2VJ968eJwKn+gT47YaYICWjbI
	1dsGtvfti1EwXkFhMPWX6AYEdk3i71Rro4nmAGpZIL4YuH9LIRCSBdsVXLDMQnRCuxeqAAdxqdnO+
	NMLD9TGtd7facUFbox7oiCQzOeAjeRLRk/HNxjwBa2/IAYQcUeAizSFma9l8VNeIEidu9K1J/sJIh
	PhMe3NdvaFWoMImBge72O1riAwElq6cQYuk1zRVRhhouwGAkuJPOxKTrs4Tmbz8zZX0eckv21ESui
	alR0tVFgrtPZY3odqT3kQAzpsFcSHihR1MkyQzRkzsheKwoWWqG/gzEyMXnti2LT/2HMCxE5nY3gK
	Wf2LV3lA==;
Received: from [175.114.83.198] (helo=[192.168.45.92])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1s4yMM-003eD0-5T; Thu, 09 May 2024 09:38:34 +0200
Message-ID: <344145d4-ec56-423f-a016-cbddada8abe5@igalia.com>
Date: Thu, 9 May 2024 16:38:16 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 joshdon@google.com, brho@google.com, pjt@google.com, derkling@google.com,
 haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
 dskarlat@cs.cmu.edu, riel@surriel.com, himadrics@inria.fr, memxor@gmail.com,
 andrea.righi@canonical.com, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com,
 kernel-dev@igalia.com
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20240503085232.GC30852@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I'd like to reaffirm Valve and Igalia's backing for the sched_ext
proposal.

Let's delve into the context first. Valve, in collaboration with
Igalia and other firms, has been dedicated to enhancing the
gaming experience on Linux. Our endeavor involves utilizing
a standard Linux distribution (SteamOS) to execute unaltered
Windows games on the Linux kernel with the aid of Wine and
various other software components. The overarching objective is
to refine the Linux desktop environment for gaming and
interactive purposes. As part of our commitment, we adhere to an
"upstream everything" policy, contributing to the Linux kernel
and numerous open-source projects. For those interested, you can
explore the details of our contributions through the following
link:

 
https://osseu2023.sched.com/event/1Qv8y/how-steamos-is-contributing-to-the-linux-ecosystem-alberto-garcia-igalia


 From our perspective, sched_ext holds significant promise and
utility, particularly in facilitating rapid experimentation with
new ideas. Our experimental ideas may or may not align with the
existing scheduler designs, be it CFS or EEVDF.

Specifically, our research into the characteristics of gaming
workloads for schedulers has unveiled intriguing insights that
could inform better scheduling decisions. For instance, tasks
within the gaming software stack, such as game engines, Wine, and
graphics drivers, often exhibit very short duration when
scheduled, necessitating frequent scheduling activities.
Moreover, multiple tasks across software layers collaborate to
complete a single application-level task, forming task chains.
Inadequate scheduling decisions within these chains can lead to
high tail latency, commonly known as "stuttering" in the gaming
community.


> Witness the metric ton of toy schedulers written for it, that's all
> effort not put into improving the existing code.

While these properties offer valuable insights for improving
scheduling decisions for gaming workloads, their applicability to
general-purpose schedulers like EEVDF remains uncertain. The most
effective means to evaluate their broader utility is through
practical experimentation. In this regard, sched_ext provides an
excellent platform for rapid testing of new ideas.

One may question why not just experiment out-of-tree? In reality,
we can’t just trivially patch _general-purpose_ EEVDF (and CFS
too) to be better for _all_ use cases, especially when upstream
has resisted tons of niche complexity in the upstream scheduler.
It is a very hard problem, and we believe having the sched_ext
upstream for more users/distros will encourage more progress. Our
case of Linux gaming demonstrates that working on the existing
code is neither always possible nor effective. Further details of
our findings can be found through the following link:

 
https://ossna2024.sched.com/event/1aBOT/optimizing-scheduler-for-linux-gaming-changwoo-min-igalia


> situation that's been created is solved. And even then, I fundamentally
> believe the approach to be detrimental to the scheduler eco-system.

Contrary to the notion that sched_ext might prove detrimental to
the scheduler ecosystem, we hold a different view. The successful
implementation of sched_ext enriches the scheduler community with
fresh insights, ideas, and code. For instance, our adoption of
a virtual deadline-based approach in designing LAVD
(Latency-criticality Aware Virtual Deadline), our sched_ext-based
scheduler for gaming, represents a deliberate design choice.
Aligning our heuristics and findings with EEVDF through a similar
virtual deadline-based approach enables us to contribute our
discoveries to EEVDF in the future once proven to be more
universally applicable. Notably, the concept of "latency
criticality" in LAVD holds promise beyond gaming workloads,
potentially benefiting various interactive workloads. If you are
interested in, you can find the source code of LAVD in the
following link:

     https://github.com/sched-ext/scx/tree/main/scheds/rust/scx_lavd


In essence, I envision sched_ext and its community as an
incubator for new ideas, invigorating the scheduler ecosystem.
Some of the "toy" schedulers may evolve into specialized
solutions tailored for specific problem domains, such as HPC,
AI/ML, or gaming. Lessons learned from these experimental
schedulers will invariably contribute, directly or indirectly, to
the evolution of the EEVDF scheduler.

Sincerely,
Changwoo Min

