Return-Path: <bpf+bounces-60122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33497AD2AB4
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108157A7E56
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FF822FDE8;
	Mon,  9 Jun 2025 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LdJM2QlN"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFF422DFBB
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749513131; cv=none; b=IAOpS3YWtk+5gJgxLFFoQbw9zRz/geP/5QPBsc4qkqKrF5qZze5ZQbexnf8ZFSZx6FpdFAeIQjY+9T139RvjUDK/A/j+ZYECKdJRdIeDx/tO3UWLhBJuIveqpAR8arhTE7wudUyE52AxBbETV5GbMC6qlojRHuH6lU9lOpESw18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749513131; c=relaxed/simple;
	bh=vihDDAMqKmUVRxdKZjrKueXjwDmzk/jim57DEDHx+8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkQd5UoY8vOnYvHdRsAbvbWkPMP4OnQHntgDfadb8hLDL6QKRo4vHn+DTYVnuofHBLXho6sL/EvRMgO1oB7CNnM48eQ3Osp6c/covubzecgMeSz9JhZkmLivii5Zz5P4Fhr3EpPwmJ4hL61lXv+JHwiUqtlxfUvQ+Nt73lC2lew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LdJM2QlN; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 9 Jun 2025 16:51:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749513126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lzo9g2TSKLGhlAF46FcJkUjIC675R2K5Fg1wL+YboY0=;
	b=LdJM2QlN8l+PFvlzGS/Rl7lZYqAp9TELewCtLKU5A7OIKsbA+KTvczBT0xkcoLUlG+/3I6
	LdAQlM3t6okehwPt5Rg0IQjfHk8ttjtejs4q5G5f3cWwCpOG0y5dJSv8ePtEpvf59C27jU
	5NlFhP+WzCjxq/MCCsn5FSxKL+DvbMw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Harry Yoo <harry.yoo@oracle.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/3] cgroup: nmi safe css_rstat_updated
Message-ID: <u54tfpwnirzpthvvynkw2dpn7rqtv6nwlllizf4yhadltupv34@3466il3qbfib>
References: <20250609225611.3967338-1-shakeel.butt@linux.dev>
 <20250609164410.568fd70e6a1deb6556e25af7@linux-foundation.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609164410.568fd70e6a1deb6556e25af7@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 09, 2025 at 04:44:10PM -0700, Andrew Morton wrote:
> On Mon,  9 Jun 2025 15:56:08 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > BPF programs can run in nmi context and may trigger memcg charged memory
> > allocation in such context. Recently linux added support to nmi safe
> > page allocation along with memcg charging of such allocations. However
> > the kmalloc/slab support and corresponding memcg charging is still
> > lacking,
> > 
> > To provide nmi safe support for memcg charging for kmalloc/slab
> > allocations, we need nmi safe memcg stats and for that we need nmi safe
> > css_rstat_updated() which adds the given cgroup state whose stats are
> > updated into the per-cpu per-ss update tree. This series took the aim to
> > make css_rstat_updated() nmi safe.
> > 
> > This series made css_rstat_updated by using per-cpu lockless lists whose
> > node in embedded in individual struct cgroup_subsys_state and the
> > per-cpu head is placed in struct cgroup_subsys. For rstat users without
> > cgroup_subsys, a global per-cpu lockless list head is created. The main
> > challenge to use lockless in this scenario was the potential multiple
> > inserters using the same lockless node of a cgroup_subsys_state which is
> > different from traditional users of lockless lists.
> > 
> > The multiple inserters using potentially same lockless node was resolved
> > by making one of them succeed on reset the lockless node and the winner
> > gets to insert the lockless node in the corresponding lockless list.
> 
> And what happens with the losers?

Losers can continue their normal work without worrying about this
specific insertion. Basically we need one successful insertion. In
addition this is a contention between process context, softirq, hardirq
and nmi on the same cpu for the same cgroup which should be very
unlikely.

