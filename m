Return-Path: <bpf+bounces-60746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E5AADB97B
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 21:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7632F1749BA
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 19:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D81D289E0F;
	Mon, 16 Jun 2025 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pw6lUFpi"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A84289352
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101650; cv=none; b=Q2+i6ewDXar7BKvwMTwWSaShTdCmsV4qvQqQdC7xSIxlgzDOGxEGZr5mNlBJr3O70b+BjV5GSSRVTMQHSOCrPTFrsTeG6W258iWLUQ7uto49vxPAwly4Fc5E3Lu5CzjDezcUmRuPNh8Y2vZnBkO/CeV0fC3kQsJQ1oDUhwGrOu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101650; c=relaxed/simple;
	bh=HumAqwnOsGSWMa46buCT1W25Zg7tuj/RQxmzzbSfJWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWJrKVTqB6df2zzOwfXEs3/G2QY3RLekQWcFVkqEIbpFwt2YZxbkVG3DKD/FbrBO0qemPG9Tb9FtwohJ/JHXDNFPCI49iBvL6cdx7306mbE1I7s10lqmuo7uqOR3oM/+9pKnMUwvdw0ssBi/81OuTpuntIxKfJhAlnZhZA33HFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pw6lUFpi; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 16 Jun 2025 12:20:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750101637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KCx8G8iB4GFG7YkzRAgMeNEZrvPEgTU8KFH3idAR55g=;
	b=pw6lUFpivOAs6oOemvC5IEw3UOHeLHr5jtTonYoczi8z44yrYDdW+ohDx3uEyy8CzH1j9E
	XKAil2+qZoqJzqkJx80vOoEcpxA62QGV8Me2Vy+G6Bb98Dpmj5xjuo9rIpd/+uiIMShywt
	Wk7SwFw9gmHVHqzSDuAgjqgyApK6Tr0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	JP Kobryn <inwardvessel@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Harry Yoo <harry.yoo@oracle.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2 0/4] cgroup: nmi safe css_rstat_updated
Message-ID: <qtudjvrdvbsz6rrygb5bt32dzps6ocwefhr5hyfgtam65jowdo@colgnna6ogqm>
References: <20250611221532.2513772-1-shakeel.butt@linux.dev>
 <aFBfNRVAyE1FU9aQ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFBfNRVAyE1FU9aQ@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 16, 2025 at 08:15:17AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jun 11, 2025 at 03:15:28PM -0700, Shakeel Butt wrote:
> > Shakeel Butt (4):
> >   cgroup: support to enable nmi-safe css_rstat_updated
> >   cgroup: make css_rstat_updated nmi safe
> >   cgroup: remove per-cpu per-subsystem locks
> >   memcg: cgroup: call css_rstat_updated irrespective of in_nmi()
> 
> The patches look good to me. How should it be routed? Should I take all
> four, just the first three or would it better to route all through -mm?
> 

I would like all four to be together and since most of the code is in
cgroup, cgroup tree makes more sense unless Andrew has different
opinion.

thanks,
Shakeel

