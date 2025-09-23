Return-Path: <bpf+bounces-69297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3337B939E0
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF573A4440
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 23:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571782FFFB2;
	Mon, 22 Sep 2025 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ksO/eRpK"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804C2DEA6F
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584404; cv=none; b=dQfDCRHh8IE0YxQjwL2kbXXAC9eauUaWhmj/Ato9cbflDb98hwBoWj0Qwaj4JxvlXTVZbknjtpkQLwmC030/WxJZXvBdSrRmwcfZ8OWf1z8wyRCc4oO3DBmkxg+2iuPaZ60ubtTuY7sThtwAVJH2ffMNomDR5KgPE2XFveClv7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584404; c=relaxed/simple;
	bh=nQ+nJKAqfH3akqIipGSES3PuSwYbGJnWEeN3gYAiKTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy6qsP1CAQiRZLdVp7SC5H7uK411eM5WR2x9qmJpcPs28nClb0TYPgtJFkmwZEQUjNZ5XXuQvrzTKqRSoiTskrqVCrC+y9Nxyj1QOvzScv3Yp6tGOJ+bWqBVb/xVDHMabknSkECf2nPllwXOBRrI4G/9dpRDHY0Vr0LVvrQHPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ksO/eRpK; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Sep 2025 16:39:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758584401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6UQ6EfbCYepok3ceoUDeJ/x6bFVJ/E+q/zzBwjTLLp4=;
	b=ksO/eRpKDXXynNESrLmMo1u81CH/LwY9blsXfMRvkA6O6cPUQuZ0v5Nzq6INeIbeJcqmbI
	Bv6aLttCnAEx2rrt/l3Qumlpjdp4ukS+cXgCd5odAtNGUWw7827V3Noc4C076aDAEus9Lh
	zY5U6BKC5S3WXSc1AeIrIIDLwp/lrOA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Peilin Ye <yepeilin@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] memcg: skip cgroup_file_notify if spinning is not
 allowed
Message-ID: <552lz3qxc3z45r446rfndi7gx6nsht5iuhrhaszljofka2zrfs@odxfnm2blgdd>
References: <20250922220203.261714-1-shakeel.butt@linux.dev>
 <20250922160443.f48bb14e2d055e6e954cd874@linux-foundation.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922160443.f48bb14e2d055e6e954cd874@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 22, 2025 at 04:04:43PM -0700, Andrew Morton wrote:
> On Mon, 22 Sep 2025 15:02:03 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
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
> > 
> > Alternative approach was also explored where instead of skipping
> > cgroup_file_notify(), we defer the memcg event processing to irq_work
> > [1]. However it adds complexity and it was decided to keep things simple
> > until we need more memcg events with !allow_spinning requirement.
> > 
> > Link: https://lore.kernel.org/all/5qi2llyzf7gklncflo6gxoozljbm4h3tpnuv4u4ej4ztysvi6f@x44v7nz2wdzd/ [1]
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Fixes a possible kernel deadlock, yes?
> 
> Is a cc:stable appropriate and can we identify a Fixes: target?
> 
> Thanks.
> 
> (Did it ever generate lockdep warnings?)

The report is here:
https://lore.kernel.org/all/20250905061919.439648-1-yepeilin@google.com/

I am not sure about the Fixes tag though or more like which one to put
in the Fixes as we recently started supporting memcg charging for NMI
context or allowing bpf programs to do memcg charged allocations in
recursive context (see the above report for this recursive call chain).
There is no single commit which can be blamed here.

Alexei, what do you suggest? 

