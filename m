Return-Path: <bpf+bounces-33037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2115691613C
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 10:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D6B284B99
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 08:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7565D149003;
	Tue, 25 Jun 2024 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fzYIozMs"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372731487C8;
	Tue, 25 Jun 2024 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304194; cv=none; b=rueYt/dtEVEr74JNAHFgu+5Nh2j0rqOQZ7kuNAjH7Z2ivx9ju/g9cm7L4Eh4v2xjs2Z6uvFEsyWfTxCseUseEoY6Wys3Q708GtY5JRRPhN1XOWIvcUleW3ir+wK7wD56KY6LaW6pmlZbCLQUPW6l3KDxDh34zu7uIxDGtk0PL7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304194; c=relaxed/simple;
	bh=mL0WhTS8OZdvcWmjwK8Bfc0yHsEXfVl9MUwSk+1gXJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdrLXqagR0/O48ql14BlWmWG1il5wF9qfuCqOp16u17aEptlEIAYX+v3pZ9wRPtHBH0mXyRv515vH6qDGuL9Bl7WzRmMR1Nqyn0maKFlbBRpSLqhI4da5jN1F138j02wKdtT65giJ3dC6do9+uJAtJbc1stjpBHnEO53zlXhxS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fzYIozMs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IjR5Ku64W/7IJWeMefbbUADBt1oTV5alXkKLamJEDC8=; b=fzYIozMsvbn/PaoeP3WPrj18Mb
	vLBT3cD9gUjIzgD6jnbWXVBFrG+4NL0w0PN8XX/Tjt/McgrSrI6UEeyQVg2MtY06ItDaLBWp8jubc
	B0QWxH6y0iKxcPjujGpay+fVK/ueO08ELjDxCMhDiyvw/c8QriJSwKb5J9hUSZ5Mhd7QaDotP9w7o
	UsKoQLfdiAiPGdlIjyTmCfJXHymixn+dkcfnYSbhhnKhiDVFOrnW8XCip+kqHgciArEewvpfTZMbc
	H5H3ppnETu7F0TTDGJAJUFb7xRFjry5ao5byaD93vGlrloRlf6fSSIpn9CZGNBVHgvMmHDG6zxIBZ
	uER4YbWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM1YM-0000000Ax23-2kE6;
	Tue, 25 Jun 2024 08:29:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0D10D300754; Tue, 25 Jun 2024 10:29:26 +0200 (CEST)
Date: Tue, 25 Jun 2024 10:29:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 09/39] sched: Add @reason to
 sched_class->rq_{on|off}line()
Message-ID: <20240625082926.GT31592@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-10-tj@kernel.org>
 <20240624113212.GL31592@noisy.programming.kicks-ass.net>
 <ZnnijsMAQYgCnrZF@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnnijsMAQYgCnrZF@slm.duckdns.org>

On Mon, Jun 24, 2024 at 11:18:06AM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Mon, Jun 24, 2024 at 01:32:12PM +0200, Peter Zijlstra wrote:
> > On Wed, May 01, 2024 at 05:09:44AM -1000, Tejun Heo wrote:
> > > ->rq_{on|off}line are called either during CPU hotplug or cpuset partition
> > > updates. A planned BPF extensible sched_class wants to tell the BPF
> > > scheduler progs about CPU hotplug events in a way that's synchronized with
> > > rq state changes.
> > > 
> > > As the BPF scheduler progs aren't necessarily affected by cpuset partition
> > > updates, we need a way to distinguish the two types of events. Let's add an
> > > argument to tell them apart.
> > 
> > That would be a bug. Must not be able to ignore partitions.
> 
> So, first of all, this implementation was brittle in assuming CPU hotplug
> events would be called in first and broke after recent cpuset changes. In
> v7, it's replaced by hooks in sched_cpu_[de]activate(), which has the extra
> benefit of allowing the BPF hotplug methods to be sleepable.

Urgh, I suppose I should go stare at v7 then.

> Taking a step back to the sched domains. They don't translate well to
> sched_ext schedulers where task to CPU associations are often more dynamic
> (e.g. multiple CPUs sharing a task queue) and load balancing operations can
> be implemented pretty differently from CFS. The benefits of exposing sched
> domains directly to the BPF schedulers is unclear as most of relevant
> information can be obtained from userspace already.

Either which way around you want to turn it, you must not violate
partitions. If a bpf thing isn't capable of handling partitions, you
must refuse loading it when a partition exists and equally disallow
creation of partitions when it does load.

For partitions specifically, you only need the root_domain, not the full
sched_domain trees.

I'm aware you have these shared runqueues, but you don't *have* to do
that. Esp. so if the user explicitly requested partitions.

