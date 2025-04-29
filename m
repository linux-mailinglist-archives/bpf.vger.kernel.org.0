Return-Path: <bpf+bounces-56981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B618AAA395D
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 23:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 778B27AE484
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 21:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1B225E47D;
	Tue, 29 Apr 2025 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RpoLWHj9"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5695E22A7ED
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 21:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962306; cv=none; b=ckd6ozm63ArA9850JT1+8CSCV9rjuCnTUcu+G1L1ypcQVLCqj4EexhKSLiXla83Bk9J8IC+Mkjmn9bymXLx9N0XBKvMCLtHoYzs5mPJEnJG9jOTWi31MzyQyi/fhU4E5r2x33AyD7y2tCInVPENK4hmFlzAGCIW4JKdDxEcKevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962306; c=relaxed/simple;
	bh=wNAc4aowVByIQ1+NzBaNnltNXcSYmk8rJfuBWl1IJ+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEGcP3H4tbUurUcTnliXqriG3w9taKyUirp6XBVXi57w8ccMGKDlYA8yt43i3tGWvXcv1pTopy5JkKKPAbx0EAj2iOyviIdtiJWgL0jEEVdgvaoBzjZcOAZ8xBk+NqwgxmWVCwY4DD/z8MBKNv/agxezpyVVd3kIyxsszPJwi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RpoLWHj9; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 29 Apr 2025 21:31:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745962301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhK44/8Ys5iZS1I95Gpf9TqiXTQ03StabhU2aIbnGz0=;
	b=RpoLWHj9v72jkc+SsJKuznsirnepqqaYc4rnWbmg6qDrd5FNw/0Sv63lIssnA/dSZrIuF6
	4Vh2ibWZ0VBPVCkglXEto1ilSA2wLvA1cTnU1hVqEeOJ3kuCmRavlPYIqyFm5wN4ZMURRr
	nRjYlZqWCQ2NLIySrECZzILAU3jkntI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>, Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH rfc 10/12] mm: introduce bpf_out_of_memory() bpf kfunc
Message-ID: <aBFFNyGjDAekx58J@google.com>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
 <20250428033617.3797686-11-roman.gushchin@linux.dev>
 <aBC7_2Fv3NFuad4R@tiehlicka>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBC7_2Fv3NFuad4R@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 29, 2025 at 01:46:07PM +0200, Michal Hocko wrote:
> On Mon 28-04-25 03:36:15, Roman Gushchin wrote:
> > Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
> > an out of memory events and trigger the corresponding kernel OOM
> > handling mechanism.
> > 
> > It takes a trusted memcg pointer (or NULL for system-wide OOMs)
> > as an argument, as well as the page order.
> > 
> > Only one OOM can be declared and handled in the system at once,
> > so if the function is called in parallel to another OOM handling,
> > it bails out with -EBUSY.
> 
> This makes sense for the global OOM handler because concurrent handlers
> are cooperative. But is this really correct for memcg ooms which could
> happen for different hierarchies? Currently we do block on oom_lock in
> that case to make sure one oom doesn't starve others. Do we want the
> same behavior for custom OOM handlers?

It's a good point and I had similar thoughts when I was working on it.
But I think it's orthogonal to the customization of the oom handling.
Even for the existing oom killer it makes no sense to serialize memcg ooms
in independent memcg subtrees. But I'm worried about the dmesg reporting,
it can become really messy for 2+ concurrent OOMs.

Also, some memory can be shared, so one OOM can eliminate a need for another
OOM, even if they look independent.

So my conclusion here is to leave things as they are until we'll get signs
of real world problems with the (lack of) concurrency between ooms.

Thanks

