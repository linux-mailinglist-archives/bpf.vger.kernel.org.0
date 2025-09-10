Return-Path: <bpf+bounces-68009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CADB51539
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 13:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F51316CB4A
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 11:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1A9318143;
	Wed, 10 Sep 2025 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbhzhbfA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA3E30C626
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502856; cv=none; b=rpZp3AtpfcvRj2Mo+Z9fuRnKBhIjwXDyAyGCv/73bsG4d7P5jFJArfgaoutjUTprYktDfj7iKBekXKoL6AZx1998r24390gowiPft8yUogJT5wCk0e5eXV0dtc+EbA7FeUfAnn67AZKg6o2MriwQ0AY0AqCsd4PygoN8aaNH0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502856; c=relaxed/simple;
	bh=4OBZ2ZfKsExYLPiXZhnyp4Ky5O+dJ7H0S4S55ZV3fVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=arPywQRKQKOVMMRl/PEVLOwe7lAMwZJuJU3RA4EsS/Mv9l/tORPhD86ybqoNMSD1L+/osJita2hBZsBItbdomx6Yqq5wYE5h5Mv/9tvRLRgbA4h0CZvRP2r0hOvuuFL6xFXxtqkE//+jmhqctlza8H1u+Eb7h4AdqTe7evv3PeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cbhzhbfA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so41907845e9.0
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 04:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757502853; x=1758107653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U3OQu9v7444v/noKKraVi4jc91DRs3isyorMMbC0SUY=;
        b=cbhzhbfALaQnnWzjVxOUJel//fGecYdcGBFeUwvaOTeyowf26l8mQOS8fyyeZ6h8kO
         ixUxTNzm7m0VqhL70rAgSAg3fz+HMsjZY6w8eA6EHe4+kkJwhksvrXbxta3h3JLzysSY
         F6ROmmjY1S6Cug2sEVTTQRn9BWFF2H8ZWen0RKuD/Ch0HZ+RWnYTTNB1709cB3PwrBmp
         YORw7OchwmTpkiI9SijTxi25KTiwFhsY6KMAW8xHaximR7Quli3Tg/pNBxvgFKx4H1pX
         tNDQ4+CoYJO8+jazN817aVSsUiUyqL0uO5r9YPXYgLSZWVQFe94eXFguxegOtaiWjHPz
         m9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757502853; x=1758107653;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3OQu9v7444v/noKKraVi4jc91DRs3isyorMMbC0SUY=;
        b=vEV8dlnVNnDz7b5zhD66aS7bcYpn3BMu5jq5eW++4Wh8C6U/f7/BbD3NIX52Sop7Xg
         SXNbhsYHWaw1pDDDC9YB3ECI+BJxNuufDdMxvIcL0JDggfv20NIrxiBRbjpp46GDFPHU
         tBD5k9yJVMGVoEHkTCtE8eTfGuxGWcJ2hK3nR+qLhu3hm7EpeIoqg5D2XVj1WS/0oo/y
         ZvVnP7xL1wxgKhCtqzT/Pc7OMJVpeYBL3BTCvilAkx60wbavwych7VEiO4pOA0v0Gldl
         XZCOzrG1gLdy20GWjkAlWtUlZV3QioyhvaSI1nnCtEM95ZxYcMsoUut3jpgwpceL3JGc
         6C/w==
X-Forwarded-Encrypted: i=1; AJvYcCWfG6vI/jmL/feXVmiq4LDUkYEplM620yp8Gc4HeSrPGIqVoHCN2P2Vb/PUOCT4NQ8s83s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzckTBFsPgcYuVLi/nyV0N9+RXAaebTdlGG2dhbs3y3fbSBpPWf
	utOdzVEM4Q/7T/AFnj2oPzPqBP2qhzfonHK/YchRMBc7fPC0IESaKkKscKln8y0Ju6M=
X-Gm-Gg: ASbGncvnZVddgIsF7cLC2WIvsXVLcmbb+LjLQ3/I+Ltq9CXv6yKQLZGE1gGdG7tfSJN
	lgtpEBRp8Bgp2PCAae3tsyNP519UhjSNDkRTvVipCCQPzQ8EhgCQZU8qyrqjcMYCDszsd7tBxD2
	v9ku7Dp82zKBhnhwPzQTCJckfcQmL9AIehNT56LLi05RylhzKyJPaArKPPg+k07tlY1Jjuawok3
	GE+3c5pTJuJMWgx3E4xy+Pm07HGW4RfDBWr3zwRnOh0EXteAxD0sygOumRvFCib54LpcgIw6R0P
	q2e7JI2BbX6yAEA7lbhLi15zUXpuItN3YP9PUJQeKcA5Edvh9qDS5LuJgWSFLnsgYvoWD/q8Oft
	AR3jPSez9syFjFFGYiCgSJNttpOp88QqNWg3LOQ==
X-Google-Smtp-Source: AGHT+IE9s13i7j3TkMJ++FVCyif8BAKmecMcfB9JJQFyKeNZbnaim6+3ufJHKPlruBr5wa8K36udJw==
X-Received: by 2002:a05:600c:4692:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-45dddeb907dmr132007665e9.13.1757502853033;
        Wed, 10 Sep 2025 04:14:13 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bf85esm6721413f8f.1.2025.09.10.04.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 04:14:12 -0700 (PDT)
Message-ID: <21d108f2-db8e-457a-bbef-89d18e8d7601@linaro.org>
Date: Wed, 10 Sep 2025 12:14:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Legacy hardware/cache events as json
To: Ian Rogers <irogers@google.com>
References: <20250828205930.4007284-1-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
 Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
 Vince Weaver <vincent.weaver@maine.edu>
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/08/2025 9:59 pm, Ian Rogers wrote:
> Mirroring similar work for software events in commit 6e9fa4131abb
> ("perf parse-events: Remove non-json software events"). These changes
> migrate the legacy hardware and cache events to json.  With no hard
> coded legacy hardware or cache events the wild card, case
> insensitivity, etc. is consistent for events. This does, however, mean
> events like cycles will wild card against all PMUs. A change doing the
> same was originally posted and merged from:
> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
> his dislike for the cycles behavior on ARM with perf record. Earlier
> patches in this series make perf record event opening failures
> non-fatal and hide the cycles event's failure to open on ARM in perf
> record, so it is expected the behavior will now be transparent in perf
> record on ARM. perf stat with a cycles event will wildcard open the
> event on all PMUs.

Hi Ian,

Briefly testing perf record and perf stat seem to work now. i.e "perf 
record -e cycles" doesn't fail and just skips the uncore cycles event. 
And "perf stat" now includes the uncore cycles event which I think is 
harmless.

But there are a few perf test failures. For example "test event parsing":

   evlist after sorting/fixing: 'arm_cmn_0/cycles/,{cycles,cache-
     misses,branch-misses}'
   FAILED tests/parse-events.c:1589 wrong number of entries
   Event test failure: test 57 '{cycles,cache-misses,branch-
     misses}:e'running test 58 'cycles/name=name/'

The tests "Perf time to TSC" and "Use a dummy software event to keep 
tracking" are using libperf to open the cycles event as a sampling event 
which now fails. It seems like we've fixed Perf record to ignore this 
failure, but we didn't think about libperf until now.

Thanks
James


