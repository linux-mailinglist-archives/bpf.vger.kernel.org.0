Return-Path: <bpf+bounces-67624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D173B46588
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF091C817B5
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3E02C3770;
	Fri,  5 Sep 2025 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="voEmRble"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4815AE55A
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107883; cv=none; b=iNM5Rk1PwtrnLe+seSMphvqvekk/PT/YEp/nEwgHZRjXZs38KHqXvcgYSaVZkmWtMs/y5p/xzrS7HW638jjX+83e8ns/fNtzKeacwZHGJYt2hmh6byQKUF4fv1y7Jj2/WNl148/TGIvf9rDvSGCXZm1TKvCZdAqJ6lICIEjrNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107883; c=relaxed/simple;
	bh=O1QlZOpxn2e4JbweuBX+CLtUVDe61DRgQomhWgdN20s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0jS8tG2+i1XLLg/bQsLfPYMlQtNBfluZGolWJL+dU9orcGY2Ji+2wA1NUxdySuEhOsO1by4IE6XFK7CtfW5rcwSeAeerBBxwSnSSMC1XpXrIijm3PuIvLRiePxu7C8zWHGdw+TVu7vJNrCI3PRBiopVjQnGWQXTuFMjhkJdv7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=voEmRble; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Sep 2025 14:31:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757107879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RFQUguBVJMx+l4CUkTr7CK43jPG6OXp0+p67IT5nXMo=;
	b=voEmRblefBXMxz3/aRw61YL39gF+K4+3bqkAdIgzpUcJeINfDp+Ef2SjC/9GndUwbRNl3I
	3GjnzzdPeWH0FaYq7EoXMcvDWPFesvQ9XHU/tJMv7wB1CZ3hXohp3VPsJ4nxtBGhwae0pY
	KQyV7A0uv54NDMEhzag/JNNs22cMcSs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Peilin Ye <yepeilin@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <mai3ndkvqrpkfpblkazbyejvpkizrp7dh22374tpkmepfji32o@3troawzsuvqe>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <87y0qsa95d.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0qsa95d.fsf@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 05, 2025 at 02:20:46PM -0700, Roman Gushchin wrote:
> Shakeel Butt <shakeel.butt@linux.dev> writes:
> 
> > Generally memcg charging is allowed from all the contexts including NMI
> > where even spinning on spinlock can cause locking issues. However one
> > call chain was missed during the addition of memcg charging from any
> > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > cgroup_file_notify().
> >
> > The possible function call tree under cgroup_file_notify() can acquire
> > many different spin locks in spinning mode. Some of them are
> > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> > just skip cgroup_file_notify() from memcg charging if the context does
> > not allow spinning.
> 
> Hmm, what about OOM events? Losing something like MEMCG_LOW doesn't look
> like a bit deal, but OOM events can be way more important.
> 
> Should we instead preserve the event (e.g. as a pending_event_mask) and
> raise it on the next occasion / from a different context?
>

Thanks for the review. For now only MAX can happen in non-spinning
context. All others only happen in process context. Maybe with BPF OOM,
OOM might be possible in a different context (is that what you are
thinking?). I think we can add the complexity of preserving the event
when the actual need arise.

