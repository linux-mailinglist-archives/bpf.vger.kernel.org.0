Return-Path: <bpf+bounces-35883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 951C693F556
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 14:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8B11F229BB
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 12:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBEA148308;
	Mon, 29 Jul 2024 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DyWQIPoK"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096A145354;
	Mon, 29 Jul 2024 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256067; cv=none; b=GHxW/nxh7DLoA9myWDDAF14lrZ7UUwJF1ddTdILzADexTJ0Gfmbv5+2cMEhd+CCPnKKMzAaOGAbgDsnFFEqmMrG1vs5rNU0wG6+dCqRmgz9n91YzJXfIwHbJu9X3uqTtz72/eXaZlpISLUFRyV3BVMXWlf3iJdFvSyiY3SnRN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256067; c=relaxed/simple;
	bh=s3PoMGtlLZke7E3nshDH/a+g8A+gVgLmiTZ3FTiUJh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAgdtRbspj1eO+x3IqbPhXORAJwmZORUZ63qRmKBStx6zXa1TuhBh2kc6MlcQ2+NqY3llwdfmL27uAb3uzmQlYqwLPBhoD+3yjrRikGPHl4fH7ypgwYUlHbhGebkbXrpsK1UedNng5hgv/K6VFlsP6/J1DEXhBE+rbbhqYtxPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DyWQIPoK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9pB4wH7DkeZ8aalFphoP7WyUgOytv89Rylnd6dqfvS8=; b=DyWQIPoKPBOs+NbpjFUKFgTYPE
	Uby4JoRl+mXJ6MlB6pCqgVDAQEA7RiO5bXj75voT5kdi+VF98GAXc2rV0HoFzKWxVJcFgXuf9fJ45
	huhf9/RhUO0DDY1fzIJWgxBLcydVYdKkT5m2JKhfUTRjO1ttzfOSsaY9AhpcpwwipVVX0G4y6UMvb
	PY2392Bo0Q/P8WjIFkvpfUbk9Ku551+hZsNKSDWxk7XnUxZ0YuYZqfE4XUc1lnlpRnwVQg90cFDZE
	CPiJ/SfJ7Pyut4Q71ginZJTUxL5Lu2Iqz/PegEZrty1ho8byvgWjQ8tjTYVNbBgToI2zXIzpJtvAJ
	s7XMmhdQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYPTL-00000004mTs-41iX;
	Mon, 29 Jul 2024 12:27:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EA226300439; Mon, 29 Jul 2024 14:27:26 +0200 (CEST)
Date: Mon, 29 Jul 2024 14:27:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, song@kernel.org, jolsa@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, mattbobrowski@google.com, qyousef@layalina.io,
	tiozhang@didiglobal.com, elver@google.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [RFC] Printk deadlock in bpf trace called from scheduler context
Message-ID: <20240729122726.GA33588@noisy.programming.kicks-ass.net>
References: <20240729114608.1792954-2-radoslaw.zielonek@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729114608.1792954-2-radoslaw.zielonek@gmail.com>

On Mon, Jul 29, 2024 at 01:46:09PM +0200, Radoslaw Zielonek wrote:
> I am currently working on a syzbot-reported bug where bpf
> is called from trace_sched_switch. In this scenario, we are still within
> the scheduler context, and calling printk can create a deadlock.
> 
> I am uncertain about the best approach to fix this issue.

It's been like this forever, it doesn't need fixing, because tracepoints
shouldn't be doing printk() in the first place.

> Should we simply forbid such calls, or perhaps we should replace printk
> with printk_deferred in the bpf where we are still in scheduler context?

Not doing printk() is best.

