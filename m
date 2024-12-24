Return-Path: <bpf+bounces-47600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52D69FC28B
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 22:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6E8164D3C
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 21:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E812F19F49E;
	Tue, 24 Dec 2024 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpGftYVK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9CC14A099;
	Tue, 24 Dec 2024 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735075744; cv=none; b=XNgFLsONzoxZrnqdNYQZIXiO5zwSU47MA8q7ZbGSnFBrehq9QENq0N5fny186Gg+hMxBGK4AMJdX1s2OL96gb53CjZ63vIuOQmMVvU4M3T49lYxacaSxKc26dZN8NTgOQf0vvVWagpkBBqyqzeahh0OfbkKHjeWiQGMrDPn3l3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735075744; c=relaxed/simple;
	bh=5+NxKNw1ro8ezob6iU7PBoaUmScg7SvQzfMoCsnHTNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKPmMi4LJ5N90rOLwyjI82Bo0cTMQ5irJrChFTPf3HEb/4ah6ItI2dBOBLm6sAzn1iGWkS3ZX2NX2eDHHcLujhPsdPRR3GGbqw3mQhs6NuZlfmwDdMRFiziOS4kXmcWrbz9TQe9HNtedty+N3EH60gpyxfwE6avYPnFK0Lcdzt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpGftYVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4096C4CED0;
	Tue, 24 Dec 2024 21:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735075743;
	bh=5+NxKNw1ro8ezob6iU7PBoaUmScg7SvQzfMoCsnHTNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpGftYVKRap4lp5SyX8iuRC80HJym40pkphxJ+1d8vYsk0MwT5Sd0rKNd3sOk7Eqv
	 Ksy7UGkNLsCWc1Xbq5L4YZscwqysVCpVzuVa1yxlYLQDYs3XIwRMhoz7qB0AvT+FfU
	 gRz6eocVOpewgV6pAVweQpJN1AlUA13VBg6lCSMAxskLZDiA69X45Z77870lT8cQ5i
	 VGm+IQZlB8O8gHHUR4YwQDjnMSDe2oprTyBpgRnm9ZcfgLj+k7p0iw/sNVz7Pxk3u0
	 6LldAFz/UAC1lXV56yVvk3ox6HEbc+HkboFJT4wv+fU4hfvQ9ghHUPkpE3QEoUcswc
	 nvMyhuGh4e2Bg==
Date: Tue, 24 Dec 2024 11:29:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] sched_ext: idle: introduce SCX_PICK_IDLE_NODE
Message-ID: <Z2snntl5Eze68O6B@slm.duckdns.org>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-9-arighi@nvidia.com>
 <Z2ohDX-F6bvBO3bx@yury-ThinkPad>
 <Z2pvWdwLr86tj_8Q@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2pvWdwLr86tj_8Q@gpd3>

On Tue, Dec 24, 2024 at 09:22:49AM +0100, Andrea Righi wrote:
> > >  enum scx_pick_idle_cpu_flags {
> > >  	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
> > > +	SCX_PICK_IDLE_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */
> > 
> > SCX_FORCE_NODE or SCX_FIX_NODE?
> 
> Ok, I like SCX_FORCE_NODE.

How about SCX_PICK_IDLE_IN_NODE?

Thanks.

-- 
tejun

