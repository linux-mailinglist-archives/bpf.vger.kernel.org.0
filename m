Return-Path: <bpf+bounces-41873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD4199D4F9
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 18:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8982283AF2
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 16:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE801AF4F6;
	Mon, 14 Oct 2024 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD49wm8e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E489288B1;
	Mon, 14 Oct 2024 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924677; cv=none; b=hrd0ILmqSYs+Frbtw6DqsJdQT+8PY4F6ZId1gU1E2CVlDG/RKVgo9+PF0lKCp8q6kHtAjdfPsVSE1egd9J2Va0iCA0PQXyzjnQiq81WZh+C7jJ/8qYIK9NOjzwM0h9/EWNY/PJuU9Jfx/Y4hkQX8vTSeBKGu9oNAYTef9E4fzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924677; c=relaxed/simple;
	bh=HVkCAK28Uz4v2yjt6+6+8HaHLau4B2tiGzMBjwo5yvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4S9qFY5FjZAMxgQKep2h0aU+SMDqyqXW+GO9iJ8pZs7m+/qGk4lf93tJ7ynJF4zszpkoEWAM6wUK6IuyByiWII6xQCjWHEstTptmGE+wUK1FgqHZQadDsqQ14a/4HGxSu07kdeopvzCu8GSZSvHHvA5j8ml/wskq5OrUm8PZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eD49wm8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7D9C4CEC3;
	Mon, 14 Oct 2024 16:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728924676;
	bh=HVkCAK28Uz4v2yjt6+6+8HaHLau4B2tiGzMBjwo5yvw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eD49wm8eSZIYMXleMB9YbI5akYYyLT9prVZNXEKSzVFlgu7E66pfEvdB9XbCfwmr9
	 dSENrcMazgWojRRN8wA8RTkpS20mm4vtSKEpDP79Wc3cq+UFnDuzSfUUMN9a5OxrYD
	 HYOzLf/6sIxa4ayZFNwJbiJvtuYoE53N3n7EiiYU7Updvg68YkfTi4ndvJumsusii5
	 GS41w7IjAC9oHZUwZoKkH201h7BninzBg/xVVfXlsyyUfOEoOMhKFK+Hf/8xsobphG
	 6h4ZP8EMejn7b+EMwyNGl3+iwNYGOZ50sBaUpMM6yAa834kd/brgGkM+sDEJGt+ieg
	 kj7DOhEbl84Dg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3C736CE0B68; Mon, 14 Oct 2024 09:51:16 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:51:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: frederic@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 04/12] srcu: Bit manipulation changes for additional
 reader flavor
Message-ID: <6f8934c8-8499-48ec-89fa-e3f356fae419@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-4-paulmck@kernel.org>
 <abf6c382-7b70-4cdb-9227-7dfd21e60c45@amd.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abf6c382-7b70-4cdb-9227-7dfd21e60c45@amd.com>

On Mon, Oct 14, 2024 at 02:42:33PM +0530, Neeraj Upadhyay wrote:
> On 10/9/2024 11:37 PM, Paul E. McKenney wrote:
> > Currently, there are only two flavors of readers, normal and NMI-safe.
> > Very straightforward state updates suffice to check for erroneous
> > mixing of reader flavors on a given srcu_struct structure.  This commit
> > upgrades the checking in preparation for the addition of light-weight
> > (as in memory-barrier-free) readers.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: <bpf@vger.kernel.org>
> > ---
> >  kernel/rcu/srcutree.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 18f2eae5e14bd..abe55777c4335 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -462,7 +462,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
> >  		if (IS_ENABLED(CONFIG_PROVE_RCU))
> >  			mask = mask | READ_ONCE(cpuc->srcu_reader_flavor);
> >  	}
> > -	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask >> 1)),
> > +	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
> >  		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
> >  	return sum;
> >  }
> > @@ -712,8 +712,9 @@ void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
> >  	sdp = raw_cpu_ptr(ssp->sda);
> >  	old_reader_flavor_mask = READ_ONCE(sdp->srcu_reader_flavor);
> >  	if (!old_reader_flavor_mask) {
> > -		WRITE_ONCE(sdp->srcu_reader_flavor, reader_flavor_mask);
> > -		return;
> > +		old_reader_flavor_mask = cmpxchg(&sdp->srcu_reader_flavor, 0, reader_flavor_mask);
> 
> This looks to be separate independent fix?

I would say that it is part of the upgrade.  The old logic worked if there
are only two flavors, but the cmpxchg() is required for more than two.

							Thanx, Paul

> - Neeraj
> 
> > +		if (!old_reader_flavor_mask)
> > +			return;
> >  	}
> >  	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
> >  }
> 

