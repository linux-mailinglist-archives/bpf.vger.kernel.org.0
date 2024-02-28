Return-Path: <bpf+bounces-22941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7372186BAC2
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2CDB24B35
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FAA2B9A7;
	Wed, 28 Feb 2024 22:31:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2425C16423;
	Wed, 28 Feb 2024 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159466; cv=none; b=DAyld/qc+Pw9OFlLUZeDl7IY9oKiG11tRntRMyEeqRu0a2tlpR4IW/QgKROmw44AwL3CIpZTGjLPt0NeI4TrmVxgd9Ay+KXtN6MyWwSMbs2vUNT7Iq6d1zehfph9D0f7K4yw6/SDMAG5XtghQvENoQ6FaY47niU/r8/OU852a5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159466; c=relaxed/simple;
	bh=lsoEUwVdzDJU8AO/Ssmxi6hs4UEIghre58Da9e/5tt8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqLfpTjLE5ZQCm2+i0YjLGMtL+JvdToIYuoI2j8pxiiv7cPBkVu7WZjKK7b2pxp/fNZsxtWl3KNWNOE04yWaN3miMEtqbSTqthre/flDZy59MMJHSew0SQHmDxEuRU18do82jFXarhxquycvcZwvAbhAYh+XAxT466+EuLOlAqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61490C433C7;
	Wed, 28 Feb 2024 22:31:03 +0000 (UTC)
Date: Wed, 28 Feb 2024 17:33:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Yan Zhai <yan@cloudflare.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Simon Horman
 <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang
 <weiwan@google.com>, Alexander Duyck <alexanderduyck@fb.com>, Hannes
 Frederic Sowa <hannes@stressinduktion.org>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com,
 mark.rutland@arm.com, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <20240228173307.529d11ee@gandalf.local.home>
In-Reply-To: <ba95955d-b63d-4670-b947-e77b740b1a49@paulmck-laptop>
References: <02913b40-7b74-48b3-b15d-53133afd3ba6@paulmck-laptop>
	<3D27EFEF-0452-4555-8277-9159486B41BF@joelfernandes.org>
	<ba95955d-b63d-4670-b947-e77b740b1a49@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 14:19:11 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > > 
> > > Well, to your initial point, cond_resched() does eventually invoke
> > > preempt_schedule_common(), so you are quite correct that as far as
> > > Tasks RCU is concerned, cond_resched() is not a quiescent state.  
> > 
> >  Thanks for confirming. :-)  
> 
> However, given that the current Tasks RCU use cases wait for trampolines
> to be evacuated, Tasks RCU could make the choice that cond_resched()
> be a quiescent state, for example, by adjusting rcu_all_qs() and
> .rcu_urgent_qs accordingly.
> 
> But this seems less pressing given the chance that cond_resched() might
> go away in favor of lazy preemption.

Although cond_resched() is technically a "preemption point" and not truly a
voluntary schedule, I would be happy to state that it's not allowed to be
called from trampolines, or their callbacks. Now the question is, does BPF
programs ever call cond_resched()? I don't think they do.

[ Added Alexei ]

-- Steve

