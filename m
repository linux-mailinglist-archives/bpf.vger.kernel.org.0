Return-Path: <bpf+bounces-32896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F30D914A63
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 14:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E391F213EC
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 12:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F9113C9C0;
	Mon, 24 Jun 2024 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="URarxOO/"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEFE13C677;
	Mon, 24 Jun 2024 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719232887; cv=none; b=A37ylm7NUeIscg5PaqgftskAH+kTxBn7W1BGJNOsXo0cG2XxBlV5NhNv+Zqs1oZVeWz6pyNC9peO2LeXKC9Igk1ZLXIc1gKj9htaJLfTfNZ0sXhdUc45ioookZxwGG4vD7DoKhhrA/oCgUdPBB+4ARbxIKv4fHuJ03gsc7B48BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719232887; c=relaxed/simple;
	bh=hqF5YhKcz6BXATHeicfIAP7R6xcFWkNdFhorTxOChFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de+xVoGMXZR9mmfQkh82F997uhlA/vR4xQBvm4cGb0PKA5kLQ8SGYRcb7hLdmcstRTEBBcqdj41kNCylFK3aodtHaqQQ6bsaIaBFj3bWC51yoYfAI3bv5PLyZHg1uPThKP1MuHmBcX9VuBNkNzUh/Gi/HFV7a5BCJzOO90TevFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=URarxOO/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hqF5YhKcz6BXATHeicfIAP7R6xcFWkNdFhorTxOChFc=; b=URarxOO/eoOmOCkGprP4MsHkO2
	Z1bpQXKwcHb/4eAWT+taPhSuzOTJVvmwbjqqIHeqT5tVTBmWkpMJbgy3cxllqFCLJpaISzFcWyj1Z
	jZ8RBWZVjxbNwiNT4Fv7apbPWy3shPuVe3cixSbpw49Mu1TLKVXPtDoi0WZerdUAG/gWH8Zbln36r
	PgRhgqIyRoA/BvQ5msnkcL89rv+DGqkKpfP2GJBkHqin4kZmZUk4+ll7FinPx87MWdUimAjP7rMi3
	13SM2uhjgs+auumvXHXP9BxWrtbwUorBesDHck+F6bzTvgD4p1BGcKfVtnMWWbYCcjmv6IPJREMQS
	sUFLunXA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLj0A-00000008FAl-3Jje;
	Mon, 24 Jun 2024 12:41:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CD4EC300754; Mon, 24 Jun 2024 14:40:53 +0200 (CEST)
Date: Mon, 24 Jun 2024 14:40:53 +0200
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
Subject: Re: [PATCH 18/39] sched_ext: Allow BPF schedulers to disallow
 specific tasks from joining SCHED_EXT
Message-ID: <20240624124053.GN31592@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-19-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501151312.635565-19-tj@kernel.org>

On Wed, May 01, 2024 at 05:09:53AM -1000, Tejun Heo wrote:
> BPF schedulers might not want to schedule certain tasks - e.g. kernel
> threads. This patch adds p->scx.disallow which can be set by BPF schedulers
> in such cases. The field can be changed anytime and setting it in
> ops.prep_enable() guarantees that the task can never be scheduled by
> sched_ext.

Why ?!?!

By leaving kernel threads fair, and fair sitting above the BPF thing,
it is not dissimilar to promoting them to FIFO. They will instantly
preempt the BPF thing and keep running for as long as they need. The
only real difference between this and actual FIFO is the behaviour on
contention.

This seems like a very bad thing to have, and your 'changelog' has no
justification what so ever.

