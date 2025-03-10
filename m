Return-Path: <bpf+bounces-53745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E745A59AA5
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 17:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D947A1DDD
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 16:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D6322E3F1;
	Mon, 10 Mar 2025 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFa36S2+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5314B5AE;
	Mon, 10 Mar 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622843; cv=none; b=Qtn8fbgacdyCf5nwC1oePjy0aT+2dYxE/+VZBYERxp62fJafTQxNaeVCRCqMok9i8/fMVMuGqbs97BmGM0mxVQ8HwV68bkWALWdlaSmAzu/urB/LHJZdjWbUx8PBoEIkZrO52rmySMovykf13oaf1iX3TEGwZJKOyFERsVn2yqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622843; c=relaxed/simple;
	bh=WLjGO0Yf+HEuQSLO0MZCDJSF/aVI6xMKp97hSUYkCGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsvOABl13qE5YenMtlFj+tqdZ+87ALhu1gOkdxPPMB3636X911JL6Yn+YOOOxm9V3fiGcoRd//PxzjXm9yjLC2Ch2jM38LE2Flax96IvgM6U4IMYbwWcs9G1iotMptQc+TDeWCfwhn5Z3ZkmIRPqrZemPuqtZNhi6yh2NFT2Kwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFa36S2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4720C4CEEB;
	Mon, 10 Mar 2025 16:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741622843;
	bh=WLjGO0Yf+HEuQSLO0MZCDJSF/aVI6xMKp97hSUYkCGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFa36S2+7+HVx4RtmmRn/LwIPsD2F+0JsJjtyZ/sLSEiS/445Ytc60kO442SbiQ0D
	 qTsxGct937C2ujyOivwiDXQVuQGRLgdZFCTme6IEq/6gUXxsu7XGRIApyQmDmRmErf
	 sFN8hqpGoOtp1Q6LuwKqc3awx565PF6TukGDSul68YoVVzVDZM9JaGwQtkStE9mRVn
	 tCyjhA6o1fZdh0RYfKgu1CPvGM93AcJmCe+VrqVKq4K3wxUUBqJQQ6llVhqF1vRJVT
	 UJfytJT2tYQ37ffllXcxs2IyUGNOFNJkIClhw2wMwgkOPOEyBhZIK7IibMa0AzYc7X
	 mDXifZYKfHB7Q==
Date: Mon, 10 Mar 2025 06:07:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] sched_ext: idle: Introduce the concept of allowed
 CPUs
Message-ID: <Z88OOena_fucXLVl@slm.duckdns.org>
References: <20250307200502.253867-1-arighi@nvidia.com>
 <20250307200502.253867-4-arighi@nvidia.com>
 <Z8twc3pc7I9SyIMC@slm.duckdns.org>
 <Z8voSv70QuxuZa5Z@gpd3>
 <Z82sImYF7jOgPGbL@slm.duckdns.org>
 <Z822PGZLYl1Vima4@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z822PGZLYl1Vima4@gpd3>

Hello,

On Sun, Mar 09, 2025 at 04:39:40PM +0100, Andrea Righi wrote:
> > Would just using a pre-allocated cpumask to do pre-and on @cpus_allowed
> > work? This won't only be used for topology support (e.g. soft partitioning
> > in scx_layered and scx_mitosis may want to use multi-topology-unit spanning
> > subsets) and I'm not sure assuming and optimizing for that is a good idea
> > for generic API.
> 
> We can pre-allocate two additional (per-cpu) cpumasks to do:
>  - cpumask_and(numa_cpus, numa_span(cpu), cpus_allowed)
>  - cpumask_and(llc_cpus, llc_span(cpu), cpus_allowed)
> 
> And update/use them only when it's needed. In this way the API would be
> generic without making any implicit assumption about @cpus_allowed.

I'm not quite following why two masks would be necessary. The user is
providing two masks and and'ing those two masks result in a single
cpus_allowed mask which can then be passed down to the existing pick
functions, no?

Thanks.

-- 
tejun

