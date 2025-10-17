Return-Path: <bpf+bounces-71220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 797C8BEA0C2
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 17:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26F9835E78D
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF5333290B;
	Fri, 17 Oct 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQz1Xnx2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25981332903;
	Fri, 17 Oct 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715614; cv=none; b=hoWkIYq6FuK2PAEyFHT3AyoMPkxX/pNS6AX3ubN3jAFOCRvmWHrJQ0+p1N86eGQFfSVq/2iCEaxKTzAiAkFu2FezPWJhsDdtffETkvlREleqMALIZ1sJGtBXkjMpiDa0YZVR0ljFsL3vVEYFlHVNlc8O6Xw9NmcZSTgQrS/Tz3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715614; c=relaxed/simple;
	bh=IQkNW1F4nV6Vxf2WS9P9qIikl4xugxlZvh+MEW6AR3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxOZONIIPwQg39i6i9EgxUTXNAVf8bCHUi6WUjKC0MATqp39aLC9YnibIzWIAgJo30XPPjkJ94z7V1jbvVs3buw0vpgKq5Rs1AiR8N1+v6DTJzSdK6w9FBVjPkwItehbVKNizVC/VH+Lrz371HvdLER8S5oCCWyHzCmoGdhvPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQz1Xnx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C725AC4CEE7;
	Fri, 17 Oct 2025 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760715613;
	bh=IQkNW1F4nV6Vxf2WS9P9qIikl4xugxlZvh+MEW6AR3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQz1Xnx2ndMO4J1MPHj1jpyr+DWmWgpPMl9nbXgnvW1QDZk1196EDbInzlMrQiRCq
	 p5HkDiqkDwA2T00U2v6RVqpqELnlWHaafqOQbgcvm87n+pq8UkNMGs/NUwKqCVsIFm
	 PUlu4grZXXs1jegNpRChwRAC6zMHmcFkof4/fD9Hh9oGexChzpO/mAaXf13eqFy56u
	 FjbnHaH7bsIfBBoqHei1+XjmUF0kqINw7sXXRLALomHRWFc5Fgwm8Cnt3HVfhFiget
	 079tpLQw0PP23ZLv8co1aHKSZi6B6t7m9b6WQuzYKBSXap51HWCLsQfCzwQQ94uJXl
	 82yVTEAqmmJPQ==
Date: Fri, 17 Oct 2025 05:40:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 06/14] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aPJjXBifYNbXY0bI@slm.duckdns.org>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-7-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-7-arighi@nvidia.com>

On Fri, Oct 17, 2025 at 11:25:53AM +0200, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> sched_ext currently suffers starvation due to RT. The same workload when
> converted to EXT can get zero runtime if RT is 100% running, causing EXT
> processes to stall. Fix it by adding a DL server for EXT.
> 
> A kselftest is also provided later to verify:
> 
> ./runner -t rt_stall
> ===== START =====
> TEST: rt_stall
> DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
> OUTPUT:
> TAP version 13
> 1..1
> ok 1 PASS: CFS task got more than 4.00% of runtime
> 
> [ arighi: drop ->balance() now that pick_task() has an rf argument ]
> 
> Cc: Luigi De Matteis <ldematteis123@gmail.com>
> Co-developed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

I don't see anything preventing this to come after patch 11 so that all
sched_ext changes are at the end. Am I correct? That'd make applying the
patches easier. All the debug and deadline changes can be applied to
sched/core and I can pull that and apply sched_ext changes on top.

Thanks.

-- 
tejun

