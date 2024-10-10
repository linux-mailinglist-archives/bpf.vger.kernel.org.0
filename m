Return-Path: <bpf+bounces-41532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F88997C06
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 06:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1D31F24C14
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 04:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF5B19E82A;
	Thu, 10 Oct 2024 04:53:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3434A07;
	Thu, 10 Oct 2024 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728536012; cv=none; b=p7l1IIgY6R8AI1T8XUSWHwJUM/PArFv9ooidXrNiLLdVKo36lsymTKhV5KerZqOSIiDGt99mciyFmw1tMawzR6lAZ52szkBgYioMRF8rM2aT3YF9FuiJnPZ9BWe/HqgXrPxmQH64N17SXhyDPCeoF6PQ9+hJL+hSxbf5MbShYTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728536012; c=relaxed/simple;
	bh=BfipDDsqUnVOrPWkwh4bhHNxe6HlOv1kOOFu2CM6OAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoKpSJM44d84/9rMuBEfJI+QSB2frXMC92CQ6+qYXd5J2tklYoKdLh2AG6YtSlFVIaR44Omhe9LiBZL0Fu2mUCM34fcOjDSfDaltUApfi+6jfBDOwfu6QZeEX9ZahsPQE1BZeDh6jY8xwfK+xQTWk4toBbPGsSVuDSmG/m6tbtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XPHSh1ZDWz4f3l26;
	Thu, 10 Oct 2024 12:53:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D00281A018D;
	Thu, 10 Oct 2024 12:53:25 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgAHO2DEXQdn8XquDg--.17460S2;
	Thu, 10 Oct 2024 12:53:25 +0800 (CST)
Message-ID: <a98f599f-ea6e-4c7f-b39d-44e6cd2a9f20@huaweicloud.com>
Date: Thu, 10 Oct 2024 12:53:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 1/2] perf stat: Support inherit events during
 fork() for bperf
To: Namhyung Kim <namhyung@kernel.org>, Song Liu <song@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240916014318.267709-1-wutengda@huaweicloud.com>
 <20240916014318.267709-2-wutengda@huaweicloud.com>
 <CAPhsuW6wrwcMYLufVfu-R9OzPBfspJD0w-pZUr68UBRSZExc=A@mail.gmail.com>
 <ZwcgZhOC_gq9kToT@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <ZwcgZhOC_gq9kToT@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHO2DEXQdn8XquDg--.17460S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF13Jr4fXFyrKw4UtFyxKrg_yoW5Zr4fpr
	WIkasFk3ykXFyYkw12qw1DZrySyrZ5JrW3Xrn8KrWxtFyDK3sIgF17GrWY9asrXr1xGryr
	X3yj9343ua98A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2024/10/10 8:31, Namhyung Kim wrote:
> On Wed, Oct 09, 2024 at 10:18:44AM -0700, Song Liu wrote:
>> On Sun, Sep 15, 2024 at 6:53 PM Tengda Wu <wutengda@huaweicloud.com> wrote:
>>>
>>> bperf has a nice ability to share PMUs, but it still does not support
>>> inherit events during fork(), resulting in some deviations in its stat
>>> results compared with perf.
>>>
>>> perf stat result:
>>> $ ./perf stat -e cycles,instructions -- ./perf test -w sqrtloop
>>>
>>>    Performance counter stats for './perf test -w sqrtloop':
>>>
>>>        2,316,038,116      cycles
>>>        2,859,350,725      instructions
>>>
>>>          1.009603637 seconds time elapsed
>>>
>>>          1.004196000 seconds user
>>>          0.003950000 seconds sys
>>>
>>> bperf stat result:
>>> $ ./perf stat --bpf-counters -e cycles,instructions -- \
>>>       ./perf test -w sqrtloop
>>>
>>>    Performance counter stats for './perf test -w sqrtloop':
>>>
>>>           18,762,093      cycles
>>>           23,487,766      instructions
>>>
>>>          1.008913769 seconds time elapsed
>>>
>>>          1.003248000 seconds user
>>>          0.004069000 seconds sys
>>>
>>> In order to support event inheritance, two new bpf programs are added
>>> to monitor the fork and exit of tasks respectively. When a task is
>>> created, add it to the filter map to enable counting, and reuse the
>>> `accum_key` of its parent task to count together with the parent task.
>>> When a task exits, remove it from the filter map to disable counting.
>>>
>>> After support:
>>> $ ./perf stat --bpf-counters -e cycles,instructions -- \
>>>       ./perf test -w sqrtloop
>>>
>>>  Performance counter stats for './perf test -w sqrtloop':
>>>
>>>      2,316,252,189      cycles
>>>      2,859,946,547      instructions
>>>
>>>        1.009422314 seconds time elapsed
>>>
>>>        1.003597000 seconds user
>>>        0.004270000 seconds sys
>>>
>>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>>
>> The solution looks good to me. Question on the UI: do we always
>> want the inherit behavior from PID and TGID monitoring? If not,
>> maybe we should add a flag for it. (I think we do need the flag).
> 
> I think it should depend on the value of attr.inherit.  Maybe we can
> disable the autoload for !inherit.
> 

Got it. The attr.inherit flag(related to --no-inherit in perf command)
is suitable for controlling inherit behavior. I will fix it. Thanks!

>>
>> One nitpick below.
>>
>> Thanks,
>> Song
>>
>> [...]
>>>
>>> +struct bperf_filter_value {
>>> +       __u32 accum_key;
>>> +       __u8 exited;
>>> +};
>> nit:
>> Can we use a special value of accum_key to replace exited==1
>> case?
> 
> I'm not sure.  I guess it still needs to use the accum_key to save the
> final value when exited = 1.

In theory, it is possible. The accum_key is currently only used to index value
in accum_readings map, so if the task is not being counted, the accum_key can
be set to an special value.

Due to accum_key is of u32 type, there are two special values to choose from: 0
or max_entries+1. I think the latter, max_entries+1, may be more suitable because
it can avoid memory waste in the accum_readings map and does not require too
many changes to bpf_counter.

Thanks for your kindly review!
Tengda

> 
> Thanks,
> Namhyung
> 
>>
>>> +
>>>  #endif /* __BPERF_STAT_U_H */
>>> --
>>> 2.34.1
>>>


