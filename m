Return-Path: <bpf+bounces-60748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D0FADBAA0
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 22:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F63C3B576A
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 20:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A191898E8;
	Mon, 16 Jun 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZQ3dcc5k"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010292868B7
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104810; cv=none; b=g+RyZjzzOrQMLSLObVFuz8gM4+R7Jj9HUJrIINcJH3ajU3Y8wi9440qikWa2lZ0t04JzEGdI5TAqcg8E7wmkdzgt5R0F1zFpL12ySMe1GosZsgQ8fGlkhEky2UT0tBRy6qanwAUcjap8PCsKzZjybhnwJ1OYA4nJjVQyK+q3n9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104810; c=relaxed/simple;
	bh=ls4VGECiCBtg2JlEG7yNXWSKEOGCxJcawxWh97L01Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekN2R4bIR8w9Gh6FGzf0RFurYZTfADQ+SMO7JeuEoeXsSBoKcURvQpdI/kkpxLvpbNl9C9Q/q/67qVcX/v1H455mwLMia4mqFfKsPR69AFmvGf2TOAt74CRamh8tesA5psyyDmoysoq7WclJ1o8haZSAyEzMdt1HpUM6CmG1DgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZQ3dcc5k; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 16 Jun 2025 13:13:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750104806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7sWRkpC4J/fwZ8hiPeG9n9Tg+PgJKdAZANW52vn8x6Y=;
	b=ZQ3dcc5kh6ona5ww/0k7/JsyT8NLs1JyZaMkcZsHB8MCT7NnZx9bcpaIRCYtFp4nCcIwk0
	+ra73movQM5WaTKViT6cCTci195lS0YRX0dS53qVXMs5qfy0UNo4dx2kMkqRylshivfGhu
	KDTh3eVjr0zGjK3bY08lspkLe6PKVXg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2 0/4] cgroup: nmi safe css_rstat_updated
Message-ID: <nv7p4v6jpc7fc4dw6by4dqciqcfkzqtt74enyymx7s764f2dce@o5xlm5njrvwo>
References: <20250611221532.2513772-1-shakeel.butt@linux.dev>
 <218e8b26-6b83-46a4-a57c-2346130a1597@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218e8b26-6b83-46a4-a57c-2346130a1597@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 16, 2025 at 01:08:49PM -0700, JP Kobryn wrote:
> On 6/11/25 3:15 PM, Shakeel Butt wrote:
> > BPF programs can run in nmi context and may trigger memcg charged memory
> > allocation in such context. Recently linux added support to nmi safe
> > page allocation along with memcg charging of such allocations. However
> > the kmalloc/slab support and corresponding memcg charging is still
> > lacking,
> > 
> > To provide nmi safe support for memcg charging for kmalloc/slab
> > allocations, we need nmi safe memcg stats because for kernel memory
> > charging and stats happen together. At the moment, memcg charging and
> > memcg stats are nmi safe and the only thing which is not nmi safe is
> > adding the cgroup to the per-cpu rstat update tree. i.e.
> > css_rstat_updated() which this series is doing.
> > 
> > This series made css_rstat_updated by using per-cpu lockless lists whose
> > node in embedded in individual struct cgroup_subsys_state and the
> > per-cpu head is placed in struct cgroup_subsys. For rstat users without
> > cgroup_subsys, a global per-cpu lockless list head is created. The main
> > challenge to use lockless in this scenario was the potential multiple
> > inserters from the stacked context i.e. process, softirq, hardirq & nmi,
> > potentially using the same per-cpu lockless node of a given
> > cgroup_subsys_state. The normal lockless list does not protect against
> > such scenario.
> > 
> > The multiple stacked inserters using potentially same lockless node was
> > resolved by making one of them succeed on reset the lockless node and the
> > winner gets to insert the lockless node in the corresponding lockless
> > list. The losers can assume the lockless list insertion will eventually
> > succeed and continue their operation.
> > 
> > Changelog since v2:
> > - Add more clear explanation in cover letter and in the comment as
> >    suggested by Andrew, Michal & Tejun.
> > - Use this_cpu_cmpxchg() instead of try_cmpxchg() as suggested by Tejun.
> > - Remove the per-cpu ss locks as they are not needed anymore.
> > 
> > Changelog since v1:
> > - Based on Yosry's suggestion always use llist on the update side and
> >    create the update tree on flush side
> > 
> > [v1] https://lore.kernel.org/cgroups/20250429061211.1295443-1-shakeel.butt@linux.dev/
> > 
> > 
> > Shakeel Butt (4):
> >    cgroup: support to enable nmi-safe css_rstat_updated
> >    cgroup: make css_rstat_updated nmi safe
> >    cgroup: remove per-cpu per-subsystem locks
> >    memcg: cgroup: call css_rstat_updated irrespective of in_nmi()
> > 
> >   include/linux/cgroup-defs.h   |  11 +--
> >   include/trace/events/cgroup.h |  47 ----------
> >   kernel/cgroup/rstat.c         | 169 +++++++++++++---------------------
> >   mm/memcontrol.c               |  10 +-
> >   4 files changed, 74 insertions(+), 163 deletions(-)
> > 
> 
> I tested this series by doing some updates/flushes on a cgroup hierarchy
> with four levels. This tag can be added to the patches in this series.
> 
> Tested-by: JP Kobryn <inwardvessel@gmail.com>
> 

Thanks a lot.

