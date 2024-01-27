Return-Path: <bpf+bounces-20488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D881783EF56
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 18:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A3FB223FC
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 17:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BE22E40B;
	Sat, 27 Jan 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BPHwnowD"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0862E40A
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706378274; cv=none; b=bAcQaiqP6Rs6i7HDs/taSg7hRJPIbTewsLC9vgmmk1cXSzcAz/JTgJfB7qxrpTzqH4cM+t/e9glIClOkhgHy9SOQyThtOoYsc84K6PxExKWrkD1odqnlWk+lWvrONhUzxDVj4jq+lU+uXY/jBGA9ZJTGgrhwHEKJrB0fSgAEcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706378274; c=relaxed/simple;
	bh=ktNUOSofe+sjnToKDlcSg8jneSeLtU3Xkt2laummbqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ql3kYWneLGcKJ5u3tGYoQtL+VkM/R7pWh+L6V3rBEM723kQuYzHOPp3XQJp+68lRO0i3H5wIlYkiSEOnCWOh28Gt5fO3MPlm9GTuA9Wk+rCeE+8Ub0j7aBxHyqKVU2xBxcMnMd0n/TqxDrZU9hHgt0v5tNMY1EZLLGtQXMhE260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BPHwnowD; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 27 Jan 2024 12:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706378269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8FnooJCWSxpBQ7kJMIzkrQtNeGdttnkRA9KqDLumr+o=;
	b=BPHwnowDbG/6r6CMDf/n/61SkvEjYVDhLgXNOaJA00LRzmXdeRPz07+gcZ+jOsDy6VWYQE
	AYvU1rYFNEjCL6IwxbYd7ffEaJ3JTrWQbcpNjsYzZBHI8QqIdQPkgU10XZ1H+ldxBB0NRt
	bk7XNBThQEMD8l6RHs2aDybHQfjhkys=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <yrswihigbp46vlyxqvi3io5pfngcivfwfb3gdlnjs6tzntldbx@mbnrycaujxb3>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 19, 2024 at 04:24:29PM +0000, Matthew Wilcox wrote:
>  - What are we going to do about bio_vecs?

For bios and biovecs, I think it's important to keep in mind the
distinction between the code that owns and submits the bio, and the
consumer underneath.

The code underneath could just as easily work with pfns, and the code
above got those pages from somewhere else, so it doesn't _need_ the bio
for access to those pages/folios (it would be a lot of refactoring
though).

But I've been thinking about going in a different direction - what if we
unified iov_iter and bio? We've got ~3 different scatter-gather types
that an IO passes through down the stack, and it would be lovely if we
could get it down to just one; e.g. for DIO, pinning pages right at the
copy_from_user boundary.

