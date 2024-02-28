Return-Path: <bpf+bounces-22835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B9D86A70A
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 04:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F051C23B7D
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 03:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBC11DDFF;
	Wed, 28 Feb 2024 03:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saYAPfc6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF931CD38;
	Wed, 28 Feb 2024 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709089803; cv=none; b=W0GOtTUbBuipUhR4gKNUejUmmeCztSt3fRKzYhTdDq6baGEJm0+l010bMsJcMcl3oMb60+Nh6mgCNEjY/cd/rB2nAexhUkIm7HEwN8b2YJRfJFDDUP9yicRCBcm/E9zFaEMW8n/ycNxMo86iQLj3zoOUF2DEf5zOetVP7Q+eh2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709089803; c=relaxed/simple;
	bh=W1euSk2De6m04QbugcV3iEslzHM6DSXT6L5/C0cY1lk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SboPAmL40f6FqEOjsPwvIBkgXaEAk0zpKmwt8nb4/O+/IHUPRRDn85/qWQjcMPadbsP5H8q12NFYdH56q3FN/T9ZTfYIAhnF+FtYGtofOLy31+Yyi2zk6WwCdz62I3EMUgsKwLkOcdjhXmonbZfkuUZZNxtU9Qr8Jm1jGaFXdbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saYAPfc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0237BC433C7;
	Wed, 28 Feb 2024 03:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709089802;
	bh=W1euSk2De6m04QbugcV3iEslzHM6DSXT6L5/C0cY1lk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=saYAPfc6j4YBJ3uQBiGwbbcpxK6wAWD7rZIcajfBMzEFKrMN3l+bblAnUV57aPA/2
	 zChRMz9ZxEb+eCnt7pg7JOFbSQWvG3n6heg88CTbymdAhsmKSPr2cQ4qLihjDtwAN5
	 wsiZBMPv5kugTrqsAkMckFRbZJQ+7yFDdD9Kcrb1pf8TZogBhC1h/61NDaBs5eWqQr
	 Y/GmVCZmbfc291DfsQDEmLJZZOJelD1RmdphjI/NHNV3I2BeQGqaCeDsooHE4jQxK7
	 CPI9MbOvn4SDiLQ7e6QCpcLi42++wyIoicIQ7K/CrJMEnzSazyd7WOIkEH3QeRjcmB
	 T1uqiCqKoxpdw==
Date: Tue, 27 Feb 2024 19:10:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Yan Zhai <yan@cloudflare.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Simon Horman
 <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang
 <weiwan@google.com>, Alexander Duyck <alexanderduyck@fb.com>, Hannes
 Frederic Sowa <hannes@stressinduktion.org>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <20240227191001.0c521b03@kernel.org>
In-Reply-To: <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
References: <Zd4DXTyCf17lcTfq@debian.debian>
	<CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
	<d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 10:32:22 -0800 Paul E. McKenney wrote:
> > > +                       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > > +                               rcu_softirq_qs();
> > > +
> > >                         local_bh_enable();
> > >
> > >                         if (!repoll)
> >
> > Hmm....
> > Why napi_busy_loop() does not have a similar problem ?
> > 
> > It is unclear why rcu_all_qs() in __cond_resched() is guarded by
> > 
> > #ifndef CONFIG_PREEMPT_RCU
> >      rcu_all_qs();
> > #endif  
> 
> The theory is that PREEMPT_RCU kernels have preemption, and get their
> quiescent states that way.

But that doesn't work well enough?

Assuming that's the case why don't we add it with the inverse ifdef
condition next to the cond_resched() which follows a few lines down?

			skb_defer_free_flush(sd);
+
+			if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+				rcu_softirq_qs();
+
			local_bh_enable();

			if (!repoll)
				break;

			cond_resched();
		}

We won't repoll majority of the time.

