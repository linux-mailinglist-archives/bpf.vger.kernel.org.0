Return-Path: <bpf+bounces-47455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834189F98B6
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5A81899AE7
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDB722A1D5;
	Fri, 20 Dec 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K804B67s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2FF215F74;
	Fri, 20 Dec 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715609; cv=none; b=cnsaSEetzimkbaxAgY5QDzTdE0dgdUNtpW07HzmeF060+cONmMkkFlj6ca/a9W9G20MHvvh2WR6OfIKC+Eygdw7XirncqD/Qv7rY9NOV/5uaSB0gmi6bKbkzMkF6qr9g9BGUi1Jg9ILoXvHpWOuDxLY87Y+wAYc87Q1aRjXSalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715609; c=relaxed/simple;
	bh=7NyLAA1WEljU+qXEHmkJUnhhHGok3Qw1EqYfD/FkVTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9qhDEV1bysrPzaXAb13xsXz1qAUyVp5hAdto2B+pDtNCmMOZbTiOFd8D5PCq9XsJS0UZlH9ewIfBPz93mjmqiU0eN+qID1xwBBjndat5H31BfBmDrEAd1yYxrHTDd8aeuSptl1R94n5a8SO3YfCwUnMAH76oWZoJXSk9eqM9U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K804B67s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37272C4CED3;
	Fri, 20 Dec 2024 17:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734715608;
	bh=7NyLAA1WEljU+qXEHmkJUnhhHGok3Qw1EqYfD/FkVTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K804B67s4c1BZNjrrI24TwYCA4Z51ti2bcDvEVkSrvOGQaY8oN7oi50wogqcXQg+T
	 KI5flG9Bh84mHKpT41GjoAnRfP1BswylwspzL1ml/WkyOXDK1cqFtVmSa5lxrk7T6S
	 ck4C1xrWRi7/tD9jE/j7VCW4hp+JEvp4Ys14qbsGvQgUQXxNZeyI7qd+cE/e9bAW4s
	 rkR7fkTpr/Itv6IVvHGuGw3N8MnIavm5kWsmkdedNlGqanePwvqZUtPg8uBdDkjfoP
	 Z2pTDrmuArm+HS+tLh0oTm0xqYjD9pwyLKMjTHWcSxK+vh1+D+/J5dLiO/UPZto5gb
	 u2tEPWiUjtA3A==
Date: Fri, 20 Dec 2024 09:26:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Jose E. Marchesi"
 <jose.marchesi@oracle.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, "Magnus Karlsson" <magnus.karlsson@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 6/7] xsk: add helper to get &xdp_desc's DMA and
 meta pointer in one go
Message-ID: <20241220092647.63affabc@kernel.org>
In-Reply-To: <388fe411-d06f-4cb4-b58a-a2b9b5eb08ce@intel.com>
References: <20241218174435.1445282-1-aleksander.lobakin@intel.com>
	<20241218174435.1445282-7-aleksander.lobakin@intel.com>
	<20241219195058.7910c10a@kernel.org>
	<388fe411-d06f-4cb4-b58a-a2b9b5eb08ce@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 16:58:57 +0100 Alexander Lobakin wrote:
> > On Wed, 18 Dec 2024 18:44:34 +0100 Alexander Lobakin wrote:  
> >> +	ret = (typeof(ret)){
> >> +		/* Same logic as in xp_raw_get_dma() */
> >> +		.dma	= (pool->dma_pages[addr >> PAGE_SHIFT] &
> >> +			   ~XSK_NEXT_PG_CONTIG_MASK) + (addr & ~PAGE_MASK),
> >> +	};  
> > 
> > This is quite ugly IMHO  
> 
> What exactly: that the logic is copied or how that code (>> & ~ + & ~)
> looks like?
> 
> If the former, I already thought of making a couple internal defs to
> avoid copying.
> If the latter, I also thought of this, just wanted to be clear that it's
> the same as in xp_raw_get_dma(). But it can be refactored to look more
> fancy anyway.
> 
> Or the compound return looks ugly? Or the struct initialization?

Compound using typeof() and the fact it's multi line.

It's a two member struct, which you return by value,
so unlikely to grow. Why not init the members manually?

And you could save the intermediate computations to a temp variable
(addr >> PAGE_SHIFT, addr & ~PAGE_MASK) to make the line shorter.

