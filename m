Return-Path: <bpf+bounces-27690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF8D8B0EC0
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2B8B2C204
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBE01607A5;
	Wed, 24 Apr 2024 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkZuXtm6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B715ECE4;
	Wed, 24 Apr 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972887; cv=none; b=gsRpB87L34PdNQtAz9i9ZBQwO7RkLfY5kH+Nzhvcg4e/240OdxCYgaGs8NTKFq4EyAs1CEXIqKSTej9OrLiKQBJ3CQVS/lcXB9trlXlVgsEm84mbd/gMEfl57Ak30uBjZO8uRU/qmpFu7kggAdGvPODxu4ueyMbulMU8wp9Rxws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972887; c=relaxed/simple;
	bh=XHcrnAmOsOix8K/xKq2+ZtbSNEaC/vMNW+9wzdDr6Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qDrsd/Q+RcT+4cSRBgxYXIIn9LDAQzwFS0F4GPZL2xGmwk/iiomLUKz6ULjZE7RQOAaUNt1jnV5ryHfaCW1I81EOnSZcf7ldqpbwKl2axCk1DvqgsQwour0dxmFjOWyrkITxy6HJBapxf46ByMsV6lkL+tfA4RIwa9zMNjuhyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkZuXtm6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713972886; x=1745508886;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=XHcrnAmOsOix8K/xKq2+ZtbSNEaC/vMNW+9wzdDr6Fg=;
  b=HkZuXtm6tdT37JcQxdnClG8nBIOnUwVPFKW3TNOkD9U4+WaZl69QbSEP
   6TFWnBRJ13bTLR9TLSRgMANVhLfRbTmxa97uz3g0yoqaDclP3pHvdAZhp
   NdyAoJ2wrbvhg7fGU8KVEStxkI4VZqujYCOZ4ERx9dIcU95+3YDfYM+Im
   QiAeRkPzl7vBxnxhaCshEBcDGdIUhIuFleWeBDNpVRfjECQKK5ArTXzOd
   GwXd1YoK+mcBFmz3cI7ZfF1XuBUUyMNyMEgBwo2Ub/rxbB+jFHLzSMO9C
   Krcoi5Wjq+fFcxSX0BBH8RN5JwSDFHgUR+SqmjZs5o7YLRZCuwfz/nPX1
   A==;
X-CSE-ConnectionGUID: 4FgB68m7RAyv/UqpHxYLvg==
X-CSE-MsgGUID: xFcruwniQJS01cUDfhrnJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="35011179"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="35011179"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 08:34:35 -0700
X-CSE-ConnectionGUID: rM0GpW3TRuC8zyhzefLgaQ==
X-CSE-MsgGUID: 6mtRVtWERXaa/MAJLWhc0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29556579"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 08:34:36 -0700
Received: from [10.212.107.188] (kliang2-mobl1.ccr.corp.intel.com [10.212.107.188])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2E4F6206D89D;
	Wed, 24 Apr 2024 08:34:33 -0700 (PDT)
Message-ID: <54a2ecfc-5a31-4e11-9e97-5a96baf18a0d@linux.intel.com>
Date: Wed, 24 Apr 2024 11:34:32 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] Consistently prefer sysfs/json events
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org,
 Beeman Strong <beeman@rivosinc.com>
References: <20240416061533.921723-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-16 2:15 a.m., Ian Rogers wrote:
> As discussed in:
> https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/
> preferring sysfs/json events consistently (with or without a given
> PMU) will enable RISC-V's hope to customize legacy events in the perf
> tool.
> 
> Some minor clean-up is performed on the way.
> 
> v2. Additional cleanup particularly adding better error messages. Fix
>     some line length issues on the earlier patches.
> 
> Ian Rogers (16):
>   perf parse-events: Factor out '<event_or_pmu>/.../' parsing
>   perf parse-events: Directly pass PMU to parse_events_add_pmu
>   perf parse-events: Avoid copying an empty list
>   perf pmu: Refactor perf_pmu__match
>   perf tests parse-events: Use branches rather than cache-references
>   perf parse-events: Legacy cache names on all PMUs and lower priority
>   perf parse-events: Handle PE_TERM_HW in name_or_raw
>   perf parse-events: Constify parse_events_add_numeric
>   perf parse-events: Prefer sysfs/json hardware events over legacy
>   perf parse-events: Inline parse_events_update_lists
>   perf parse-events: Improve error message for bad numbers
>   perf parse-events: Inline parse_events_evlist_error
>   perf parse-events: Improvements to modifier parsing
>   perf parse-event: Constify event_symbol arrays
>   perf parse-events: Minor grouping tidy up
>   perf parse-events: Tidy the setting of the default event name
> 
>  tools/perf/tests/parse-events.c |   6 +-
>  tools/perf/util/parse-events.c  | 482 ++++++++++++++++----------------
>  tools/perf/util/parse-events.h  |  49 ++--
>  tools/perf/util/parse-events.l  | 196 +++++++++----
>  tools/perf/util/parse-events.y  | 261 +++++++----------
>  tools/perf/util/pmu.c           |  27 +-
>  tools/perf/util/pmu.h           |   2 +-
>  7 files changed, 540 insertions(+), 483 deletions(-)
> 


The series looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

