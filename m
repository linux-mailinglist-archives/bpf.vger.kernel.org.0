Return-Path: <bpf+bounces-60839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6BEADDC84
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 21:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBB017A6D0
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 19:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E882E719A;
	Tue, 17 Jun 2025 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nNiMjqme"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11EA28D8C4
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189149; cv=none; b=NLFPvMhmAOd0dBx5hKvzECTL+I2UrDA28pDAUesnNO7ruThFkfXqLH8+pG9b1mue4qqd2SyifS+iuaOFAlYV0IteweWA4zk0FVHSCXqhT9vNhRiZ8u5htVIvTUi38mn2TCI0h5bdUjTBj6y/6TJPgwIdD5FaLfC3XwIDPDvX5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189149; c=relaxed/simple;
	bh=T6/GPJUaE5MWO1xJYkdWZ+ZjWpepTkI5T3JAT7p2KUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLIRVz0iQZWf+4WRz3KDHIvcXKfzz1ckC42LLfwz5yfuacx/TPZsVnUm0Ft2IAzUIOCj1tpyxSqMi5+kgtfvh5uk60e/7uAOzbwQ94afdnhGtCiZwZn60zXEufrkC5N0QaxobmZ1NNXW4vLQhPHpYWsUhl3X8F62Z1Q9t+sX+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nNiMjqme; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 17 Jun 2025 12:38:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750189135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4glMiMkHgRFcU3DsIIfl2zw2C365sdHCF6BOHGpWlxw=;
	b=nNiMjqmeytdSt1NSBO5GH+jC1MrgK7NYBOn2uyEclOXBjXHdzP25+sRv/P2PRE5rEyZ2q0
	iGPJUFqtq+6LpgyKNtZXmdoJu8jXYcuvKcVSdzMuZjVtwwSxZyKhXth4/55VePAC7lo1MI
	TSu8dvgo7qJow0bSx72Tg6xP6XI1jZY=
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
Message-ID: <rnbk6cnvkvpdaei7zhtgcmzw3cbokmbgt6qnorf5cpey5ievlq@yffgq4oslnvv>
References: <20250611221532.2513772-1-shakeel.butt@linux.dev>
 <aFBfNRVAyE1FU9aQ@slm.duckdns.org>
 <qtudjvrdvbsz6rrygb5bt32dzps6ocwefhr5hyfgtam65jowdo@colgnna6ogqm>
 <aFG8mZOOwl9s5ySm@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFG8mZOOwl9s5ySm@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 17, 2025 at 09:06:01AM -1000, Tejun Heo wrote:
> On Mon, Jun 16, 2025 at 12:20:28PM -0700, Shakeel Butt wrote:
> > On Mon, Jun 16, 2025 at 08:15:17AM -1000, Tejun Heo wrote:
> > > Hello,
> > > 
> > > On Wed, Jun 11, 2025 at 03:15:28PM -0700, Shakeel Butt wrote:
> > > > Shakeel Butt (4):
> > > >   cgroup: support to enable nmi-safe css_rstat_updated
> > > >   cgroup: make css_rstat_updated nmi safe
> > > >   cgroup: remove per-cpu per-subsystem locks
> > > >   memcg: cgroup: call css_rstat_updated irrespective of in_nmi()
> > > 
> > > The patches look good to me. How should it be routed? Should I take all
> > > four, just the first three or would it better to route all through -mm?
> > > 
> > 
> > I would like all four to be together and since most of the code is in
> > cgroup, cgroup tree makes more sense unless Andrew has different
> > opinion.
> 
> Okay, I'll route them through cgroup. The patches don't apply cleanly on
> cgroup/for-6.17. Can you please send a refreshed set?

Yup, I will do asap.

