Return-Path: <bpf+bounces-63666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFDBB09534
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 21:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78183A40D2
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BE721ADB9;
	Thu, 17 Jul 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+ISuQyF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747FB194A60;
	Thu, 17 Jul 2025 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781890; cv=none; b=jXgwya7RF7QgP2+vc6FfU7xE2EtdxfYyMhT6FvYSvkxmC8c9gOrubLiPSTkl/MHEkzGAcSpwmoolI3tW1TVcaXcdjMr0QYlOYPWnmQeu2B3X0/dPN/8k5AG5MvIaIraVfw19AmmoiOMnvm9lF387KxcxpFGsMOV8w1Kze/f8i5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781890; c=relaxed/simple;
	bh=yAE0t+HQBR1WNyXJdNvZL+F48vFDXWsQ5GGLJaRf2jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlnZAQKVfIskz084zSCfI7VFwtaPCQB1c1griNLXLRb1O9Y+dlvWiVfcokHHB+Dv5sxRd8V1c51tVmvW570NBp4wXL8pwT4OvV6VpTHyoC2w9zd+MzO9hUUP9Xa7s+ybZcU9SQwfutUFrNAuP4IzxNcKl22RUV3T8U612S+M64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+ISuQyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5F8C4CEE3;
	Thu, 17 Jul 2025 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752781890;
	bh=yAE0t+HQBR1WNyXJdNvZL+F48vFDXWsQ5GGLJaRf2jA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=U+ISuQyFWyiinPu+NA6dM4Rb6aOFopwq4yeBwnQsRuahX80tBF1Nl4M1oFoWZsWld
	 Q0wMWJ9qbCeTr3zRRlxrQf+vYeWxSRdLFpPEQTt5uWTKhJcnpGl5pwHzov5oAQMCol
	 e3Fi4Dt7jYsQTvAB8wFG1AkidLSUOvTu49TyirHSokjNzJMML1wgumgEofrOlXIBU4
	 3WpFjBsFDtUU7VspqgxK0J3vWqRXuBiGhV43245Ddd7TSXnkVuZTjzD6wj6pPxNVFY
	 yrzMDX+rU/DALSEs+k6zns8b19BdbGcC5hqB66PYSQmMc+shnQJRnj3Z1U4oRqd172
	 0joJ3Pc4sOpmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 86DB2CE13CD; Thu, 17 Jul 2025 12:51:29 -0700 (PDT)
Date: Thu, 17 Jul 2025 12:51:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	bpf@vger.kernel.org
Subject: Re: [PATCH RFC 6/4] srcu: Add guards for SRCU-fast readers
Message-ID: <af022343-1719-4882-bf86-ec49e59f77c3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <58866d6b-f4d9-4aaf-abce-10ddf526c3ad@paulmck-laptop>
 <20250717151934.282d8310@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717151934.282d8310@batman.local.home>

On Thu, Jul 17, 2025 at 03:19:34PM -0400, Steven Rostedt wrote:
> On Thu, 17 Jul 2025 12:04:46 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > This adds the usual scoped_guard(srcu_fast, &my_srcu) and
> > guard(srcu_fast)(&my_srcu).
> > 
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you!  I will apply this on my next rebase.

The normal process puts this into the v6.18 merge window, that it, the
merge window after the upcoming one.  If you need it sooner, please let
us know.

							Thanx, Paul

> -- Steve
> 
> > ---
> >  srcu.h |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index 0aa2376cca0b1..ada65b58bc4c5 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -510,6 +510,11 @@ DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
> >  		    srcu_read_unlock(_T->lock, _T->idx),
> >  		    int idx)
> >  
> > +DEFINE_LOCK_GUARD_1(srcu_fast, struct srcu_struct,
> > +		    _T->scp = srcu_read_lock_fast(_T->lock),
> > +		    srcu_read_unlock_fast(_T->lock, _T->scp),
> > +		    struct srcu_ctr __percpu *scp)
> > +
> >  DEFINE_LOCK_GUARD_1(srcu_fast_notrace, struct srcu_struct,
> >  		    _T->scp = srcu_read_lock_fast_notrace(_T->lock),
> >  		    srcu_read_unlock_fast_notrace(_T->lock, _T->scp),
> 

