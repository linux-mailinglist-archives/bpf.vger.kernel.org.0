Return-Path: <bpf+bounces-67478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9408CB443BF
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F993BD771
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A6C2F8BD1;
	Thu,  4 Sep 2025 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7M3muTA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3D2212576;
	Thu,  4 Sep 2025 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005113; cv=none; b=QVN+T8G5x6qGRA3bZ3LE3HrjPm96BES9vHY3NiDY2isITB+ib8LFJksyt3WqH7rCDraYHowP7oV9lH/X2cS3eH4QqDwkRhXT0N9zKvGAGVCKKkerNuMhgZsCZtLhFjI8666OMcTpdWbQryoaVfv1p7wTF0gL089vRhRbPldk0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005113; c=relaxed/simple;
	bh=UEa9OQ4jfJH4rBrlyyXkXe7/eodn6/EO6fsvw2kn4z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lf1MhPQY2STxQZi7DeEU/XTYXuCkyKGqiZDSA5vpQGPMxYWzE3bGhQdGfjg696+QKrrARsg5ZXZvWmVzeqm0aCzLD9Y5M8b8S3EYexFxElp1cV9PuvpDJJtdjnNYs1Ebsq2aYuGFxbtCfBe2TPpq/7gGwE7QmQ60M3/O6YotJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7M3muTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA516C4CEF0;
	Thu,  4 Sep 2025 16:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757005112;
	bh=UEa9OQ4jfJH4rBrlyyXkXe7/eodn6/EO6fsvw2kn4z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7M3muTAHD8kpFjXtUyq3zi080/5t6d9tcPFDyt+0GAnhnpvzR/rbfxPHP7UTk/66
	 4ANXrAxnDo+uy+SrKkekWheeh42CvDD5kydArSKGJPRjDhEGumGaz7J8XY3bUTlRZG
	 iDYfV8fgOqejlgb7L3KGjBGrPuX/tQIcK02DLmrAaV0KFl+nqRs1LoopsbmWE3lDEx
	 Il3VJbfTZ2jJAhIFBQTVurI7tVRifvulia3/xJTdPY1JerP2CjTygZCrlGLGuD2pb7
	 zEnXJP8qbxVeY7oVSLiaEs/CyKbUfDGEBEjgkT7vPUcrYyJuVT+cW8Jo63csmm8K96
	 +xTlky2qxWflA==
Date: Thu, 4 Sep 2025 06:58:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
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
Message-ID: <aLnFN-jJkVzL403b@slm.duckdns.org>
References: <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
 <87wm6rwd4d.fsf@linux.dev>
 <ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
 <CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
 <87iki0n4lm.fsf@linux.dev>
 <aLeLzWygjrTsgBo8@slm.duckdns.org>
 <87qzwnxgfr.fsf@linux.dev>
 <aLk0FuezkcInlM_r@slm.duckdns.org>
 <87h5xi1e6p.fsf@linux.dev>
 <CAADnVQLBrOgeH5T2iXa7nNpHTtQvpzuzfOgEgPQv8T_AKEg6mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLBrOgeH5T2iXa7nNpHTtQvpzuzfOgEgPQv8T_AKEg6mQ@mail.gmail.com>

Hello,

On Thu, Sep 04, 2025 at 09:26:45AM -0700, Alexei Starovoitov wrote:
...
> > >>      err = test_oom__attach_cgroup(skel, cgroup_fd);
> > >>      if (CHECK_FAIL(err))
> > >>              goto cleanup;
> > >
> > > Yeah, that'd look better but are there practical differences? The only one I
> > > can think of is fs based permission check but that can be done separately
> > > too.
> >
> > The practical difference is that a single struct ops can be attached
> > to multiple cgroups.
> 
> +1
> Attaching the same scheduler to multiple cgroups also sounds useful.
> I feel sched-ext should use cgroup_fd too and do scx_sub_enable() at
> attach time instead of load time.
> Then scx_sub_disable() can happen at link detach.
> Looks more flexible from user pov.

Nothing wrong with that but I'm not sure that'd have practical
user-noticeable benefits for sched_ext. Also, would it affect how associated
programs can identify which instance they belong to? At least from sched_ext
POV, that's a lot more important than the ability to attach the same
programs in multiple places.

Thanks.

-- 
tejun

