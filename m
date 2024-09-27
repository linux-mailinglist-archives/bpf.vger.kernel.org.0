Return-Path: <bpf+bounces-40378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB276987D13
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 04:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91A81C2227F
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 02:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE30516D4FF;
	Fri, 27 Sep 2024 02:36:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38508475;
	Fri, 27 Sep 2024 02:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727404570; cv=none; b=mhTQdD9O4MKf97GgZ+7gMtEVgZ5Ra8BtWrIvmKVkCIS7yd7a8jaEWIM5VLl6URAzyOBTl1weOlSh5BRp0E29o0GWzNfuMTnmm+tLKTJC+DCe7S2QlveiUKACVbZUbuKFZEa2fo9sR4kCSwJDo/K7XMQ1e8P0TP7OaBzZ+cDuYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727404570; c=relaxed/simple;
	bh=dOpf6OD4qs7FUOTqjZZO1NJu3mPxmgwPN0iebZyhN5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pn8WEqiTKva6FWQsqrRYf+Lq5PjDQvR/WIkParEum7rpk1drV0vgsNOHli3FzJK2vu3qMvTBwTqTd4aMZJZN21EcHYrL/1tEsDkipTCfqjoqsa5cGxFNwSRXo5hn+sjUemC/mpD9MDC1lCg23A3d6rhG/CL5cDTDx9PCOemX87w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XFF250jZpz4f3jXL;
	Fri, 27 Sep 2024 10:35:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5DF001A1637;
	Fri, 27 Sep 2024 10:35:57 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgAnW2AKGvZm6J_LCQ--.34226S2;
	Fri, 27 Sep 2024 10:35:55 +0800 (CST)
Message-ID: <41d1d728-dbf4-4b0d-9855-19cd06e2a594@huaweicloud.com>
Date: Fri, 27 Sep 2024 10:35:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/2] perf stat: Increase perf_attr_map entries
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, song@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240925135523.367957-1-wutengda@huaweicloud.com>
 <20240925135523.367957-2-wutengda@huaweicloud.com>
 <ZvTgHKl4eZvpyVml@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <ZvTgHKl4eZvpyVml@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnW2AKGvZm6J_LCQ--.34226S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4fKryDAw1rCw4kZr43Jrb_yoW5AryrpF
	4kCF9rKF15Wr1xGwnxZanIgr90gw45uFW5Kr13KrW8AFnxWr1rKayIgF4FgF1xJrZ2yr1F
	qw4qgrW7ZayY9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2024/9/26 12:16, Namhyung Kim wrote:
> On Wed, Sep 25, 2024 at 01:55:22PM +0000, Tengda Wu wrote:
>> bperf restricts the size of perf_attr_map's entries to 16, which
>> cannot hold all events in many scenarios. A typical example is
>> when the user specifies `-a -ddd` ([0]). And in other cases such as
>> top-down analysis, which often requires a set of more than 16 PMUs
>> to be collected simultaneously.
>>
>> Fix this by increase perf_attr_map entries to 100, and an event
>> number check has been introduced when bperf__load() to ensure that
>> users receive a more friendly prompt when the event limit is reached.
>>
>>   [0] https://lore.kernel.org/all/20230104064402.1551516-3-namhyung@kernel.org/
> 
> Apparently this patch was never applied.  I don't know how much you need
> but having too many events at the same time won't be very useful because
> multiplexing could reduce the accuracy.
> 

Could you please explain why patch [0] was not merged at that time? I couldn't
find this information from the previous emails.

In my scenario, we collect more than 40+ events to support necessary metric
calculations, which multiplexing is inevitable. Although multiplexing may
reduce accuracy, for the purpose of supporting metric calculations, these
accuracy losses can be acceptable. Perf also has the same issue with multiplexing.
Removing the event limit for bperf can provide users with additional options.

In addition to accuracy, we also care about overhead. I compared the overhead
of bperf and perf by testing ./lat_ctx in lmbench [1], and found that the
overhead of bperf stat is about 4% less than perf. This is why we choose to
use bperf in some extreme scenarios.

  [1] https://github.com/intel/lmbench

Thanks,
Tengda

> 
>>
>> Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  tools/perf/util/bpf_counter.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
>> index 7a8af60e0f51..3346129c20cf 100644
>> --- a/tools/perf/util/bpf_counter.c
>> +++ b/tools/perf/util/bpf_counter.c
>> @@ -28,7 +28,7 @@
>>  #include "bpf_skel/bperf_leader.skel.h"
>>  #include "bpf_skel/bperf_follower.skel.h"
>>  
>> -#define ATTR_MAP_SIZE 16
>> +#define ATTR_MAP_SIZE 100
>>  
>>  static inline void *u64_to_ptr(__u64 ptr)
>>  {
>> @@ -451,6 +451,12 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>>  	enum bperf_filter_type filter_type;
>>  	__u32 filter_entry_cnt, i;
>>  
>> +	if (evsel->evlist->core.nr_entries > ATTR_MAP_SIZE) {
>> +		pr_err("Too many events, please limit to %d or less\n",
>> +			ATTR_MAP_SIZE);
>> +		return -1;
>> +	}
>> +
>>  	if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
>>  		return -1;
>>  
>> -- 
>> 2.34.1
>>


