Return-Path: <bpf+bounces-27689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218F18B0E65
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5801F287E7
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26AB1607B8;
	Wed, 24 Apr 2024 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLn+KLHa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F9415FA68;
	Wed, 24 Apr 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972622; cv=none; b=n9Ze8F6FvuXymFKmlWHwj1JuoW54wLY/9F+gLwZ+jCKi+aNFEbLh6mcvl4bgoaKhmprX44TX/t4jLg8r0J0OjIQu6J1JrbSPnC0sS+UyyH3INeJVyLvpiirerVTU3ckj2Ec/7tgNnYAaqBQLzoNrSdcQKLczZylaoZyco9FTbQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972622; c=relaxed/simple;
	bh=wbLuhw/WYXCcv7kdW+LHH5poNfQY/brJKzckpRJupaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g01LY+69ZAcDCTBQjpzraBmIpXue/oEiMPSCXONFqzRact8dqKf/beJP/YLtilUIMfYIS4HiT1gIUYVwbbeag2AhbaCgbhmY+cF/GoKy2u3fo0VqXJQn2jcdGzyldAuqzBhhxQ0vCWFjO+xklr0KF8zkeyUBBUSiZvSF4S7FNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLn+KLHa; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713972620; x=1745508620;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wbLuhw/WYXCcv7kdW+LHH5poNfQY/brJKzckpRJupaE=;
  b=dLn+KLHad0uNBXmg1wNDoq+v7czZDYkCvTA02uZAOiLMCAb6qkNBB6tc
   v0/Yqswo5HGCsK2b4l6I93eh1UGVrhBYT+YPDm+FEftsAEDHohCK6XUUS
   F9nhYVynzUIGhug6KCIZsygM//pwXi8X5M0zhMNO1EfJt1V+7a6HyArwa
   b8lzwQrC51dQBaNP4nL7KbB63tyATBZH1KryAfFF+tHj0MDO4tEYDSUz9
   HB+8x2m2OAQZ5FlANzrz65bjOD4KiHmUSVj5S+iJNOOm8p/37MOwfPF1u
   PGYmaiqKH4vhJ67E0xydek5StOB3qLJkLCouAeyPMnpMVrSm8cGNyRMVf
   w==;
X-CSE-ConnectionGUID: RtD5yi/ARNO77Y3QqExL7Q==
X-CSE-MsgGUID: 5DiS7h6ISly66z7Coi02MQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9540547"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9540547"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 08:30:18 -0700
X-CSE-ConnectionGUID: 8VHd22DdTmO/lLu1mNIrQA==
X-CSE-MsgGUID: D1ZemLcCQiKus60QrdcssQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24631769"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 08:30:18 -0700
Received: from [10.212.107.188] (kliang2-mobl1.ccr.corp.intel.com [10.212.107.188])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 422D8206D89D;
	Wed, 24 Apr 2024 08:30:16 -0700 (PDT)
Message-ID: <7f1014fc-eb0a-4989-8efa-245d5b6937cd@linux.intel.com>
Date: Wed, 24 Apr 2024 11:30:14 -0400
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
 <7df3ff63-a421-42cc-bcaa-b0254ff6a0e8@linux.intel.com>
 <CAP-5=fUi8DPNrbp=978K92Mopa71ag1sukttX3KcztD2ac0ADg@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUi8DPNrbp=978K92Mopa71ag1sukttX3KcztD2ac0ADg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-04-24 11:18 a.m., Ian Rogers wrote:
> On Fri, Apr 19, 2024 at 6:20 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-04-19 2:22 a.m., Ian Rogers wrote:
>>>>> +             /* Simple modifiers copied to the evsel. */
>>>>> +             if (mod.precise) {
>>>>> +                     u8 precise = evsel->core.attr.precise_ip + mod.precise;
>>>>> +                     /*
>>>>> +                      * precise ip:
>>>>> +                      *
>>>>> +                      *  0 - SAMPLE_IP can have arbitrary skid
>>>>> +                      *  1 - SAMPLE_IP must have constant skid
>>>>> +                      *  2 - SAMPLE_IP requested to have 0 skid
>>>>> +                      *  3 - SAMPLE_IP must have 0 skid
>>>>> +                      *
>>>>> +                      *  See also PERF_RECORD_MISC_EXACT_IP
>>>>> +                      */
>>>>> +                     if (precise > 3) {
>>>> The pmu_max_precise() should return the max precise the current kernel
>>>> supports. It checks the /sys/devices/cpu/caps/max_precise.
>>>>
>>>> I think we should use that value rather than hard code it to 3.
>>> I'll add an extra patch to do that. I'm a bit concerned it may break
>>> event parsing on platforms not supporting max_precise of 3.
>>
>> The kernel already rejects the precise_ip > max_precise (using the same
>> x86_pmu_max_precise()). It should be fine to apply the same logic in the
>> tool.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/core.c#n566
>>
>> Will the extra patch be sent separately?
> 
> Let's do it separately. I'm concerned about the behavior on AMD (and
> possibly similar architectures) where certain events support precision
> like cycles, as they detour to the IBS PMU, but not all events support
> it. The max_precise should reflect that AMD's Zen core PMU does
> support precision as a consequence of detouring to IBS, but maybe
> things in sysfs aren't set up correctly.
> 

The x86_pmu_max_precise() is a generic function for X86. It should apply
to AMD as well.

A separate patch looks good to me.

Thanks,
Kan


