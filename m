Return-Path: <bpf+bounces-36238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7A994528D
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 20:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2641B225A0
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C3013D897;
	Thu,  1 Aug 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP1SOrfr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2649144D00;
	Thu,  1 Aug 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722535511; cv=none; b=nNsLR5MMOD95ktnKE30RJDSaUh5vJxFAlFAkeI1p6/B739EnUU35SZ9+tbur+6gjB+PMWLDRMkELFvraBFOxGwaPWOXIanvYyygR0IdudJMaI3Sfs9djNf6bi+17PLxdoQ4BqVG1IWK4KtAMFlQQ1NQaKuy+bTsh1PCdeW8/AQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722535511; c=relaxed/simple;
	bh=eo/BtBdhtofDzOVa2d0p8KsqVkh7oOT/ChhgncGIpE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAq4oz0rP5bRp/0Z9SeJomNQk9p96Y/+eaNEOad1zs/ZK9RDIG1LT2AZYiDAY0MAIt4bjl1tbf7mOAcX2M//84ztI/99YIRFIyI7sfvOyFgAfAB3ozzGEL5zHA9OG9OvIZzh2whOvhujOcm3443FAeDXjU9c1yWvdxqCWk0kgCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP1SOrfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F245C4AF0D;
	Thu,  1 Aug 2024 18:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722535511;
	bh=eo/BtBdhtofDzOVa2d0p8KsqVkh7oOT/ChhgncGIpE4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HP1SOrfrVy+i8Ocl/iUVhE6wIMZmDi6L0YmWS0Ljf/4YjyDFOTtQ73vVfKNLLEOnE
	 6mzv6BDpK9s4ks51d8GyY38tmkd2jOFCzaGiJpqh6oQfiiY79s5bq/pZpfg3h9E/tE
	 TfPL5PZO8fgVeI96BTMFObzl2AnNnj4iemG2lMlOWgTh/c6b2Bptbxm+BlykSjN6S+
	 dLGB/qdj7L6GuislzF1vGfnmQCvZyZ2B9kAHMmtm0sz7aP+IMiRqeX8ApSqXvhyjyy
	 7pPeQIT7XgaSkHX/YrwEyOKpgkoLLl6ygQ/Ok4svWqmyM99Q184Tk0QMRz5XHh3CzV
	 qORBZQ6q6bdbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C77D7CE08A5; Thu,  1 Aug 2024 11:05:10 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:05:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org
Subject: Re: [PATCH 8/8] uprobes: switch to RCU Tasks Trace flavor for better
 performance
Message-ID: <05ff631a-756b-4b6b-814f-413a1f309196@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-9-andrii@kernel.org>
 <20240801093505.GP33588@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801093505.GP33588@noisy.programming.kicks-ass.net>

On Thu, Aug 01, 2024 at 11:35:05AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 31, 2024 at 02:42:56PM -0700, Andrii Nakryiko wrote:
> > This patch switches uprobes SRCU usage to RCU Tasks Trace flavor, which
> > is optimized for more lightweight and quick readers (at the expense of
> > slower writers, which for uprobes is a fine tradeof) and has better
> > performance and scalability with number of CPUs.
> > 
> > Similarly to baseline vs SRCU, we've benchmarked SRCU-based
> > implementation vs RCU Tasks Trace implementation.
> 
> Yes, this one can be the trace flavour, the other one for the retprobes
> must be SRCU because it crosses over into userspace. But you've not yet
> done that side.
> 
> Anyway, I think I can make the SRCU read_{,un}lock() smp_mb()
> conditional, much like we have for percpu_rwsem and trace rcu, but I
> definitely don't have time to poke at that in the foreseeable future :(

You most certainly can, but all of the approaches that I know of have
sharp edges in one place or another.  There were extensive unrecorded
and unminuted discussion of this about five years ago, and I have been
reconstituting those neurons to document what is feasible.  None of which
were useful for the use cases back then, whose performance requirements
could not be met by unsafe srcu_read_lock() and srcu_read_unlock() with
smp_mb() removed, and others of which really wanted CPU stall warnings.

But it is of course possible that newer use cases might benefit.
Who knows?

I haven't gotten very far, but it is on my list.

							Thanx, Paul

