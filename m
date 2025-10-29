Return-Path: <bpf+bounces-72925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA7AC1DA52
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 428784E2DA5
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAD12F1FED;
	Wed, 29 Oct 2025 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIWpBivi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF58B2EDD76;
	Wed, 29 Oct 2025 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779540; cv=none; b=CeEqM4iS2DyAum0jqI9O9EHwhzvD+Xqzis4RaNlDZKgVALeZbEDBcMVMieL/Xq6ttaCMDW4EQvQuo2KfxFHvoEqciz1Timl3vb0rrTIUFhOoEl7Qd2ZSH69T1H9xc8cnVBTQrSTv8JNniIRAkxOHT8c+KeosvlQa0Db1PrZ5+Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779540; c=relaxed/simple;
	bh=6BSN0rcgs0DzYKrINPAj7MX3VIGewgEfCuLdqxbHYy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4y1hTpBxcWA8gdZZsxzCUUWJExwPsSxoX1Iq62YrYRTkSwq2bqhHlbwDYtMcTYrI+BGTRt8aAw29yZQufjzf6BtBojt09QSxfSUlGWP0YVPaM9pRmmXbZt9g/WC2uxwpnwOy9xTXKkhKPp6IR1Vee/YDWoeYEcn58ft2jGIrFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIWpBivi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E19EC4CEFD;
	Wed, 29 Oct 2025 23:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761779540;
	bh=6BSN0rcgs0DzYKrINPAj7MX3VIGewgEfCuLdqxbHYy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TIWpBiviwQBhOUhXDzqDUdup8/QMGxvPROL3Axo0HLdi0+uNAo7e0NPmiF4jf18hp
	 Ykbt83g34Uz7CAfh81KcMaE8wzb+eUWnFc7V8yU5E9i22oUoxyenpCTBA3S1wQ2DTQ
	 ubAMBMBlbLKZ0OIx6ID2Habv5I2lPlWD3g0NM3eFTxyW2mkMQWe9GB31AahtVGfdf6
	 OJfeRgcv+XiphoWVqMKewDBTR9SGne0SP5NUUoue8koZBiVrWp+z0rQh01bVLwRQ0u
	 xYpS7kzBaPXwr3jEbKcNovb7X0T4btOx1GiJ022H3VSPyfE806h/kMiDOuNAHo0Uck
	 qpEhEwg4MH0VA==
Date: Wed, 29 Oct 2025 16:12:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <aleksander.lobakin@intel.com>,
 <ilias.apalodimas@linaro.org>, <toke@redhat.com>, <lorenzo@kernel.org>,
 <syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v4 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <20251029161218.15aef43e@kernel.org>
In-Reply-To: <aQH5+ojHJ1V9jfk8@boxer>
References: <20251027121318.2679226-1-maciej.fijalkowski@intel.com>
	<20251027121318.2679226-2-maciej.fijalkowski@intel.com>
	<11142984-9bbe-4611-bbe7-fa5494036b8f@kernel.org>
	<20251028185314.1ad62578@kernel.org>
	<aQH5+ojHJ1V9jfk8@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 12:26:50 +0100 Maciej Fijalkowski wrote:
> > I still think _all_ frags which may end up here are from the per CPU PP
> > since we CoW the skbs. So:  
> 
> Agree!
> 
> > 
> > 	DEBUG_NET_WARN_ON_ONCE(!skb->pp_recycle);
> > 	xdp->rxq->mem.type = MEM_TYPE_PAGE_POOL;  
> 
> This has to be conditional as it is fine to use this helper for
> MEM_TYPE_PAGE_SHARED, plus the mem type has to be updated per packet.
> 
> > ? It is legal to have pp and non-pp frags in a single skb AFAIK.  
> 
> Ok, but not in this case where data origins from CoW path.

Right.

I guess what I'm saying is that right now we have 4 callers:
 - XDP generic
 - veth
 - devmap 
 - cpumap
these all go thru skb_pp_cow_data() if skb has frags.

You're right that in theory someone can call this function
on a private skb they just constructed (IOW they know they 
don't need to CoW). But IIUC (1) such caller doesn't exist
today; (2) why wouldn't that caller run XDP before allocating
the skb..

So my thinking was to keep this simple for now, used fixed
MEM_TYPE_PAGE_POOL. Add that DEBUG_WARN() and in the kdoc
say that we expect the skbs to have gone thru skb_pp_cow_data().

Worry about conditionals when the odd new user appears.

