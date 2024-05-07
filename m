Return-Path: <bpf+bounces-28950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FE68BECC5
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B7E1F21CE0
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B97E16E86A;
	Tue,  7 May 2024 19:49:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A01F16DEAF;
	Tue,  7 May 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715111354; cv=none; b=NuOWKcFW9HtmacBLRSnirOGylf7BUpYtO1BXesBOg5oXOsoziQ5+SLagM3vKfeUIPoarAtSYG88jwaHJKSfjoU1I7eTcFDVu262DB025qtvDyWC1xJKps1US2Ihq/zJJ6b9il/EERGNDkkfF1w6YzKQN8eEN/DZwfaYMPAmbPCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715111354; c=relaxed/simple;
	bh=MM4Dl5dC1Re/BaL3KxbbzVSu9uQPG+/wVKmxbJqqnms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dFID3ngm4NoWIq1U9kOxCtK8RBzbh1MsEY0+kL2TrArG6dYVjU/LLCvuUP/Pxx09EBe5Vs3PQ3NReDsGvynwjPZ3BAjMMzWQNLgPZNw7zfq5oztlzV5lwdakBZOOcqc9pdFIyxgANZ04irNSB0MqCbi0dFw0ViyEnAYUFhd0eTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1s4QmM-000000004Mh-09Sd;
	Tue, 07 May 2024 15:47:10 -0400
Message-ID: <d650aad701652ba1e4ca2052a8880e51904b8d17.camel@surriel.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
From: Rik van Riel <riel@surriel.com>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org, 
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de,  bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
 daniel@iogearbox.net,  andrii@kernel.org, martin.lau@kernel.org,
 joshdon@google.com, brho@google.com,  pjt@google.com, derkling@google.com,
 haoluo@google.com, dvernet@meta.com,  dschatzberg@meta.com,
 dskarlat@cs.cmu.edu, changwoo@igalia.com, himadrics@inria.fr, 
 memxor@gmail.com, andrea.righi@canonical.com, joel@joelfernandes.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Date: Tue, 07 May 2024 15:47:05 -0400
In-Reply-To: <ZjqB7MT6DeLznAgu@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
	 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
	 <ZjPnb1vdt80FrksA@slm.duckdns.org>
	 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
	 <798768ad5db073d36467a432352b968b01649898.camel@surriel.com>
	 <ZjqB7MT6DeLznAgu@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Tue, 2024-05-07 at 09:33 -1000, Tejun Heo wrote:
> On Mon, May 06, 2024 at 02:47:47PM -0400, Rik van Riel wrote:
>=20
>=20
> > =C2=A0=C2=A0 I believe this can be solved with the same idea I had for
> > =C2=A0=C2=A0 reimplementing CONFIG_CFS_BANDWIDTH. Specifically, the cod=
e that
> > =C2=A0=C2=A0 determines the time slice length for a task already has a =
way to
> > =C2=A0=C2=A0 determine whether a CPU is "overloaded", and time slices n=
eed to
> > be
> > =C2=A0=C2=A0 shortened. Once we reach that situation, we can place woke=
n up
> > tasks on
> > =C2=A0=C2=A0 a secondary heap of per-cgroup runqueues, from which we do=
 not
> > directly
> > =C2=A0=C2=A0 run tasks, but pick the lowest vruntime task from the lowe=
st
> > vruntime
> > =C2=A0=C2=A0 cgroup and put that on the main runqueue, if the previousl=
y
> > running
>=20
> When overloaded, are the cgroups being put on a single rbtree? If so,
> they'd
> be using flattened shares, right? I wonder what you're suggesting for
> the
> overloaded case is pretty simliar to what flatcg is doing plus
> avoiding one
> level of indirection while not overloaded.

It does indeed sound like flatcg is doing almost the same thing.

I'm not entirely sure what to make of the fact that we both
came up with the same solution to the problem. I suppose it's
a nice improvement over a fully hierarchical solution, especially
when it comes to overhead, but there is still a fair amount of
complexity left.

I don't know if there is a simpler solution to this problem.

There might not be.

--=20
All Rights Reversed.

