Return-Path: <bpf+bounces-67393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D14D9B432A3
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 08:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB0A7C6378
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 06:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F2279335;
	Thu,  4 Sep 2025 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQw6WNVH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C725C27C17F;
	Thu,  4 Sep 2025 06:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967959; cv=none; b=duUiAI76zGrDnxBeDH/xUtATLnC9RAteXDc3flHq74ktOtvdbWbvHTM7avd8a1vxT98H/8N5DL0i+D3yfPR5roTbGX/Zc5mLtVXGcyZ9NIAP3FDJWF8CrBxy++xDZ9gAuc6Fw/pqNg8agEEqUrlC9PCzHb/0omRE3XYyKdu4b3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967959; c=relaxed/simple;
	bh=SVkNgU9FyklxN8vI/1LcwXJJASb8Zw5fwx+daQ223sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SR1c1moRftXo+TkZmfG6vGmr5LVea0nwRo71IrWJGOLDAwUnpeLxd/iuX930EaCBfIISZJ9xdBoDqcXL0u1gZIV5aShTHLpiATHznH72Oa6s7P5TAizZdTH4L0I/NWJ+TtwLX0A8vMnu7vBoPyiWuT0dmRoIRa/akZmeb1uXEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQw6WNVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2CAC4CEF1;
	Thu,  4 Sep 2025 06:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756967959;
	bh=SVkNgU9FyklxN8vI/1LcwXJJASb8Zw5fwx+daQ223sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQw6WNVHoW/KS1hUY15Q0PkslgZvP+TZ1M0hUw53UBYSSKbljQ1nnM/X5n93S/I3A
	 JvAJeGccjuWFWJQr+HI0/ttT5PXEv/1/S7MwOcIp1cgRts8JxIzc7+6q0y68E+vcdQ
	 IjcY6aP5szF66JjI2H3eSBkmcmzqBQMtHtsN14UFsZzEf3F+HhgwA7AtEBxp1e3Cws
	 7c3brDrPJVm2LubAkN2f/JJIGRYImAvfavKx0reOTXi5MQcgHge5XvaLKQvErg5+ta
	 MTTLlDMudFuMVZL8FuyIT24Gvg3/ysOSwrAHHM2x0aF/sDNfhmoJi+9R79XUVpo+Y5
	 LuvIG/EMIUghA==
Date: Wed, 3 Sep 2025 20:39:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
Message-ID: <aLk0FuezkcInlM_r@slm.duckdns.org>
References: <20250818170136.209169-2-roman.gushchin@linux.dev>
 <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev>
 <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
 <87wm6rwd4d.fsf@linux.dev>
 <ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
 <CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
 <87iki0n4lm.fsf@linux.dev>
 <aLeLzWygjrTsgBo8@slm.duckdns.org>
 <87qzwnxgfr.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzwnxgfr.fsf@linux.dev>

Hello,

On Wed, Sep 03, 2025 at 04:30:16PM -0700, Roman Gushchin wrote:
...
> > - I'm passing in cgroup_id as an optional field in struct_ops and then in
> >   enable path, look up the matching cgroup, verify it can attach there and
> >   insert and update data structures accordingly:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/tree/kernel/sched/ext.c?h=scx-hier-prototype#n5280
> 
> Yeah, we discussed this option with Martin up in this thread. It doesn't
> look as the best possible solution, but maybe the best we have at the moment.
> 
> Ideally, I want something like this:
> 
> void test_oom(void)
> {
> 	struct test_oom *skel;
> 	int err, cgroup_fd;
> 
>         cgroup_fd = open(...);
>         if (cgroup_fd < 0)
> 		goto cleanup;
> 
> 	skel = test_oom__open_and_load();
>         if (!skel)
> 		goto cleanup;
> 
> 	err = test_oom__attach_cgroup(skel, cgroup_fd);
> 	if (CHECK_FAIL(err))
> 		goto cleanup;

Yeah, that'd look better but are there practical differences? The only one I
can think of is fs based permission check but that can be done separately
too.

Thanks.

-- 
tejun

