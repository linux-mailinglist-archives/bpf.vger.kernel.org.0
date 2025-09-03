Return-Path: <bpf+bounces-67348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDB6B42B6C
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 22:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CF316CB02
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 20:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244542E8B77;
	Wed,  3 Sep 2025 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LCtCdTC/"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250E42BF00D;
	Wed,  3 Sep 2025 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756933017; cv=none; b=VydlfLgYPJyjbjKkVYUmmeDVAvUV1z+ZXr0hCdugRcvKi+D1Kdgql6pcjIiErW0o9njJeo4AeYSR823ipaLscI58ugL+rkaAXpnY59xd18y+MtEZcbl6jnThn2D0Um6UHnZmjodXfItUlagloRDYhRFn6dWt0rHAR/uivUmbW8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756933017; c=relaxed/simple;
	bh=kMagB/2vrSFlzX1NVtQUhHL35BtHspXWoPFCyusgC8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOs62v/NoIemBSaPHflCE76euoyY7Xqw52OakKjS7+K+2xfLJwhfZpSnUNYOz/eeTfDhCJvicD9+LK5abjFPZw8f3EAlMoPMUcdHT2uNgteBxmt8IWE2UIq+KZLjA2zs81ooWnqZGesB+B9JxO9Hxl68r9AA6E3MevoX/hNcDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LCtCdTC/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LS+2+7GSaeYnGpvUxaEOliiPaOTFzgZLEAGZESzxTL8=; b=LCtCdTC/+pHuwcALA3518Nvbqg
	G9Xg/zXmSw1jBIcBLbI9g0xS8nwTMFuQQnuCgAxAU1R8ctFE6iDssGKMMajXE4RP20356wR62EYbA
	dMPxmHmh1NpjLmQf0a7Qcc4cTjOM9bP9SM1g4IgeCe16W/Gkvz0GtLZHfEMiMymr+E7WmWMQP3hE+
	OJ336IWaFCP4i1GZ4Zdmm1LUGDRPyIgJdaKV6+iqa5liwyOv+PruhzPZdO7gFCQ2DIAtPilkpaPSz
	91DhkZti7wuCC5DX2BPBsoq9Zwikrf2fnYr8tjYP2bnEQjqND1nsBjuEBTv3HYgUbfsjLiYhwoNmY
	J3j+nL2A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utuX7-00000007vmC-48fF;
	Wed, 03 Sep 2025 20:56:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 23A8C300220; Wed, 03 Sep 2025 22:56:46 +0200 (CEST)
Date: Wed, 3 Sep 2025 22:56:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 07/16] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <20250903205646.GR4067720@noisy.programming.kicks-ass.net>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-8-arighi@nvidia.com>
 <aLidEvX41Xie5kwY@slm.duckdns.org>
 <20250903200822.GO4067720@noisy.programming.kicks-ass.net>
 <aLin8VayVsYyKXze@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLin8VayVsYyKXze@slm.duckdns.org>

On Wed, Sep 03, 2025 at 10:41:21AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 03, 2025 at 10:08:22PM +0200, Peter Zijlstra wrote:
> > > I'm a bit confused. This series doesn't have prep patches to add @rf to
> > > dl_server_pick_f. Is this the right patch?
> > 
> > Patch 14 seems to be the proposed alternative, and I'm not liking that
> > at all.
> > 
> > That rf passing was very much also needed for that other issue; I'm not
> > sure why that's gone away.
> 
> Using balance() was my suggestion to stay within the current framework. If
> we want to add @rf to pick_task(), that's more fundamental change. We
> dropped the discussion in the other thread but I found it odd to add @rf to
> pick_task() while disallowing the use of @rf in non-dl-server pick path and
> if we want to allow that, we gotta solve the race between pick_task()
> dropping rq lock and the ttwu inserting high pri task.

I thought the idea was to add rf unconditionally, dl-server or not, it
is needed in both cases.

Yes, that race needs dealing with. We have this existing pattern that
checks if a higher class has runnable tasks and restarting the pick.
This is currently only done for pick_next_task_fair() but that can
easily be extended.

You suggested maybe moving this to the ttwu side -- but up to this point
I thought we were in agreement. I'm not sure moving it to the ttwu side
makes things better; it would need ttwu to know a pick is in progress
and for which class. The existing restart pick is simpler, I think.

Yes, the restart is somewhat more complicated if we want to deal with
the dl-server, but not terribly so. It could just store a snapshot of
rq->dl.dl_nr_running from before the pick and only restart if that went
up.



