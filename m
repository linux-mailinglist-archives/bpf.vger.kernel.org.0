Return-Path: <bpf+bounces-64218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70337B0FC14
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 23:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E851585A64
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 21:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B304426CE32;
	Wed, 23 Jul 2025 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzlqJBGQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321EE2E630;
	Wed, 23 Jul 2025 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753305674; cv=none; b=Uj2u6BTvmbWujADV1cXIn8gpZ1VLwtwJ7yloO6w09e6jygwu+JK7L0ODS3cpOYQrb0S4NaTZq1Lm9urY2Jg4NBYPxd8ylxVqr+NVEL+15c+TUiLowlBUCObT4ydqxRKqNCow2m7wuOsVDikvuMtsKa4NKA+yi4jakhHbXjTJng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753305674; c=relaxed/simple;
	bh=J+2l9Ux3H/DgjEwIji6H7wMMNYF7wVPwD6xtgBzUtSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReQ4u/HFJDGJiST/9oVopwKXYDPhZy7MAs/7LdobD1j8Wwz9rmIRz4R9le12JOZd1CKNrGBAxpuGt6r17wmRxkliB+CWmCanAdOl9gRtvRtcE+dQ1sOqjzalf3Zk9L6A0ysFFZjihDC8zWfl51I8sOLPV94q4rnh5GeETxMs/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzlqJBGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE68FC4CEE7;
	Wed, 23 Jul 2025 21:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753305673;
	bh=J+2l9Ux3H/DgjEwIji6H7wMMNYF7wVPwD6xtgBzUtSU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kzlqJBGQj2u6k31WdSrMq3v85JMSp3+3Z4jhYuxOyrgOD343mRhEfZgYwbq76DtGK
	 kGKbZVok0/VQNlnjBVgq3XVPS1LZZMacAqjkdRZn6JKoVx6Oy402jf64FfMjLFqMvI
	 bw6HsDVLLsuL1mEUf8pkgErLfrXsfH1u0ENosZUcyVMicXzVAsHZUsOWHvCGzIpRcs
	 IMSCnVE2mbh2MxZdpfc3M7IuQVRQ9itxof1KETheLWt/l3YRbo/oAp6A9dYCA4QpP4
	 pPCOtnKAAl5dvreQFSkS59+Yu1VSBiodagNOEZ+ATQS9KJlxhWL6/77lWcxGzYzsWb
	 mqjqWIiEyfJwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6DD0CCE08DF; Wed, 23 Jul 2025 14:21:13 -0700 (PDT)
Date: Wed, 23 Jul 2025 14:21:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Joel Fernandes <joelagnelf@nvidia.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 2/6] srcu: Add srcu_read_lock_fast_notrace() and
 srcu_read_unlock_fast_notrace()
Message-ID: <a62c72c0-41f6-4588-bfd1-0506ecb6910e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
 <20250723202800.2094614-2-paulmck@kernel.org>
 <aIFLG91VhtjN8iaf@tardis.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIFLG91VhtjN8iaf@tardis.local>

On Wed, Jul 23, 2025 at 01:50:35PM -0700, Boqun Feng wrote:
> On Wed, Jul 23, 2025 at 01:27:56PM -0700, Paul E. McKenney wrote:
> > This commit adds no-trace variants of the srcu_read_lock_fast() and
> > srcu_read_unlock_fast() functions for tracing use.
> > 
> > [ paulmck: Apply notrace feedback from Joel Fernandes, Steven Rostedt, and Mathieu Desnoyers. ]
> > 
> > Link: https://lore.kernel.org/all/20250721162433.10454-1-paulmck@kernel.org
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: <bpf@vger.kernel.org>
> > ---
> >  include/linux/srcu.h     | 30 ++++++++++++++++++++++++++++--
> >  include/linux/srcutree.h |  5 +++--
> >  2 files changed, 31 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index 478c73d067f7d..ec3b8e27d6c5a 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -271,7 +271,7 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
> >   * where RCU is watching, that is, from contexts where it would be legal
> >   * to invoke rcu_read_lock().  Otherwise, lockdep will complain.
> >   */
> > -static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *ssp) __acquires(ssp)
> > +static inline struct srcu_ctr __percpu notrace *srcu_read_lock_fast(struct srcu_struct *ssp) __acquires(ssp)
> 
> Hmm.. am I missing something, why do we need ot make
> srcu_read_lock_fast() notrace? I thought we only need those _notrace()
> variants notrace?

Good point!  It looks like I got a bit too exuberant here.  I am removing
notrace from srcu_read_lock_fast() and srcu_read_unlock_fast(), but
leaving srcu_read_lock_fast_notrace(), srcu_read_unlock_fast_notrace(),
__srcu_read_lock_fast(), and __srcu_read_unlock_fast() as-is.

							Thanx, Paul

> Regards,
> Boqun
> 
> >  {
> >  	struct srcu_ctr __percpu *retval;
> >  
> > @@ -282,6 +282,20 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
> >  	return retval;
> >  }
> >  
> > +/*
> > + * Used by tracing, cannot be traced and cannot call lockdep.
> > + * See srcu_read_lock_fast() for more information.
> > + */
> > +static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_struct *ssp)
> > +	__acquires(ssp)
> > +{
> > +	struct srcu_ctr __percpu *retval;
> > +
> > +	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
> > +	retval = __srcu_read_lock_fast(ssp);
> > +	return retval;
> > +}
> > +
> >  /**
> >   * srcu_down_read_fast - register a new reader for an SRCU-protected structure.
> >   * @ssp: srcu_struct in which to register the new reader.
> > @@ -385,7 +399,8 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
> >   *
> >   * Exit a light-weight SRCU read-side critical section.
> >   */
> > -static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
> > +static inline void notrace
> > +srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
> >  	__releases(ssp)
> >  {
> >  	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
> > @@ -394,6 +409,17 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
> >  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
> >  }
> >  
> > +/*
> > + * Used by tracing, cannot be traced and cannot call lockdep.
> > + * See srcu_read_unlock_fast() for more information.
> > + */
> > +static inline void srcu_read_unlock_fast_notrace(struct srcu_struct *ssp,
> > +						 struct srcu_ctr __percpu *scp) __releases(ssp)
> > +{
> > +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
> > +	__srcu_read_unlock_fast(ssp, scp);
> > +}
> > +
> >  /**
> >   * srcu_up_read_fast - unregister a old reader from an SRCU-protected structure.
> >   * @ssp: srcu_struct in which to unregister the old reader.
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index 043b5a67ef71e..4d2fee4d38289 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -240,7 +240,7 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
> >   * on architectures that support NMIs but do not supply NMI-safe
> >   * implementations of this_cpu_inc().
> >   */
> > -static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
> > +static inline struct srcu_ctr __percpu notrace *__srcu_read_lock_fast(struct srcu_struct *ssp)
> >  {
> >  	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
> >  
> > @@ -267,7 +267,8 @@ static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct
> >   * on architectures that support NMIs but do not supply NMI-safe
> >   * implementations of this_cpu_inc().
> >   */
> > -static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
> > +static inline void notrace
> > +__srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
> >  {
> >  	barrier();  /* Avoid leaking the critical section. */
> >  	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
> > -- 
> > 2.40.1
> > 
> > 

