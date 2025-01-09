Return-Path: <bpf+bounces-48412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB55A07CCC
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 17:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF069188C6D2
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553BA21D5B0;
	Thu,  9 Jan 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2Pocp/D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C0249E5;
	Thu,  9 Jan 2025 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438609; cv=none; b=nXUv/8ucwwpNibtbUlL0yBEeYcGPJVjMczVX3CJPZIrh4ep6Qu1Ac2/vrrBftA3xIZ4/2li4CnRoC+XZMr7Vkf6OPo+6i57LvrEYe8LxKLSqcJVHKnTLaMHIKZjtEuvMAmfpD46vhN7GhrB3krv0zNmLcrRQpT2hCc77t44CvT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438609; c=relaxed/simple;
	bh=MeRpIz07IO3DB6Ldz84dGTdMhtVBjunWM8RIYG1CZDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgJSv4oeHOZfPaXQKXB8tyEk3ZjOk+b7XAsLa6vxWmNJQGoMMPSVdvSi6ZpMzPwqLRKFBSeLDgGVe1U+CZy3nnJkLbsXUyUckmCH+oOrlmsJCevmjRvafnyf/HHPSMLXUscGNp3oJ7h8zujlWs5rBX0aH8AVZ9yq7zhmgT9/TQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2Pocp/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E3DC4CED3;
	Thu,  9 Jan 2025 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736438609;
	bh=MeRpIz07IO3DB6Ldz84dGTdMhtVBjunWM8RIYG1CZDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g2Pocp/D7ATfHqlN++yZr2YQ2pFNHk7+D97yBWrGkQNdjriYrXijXjq7eEfqNxPWU
	 gBgac0p5Y3kmvE9xVndfsd2BNgR8Gj0BT0Yf9Y7TxCQHuptOdxjDOvWbLglrYFoX++
	 n2P3KIbUzwWALrY1OnRLxTOjnhmsjpl0Tqg1NzOSzLAjS6jMJNJJEl7DTA4aBDdwZB
	 INnyhsIX+ILceH+MkpOvenfwzYhx5JbLNeNeVBjG/Wu6Y+2w4xYm8r3g1wt3meY0yx
	 oT8Wc7Cj7M5GSxbVfAOq50JHRWdskC4/iA2wYdAL8GFPC+VrgHUaCADEiMiFfOgqMR
	 /4vk9pZuv3bTA==
Date: Thu, 9 Jan 2025 13:03:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org,
	eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] dwarves: set cu->obstack chunk size to 128Kb
Message-ID: <Z3_zTvfgnOt-fhLZ@x1>
References: <20241221030445.33907-1-ihor.solodrai@pm.me>
 <92a6a095-3a49-4204-af49-643f2db1e3a9@oracle.com>
 <Xfd2PxigaipLv392tfxKUdgwxRMdn9bMsaq4GCJxbX7DooxvxfZAtJceZkZVk14GHODh0twQw598iFTBaYkZ8mJxTCfEhi7S9WgB54C0zN4=@pm.me>
 <bf09b28d-e1b6-4de8-8eb2-410b017679ff@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf09b28d-e1b6-4de8-8eb2-410b017679ff@oracle.com>

On Wed, Jan 08, 2025 at 05:22:56PM +0000, Alan Maguire wrote:
> On 08/01/2025 16:38, Ihor Solodrai wrote:
> > On Wednesday, January 8th, 2025 at 5:55 AM, Alan Maguire <alan.maguire@oracle.com> wrote:
> > 
> >>
> >>
> >> On 21/12/2024 03:04, Ihor Solodrai wrote:
> >>
> >>> In dwarf_loader with growing nr_jobs the wall-clock time of BTF
> >>> encoding starts worsening after a certain point [1].
> >>>
> >>> While some overhead of additional threads is expected, it's not
> >>> supposed to be noticeable unless nr_jobs is set to an unreasonably big
> >>> value.
> >>>
> >>> It turns out when there are "too many" threads decoding DWARF, they
> >>> start competing for memory allocation: significant number of cycles is
> >>> spent in osq_lock - in the depth of malloc called within
> >>> cu__zalloc. Which suggests that many threads are trying to allocate
> >>> memory at the same time.
> >>>
> >>> See an example on a perf flamegraph for run with -j240 [2]. This is
> >>> 12-core machine, so the effect is small. On machines with more cores
> >>> this problem is worse.
> >>>
> >>> Increasing the chunk size of obstacks associated with CUs helps to
> >>> reduce the performance penalty caused by this race condition.
> >>
> >>
> >> Is this because starting with a larger obstack size means we don't have
> >> to keep reallocating as the obstack grows?
> > 
> > Yes. Bigger obstack size leads to lower number of malloc calls. The
> > mallocs tend to happen at the same time between threads in the case of
> > DWARF decoding.
> > 
> > Curiously, setting a higher obstack chunk size (like 1Mb), does not
> > improve the overall wall-clock time, and can even make it worse.
> > This happens because the kernel takes a different code path to allocate
> > bigger chunks of memory. And also most CUs are not big (at least in case
> > of vmlinux), so a bigger chunk size probably increases wasted memory.
> > 
> > 128Kb seems to be close to a sweet spot for the vmlinux.
> > The default is 4Kb.
> >
> 
> Thanks for the additional details!
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

I'm adding these details and your reviewed-by tag to that cset.

Thanks!

- Arnaldo

