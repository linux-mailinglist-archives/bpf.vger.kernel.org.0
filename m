Return-Path: <bpf+bounces-54062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 804B3A61937
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 19:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BE917D788
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 18:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC01E204C15;
	Fri, 14 Mar 2025 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbfMpJ/w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623EE14A0A3;
	Fri, 14 Mar 2025 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741976246; cv=none; b=R/o2Tw8U4vbJO5TPJYx2jCpAL5eSZPToKpW7SJ0BQ8mbbNMHE0YNCFEjPOxT1WL4TpiwnG2ao65aQ9wQGuXiJ6LEq4w6HTNjdntaETa75oxHnuyaHFRcYxPBySCFvghi/zpymG/el0RHRyY55VH3pKBUpQe6fdRG8ptzOtGziMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741976246; c=relaxed/simple;
	bh=BzvMRiH24ZD6cSiM6yAOWEs/fnpgpmdAPB0QcLeRWlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPEiVh5hWbK+4Zo5NwlDl7otzC7zKu/ZKZRaJUKICTkjF6vbZyLHysMcsOtoz4LIvlt3KsRq665XvUZ1HwWsKVVbcU4n2KQsKbmeFIHOhAnxD1mVnS21yP1EUg32RoagAmzBXR7INrM2FtsNoeRDHXRFBDOqTRkpnGvl5Pb62io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbfMpJ/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A7DC4CEE3;
	Fri, 14 Mar 2025 18:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741976245;
	bh=BzvMRiH24ZD6cSiM6yAOWEs/fnpgpmdAPB0QcLeRWlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GbfMpJ/w9QgzYo1y2fhJJIflFaPMQSaXW+h6FNMDIpKqAwI0tGK4/hBU2IYShfEuM
	 DUlfj2yjkcimMndQ6V79dPyH/tGHLXAf6GC1eGljOYzTmq0C3ju5ll/a9/StoDa108
	 0+ZXI4iZa2zmR1rQ/LGUhvz2NR0UArabdOg0ScYupDAvF9ks+j8zQmIl6AI8aBdJeo
	 AsbHPwyxLXcu89zq9unmMN0i2TVtbMOUYfWr1o97U8WJEqAYMv6IcvKjdN5hiVmqNg
	 2l0/9jWp3aDl1vfdO4ijYfqvnVxZ3ABLYe218BogpdjuKFwsbw5aX685NMvTVD+jRW
	 xW3UBj6d3xNDw==
Date: Fri, 14 Mar 2025 08:17:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] sched_ext: idle: Refactor scx_select_cpu_dfl()
Message-ID: <Z9RytEzaW2VOh3Bj@slm.duckdns.org>
References: <20250314094827.167563-1-arighi@nvidia.com>
 <20250314094827.167563-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314094827.167563-3-arighi@nvidia.com>

On Fri, Mar 14, 2025 at 10:45:34AM +0100, Andrea Righi wrote:
> Make scx_select_cpu_dfl() more consistent with the other idle-related
> APIs by returning a negative value when an idle CPU isn't found.
> 
> No functional changes, this is purely a refactoring.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied 1-2 to sched_ext/for-6.15.

Thanks.

-- 
tejun

