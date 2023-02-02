Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85253687C6B
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 12:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjBBLgr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Feb 2023 06:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjBBLgq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 06:36:46 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557768A64
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 03:36:44 -0800 (PST)
X-QQ-mid: bizesmtp74t1675337782tj4gafyc
Received: from smtpclient.apple ( [1.202.165.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 02 Feb 2023 19:36:19 +0800 (CST)
X-QQ-SSF: 0100000000000080B000000A0000000
X-QQ-FEAT: xsBrTKm2GcgjqomKD5+qJx+cTBnvKxMr9MXejoc0z+ITZdnYZT8zgTV+HnC95
        9EECSRsNVqk8O3X5LHTW8D61aL6BzHHuY1dS3wER8Zrb6snTRRUhAiE4Gg905HWGUt+k9+T
        S4bHUcI3RB+32xUH9TIFNShaHa7maeWzxGCWkVjcJMTE6Bhu38T8VtAxiNKOuQQGAUg6adk
        VTgeYy0TM9U7aDPQgBC6KLYgX/sRmmsyCINeIzTDHM2vkiMdP7CHdC9G1ocw47K6sWIu15G
        YzLF+zyTFXfqmVNA1J7/ib4bT9CTLTX0DG9wg7Ja4CwuVwaDTvWC2blbSozRiVFcIG1SmEs
        vTd1tQ6AQmE3a4kNwY/nDjY3+GYm4mn4Zu0qcRP
X-QQ-GoodBg: 0
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [bpf-next v2] bpftool: profile online CPUs instead of possible
From:   Tonghao Zhang <tong@infragraf.org>
In-Reply-To: <fb4004dd-597a-e741-27cc-b0cd03bc2172@iogearbox.net>
Date:   Thu, 2 Feb 2023 19:36:19 +0800
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <38619A73-7E42-46C7-88CE-27A42DFF4224@infragraf.org>
References: <20230201122404.4256-1-tong@infragraf.org>
 <fb4004dd-597a-e741-27cc-b0cd03bc2172@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:infragraf.org:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Feb 2, 2023, at 7:15 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> 
> On 2/1/23 1:24 PM, tong@infragraf.org wrote:
>> From: Tonghao Zhang <tong@infragraf.org>
>> The number of online cpu may be not equal to possible cpu.
>> bpftool prog profile, can not create pmu event on possible
>> but on online cpu.
>> $ dmidecode -s system-product-name
>> PowerEdge R620
>> $ cat /sys/devices/system/cpu/online
>> 0-31
>> $ cat /sys/devices/system/cpu/possible
>> 0-47
>> BTW, we can disable CPU dynamically:
>> $ echo 0 > /sys/devices/system/cpu/cpuX/online
>> If CPU is offline, perf_event_open will return ENODEV.
>> To fix this issue, check the value returned and skip
>> offline CPU.
>> Signed-off-by: Tonghao Zhang <tong@infragraf.org>
>> Cc: Quentin Monnet <quentin@isovalent.com>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Andrii Nakryiko <andrii@kernel.org>
>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>> Cc: Song Liu <song@kernel.org>
>> Cc: Yonghong Song <yhs@fb.com>
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Cc: KP Singh <kpsingh@kernel.org>
>> Cc: Stanislav Fomichev <sdf@google.com>
>> Cc: Hao Luo <haoluo@google.com>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> ---
>> v1:
>> https://patchwork.kernel.org/project/netdevbpf/patch/20230117044902.98938-1-tong@infragraf.org/
>> https://patchwork.kernel.org/project/netdevbpf/patch/20230117044902.98938-2-tong@infragraf.org/
>> ---
>>  tools/bpf/bpftool/prog.c | 36 ++++++++++++++++++++++++++++--------
>>  1 file changed, 28 insertions(+), 8 deletions(-)
>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index cfc9fdc1e863..f48067cb0496 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
>> @@ -2233,10 +2233,36 @@ static void profile_close_perf_events(struct profiler_bpf *obj)
>>  	profile_perf_event_cnt = 0;
>>  }
>>  +static int profile_open_perf_event(int mid, int cpu, int map_fd)
>> +{
>> +	int pmu_fd;
>> +
>> +	pmu_fd = syscall(__NR_perf_event_open, &metrics[mid].attr,
>> +			 -1/*pid*/, cpu, -1/*group_fd*/, 0);
>> +	if (pmu_fd < 0) {
>> +		if (errno == ENODEV) {
>> +			p_info("cpu %d may be offline, skip %s metric profiling.",
>> +				cpu, metrics[mid].name);
>> +			profile_perf_event_cnt++;
>> +			return 0;
>> +		}
>> +		return -1;
>> +	}
>> +
>> +	if (bpf_map_update_elem(map_fd,
>> +				&profile_perf_event_cnt,
>> +				&pmu_fd, BPF_ANY) ||
>> +	    ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0))
>> +		return -1;
> 
> This leaks pmu_fd here, no? We should close fd on error as the later call to
> profile_close_perf_events() only closes those which are in profile_perf_events[]
> array.
Yes. I will fix this issue. Seem this issue introduced by 47c09d6a9f67. I will add fix tag in next version.

Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
Cc: Song Liu <songliubraving@fb.com>

> 
>> +	profile_perf_events[profile_perf_event_cnt++] = pmu_fd;
>> +	return 0;
>> +}
>> +
>>  static int profile_open_perf_events(struct profiler_bpf *obj)
>>  {
>>  	unsigned int cpu, m;
>> -	int map_fd, pmu_fd;
>> +	int map_fd;
>>    	profile_perf_events = calloc(
>>  		sizeof(int), obj->rodata->num_cpu * obj->rodata->num_metric);
>> @@ -2255,17 +2281,11 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
>>  		if (!metrics[m].selected)
>>  			continue;
>>  		for (cpu = 0; cpu < obj->rodata->num_cpu; cpu++) {
>> -			pmu_fd = syscall(__NR_perf_event_open, &metrics[m].attr,
>> -					 -1/*pid*/, cpu, -1/*group_fd*/, 0);
>> -			if (pmu_fd < 0 ||
>> -			    bpf_map_update_elem(map_fd, &profile_perf_event_cnt,
>> -						&pmu_fd, BPF_ANY) ||
>> -			    ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0)) {
>> +			if (profile_open_perf_event(m, cpu, map_fd)) {
>>  				p_err("failed to create event %s on cpu %d",
>>  				      metrics[m].name, cpu);
>>  				return -1;
>>  			}
>> -			profile_perf_events[profile_perf_event_cnt++] = pmu_fd;
>>  		}
>>  	}
>>  	return 0;
> 
> 

----
Best Regards, Tonghao <tong@infragraf.org>

