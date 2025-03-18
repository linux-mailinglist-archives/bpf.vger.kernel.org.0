Return-Path: <bpf+bounces-54336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64C7A67AFF
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 18:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE8C177CC4
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49100211A15;
	Tue, 18 Mar 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYTtm6Ru"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D521129B;
	Tue, 18 Mar 2025 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319111; cv=none; b=h8liq+iaZYq/sYpKt5bSG6JX8aTmPOebHQGskti1GO/vJQVtCOiGlROjz9LPcUTHJ1Eke5T+pOFCK0cmj4s6aXQdG4fLINzp1hiWQmLFrkuksyjwczmLqE4Op+rLE16eOiU6NJAN7NeoJDRMcJH+0AD5fgxWwqVPkgoVgXSIamU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319111; c=relaxed/simple;
	bh=QzSsTAkqUlXLKitNXdTYm+wsrrEW/dyqMPTFhkbKxnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxj0lC0Ds/hkzJiE1Jw0ebuJxrZn9jwFrrUNcoxKNNgqj/ouV+m9/mueag0hgpPrFOJMg9h+1n7y+IcNSpLt67vSg1tlIxn0d72I4WHdW3HKSS+AdMj4Nn1ayNNKmU4HKTzWONq8Q39xjPH/U9NeQ/FqZ/FQbelqbdKe74hDc4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYTtm6Ru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB14C4CEDD;
	Tue, 18 Mar 2025 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742319111;
	bh=QzSsTAkqUlXLKitNXdTYm+wsrrEW/dyqMPTFhkbKxnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYTtm6RuxkCmYxaqCdRc1ryrbtbdWq/hKmG2Z3I19pX0inWAR6iNd7cenXNhweE5Z
	 LpT20ng2xoAcCn0MRtm+lf/RTXzp4prZEXF83IseagF/S2cf63x2ianYsrlwHs85IA
	 dcxdEQMWbCxTyxhu+ylp+Zv+Haww4bxYWSR3HOLwsQX9zTrvz9rKXYeXU7FxzH8VH7
	 PPr5Zg5kA6GPVI4wY7hngXOdLpu8LLwj37/ZcR4Tp+vaK6JsGjD9DsQLO+EzgS5q8L
	 oUUYwlq7qTnADjzWhqQtD6YHSifRFzk1H28q1mItNqvlmed42J91o2L2PkmgY4z1XA
	 q+MtHaAtouLvw==
Date: Tue, 18 Mar 2025 07:31:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] sched_ext: idle: Extend topology optimizations to
 all tasks
Message-ID: <Z9muBqNbDOxXMB-y@slm.duckdns.org>
References: <20250317175717.163267-1-arighi@nvidia.com>
 <20250317175717.163267-2-arighi@nvidia.com>
 <Z9hoa5iPpDEOnXKt@slm.duckdns.org>
 <Z9khUVcHNfnQuN-u@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9khUVcHNfnQuN-u@gpd3>

Hello,

On Tue, Mar 18, 2025 at 08:31:29AM +0100, Andrea Righi wrote:
> On Mon, Mar 17, 2025 at 08:22:35AM -1000, Tejun Heo wrote:
> ...
> > > +	/*
> > > +	 * If the task is allowed to run on all CPUs, simply use the
> > > +	 * architecture's cpumask directly. Otherwise, compute the
> > > +	 * intersection of the architecture's cpumask and the task's
> > > +	 * allowed cpumask.
> > > +	 */
> > > +	if (!cpus || p->nr_cpus_allowed >= num_possible_cpus() ||
> > > +	    cpumask_subset(cpus, p->cpus_ptr))
> > > +		return cpus;
> > > +
> > > +	if (!cpumask_equal(cpus, p->cpus_ptr) &&
> > 
> > Hmm... isn't this covered by the preceding cpumask_subset() test? Here, cpus
> > is not a subset of p->cpus_ptr, so how can it be the same as p->cpus_ptr?
> > 
> > > +	    cpumask_and(local_cpus, cpus, p->cpus_ptr))
> > > +		return local_cpus;
> > > +
> > > +	return NULL;
> 
> Also, I'm also wondering if there's really a benefit checking for
> cpumask_subset() and then doing cpumask_and() only when it's needed, or if
> we should just do cpumask_and(). It's true that we can save some writes,
> but they're done on a temporary local per-CPU cpumask, so they shouldn't
> introduce cache contention.

Yeah, I can imagine it going either way, so no strong preference.

Thanks.

-- 
tejun

