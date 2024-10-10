Return-Path: <bpf+bounces-41589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1617998CC6
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 18:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846A51F251B8
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C4F1CCEF1;
	Thu, 10 Oct 2024 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+ZMkKMo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7E6FE16;
	Thu, 10 Oct 2024 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576407; cv=none; b=BZVx+p28VztdDr0XKdYob+LWWkFsoM0jaSd/PlTqq8yyYemfcQ85SlNTWUsiz+RqWeIZl37XGkeDfjs+diUPGP+BWQCnabk38OciB2EiQoUawEg/X6vkNXrk43slby230IFgCDVvU+O/L4Uy7b/lv7nlx7LWpVnRNFnaRF2wxT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576407; c=relaxed/simple;
	bh=XtfKr6f+9/BDFca/f75j52NAQuPvYAyCtr5tfo7a2Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0TRQQHiOaFW4qYHFbjpOFnpSZPjdP0RPimgAJlHyyCD3SVPLPx1gNdkeaWXdaJxsHEd7PyhaP4zsFIxs64pm1n8guz7HjWKaH0+zHPudPkjkdxEKUT4kjKmpPjoCSz7ouJQo/5a8mMUcgUu1SfwY4yQo/0tS3b/kaAbrq/vmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+ZMkKMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BF7C4CEC5;
	Thu, 10 Oct 2024 16:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728576407;
	bh=XtfKr6f+9/BDFca/f75j52NAQuPvYAyCtr5tfo7a2Rk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=X+ZMkKMoz4OSGGFR207u+G/k2uNJ4GSfvgnHZWMRZTY/SPSX3THA11oSHfQVoijxN
	 zOkxmTOHOf90QZWKpTgc9iMyZjCCyNQzzdr4teySMBhP9lxE67r7haWhKtNhNmsyjC
	 yieThWJUumJjLCC8cBBjnJEYOp/B1ZDrI8ZcnXCFhT5geDHQVmqDpa0/PBg6NJuezH
	 X66YRwRt4/yu9a1Cc9VpdFc9lbohBZk6xZxH9u0GrxMqec6iwB6Dc1ZaQDyfivvNAi
	 /ilmSHiMMc5sSB6gpbtBcXUtEO/260RV7sS2jnHLP7QOSyIK6+odZzT23ofNe2TKQP
	 n6oPrvQtgjkpA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9F4DDCE08F7; Thu, 10 Oct 2024 09:06:46 -0700 (PDT)
Date: Thu, 10 Oct 2024 09:06:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 12/12] refscale: Add srcu_read_lock_lite() support
 using "srcu-lite"
Message-ID: <05e431fa-bc34-489b-9711-13f0b6d26991@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-12-paulmck@kernel.org>
 <Zwf0-jFnWmpPIVy_@localhost.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zwf0-jFnWmpPIVy_@localhost.localdomain>

On Thu, Oct 10, 2024 at 05:38:34PM +0200, Frederic Weisbecker wrote:
> Le Wed, Oct 09, 2024 at 11:07:19AM -0700, Paul E. McKenney a écrit :
> > This commit creates a new srcu-lite option for the refscale.scale_type
> > module parameter that selects srcu_read_lock_lite() and
> > srcu_read_unlock_lite().
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: <bpf@vger.kernel.org>
> 
> This one does not apply cleanly. I assume there is some dependency to another
> branch?

Quite possibly, since I made a stack rather than a set of branches.

I will branchify later today, make some updates from feedback, and
resend.

Apologies for the hassle!

							Thanx, Paul

> Thanks.
> 
> > ---
> >  kernel/rcu/refscale.c | 51 +++++++++++++++++++++++++++++++++----------
> >  1 file changed, 40 insertions(+), 11 deletions(-)
> > 
> > diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> > index be66e5a67ee19..897d5b5494949 100644
> > --- a/kernel/rcu/refscale.c
> > +++ b/kernel/rcu/refscale.c
> > @@ -216,6 +216,36 @@ static const struct ref_scale_ops srcu_ops = {
> >  	.name		= "srcu"
> >  };
> >  
> > +static void srcu_lite_ref_scale_read_section(const int nloops)
> > +{
> > +	int i;
> > +	int idx;
> > +
> > +	for (i = nloops; i >= 0; i--) {
> > +		idx = srcu_read_lock_lite(srcu_ctlp);
> > +		srcu_read_unlock_lite(srcu_ctlp, idx);
> > +	}
> > +}
> > +
> > +static void srcu_lite_ref_scale_delay_section(const int nloops, const int udl, const int ndl)
> > +{
> > +	int i;
> > +	int idx;
> > +
> > +	for (i = nloops; i >= 0; i--) {
> > +		idx = srcu_read_lock_lite(srcu_ctlp);
> > +		un_delay(udl, ndl);
> > +		srcu_read_unlock_lite(srcu_ctlp, idx);
> > +	}
> > +}
> > +
> > +static const struct ref_scale_ops srcu_lite_ops = {
> > +	.init		= rcu_sync_scale_init,
> > +	.readsection	= srcu_lite_ref_scale_read_section,
> > +	.delaysection	= srcu_lite_ref_scale_delay_section,
> > +	.name		= "srcu-lite"
> > +};
> > +
> >  #ifdef CONFIG_TASKS_RCU
> >  
> >  // Definitions for RCU Tasks ref scale testing: Empty read markers.
> > @@ -1133,27 +1163,26 @@ ref_scale_init(void)
> >  	long i;
> >  	int firsterr = 0;
> >  	static const struct ref_scale_ops *scale_ops[] = {
> > -		&rcu_ops, &srcu_ops, RCU_TRACE_OPS RCU_TASKS_OPS &refcnt_ops, &rwlock_ops,
> > -		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &sched_clock_ops, &clock_ops,
> > -		&jiffies_ops, &typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
> > +		&rcu_ops, &srcu_ops, &srcu_lite_ops, RCU_TRACE_OPS RCU_TASKS_OPS
> > +		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops,
> > +		&sched_clock_ops, &clock_ops, &jiffies_ops, &typesafe_ref_ops, &typesafe_lock_ops,
> > +		&typesafe_seqlock_ops,
> >  	};
> >  
> >  	if (!torture_init_begin(scale_type, verbose))
> >  		return -EBUSY;
> >  
> >  	for (i = 0; i < ARRAY_SIZE(scale_ops); i++) {
> > -		cur_ops = scale_ops[i];
> > -		if (strcmp(scale_type, cur_ops->name) == 0)
> > +		cur_ops = scale_ops[i]; if (strcmp(scale_type,
> > +		cur_ops->name) == 0)
> >  			break;
> >  	}
> >  	if (i == ARRAY_SIZE(scale_ops)) {
> > -		pr_alert("rcu-scale: invalid scale type: \"%s\"\n", scale_type);
> > -		pr_alert("rcu-scale types:");
> > -		for (i = 0; i < ARRAY_SIZE(scale_ops); i++)
> > +		pr_alert("rcu-scale: invalid scale type: \"%s\"\n",
> > +		scale_type); pr_alert("rcu-scale types:"); for (i = 0;
> > +		i < ARRAY_SIZE(scale_ops); i++)
> >  			pr_cont(" %s", scale_ops[i]->name);
> > -		pr_cont("\n");
> > -		firsterr = -EINVAL;
> > -		cur_ops = NULL;
> > +		pr_cont("\n"); firsterr = -EINVAL; cur_ops = NULL;
> >  		goto unwind;
> >  	}
> >  	if (cur_ops->init)
> > -- 
> > 2.40.1
> > 

