Return-Path: <bpf+bounces-50814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77806A2D03C
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 23:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97806188AC47
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54D41B424E;
	Fri,  7 Feb 2025 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5HUA4Gl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3447642069;
	Fri,  7 Feb 2025 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965762; cv=none; b=Lf1y8vNx3RtSq/obI+WiTH0fHpvvC3NXtN9QCuE2aGBlpkMqQgcFPup5b1yM+MYRAjRRr+cddgJWsslgkqXZEk4Ek8Ji2W70hs0adyy2A6Hx2eduq8OtVdOa0KOVzOlREAteLTusSsYiiKjRSqNxVFOORaWJbNaXDdwTFaGWSkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965762; c=relaxed/simple;
	bh=OHXYqRG5reKAlWt/SSkCGeCCohW0zKwzj+nrrIhVr5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5P7q7rBczEEKdvKerWTUQ1wumIpEfmEnCVxz8aoSifm/O10LmeS3GEeTRdXoJcRZn/H92PHlBXaH/Dbu+xLI3vRbGqNF7McCeqDjGWjDRFrgnxGW3OdtRW7Bhi7cfycZWDTQfJwLJr42OTuBhJaMD0geAtFN5Oh7vJcgn4DNxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5HUA4Gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895EAC4CED1;
	Fri,  7 Feb 2025 22:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738965760;
	bh=OHXYqRG5reKAlWt/SSkCGeCCohW0zKwzj+nrrIhVr5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5HUA4GltF31TufGVlzTZdHCdD/JCvp+bffwKSBgKSOc0X5JDyc9SlgnPRvQHKTFF
	 xkqmDlVpNQifxRBUoS7Qrl2WDwmlWsrjetq0F4mxWoN4ivO94DAPnj8wb4LdcM8jCs
	 pQZbZEajCCUMTtu21ivvD8UWsoDnvk2XVR56WjVrqzFMBGuT4UMHgwvTmEAixuEtFd
	 FMAEwLX7MYz0QDj94SiXVwh7tsV0WZLEybhhGK6hdz7Mc41kmmhgwsfvhoTVj296As
	 SRfoEJcOLk6f4yIAe2RY0IkevEWXua+bjKoVYL0ti6f289ZhCFpAnbYRnfGkyY2L9c
	 TmHOQVgCM88fg==
Date: Fri, 7 Feb 2025 12:02:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] sched_ext: idle: introduce SCX_PICK_IDLE_IN_NODE
Message-ID: <Z6aC_7xnfC21Vkcf@slm.duckdns.org>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207211104.30009-5-arighi@nvidia.com>

On Fri, Feb 07, 2025 at 09:40:51PM +0100, Andrea Righi wrote:
> Introduce a new flag to restrict the selection of an idle CPU to a
> single specific NUMA node.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 0063a646124bc..8dbe22167c158 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -775,6 +775,7 @@ enum scx_deq_flags {
>  
>  enum scx_pick_idle_cpu_flags {
>  	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
> +	SCX_PICK_IDLE_IN_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */
>  };

Please merge this into the patch which actually uses the flag.

Thanks.

-- 
tejun

