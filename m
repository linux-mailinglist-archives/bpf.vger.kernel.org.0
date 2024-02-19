Return-Path: <bpf+bounces-22245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB1B85A11A
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 11:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEE71F212ED
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4718228DB5;
	Mon, 19 Feb 2024 10:38:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24961C10;
	Mon, 19 Feb 2024 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339110; cv=none; b=epdm9vHFGDIYLyZnMX7Klti11aEJZ/mv3aQd5c9asuu+P/FcsDoS+yExfWmyqCTMmBvnRlmFDuhRokAKNI4ih5BKBGDIxPxqrpnvzyIs9F8/t/yBUb5HU3wtG1FvuO5WZMsVyxpDXUanYahIp/zAwzowokJlqmKuV9TROS0Rc/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339110; c=relaxed/simple;
	bh=ANF00kKf6VxoZUFP3NSAnia/Ezpeg/tKkdcwSuCKNyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0fqph5ssX5pSQ02lGmDU0y6JknHF9cxFqR3Y3es1oZ6IqIRtXWnTRU2f7IdkGxwt/A2IKaBPFt+KI1GsrsMglJpTCwr+tV9nOAEQzDMX2FmHBAxS8oCkhlGv1ohhsZjFKVmOiMChcFPNZax6bw0a9w1285KvZ3BXX9UmIZszwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A211EFEC;
	Mon, 19 Feb 2024 02:39:05 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB5BC3F762;
	Mon, 19 Feb 2024 02:38:17 -0800 (PST)
Message-ID: <b260e3e1-ebe9-4fc2-6b81-bc4735a7bb66@arm.com>
Date: Mon, 19 Feb 2024 10:38:16 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/8] libperf cpumap: Ensure empty cpumap is NULL from
 alloc
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=c3=a9_Almeida?=
 <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 "Steinar H. Gunderson" <sesse@google.com>,
 Yang Jihong <yangjihong1@huawei.com>, Yang Li <yang.lee@linux.alibaba.com>,
 Changbin Du <changbin.du@huawei.com>, Sandipan Das <sandipan.das@amd.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Paran Lee <p4ranlee@gmail.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
References: <20240202234057.2085863-1-irogers@google.com>
 <20240202234057.2085863-3-irogers@google.com>
 <CAM9d7ci3VO7reyxPc8WOczdoyYYCUshxCJDMZ7wPpHknCubNXQ@mail.gmail.com>
 <CAP-5=fVNLoes2VaCcqrueiDLBZAZNthSJVD17z77cnyE7wF7ag@mail.gmail.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fVNLoes2VaCcqrueiDLBZAZNthSJVD17z77cnyE7wF7ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/02/2024 00:52, Ian Rogers wrote:
> On Fri, Feb 16, 2024 at 4:25 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> On Fri, Feb 2, 2024 at 3:41 PM Ian Rogers <irogers@google.com> wrote:
>>>
>>> Potential corner cases could cause a cpumap to be allocated with size
>>> 0, but an empty cpumap should be represented as NULL. Add a path in
>>> perf_cpu_map__alloc to ensure this.
>>>
>>> Suggested-by: James Clark <james.clark@arm.com>
>>> Closes: https://lore.kernel.org/lkml/2cd09e7c-eb88-6726-6169-647dcd0a8101@arm.com/
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/lib/perf/cpumap.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
>>> index ba49552952c5..cae799ad44e1 100644
>>> --- a/tools/lib/perf/cpumap.c
>>> +++ b/tools/lib/perf/cpumap.c
>>> @@ -18,9 +18,13 @@ void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
>>>
>>>  struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
>>>  {
>>> -       RC_STRUCT(perf_cpu_map) *cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
>>> +       RC_STRUCT(perf_cpu_map) *cpus;
>>>         struct perf_cpu_map *result;
>>>
>>> +       if (nr_cpus == 0)
>>> +               return NULL;
>>
>> But allocation failure also returns NULL.  Then callers should check
>> what's the expected result.>
> Right, we don't have a habit of just aborting on memory allocation

I'm not sure why we don't abort on allocation. It would simplify the
code a lot and wouldn't change the behavior in any meaningful way. And
it would also allow us to print out which line exactly failed which is
much more useful than bubbling up the error and hiding it.

If we're making the decision that an empty map == NULL rather than
non-null but with 0 length then maybe it's time to start thinking about it.

> errors. In the case that NULL is returned it is assumed that an empty
> CPU map is appropriate. Adding checks throughout the code base that an
> empty CPU map is only returned when 0 is given is beyond the scope of
> this patch set.
> 
> Thanks,
> Ian
> 


>> Thanks,
>> Namhyung
>>
>>> +
>>> +       cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
>>>         if (ADD_RC_CHK(result, cpus)) {
>>>                 cpus->nr = nr_cpus;
>>>                 refcount_set(&cpus->refcnt, 1);
>>> --
>>> 2.43.0.594.gd9cf4e227d-goog
>>>

