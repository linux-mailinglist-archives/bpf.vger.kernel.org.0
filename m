Return-Path: <bpf+bounces-42599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB49A6516
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAE11F225D2
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 10:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E96B1F5846;
	Mon, 21 Oct 2024 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MwoAI8l5"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2621EBA17;
	Mon, 21 Oct 2024 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507701; cv=none; b=Z4UliePByGI4d2tWdVb4eEDiEVdSpZ4Gp4dUFIwsV4/fbAKaaqAI5YkaRmBYRh+mFE8eUDtMfhootwjCUGBz4wxe56hcl3ViXEfKY9LKCWSjlKUjCQ8eibgjPZuqCRwuzXA7Itwea7EJt6hug4lZk6XB3zRA7DSK9F108fRSc+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507701; c=relaxed/simple;
	bh=Po2snFgeTrzgadxSlfIpIeFgxFSFGjUIBP2VrnUvZI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzpJ4znbMGVDXY5DujlpIQfwRtrfTjEugC0hZgwb/E7AQvkL5h3fgD74v4VTNONQrEfmfR3CWj8398yzo/imtJKaeEMb31GyTHXOMoIG7cXZlGEAYmzKdc9kitsGGNT2K2ZrZxeeWl2HT7tJll/WLSsmxbz6X4W44x12MXH8SZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MwoAI8l5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XJWSXDEmTz10iT7O0Zf08zwnUMKpBRU/Y+jJiekO3bk=; b=MwoAI8l5epAYqpSlT2cz4vWB4k
	zdlEE+AwQcCYSnta1RjpMCw/ZHNlAbzUyb9FhZ2nkWcr21MrGummeFi7s17GEto6lm4JQmUhx1ahP
	9RjKOghZzq00Z/ahNdIcQ35E4Pad6feHEcAw2j3nMQBofPwYRMoTyCcYnn58O4inXmZo3hPVhu54y
	3rTtZ8il+AfjsRW4GzpHqxuoC9RqA+BW2SknPwiHfy8U4TltqD5Q3TcFrPOqdEvO4UYRBz4t4/9Lb
	N+ZZvYlYxoEJm+PKlDuohbcjhJHPsKeFGVWgMFlZ1az+O9Kt2C+0t3VnIMsJ0tirPEQJ8VUKOLl48
	2egPlGjw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t2pxP-00000007tNc-2GyP;
	Mon, 21 Oct 2024 10:48:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3251730073F; Mon, 21 Oct 2024 12:48:15 +0200 (CEST)
Date: Mon, 21 Oct 2024 12:48:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mingo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v2 tip/perf/core 2/2] uprobes: SRCU-protect uretprobe
 lifetime (with timeout)
Message-ID: <20241021104815.GC6791@noisy.programming.kicks-ass.net>
References: <20241008002556.2332835-1-andrii@kernel.org>
 <20241008002556.2332835-3-andrii@kernel.org>
 <20241018101647.GA36494@noisy.programming.kicks-ass.net>
 <CAEf4BzZaZGE7Kb+AZkN0eTH+0ny-_0WUxKT7ydDzAfEwP8cKVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZaZGE7Kb+AZkN0eTH+0ny-_0WUxKT7ydDzAfEwP8cKVg@mail.gmail.com>

On Fri, Oct 18, 2024 at 11:22:09AM -0700, Andrii Nakryiko wrote:

> > So... after a few readings I think I'm mostly okay with this. But I got
> > annoyed by the whole HPROBE_STABLE with uprobe=NULL weirdness. Also,
> > that data_race() usage is weird, what is that about?
> 
> People keep saying that evil KCSAN will come after me if I don't add
> data_race() for values that can change under me, so I add it to make
> it explicit that it's fine. But I can of course just drop data_race(),
> as it has no bearing on correctness.

AFAICT this was READ_ONCE() vs xchg(), and that should work. Otherwise I
have to yell at KCSAN people again :-)

> > And then there's the case where we end up doing:
> >
> >   try_get_uprobe()
> >   put_uprobe()
> >   try_get_uprobe()
> >
> > in the dup path. Yes, it's unlikely, but gah.
> >
> >
> > So how about something like this?
> 
> Yep, it makes sense to start with HPROBE_GONE if it's already NULL, no
> problem. I'll roll those changes in.
> 
> I'm fine with the `bool get` flag as well. Will incorporate all that
> into the next revision, thanks!
> 
> The only problem I can see is in the assumption that `srcu_idx < 0` is
> never going to be returned by srcu_read_lock(). Paul says that it can
> only be 0 or 1, but it's not codified as part of a contract.

Yeah, [0,1] is the current range. Fundamentally that thing is an array
index, so negative values are out and generally safe to use as 'error'
codes. Paul can't we simply document that the SRCU cookie is always a
positive integer (or zero) and the negative space shall not be used?

> So until we change that, probably safer to pass an extra bool
> specifying whether srcu_idx is valid or not, is that OK?

I think Changeing the SRCU documentation to provide us this guarantee
should be an achievable goal.

> (and I assume you want me to drop verbose comments for various states, right?)

I axed the comments because I made them invalid and didn't care enough
to fix them up. If you like them feel free to amend them to reflect the
new state of things.

