Return-Path: <bpf+bounces-39055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216E696E308
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 21:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CCC1F2543C
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 19:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394CB18D65B;
	Thu,  5 Sep 2024 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="As6s0bS4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F8154C0D;
	Thu,  5 Sep 2024 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564066; cv=none; b=qjogBwyi31fzuWThhvnmfaDD2/XPKU1vFspZFvHNsgYG+d/6ChlBA4d3/davDYxM+YgvC6opDl2PU7PW0PUKYlCeZwiISjzFExWRlVrNLfFUZXDCu7K2+OzJv8LtpWzUd1K1Zsk4YiQ0UY6lXwbTNnhyodKG9aRMgofAEK8iGa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564066; c=relaxed/simple;
	bh=+BzS012R6syDeqd0t9o3KQ0U5UhKeDAJauumJpcn38k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujqSQb9ERShJM5A1PXZJ9OujWW2JlkY0bAhwVzYzk2l03Q4osW7kf+kHBYLsfh+4qdui7Xkomz3x7gSHl1nFyT2agHWY5TQK+3tpcB3baQnEe1QejhKesNlSO68HxTCcRn+k58lBQtCXQiTF3DDVxWSl9jASsDBDuPUz1ghT1SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=As6s0bS4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725564065; x=1757100065;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+BzS012R6syDeqd0t9o3KQ0U5UhKeDAJauumJpcn38k=;
  b=As6s0bS4tUp4wH+XfnQWOCxa1theCyWLQyHtYcnvMYRguivRxkQxl85z
   365IP4lpBU2zzRWNcizGSFAW936Ug7oOG5mnYWfk6hB8zbBHlqiJCtBF7
   /1nmrcY3US9RZbk2Oi8hnAmxqK3pebIm+p6HJtWdBqzre6gDNeMvPfi/6
   z+QDnFqwbI2oWVpWvEE1+Kq3cfsxmLYJwaviPAWYdgMvnLSc7HHb3+DII
   dwHAyd9HbZRTx7a/D9fKvK2A2LjSvv+TUFWcVc9b68NLott3obWPRAsS2
   7pzrAWP+XVqqd1dK4bgBDx4nqNYrlFFR5pZp5m0QRqSccGZjbzzW3UYFZ
   w==;
X-CSE-ConnectionGUID: sYcTPaQDSeqjYIvWEFow0A==
X-CSE-MsgGUID: 1BDko2IbT+qzvL7acijf8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="23859638"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="23859638"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 12:21:02 -0700
X-CSE-ConnectionGUID: q7v5jfmbQwi6MqIgTseAQw==
X-CSE-MsgGUID: 7CRiBUEcRtWVIqEX6j2Dtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="88967415"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 12:21:02 -0700
Received: from [10.212.68.73] (kliang2-mobl1.ccr.corp.intel.com [10.212.68.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 29C1520B5782;
	Thu,  5 Sep 2024 12:21:01 -0700 (PDT)
Message-ID: <ddfd906c-83cc-490a-a4bb-4fa43793d882@linux.intel.com>
Date: Thu, 5 Sep 2024 15:20:59 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86: fix wrong assumption that LBR is only useful
 for sampling events
To: Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org,
 peterz@infradead.org
Cc: x86@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, acme@kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
References: <20240905180055.1221620-1-andrii@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240905180055.1221620-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-05 2:00 p.m., Andrii Nakryiko wrote:
> It's incorrect to assume that LBR can/should only be used with sampling
> events. BPF subsystem provides bpf_get_branch_snapshot() BPF helper,
> which expects a properly setup and activated perf event which allows
> kernel to capture LBR data.
> 
> For instance, retsnoop tool ([0]) makes an extensive use of this
> functionality and sets up perf event as follows:
> 
> 	struct perf_event_attr attr;
> 
> 	memset(&attr, 0, sizeof(attr));
> 	attr.size = sizeof(attr);
> 	attr.type = PERF_TYPE_HARDWARE;
> 	attr.config = PERF_COUNT_HW_CPU_CYCLES;
> 	attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
> 	attr.branch_sample_type = PERF_SAMPLE_BRANCH_KERNEL;
> 
> Commit referenced in Fixes tag broke this setup by making invalid assumption
> that LBR is useful only for sampling events. Remove that assumption.
> 
> Note, earlier we removed a similar assumption on AMD side of LBR support,
> see [1] for details.
> 
>   [0] https://github.com/anakryiko/retsnoop
>   [1] 9794563d4d05 ("perf/x86/amd: Don't reject non-sampling events with configured LBR")
> 
> Cc: stable@vger.kernel.org # 6.8+
> Fixes: 85846b27072d ("perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK flag")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/x86/events/intel/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 9e519d8a810a..f82a342b8852 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3972,7 +3972,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  			x86_pmu.pebs_aliases(event);
>  	}
>  
> -	if (needs_branch_stack(event) && is_sampling_event(event))
> +	if (needs_branch_stack(event))
>  		event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;

To limit the LBR for a sampling event is to avoid unnecessary branch
stack setup for a counting event in the sample read. The above change
should break the sample read case.

How about the below patch (not test)? Is it good enough for the BPF usage?

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0c9c2706d4ec..8d67cbda916b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3972,8 +3972,12 @@ static int intel_pmu_hw_config(struct perf_event
*event)
 		x86_pmu.pebs_aliases(event);
 	}

-	if (needs_branch_stack(event) && is_sampling_event(event))
-		event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+	if (needs_branch_stack(event)) {
+		/* Avoid branch stack setup for counting events in SAMPLE READ */
+		if (is_sampling_event(event) ||
+		    !(event->attr.sample_type & PERF_SAMPLE_READ))
+			event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+	}

 	if (branch_sample_counters(event)) {
 		struct perf_event *leader, *sibling;


Thanks,
Kan
>  
>  	if (branch_sample_counters(event)) {

