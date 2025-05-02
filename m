Return-Path: <bpf+bounces-57262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 874B7AA794C
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 20:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D7A4C1B63
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 18:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0230922FACA;
	Fri,  2 May 2025 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4LoHsWw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BFA376;
	Fri,  2 May 2025 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746210982; cv=none; b=DszmMRaPLqH23pa7VLgo9OYvtgj7Eqa26S4yukjwT8aYz/RkKX+iTzxvXPmd3Ad5m5cGkMeBsBg6weE1+yMWBaClqFfKxtZVSTXwTT2pTa38H3DgoNeqCODjhP2KfHCXk8x5oV2E1dZvYboZwgZMYVZp/7Mp2xd6fE4A5xt7w00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746210982; c=relaxed/simple;
	bh=c9rS2LMLvL71djunTabDJK6//VIoQA3j219OaV+he+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9hOL6BT8CO3xYcTE3+TfMhrc//eYORFywtud362cSk/v8XCyhXFyZDCAGi84Q4Yed+sTb7KEKam8PHTk9ULOB5B3DqJAmETs3ZlgdERkLw9fzdE8+3MWbGex2iAFFDP1GdzsbEmsLvEd1sNUdRv9PHCBAq0okxj8AOZySOQiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4LoHsWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAED1C4CEE4;
	Fri,  2 May 2025 18:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746210981;
	bh=c9rS2LMLvL71djunTabDJK6//VIoQA3j219OaV+he+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4LoHsWwGwISYV/ODEtKA4U9+yTVRuYfEBpAsq2w07x3yFwI2Cd9YB3kjyLCHm1lY
	 TOBgWp1Yjt+USOq/OlG31h8ho8mQ2u6hE/KjNn45eaT/ygLnO5pl+S1magCngX/gmi
	 fmV23K8fo67iQ5aLOHzyVv0woCyT8qCkxLcuvUOxQi2kDqKb0k2mDoaYik2yzweauv
	 hO40DfwMACCKeo1WYXfosA1NrBIssA/rtSOuyY816qLvPcKRSH1EX6NXtSSDMmlqmC
	 MlBr6l3ZDNXNHPVI7zHeoBq08aw10LODrcUZyiyXPqEeNvq4d4TWlESnw2ezCpMxkF
	 mgkkFSosu1G9Q==
Date: Fri, 2 May 2025 08:36:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH RFC v3 0/2] Task local data API
Message-ID: <aBUQpPFemrUYxyO6@slm.duckdns.org>
References: <20250425214039.2919818-1-ameryhung@gmail.com>
 <CAEf4BzYUNckc9pXcE7BawxWFVfY--p12c3ax8ySP1P+BEww91w@mail.gmail.com>
 <CAMB2axMbAjYVB3+bMuwOszqAn153_9S_vG6iN26-J-n67NGwPQ@mail.gmail.com>
 <CAEf4BzZ=HORw6JnQz=pguoaUSc=swFiaG9mzQLxqLZgTamc1qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ=HORw6JnQz=pguoaUSc=swFiaG9mzQLxqLZgTamc1qA@mail.gmail.com>

Hello,

On Fri, May 02, 2025 at 09:14:47AM -0700, Andrii Nakryiko wrote:
> > The advantage of no memory wasted for threads that are not using TLD
> > doesn't seem to be that definite to me. If users add per-process
> > hints, then this scheme can potentially use a lot more memory (i.e.,
> > PAGE_SIZE * number of threads). Maybe we need another uptr for
> > per-process data? Or do you think this is out of the scope of TLD and
> > we should recommend other solutions?
> 
> I'd keep it simple. One page per thread isn't a big deal at all, in my
> mind. If the application has a few threads, then a bunch of kilobytes
> is not a big deal. If the application has thousands of threads, then a
> few megabytes for this is the least of that application's concern,
> it's already heavy-weight as hell. I think we are overpivoting on
> saving a few bytes here.

It could well be that 4k is a price worth paying but there will be cases
where this matters. With 100k threads - not common but not unheard of
either, that's ~400MB. If the data needed to be shared is small and most of
that is wasted, that's not an insignificant amount. uptr supports sub-page
sizing, right? If keeping sizing dynamic is too complex, can't a process
just set the max size to what it deems appropriate?

Thanks.

-- 
tejun

