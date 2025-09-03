Return-Path: <bpf+bounces-67344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36289B42B2A
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 22:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D28168A26
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 20:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6C83019B3;
	Wed,  3 Sep 2025 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkQi/ZnA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCA128CF50;
	Wed,  3 Sep 2025 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932083; cv=none; b=W/T2LujknmRnX0Z1/NxYKASWOi1U8X0tNodxfD0xwLg3JKlK4F0gqJzoGEQK8msKBSAz+yaz7pYsaKGPgi6zRl9XgFeFeqktJgA4nF9Xmq881pl7uHepTMCF2G+kLel6PONMqhhheRWCJe4rqvQHsEz4x9p5eU8YUuu3Wnz/6OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932083; c=relaxed/simple;
	bh=awJ5ekaSn/np8rb2X9ETbHDafqUhUp5JucDgif5oFhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c335u0a8DzYtBBjro7lSTbvjNf4nV8LHtdYd/5Jq6aVcWoaBt8KTCkXcV0WN0spyW3bCHiMa2c/mfJFmghNi8swuTlJN9z4gj+rOvncZgcSrMxl1UdC5mjiCQ3H3+UhNEhE0gzVdhP0WIim9o/spRWcdcSjPVw1qVuviU8p0NuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkQi/ZnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDC1C4CEE7;
	Wed,  3 Sep 2025 20:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932082;
	bh=awJ5ekaSn/np8rb2X9ETbHDafqUhUp5JucDgif5oFhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkQi/ZnAGxjji9uEM2T8wA9OCC8J6mFlgkr0aRspn0XNyWMlsyWmMPC6R8mwXLQxX
	 JJW2Ge37HAWqw3feyFcKAbIMYq/B9KiyEAm2NUzoZTr4NeVIZjeqwvpy3JV2SbpUgb
	 g4e0bbsR3/FBETj/k3eg3Yfbc9RUpqZ3I0ebEbYa0L/Seg9+HuRVfr9tI7xRhZMB0R
	 IkDe+0YLx3ApwHkNitRoEhRyQoAmBf+I6waB9kQnZ2wxtmj/ztcueWFzw393P95CGs
	 Viq4RBU7m7O+LcQKn2eufZOzNfgffUQLrCVNhLtaKL8NAHPwWJI48LJYe3RsmjmBIH
	 RGAVCjUyHEB4Q==
Date: Wed, 3 Sep 2025 10:41:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 07/16] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aLin8VayVsYyKXze@slm.duckdns.org>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-8-arighi@nvidia.com>
 <aLidEvX41Xie5kwY@slm.duckdns.org>
 <20250903200822.GO4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903200822.GO4067720@noisy.programming.kicks-ass.net>

Hello,

On Wed, Sep 03, 2025 at 10:08:22PM +0200, Peter Zijlstra wrote:
> > I'm a bit confused. This series doesn't have prep patches to add @rf to
> > dl_server_pick_f. Is this the right patch?
> 
> Patch 14 seems to be the proposed alternative, and I'm not liking that
> at all.
> 
> That rf passing was very much also needed for that other issue; I'm not
> sure why that's gone away.

Using balance() was my suggestion to stay within the current framework. If
we want to add @rf to pick_task(), that's more fundamental change. We
dropped the discussion in the other thread but I found it odd to add @rf to
pick_task() while disallowing the use of @rf in non-dl-server pick path and
if we want to allow that, we gotta solve the race between pick_task()
dropping rq lock and the ttwu inserting high pri task.

Thanks.

-- 
tejun

