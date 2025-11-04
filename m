Return-Path: <bpf+bounces-73461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D201C32224
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 17:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358BD3BCBDD
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 16:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D42337109;
	Tue,  4 Nov 2025 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8Xrgmt+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204081FFC6D;
	Tue,  4 Nov 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274969; cv=none; b=DzkW6T+dlpL7svfB9NXR3nZ7vGoU2eNNeXj/eKuZzqngXOQBhHcwCC8AJM4tKZ2DTt/F+2culDD1CHzfT8abdahG9iiCt4nn9q1GiE7VegygatcwWSuQGlh8T3HBx2LEaTE4YbMbcBr0J3h9hZIsz+ciTTgOAWSy8/qXUDnKaCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274969; c=relaxed/simple;
	bh=zDa1ulHN0riNVwwyBpJv8UbnPromiwgtgxQTJeHrWoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFa8aDws29bZJbhC1rfmqQb57DxM1s2zGqVr4+YdMpZbfrLQrlgU3rbaeu4Q1MTiDbJ4VS7uoys3LCjIFCBgIQJbyHcNcdQk0mfFNifhBqV3PrHyM7cvBXVVwQBTHHmvlYvx9LH+cYPR/wF3gzc/Ksn0Z1VQZyUWvMcUxOAmVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8Xrgmt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A4CC4CEF8;
	Tue,  4 Nov 2025 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762274968;
	bh=zDa1ulHN0riNVwwyBpJv8UbnPromiwgtgxQTJeHrWoQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=p8Xrgmt+9K+cA6snnu7WPYnf3yNDBMV7QM1ZvGQHorctDTXjcXFA0w03qJN1PLGu9
	 R3UQFOt3ldtt/A235LIBGJFAcq7u1Kjl8mAewcJVyd2G31sL07bhB0ppYxjNx3OAeS
	 70uFsVFVg+cxfrY/9b1rx3YioPRnxkuzQR8gmx9Fc2NcouGfTTTKXml1CbeWyu6OsN
	 gPQcY2M5BTjbcB2H6lCqOlobHdxfQNFfSF6MfrzNjEwBuGNJC70GDNpy/UaWEekE0p
	 H+N4j+9NkW9KrXPGPmMigftdRCMigrD79gWeOQ1zAa/vTp7bzHZLtCDoW5/A3zI25L
	 Yjiv00ynY7SeA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 34E59CE0BB3; Tue,  4 Nov 2025 08:49:27 -0800 (PST)
Date: Tue, 4 Nov 2025 08:49:27 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	peterz@infradead.org, rcu@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 15/19] srcu: Create an SRCU-fast-updown API
Message-ID: <e166df6b-1d04-4962-854d-8c88010bff5c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251102214436.3905633-15-paulmck@kernel.org>
 <e951d365-27ec-427c-ba29-8b6925342463@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e951d365-27ec-427c-ba29-8b6925342463@gmail.com>

On Tue, Nov 04, 2025 at 04:00:27PM +0900, Akira Yokosawa wrote:
> Hi Paul,
> 
> Minor nitpicks in kernel-doc comment of srcu_read_lock_fast_updown().
> 
> On Sun,  2 Nov 2025 13:44:32 -0800, Paul E. McKenney wrote:
> > This commit creates an SRCU-fast-updown API, including
> > DEFINE_SRCU_FAST_UPDOWN(), DEFINE_STATIC_SRCU_FAST_UPDOWN(),
> > __init_srcu_struct_fast_updown(), init_srcu_struct_fast_updown(),
> > srcu_read_lock_fast_updown(), srcu_read_unlock_fast_updown(),
> > __srcu_read_lock_fast_updown(), and __srcu_read_unlock_fast_updown().
> > 
> > These are initially identical to their SRCU-fast counterparts, but both
> > SRCU-fast and SRCU-fast-updown will be optimized in different directions
> > by later commits.  SRCU-fast will lack any sort of srcu_down_read() and
> > srcu_up_read() APIs, which will enable extremely efficient NMI safety.
> > For its part, SRCU-fast-updown will not be NMI safe, which will enable
> > reasonably efficient implementations of srcu_down_read_fast() and
> > srcu_up_read_fast().
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: <bpf@vger.kernel.org>
> > ---
> >  include/linux/srcu.h     | 77 +++++++++++++++++++++++++++++++++++++---
> >  include/linux/srcutiny.h | 16 +++++++++
> >  include/linux/srcutree.h | 55 ++++++++++++++++++++++++++--
> >  kernel/rcu/srcutree.c    | 39 +++++++++++++++++---
> >  4 files changed, 176 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index 1dd6812aabe7..1fbf475eae5e 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> 
> [...]
> 
> > @@ -305,6 +315,46 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
> >  	return retval;
> >  }
> >  
> > +/**
> > + * srcu_read_lock_fast_updown - register a new reader for an SRCU-fast-updown structure.
> > + * @ssp: srcu_struct in which to register the new reader.
> > + *
> > + * Enter an SRCU read-side critical section, but for a light-weight
> > + * smp_mb()-free reader.  See srcu_read_lock() for more information.
> > + * This function is compatible with srcu_down_read_fast(), but is not
> > + * NMI-safe.
> > + *
> > + * For srcu_read_lock_fast_updown() to be used on an srcu_struct
> > + * structure, that structure must have been defined using either
> > + * DEFINE_SRCU_FAST_UPDOWN() or DEFINE_STATIC_SRCU_FAST_UPDOWN() on the one
> > + * hand or initialized with init_srcu_struct_fast_updown() on the other.
> > + * Such an srcu_struct structure cannot be passed to any non-fast-updown
> > + * variant of srcu_read_{,un}lock() or srcu_{down,up}_read().  In kernels
> > + * built with CONFIG_PROVE_RCU=y, () will complain bitterly if you ignore
> > + * this * restriction.
> 
> Probably,
> 
>  * built with CONFIG_PROVE_RCU=y, __srcu_check_read_flavor() will complain
>  * bitterly if you ignore this restriction.
> 
> ??
> 
> > + *
> > + * Grace-period auto-expediting is disabled for SRCU-fast-updown
> > + * srcu_struct structures because SRCU-fast-updown expedited grace periods
> > + * invoke synchronize_rcu_expedited(), IPIs and all.  If you need expedited
> > + * SRCU-fast-updown grace periods, use synchronize_srcu_expedited().
> > + *
> > + * The srcu_read_lock_fast_updown() function can be invoked only from
> > + those contexts where RCU is watching, that is, from contexts where
> > + it would be legal to invoke rcu_read_lock().  Otherwise, lockdep will
> > + complain.
> 
> kernel-doc (script) complains:
> 
> Warning: include/linux/srcu.h:341 bad line:  those contexts where RCU is watching, that is, from contexts where
> Warning: include/linux/srcu.h:342 bad line:  it would be legal to invoke rcu_read_lock().  Otherwise, lockdep will
> Warning: include/linux/srcu.h:343 bad line:  complain.
> 
> Leading "* "s are missing.

Good eyes on both, will fix, thank you!!!

							Thanx, Pual

>         Thanks, Akira
> 
> > + */
> > +static inline struct srcu_ctr __percpu *srcu_read_lock_fast_updown(struct srcu_struct *ssp)
> > +__acquires(ssp)
> > +{
> > +	struct srcu_ctr __percpu *retval;
> > +
> > +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast_updown().");
> > +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST_UPDOWN);
> > +	retval = __srcu_read_lock_fast_updown(ssp);
> > +	rcu_try_lock_acquire(&ssp->dep_map);
> > +	return retval;
> > +}
> > +
> >  /*
> >   * Used by tracing, cannot be traced and cannot call lockdep.
> >   * See srcu_read_lock_fast() for more information.
> [...]

