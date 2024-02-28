Return-Path: <bpf+bounces-22882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FA886B33A
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 16:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609CA2879B6
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 15:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8179915CD58;
	Wed, 28 Feb 2024 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjYMzDmK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C515C8;
	Wed, 28 Feb 2024 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134547; cv=none; b=DQWT9cJAB8zQaNkHNPtiQ/TRpl8O1gzAc+QkDKiibobV3ryjcRD5UxJEU/6/bhF48ns0+hoa2iBPHiI7DcBDlSeh0Kp/0m7PPIyfOM3eO44t3WlSAAtuTzbNSl2rL/h1TIZ20lSByCLmzdMCluDkmsox3ChNkbZ5DuREBJo6Rgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134547; c=relaxed/simple;
	bh=Ow0oMcjP9WmZsxfrrSXHg6DV3yhPxuTY7U/vGkGDAk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csgnzSLVlTTcb1Cv+erbMmfOX7wxqGgzghGR5/J9/r/VvstR/b82kBRGMWVQzmawsGCmGSbEI3tdHugdlJ4rHj1kXdMKtPhX1Z9Uihh6vPPDNGXH1vb3CWYGIDgk0KUOVD90hyXZ9ReMv4Siy0z9zzz1ztOyHhcmCtHWz8tE3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjYMzDmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5059C433F1;
	Wed, 28 Feb 2024 15:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709134546;
	bh=Ow0oMcjP9WmZsxfrrSXHg6DV3yhPxuTY7U/vGkGDAk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FjYMzDmK0IQosaEYUJyTURCigp714oQKlOA4XW/fr2d9wr8GLnE6+YlOaCtrPYr1/
	 AyLRbs5tT5JQu/HwctS/gctasVnVJVwXuGXeNTZnQjvTSTVZxVag3mZtDxGNxs5tti
	 HmO7dNDqYzNRe5oVx2/Wtvw/5/yy063g8AaLRgn6a7mnCM7uFY0PPePV2OEQr9gynR
	 AP9mR9vW4/PRniAk3bZ5mzZ/3b9uZEfqnM+4y5hd14dPnqEReYjWItA7iW22h1JKcO
	 zOGRGtY00+x1vHsKfvKN1RCp84agHNXre1rxFBqKwGFIE0J60FVW3dJnZkw9O85OC+
	 iRT5HPXD8FyiA==
Date: Wed, 28 Feb 2024 07:35:44 -0800
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
Message-ID: <20240228073544.791ae897@kernel.org>
In-Reply-To: <9a0052f9-b022-42c9-a5da-1d6ca3b00885@paulmck-laptop>
References: <Zd4DXTyCf17lcTfq@debian.debian>
	<CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
	<d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
	<20240227191001.0c521b03@kernel.org>
	<66a81295-ab6f-41f4-a3da-8b5003634c6a@paulmck-laptop>
	<20240228064343.578a5363@kernel.org>
	<9a0052f9-b022-42c9-a5da-1d6ca3b00885@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 07:15:42 -0800 Paul E. McKenney wrote:
> > > Another complication is that although CONFIG_PREEMPT_RT kernels are
> > > built with CONFIG_PREEMPT_RCU, the reverse is not always the case.
> > > And if we are not repolling, don't we have a high probability of doing
> > > a voluntary context when we reach napi_thread_wait() at the beginning
> > > of that loop?  
> > 
> > Very much so, which is why adding the cost of rcu_softirq_qs()
> > for every NAPI run feels like an overkill.  
> 
> Would it be better to do the rcu_softirq_qs() only once every 1000 times
> or some such?  Or once every HZ jiffies?
> 
> Or is there a better way?

Right, we can do that. Yan Zhai, have you measured the performance
impact / time spent in the call?

