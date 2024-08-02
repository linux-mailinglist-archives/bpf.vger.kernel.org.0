Return-Path: <bpf+bounces-36299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A0C94624F
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 19:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BF41B219E0
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 17:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062361537D4;
	Fri,  2 Aug 2024 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLPw4VEa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFAD16BE0F;
	Fri,  2 Aug 2024 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722618852; cv=none; b=KhVgJlOGsU0EfBZczT7XJUJ+4043hhwySs1ayf8vmipqx/C2UppiPSh/hHlTsLRo6099ogXBPjIexvJFgFNPymEmtuxnMKujxxvechcvuhiPKEqdYOj+POcc+zYBkYb/HbzU3/no1szAuAerwxVt7PVY+AGyVBHIBfqbLJVVNBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722618852; c=relaxed/simple;
	bh=QYPYcf6TjX3Gz+/5YCOQg/yJ9tO4WHvNyoUSOTpedhg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O6MT7KeD7V7ThRrhrIvQ9Bm4YAdG0f2a9FmKvedJv8ecOEZeSZYxj9syqHF4d+Gy/EPvSGvZmnGs1Ze2I8tmyR3JbJPFGP6/nGzmzduPPlJLAheEaP9iM0rGRtcRz2wIvYW24Q3/py0WB+/lbE+LfMpAAqta9FrT/eAEJt8xJ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLPw4VEa; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722618850; x=1754154850;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=QYPYcf6TjX3Gz+/5YCOQg/yJ9tO4WHvNyoUSOTpedhg=;
  b=DLPw4VEa3yDQmCVJeZZa+zzBevHVtbdE6LecYu8VhPhsaki5GEvrD/p9
   2RW/83JaIoLi/ZXm7LcYaREKuhNnjEoTSwqT+x1z2yF5jga46uxAas6PJ
   hi580x5quqakUniFJjhr5fwxUlqexqx6YexrJ7GTkYSh+GH9ZlUgKnZE5
   AzNcdZ6NhnPGAXhqja97xggrIvB+VYq1FhvuALzQVfcLlH4n82ARrXDxA
   aXqlba50YV6A20ki+Sf/dm2cMVed5TkyRsuHmlUYktcdamYCpvLDe3OOY
   EhQ+7iSwO2ubaTg2XaIqlDNDA/yuJAgU5BUSnP/i1A7NLtaHCACziKF3c
   g==;
X-CSE-ConnectionGUID: WAZxoNuzQu+d0GCPJL1qUw==
X-CSE-MsgGUID: ChmvBFh8RgCmVPMB8IN10w==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20228503"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="20228503"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 10:14:08 -0700
X-CSE-ConnectionGUID: jSV1AsouRficdhEmK5doXg==
X-CSE-MsgGUID: YM4JCRWFRQuq80LXN0vHIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55146906"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.50.51])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 10:14:06 -0700
Message-ID: <8c394279-dae2-460e-bc9b-f76774a7dca4@intel.com>
Date: Fri, 2 Aug 2024 20:14:00 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] uprobes: misc cleanups/simplifications
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org, mhiramat@kernel.org,
 jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <20240801132638.GA8759@redhat.com>
 <20240801133617.GA39708@noisy.programming.kicks-ass.net>
 <CAEf4BzY-gNWHhjnSh3myb0sStjm0Qjsu6nhFtXEULLvo_E=i5w@mail.gmail.com>
 <CAEf4BzY9diEi2_tHsLxB4Yk-ZAWHT=XJNmagjQtOXc7qShqgrA@mail.gmail.com>
 <20240802092528.GF39708@noisy.programming.kicks-ass.net>
 <775c414e-03f3-4ae2-80df-9821014e1c32@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <775c414e-03f3-4ae2-80df-9821014e1c32@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/08/24 14:02, Adrian Hunter wrote:
> On 2/08/24 12:25, Peter Zijlstra wrote:
>> On Thu, Aug 01, 2024 at 02:13:41PM -0700, Andrii Nakryiko wrote:
>>
>>> Ok, this bisected to:
>>>
>>> 675ad74989c2 ("perf/core: Add aux_pause, aux_resume, aux_start_paused")
>>
>> Adrian, there are at least two obvious bugs there:
>>
>>  - aux_action was key's off of PERF_PMU_CAP_AUX_OUTPUT, which is not
>>    right, that's the capability where events can output to AUX -- aka.
>>    PEBS-to-PT. It should be PERF_PMU_CAP_ITRACE, which is the
>>    PT/CoreSight thing.

Not sure about that.

In perf_event_alloc(), there is:

	if (event->attr.aux_output &&
	    (!(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT) ||
	     event->attr.aux_pause || event->attr.aux_resume)) {
		err = -EOPNOTSUPP;
		goto err_pmu;
	}

which is to prevent aux_output with aux_pause or aux_resume.
That is because aux_output (i.e. PEBS-via-PT) has no interrupt
and so does not overflow.  (Instead the PEBS record is written
by hardware to the Intel PT trace)  No overflow => no (software)
aux_pause/aux_resume, so aux_output with aux_pause/aux_resume
does not make sense.

The PMU capability for aux_pause/aux_resume or aux_start_paused
is PERF_PMU_CAP_AUX_PAUSE.  aux_pause/aux_resume are valid for
non-AUX events (member of the group), whereas aux_start_paused
is valid for the AUX event itself (group leader).  For 
aux_pause/aux_resume the group leader's PMU capability is
checked.  For aux_start_paused the event's PMU capability is
checked.

>>
>>  - it sets aux_paused unconditionally, which is scribbling in the giant
>>    union which is overwriting state set by perf_init_event().

That definitely needs fixing, but the fix is just the diff
from my previous reply:

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

I tested that with:

  # perf probe -x /root/main -a main
  Added new event:
    probe_main:main      (on main in /root/main)

  # perf record -e probe_main:main -- ./main

and it made the problem go away.

>>
>> But I think there's more problems, we need to do the aux_action
>> validation after perf_get_aux_event(), we can't know if having those
>> bits set makes sense before that. This means the perf_event_alloc() site
>> is wrong in the first place.

As above, aux_start_paused is used on the AUX event itself, so the
PMU capability is checked in perf_event_alloc:

	if (event->attr.aux_start_paused &&
	    !(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE)) {
		err = -EOPNOTSUPP;
		goto err_pmu;
	}

Whereas aux_pause/aux_resume are checked in perf_get_aux_event():

	if ((event->attr.aux_pause || event->attr.aux_resume) &&
	    !(group_leader->pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE))
		return 0;

That all seems OK, so please let me know if there is
something else to change.


