Return-Path: <bpf+bounces-68243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DA1B5555B
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 19:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1A5564F83
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02C6322764;
	Fri, 12 Sep 2025 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ClJw3EoD"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162CB30DED0
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757697096; cv=none; b=Z8/eVTqxAhxeRprT4aaSHK4K5pKLf+fxgvJfroQRCkQsbwEiNRRr8BwyEE3jbksokClck+xKKidlXD2jCV4s4Ej0CTNtMOAMzr6eCYpg+dPvmnYpIrA9tPYJ5IYi0/WZ0VpnKpZkiHPouoibCrEnjnySeqIxPDmZSecGNupsIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757697096; c=relaxed/simple;
	bh=kBOfHaEF+9DmzgdGslS80I9ygBpyMgBNcGR+lin5cl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeSe76ftVTnitzkJiGULMH2V+6Y5i10j8bs+PcWI8aHolh3q5L6k8EpS78qcYzbCoanUFvDMjPW4J7US0vlgHqeoMRBN8IrEe0tCsS1UUxxkASK1LcHZB/aBhGBUioQ6rj6qos7F9p3+PZqEsGYsMBuDM9ybOnuUcPc7ROwC6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ClJw3EoD; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Sep 2025 10:11:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757697092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fprCWGn72VE9DuQaJWojr/ZxTVZimbI5m22jocZ+qDU=;
	b=ClJw3EoDyXV0Db4RAP6KAaSaVee5vTxBuC9Xd1u/SBoRtBYB95Y0Y7PdoN3blzQ1jXpx9A
	WSxQTHeXiSloZevivPW7hITq9jvrmG1tdtHMcg368eaBRS83/WruYXKDrz6qH4coIBHgHe
	zwaAcjCgzjbD8Qcjp1zz8qEP4V6TuZs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz, 
	harry.yoo@oracle.com, mhocko@suse.com, bigeasy@linutronix.de, andrii@kernel.org, 
	memxor@gmail.com, akpm@linux-foundation.org, peterz@infradead.org, 
	rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH slab v5 2/6] mm: Allow GFP_ACCOUNT to be used in
 alloc_pages_nolock().
Message-ID: <2kaahuvnmke2bj27cu4tu3sr5ezeohra56btxj2iu4ijof5dim@thdwhzjjqzgd>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-3-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909010007.1660-3-alexei.starovoitov@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 08, 2025 at 06:00:03PM -0700, Alexei Starovoitov wrote:
[...]
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d1d037f97c5f..30ccff0283fd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7480,6 +7480,7 @@ static bool __free_unaccepted(struct page *page)
>  
>  /**
>   * alloc_pages_nolock - opportunistic reentrant allocation from any context
> + * @gfp_flags: GFP flags. Only __GFP_ACCOUNT allowed.

If only __GFP_ACCOUNT is allowed then why not use a 'bool account' in the
parameter and add __GFP_ACCOUNT if account is true?

>   * @nid: node to allocate from
>   * @order: allocation order size
>   *
> @@ -7493,7 +7494,7 @@ static bool __free_unaccepted(struct page *page)
>   * Return: allocated page or NULL on failure. NULL does not mean EBUSY or EAGAIN.
>   * It means ENOMEM. There is no reason to call it again and expect !NULL.
>   */

