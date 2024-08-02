Return-Path: <bpf+bounces-36284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C41945CB8
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 13:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4C028204A
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 11:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF5C1DE852;
	Fri,  2 Aug 2024 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7PJajqC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A7E14A4E0;
	Fri,  2 Aug 2024 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596579; cv=none; b=kRWlOqu8jUsA46qkQMUDSghg6kL1ixBzXU952bItCKTxCWXNz6hORI6tI4POg+vNBbqgjQOzNXJ4C6D/d9mcMKQUlNnKyavvzBFTk5Zn5Zu2LZMmds7MKI/9Nz4ByuQzzOWORHBM9qE/UWTfBNEVoLEi4Kob4+9LaegMWU1cnMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596579; c=relaxed/simple;
	bh=CMYOm/3+qnwFmb8aGdAmrZXX3x0lbRKjufit5kztRMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OznwLgc1BgytxivPh61W4ZBJLWIty/N/JONVA24MAqu9ohDKHz92lr9fyboK8NSIR15mFEAFHu1n6ln8MPBHou6/SdjaqreTTpK2QmQ8zrluJDC7DEX/n0D/o3aZk/Q5Kf2jj3mQEFcmhPJbj3kVbPcYF6ZsW8fRScyPfPFusS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7PJajqC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722596577; x=1754132577;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CMYOm/3+qnwFmb8aGdAmrZXX3x0lbRKjufit5kztRMs=;
  b=U7PJajqC0Jqk4Gj3NSOf1RGhsJCtatYvGc8c6HnEt1nfTljUFTDzXIw0
   pTyAJHdspfHNTyZ5DQhyK+Sdf1ya4t5Jr1GT0f76sWzCBnMWrmWB3OCJO
   8ZBFOsBId5ay8/DfaS1ZRagwUWrWnNXKC4GZF/SxohqOw76N5ZoRr8SZr
   sIsj/YuGXBfI+/vy2UmNpcC0G4tPCvK2ktirkU4ov4GSNkkW84utcdxZQ
   05Tt8nzBJq70C1/JS6jveP+ha/NYVwN8hjOr9eobUaPWwy6jUDNxxxUSg
   mHYv2Tu49RfnUPk20om9dxXHx/atM9PpaMso+eGRbr+wf49TtClNEeSFZ
   Q==;
X-CSE-ConnectionGUID: eC2nCy/oQIWf1s1O2ojTpg==
X-CSE-MsgGUID: zRHKJkb4TPSJg9SiipqV+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="38070596"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="38070596"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 04:02:56 -0700
X-CSE-ConnectionGUID: R2bxbhkZQo2KnJnluuTulw==
X-CSE-MsgGUID: xYPtSlgKQkihCfgw12rpAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="56133529"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.248.12])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 04:02:54 -0700
Message-ID: <775c414e-03f3-4ae2-80df-9821014e1c32@intel.com>
Date: Fri, 2 Aug 2024 14:02:48 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] uprobes: misc cleanups/simplifications
To: Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org, mhiramat@kernel.org,
 jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
References: <20240801132638.GA8759@redhat.com>
 <20240801133617.GA39708@noisy.programming.kicks-ass.net>
 <CAEf4BzY-gNWHhjnSh3myb0sStjm0Qjsu6nhFtXEULLvo_E=i5w@mail.gmail.com>
 <CAEf4BzY9diEi2_tHsLxB4Yk-ZAWHT=XJNmagjQtOXc7qShqgrA@mail.gmail.com>
 <20240802092528.GF39708@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240802092528.GF39708@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/08/24 12:25, Peter Zijlstra wrote:
> On Thu, Aug 01, 2024 at 02:13:41PM -0700, Andrii Nakryiko wrote:
> 
>> Ok, this bisected to:
>>
>> 675ad74989c2 ("perf/core: Add aux_pause, aux_resume, aux_start_paused")
> 
> Adrian, there are at least two obvious bugs there:
> 
>  - aux_action was key's off of PERF_PMU_CAP_AUX_OUTPUT, which is not
>    right, that's the capability where events can output to AUX -- aka.
>    PEBS-to-PT. It should be PERF_PMU_CAP_ITRACE, which is the
>    PT/CoreSight thing.
> 
>  - it sets aux_paused unconditionally, which is scribbling in the giant
>    union which is overwriting state set by perf_init_event().
> 
> But I think there's more problems, we need to do the aux_action
> validation after perf_get_aux_event(), we can't know if having those
> bits set makes sense before that. This means the perf_event_alloc() site
> is wrong in the first place.
> 
> I'm going to drop these patches for now. Please rework.

Yes I will do that.

FWIW, I'd expect the reported issue would go away with just:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e4cb6e5a5f40..2072aaa4d449 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12151,7 +12151,8 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		err = -EOPNOTSUPP;
 		goto err_pmu;
 	}
-	event->hw.aux_paused = event->attr.aux_start_paused;
+	if (event->attr.aux_start_paused)
+		event->hw.aux_paused = 1;
 
 	if (cgroup_fd != -1) {
 		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);


