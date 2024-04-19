Return-Path: <bpf+bounces-27220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572228AAF37
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 15:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12866283373
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 13:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC52127B75;
	Fri, 19 Apr 2024 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUyP2S1h"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD5126F11;
	Fri, 19 Apr 2024 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713532859; cv=none; b=QRqjo3u/AbBUSLPl3RIyIhPxntX+86M9TQPGFTHOhgrEPQJvBjpX5hyoZ6iNFSpn5+IgGpuQV6crNZ7d9dd+9g6izJ9/j6HUeVP+P3anhaANJYJ/mnOLdx5xB125VeI3ZJZARSgsdgSAQgj6QSUR8/Qll4tN5BHxeZBfZOsks2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713532859; c=relaxed/simple;
	bh=9AoVEv+4aXGan7HuUBUV61T8VtGyQUi1t/MC18wWiQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnnC3Ay12EU9fuMsLU7YY31kxHbYpVeBXnY8ow/PWZNopnPsworogvAAltaSRFmFZ5Jn9MswliKIJa5acnCUfFQr/XfXBRiLuXgN+l601SEMI54EqLPkSirHnGgcmcXp3kjyNqNvcuuB4iQ9Wf3DO18vUJ7dsC8FpAphnIYh+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUyP2S1h; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713532858; x=1745068858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9AoVEv+4aXGan7HuUBUV61T8VtGyQUi1t/MC18wWiQM=;
  b=eUyP2S1hVE3ApD2/fhOFBCjqlHaXhRwlEMcD2cYPHrUEAdGdxjXGk1CK
   79zqmefhOafVPs7GO10vYBCdQxk6fNXd/ngz4i+2SVd8qjVpdNSccUWLQ
   owCyrroIjrK+Q21eYtF1oyPAMb42Zyy7ldu1Px34AicmLhhvXRKbdrT5W
   +rQ6YR3cnXsPohsDwIesq5/WFSFtyaFPk/eY5aMdxPuaWfpkckDrG/8nX
   vZxCKnsBXxq0DIYi1dXw4ykA4JmICA+M5i7vxGGRpizMcsdLcmnC8O8ZA
   k+AkXnUXUfzbgatawc4fBBW/uZJmpvuEkZIFf4TXeOQACTCM9NnaPgxee
   g==;
X-CSE-ConnectionGUID: HbiP/61BQ8yrtfbfW1AQuw==
X-CSE-MsgGUID: KkSMrnRCS4uQDPw+PCr35w==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="20524384"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="20524384"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:20:58 -0700
X-CSE-ConnectionGUID: l1Ba9EzxSTqRx/qsd0wjTw==
X-CSE-MsgGUID: sRof6H5HReWc4pDZ+Zd1fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27793667"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:20:57 -0700
Received: from [10.212.13.6] (dojung-mobl.amr.corp.intel.com [10.212.13.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9E8E8206DFDC;
	Fri, 19 Apr 2024 06:20:54 -0700 (PDT)
Message-ID: <7df3ff63-a421-42cc-bcaa-b0254ff6a0e8@linux.intel.com>
Date: Fri, 19 Apr 2024 09:20:53 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] perf parse-events: Improvements to modifier
 parsing
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org,
 Beeman Strong <beeman@rivosinc.com>
References: <20240416061533.921723-1-irogers@google.com>
 <20240416061533.921723-14-irogers@google.com>
 <e8147f53-1930-44d8-abb8-fee460ec355f@linux.intel.com>
 <CAP-5=fVXv_gsoq5L08gaEJvU1E8xoihc3-L4taA+bPHyOJfgqw@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVXv_gsoq5L08gaEJvU1E8xoihc3-L4taA+bPHyOJfgqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-19 2:22 a.m., Ian Rogers wrote:
>>> +             /* Simple modifiers copied to the evsel. */
>>> +             if (mod.precise) {
>>> +                     u8 precise = evsel->core.attr.precise_ip + mod.precise;
>>> +                     /*
>>> +                      * precise ip:
>>> +                      *
>>> +                      *  0 - SAMPLE_IP can have arbitrary skid
>>> +                      *  1 - SAMPLE_IP must have constant skid
>>> +                      *  2 - SAMPLE_IP requested to have 0 skid
>>> +                      *  3 - SAMPLE_IP must have 0 skid
>>> +                      *
>>> +                      *  See also PERF_RECORD_MISC_EXACT_IP
>>> +                      */
>>> +                     if (precise > 3) {
>> The pmu_max_precise() should return the max precise the current kernel
>> supports. It checks the /sys/devices/cpu/caps/max_precise.
>>
>> I think we should use that value rather than hard code it to 3.
> I'll add an extra patch to do that. I'm a bit concerned it may break
> event parsing on platforms not supporting max_precise of 3.

The kernel already rejects the precise_ip > max_precise (using the same
x86_pmu_max_precise()). It should be fine to apply the same logic in the
tool.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/core.c#n566

Will the extra patch be sent separately?

Thanks,
Kan

